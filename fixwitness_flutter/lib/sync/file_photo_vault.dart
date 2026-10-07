import 'dart:io';
import 'dart:typed_data';

import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:path/path.dart' as p;

import 'outbox_store.dart';

/// Stores pending photos as files in the app's private support directory.
class FilePhotoVault implements PhotoVault {
  FilePhotoVault(this.directory);

  final Directory directory;

  @override
  Future<String> save(UuidValue opId, Uint8List bytes) async {
    await directory.create(recursive: true);
    final file = File(p.join(directory.path, '${opId.uuid}.img'));
    // Write to a temp name first so a crash never leaves a half-written file
    // under the final name.
    final tmp = File('${file.path}.tmp');
    await tmp.writeAsBytes(bytes, flush: true);
    await tmp.rename(file.path);
    return file.path;
  }

  @override
  Future<Uint8List?> read(String path) async {
    final file = File(path);
    if (!await file.exists()) return null;
    return file.readAsBytes();
  }

  @override
  Future<void> delete(String path) async {
    final file = File(path);
    if (await file.exists()) await file.delete();
  }
}
