import 'dart:io';

void main() {
  final dir = Directory('lib/assets');
  if (!dir.existsSync()) {
    print('Directory lib/assets does not exist.');
    return;
  }
  final files = dir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.jpeg') || f.path.endsWith('.png'))
      .map((f) => "'${f.path.replaceAll('\\', '/')}'")
      .toList();

  final buffer = StringBuffer()
    ..writeln('// GENERATED FILE, DO NOT EDIT')
    ..writeln('const List<String> assetImages = [')
    ..writeln(files.join(',\n'))
    ..writeln('];');

  File('lib/assets_list.dart').writeAsStringSync(buffer.toString());
  print('Generated lib/assets_list.dart with \\${files.length} images.');
} 