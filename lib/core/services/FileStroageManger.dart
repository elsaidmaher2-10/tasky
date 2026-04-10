import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStroageManager {
  static final FileStroageManager _instance = FileStroageManager._();
  FileStroageManager._();

  factory FileStroageManager() {
    return _instance;
  }
  late final Directory _dir;
  late final File _file;
  Future<void> init() async {
    _dir = await getApplicationDocumentsDirectory();
    _file = File("${_dir.path}/tasks.json");
  }

  void saveTasks(List<dynamic> data) async {
    final jsontasks = jsonEncode(data);
    await _file.writeAsString(jsontasks);
  }

  Future<List<dynamic>> loadtaks() async {
    if (!await _file.exists()) return [];
    final jsontasks = jsonDecode(await _file.readAsString());
    return jsontasks;
  }
}
