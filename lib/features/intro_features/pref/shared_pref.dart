import 'package:shared_preferences/shared_preferences.dart';

class SharedPerf {
  late SharedPreferences pref;

  Future<bool> getIntroStatus() async {
    pref = await SharedPreferences.getInstance();
    final bool status = pref.getBool('intro') ?? false;
    return status;
  }

  Future<void> setIntroStatus() async {
    pref = await SharedPreferences.getInstance();
    pref.setBool('intro', true);
  }

  Future<bool> getHostStatus() async {
    pref = await SharedPreferences.getInstance();
    final bool status = pref.getBool('host') ?? false;
    return status;
  }

  Future<void> setHostStatus() async {
    pref = await SharedPreferences.getInstance();
    pref.setBool('host', true);
  }
}
