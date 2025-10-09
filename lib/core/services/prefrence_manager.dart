import 'package:shared_preferences/shared_preferences.dart';

class PrefrenceManager {
  static final PrefrenceManager _instance = PrefrenceManager._internal();
  // private constructor
  PrefrenceManager._internal() {}

  factory PrefrenceManager() {
    return _instance;
  }

  late final SharedPreferences _pref;
  init() async {
    _pref = await SharedPreferences.getInstance();
  }

  void setstring(key, value) async {
    await _pref.setString(key, value);
  }

  String? getstring(key) {
    return _pref.getString(key);
  }
  Future setbool(key, value) async {
    await _pref.setBool(key, value);
  }

  bool? getbool(key) {
    return _pref.getBool(key);
  }



  void remove(key) {
    _pref.remove(key);
  }
}
