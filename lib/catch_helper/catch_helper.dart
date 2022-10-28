import 'package:shared_preferences/shared_preferences.dart';

class CachHelper{

  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();

  }


  static Future<bool> putData({
    required String key,
    required double value,
  }) async{
    return await sharedPreferences!.setDouble(key, value);
  }

  static double? getData({
    required String key,
  }){
    return sharedPreferences!.getDouble(key);
  }
}