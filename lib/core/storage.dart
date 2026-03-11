import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Future<bool> first() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    final runned = storage.getBool("runned");
    if (runned == null) {
      return true;
    }
    return false;
  }
}
