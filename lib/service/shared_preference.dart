import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String dataKey = 'log';

  static Future<void> setData(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(dataKey, value);
  }

  static Future<String> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedData = prefs.getString(dataKey) ?? '';
    return storedData;
  }
}
