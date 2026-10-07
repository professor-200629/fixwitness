// Serves the FixWitness API (8080) and web app (8082) from one origin, so a
// single tunnel (ngrok's free plan has one domain) can expose both.
//
//   node deploy/one-origin-proxy.js        # listens on 8088
//
// Routing: Serverpod endpoint calls are POSTs, file storage lives under
// /serverpod_cloud_storage, and method streams use WebSocket upgrades; all of
// those go to the API server. Everything else (the app's HTML, JS, assets and
// /assets/assets/config.json) goes to the web server.
const http = require('http');
const net = require('net');

const LISTEN = Number(process.env.PROXY_PORT || 8088);
const API = { host: '127.0.0.1', port: 8080 };
const WEB = { host: '127.0.0.1', port: 8082 };

function targetFor(req) {
  if (req.url.startsWith('/serverpod_cloud_storage')) return API;
  if (req.method !== 'GET' && req.method !== 'HEAD') return API;
  return WEB;
}

const server = http.createServer((req, res) => {
  const t = targetFor(req);
  const upstream = http.request(
    { host: t.host, port: t.port, method: req.method, path: req.url, headers: req.headers },
    (up) => {
      res.writeHead(up.statusCode, up.headers);
      up.pipe(res);
    },
  );
  upstream.on('error', (e) => {
    res.writeHead(502, { 'content-type': 'text/plain' });
    res.end(`FixWitness server not reachable (${e.code}).`);
  });
  req.pipe(upstream);
});

// WebSocket upgrades (Serverpod method streams) go to the API server.
server.on('upgrade', (req, socket, head) => {
  const up = net.connect(API.port, API.host, () => {
    up.write(`${req.method} ${req.url} HTTP/1.1\r\n`);
    for (let i = 0; i < req.rawHeaders.length; i += 2) {
      up.write(`${req.rawHeaders[i]}: ${req.rawHeaders[i + 1]}\r\n`);
    }
    up.write('\r\n');
    if (head && head.length) up.write(head);
    up.pipe(socket);
    socket.pipe(up);
  });
  up.on('error', () => socket.destroy());
  socket.on('error', () => up.destroy());
});

server.listen(LISTEN, '127.0.0.1', () =>
  console.log(`one-origin proxy on http://127.0.0.1:${LISTEN} -> api :8080, web :8082`),
);
