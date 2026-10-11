// Writes `<file>.gz` next to every compressible file of a Flutter web build,
// for the server's precompressed-static middleware.
//
//   dart run tool/precompress_web.dart web/app
import 'dart:io';

const _extensions = {
  '.js',
  '.mjs',
  '.json',
  '.css',
  '.wasm',
  '.ttf',
  '.otf',
  '.svg',
};

void main(List<String> args) {
  final dir = Directory(args.isEmpty ? 'web/app' : args.first);
  if (!dir.existsSync()) {
    stderr.writeln('No such directory: ${dir.path}');
    exit(2);
  }
  final gzip = GZipCodec(level: 9);
  var before = 0, after = 0, count = 0;
  for (final entity in dir.listSync(recursive: true)) {
    if (entity is! File) continue;
    final path = entity.path;
    final dot = path.lastIndexOf('.');
    if (dot < 0 || !_extensions.contains(path.substring(dot).toLowerCase())) {
      continue;
    }
    final bytes = entity.readAsBytesSync();
    if (bytes.length < 1024) continue;
    final packed = gzip.encode(bytes);
    if (packed.length >= bytes.length * 0.9) continue; // not worth it
    File('$path.gz').writeAsBytesSync(packed, flush: true);
    before += bytes.length;
    after += packed.length;
    count++;
  }
  stdout.writeln(
    'Precompressed $count files: ${before ~/ 1024} KB -> ${after ~/ 1024} KB',
  );
}
