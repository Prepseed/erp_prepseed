import 'package:shared_preferences/shared_preferences.dart';

class sharedPref{

  getSharedPref(dynamic retriveString) async {
    final pref = await SharedPreferences.getInstance();
    var prefs = pref.getString(retriveString);
    return prefs;
  }

  setSharedPref(dynamic keystr, dynamic valuestr) async{
    final pref = await SharedPreferences.getInstance();
    pref.setString(keystr, valuestr);
  }
}