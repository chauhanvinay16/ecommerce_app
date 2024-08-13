

import 'package:shared_preferences/shared_preferences.dart';

class AppPref{

  setUserTocek(String userToken)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_token', userToken);
  }

  Future<String>getUserToken()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken=prefs.getString('user_token')??"";
    return userToken;
  }

  clearUserTocek(String userToken)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_token');
  }
}