import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class __PreferenceNames {
  static String largerConstraints = "ec_largerConstraints";
}

abstract class ComponentPreferences {
  static SharedPreferences? prefs;

  static late bool __largerConstraints;

  @internal
  static Future<void> init() async {
    prefs ??= await SharedPreferences.getInstance();

    if (prefs!.getBool(__PreferenceNames.largerConstraints) == null) {
      setButtonConstraints(false);
    }
    __largerConstraints = getButtonConstraints();
  }

  static void setButtonConstraints(bool isLarge) {
    prefs!.setBool(__PreferenceNames.largerConstraints, isLarge);
    __largerConstraints = isLarge;
  }

  static bool getButtonConstraints() {
    if (prefs!.getBool(__PreferenceNames.largerConstraints) != true &&
        prefs!.getBool(__PreferenceNames.largerConstraints) != false) {
      setButtonConstraints(false);
      __largerConstraints = false;
      return false;
    } else {
      __largerConstraints =
          prefs!.getBool(__PreferenceNames.largerConstraints) ?? true;
      return __largerConstraints;
    }
  }
}