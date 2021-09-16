import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceInstance {
  static SharedPreferences? prefs;

  static final SharePreferenceInstance networkcall =
      new SharePreferenceInstance._internal();

  SharePreferenceInstance._internal();

  factory SharePreferenceInstance() {
    return networkcall;
  }

  //shared pref initialize
  init() async {
    SharedPreferences.getInstance()
        .then((value) => prefs = value)
        .catchError((e) {
      print("Got error: ${e.error}"); // Finally, callback fires.
      // Future completes with 42.
    });
  }

  void clear() {
    prefs?.clear();
  }

 
  //keys
  final ISLOGIN = 'isLogin';
  final USER_TOKEN = 'user_token';

  //isLogin
  void setIsLogin(value) => prefs?.setBool(ISLOGIN, value);
  bool? isLogin() => prefs?.getBool(ISLOGIN);

  //token
  void setToken(token) => prefs?.setString(USER_TOKEN, token);
  String? getToken() => prefs?.getString(USER_TOKEN);

  void saveUserDetails(jsonResponce) {
    setToken(jsonResponce['data']['api_token']);
    // var token = getToken();
    // print('token:= $token');
    setIsLogin(true);
  }
}

SharePreferenceInstance sharePrefereceInstance = SharePreferenceInstance();
