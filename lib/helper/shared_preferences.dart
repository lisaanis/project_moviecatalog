import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  void setLogin(String email) async {
    SharedPreferences getPref = await _pref;
    getPref.setBool('isLogin', true);
    getPref.setString('email', email);
  }

  void setLogout() async {
    SharedPreferences getPref = await _pref;
    getPref.setBool('isLogin', false);
    getPref.remove('email');
  }

  Future<String> getFirstname() async {
    SharedPreferences getPref = await _pref;
    String firstname = getPref.getString('firstname') ?? 'notFound';
    return firstname;
  }

  Future<bool> getLoginStatus() async {
    SharedPreferences getPref = await _pref;
    bool loginStatus = getPref.getBool('isLogin') ?? false;
    return loginStatus;
  }
}