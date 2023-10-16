// TODO Implement this library.//use shared preference helper to setup and maintain user defaults.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// TODO: SharedPrefs in GlobalVariables.userState

class SharedPreferencesHelper {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static const String myid = "new";

  static dynamic sharedPreferences;

  static Future<SharedPreferences> load() async {
    sharedPreferences ??= await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  static sharedPrefInit() async {
    try {
      /// Checks if shared preference exist
      Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
      final SharedPreferences prefs =
          await prefs0.then((response) => sharedPreferences = response);
      prefs.getString("pdaware");
      sharedPreferences = prefs;
    } catch (err) {
      /// setMockInitialValues initiates shared preference
      /// Adds app-name
      //SharedPreferences.setMockInitialValues({});
      Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
      final SharedPreferences prefs = await prefs0;
      prefs.setString("pdaware", "my-app");
      sharedPreferences = prefs;
    }
  }

  static void persist(bool value) {
    sharedPreferences.setBool('test', true);
  }

  /// ------------------------------------------------------------
  /// Method that returns the user id, if not changed from default (default is new)
  /// ------------------------------------------------------------
  static String getIDString() {
    String val;
    val = sharedPreferences.getString(myid) ?? "new";
    return val;
  }

  /// ----------------------------------------------------------
  /// Method that saves the user id
  /// ----------------------------------------------------------
  static void setIDString(String value) {
    sharedPreferences.setString(myid, value);
  }

  static bool checkIfSeen() {
    bool seen;
    seen = (sharedPreferences.getBool('seen') ?? false);
    return seen;
  }

  static bool checkIfPatient() {
    bool patient;
    patient = (sharedPreferences.getBool('patient') ?? false);
    return patient;
  }

  static String? checkIfLastUpdate() {
    String lastUpdate;
    lastUpdate = (sharedPreferences.getString('lastUpdate') ?? "");
    return lastUpdate;
  }

  static bool checkIfCaregiver() {
    bool caregiver;
    caregiver = (sharedPreferences.getBool('caregiver') ?? false);
    return caregiver;
  }

  static bool checkIfHealthKit() {
    bool healthPermission;
    healthPermission =
        (sharedPreferences.getBool('healthPermission') ?? false);
    return healthPermission;
  }

  static bool checkIfConsent() {
    bool consentPermission;
    consentPermission =
        (sharedPreferences.getBool('consentPermission') ?? false);
    return consentPermission;
  }

  static bool checkIfConsent2() {
    bool consentPermission;
    consentPermission =
        (sharedPreferences.getBool('consentPermission2') ?? false);
    return consentPermission;
  }

  static bool checkIfNotificationsSet() {
    bool notificationsSet;
    notificationsSet =
        (sharedPreferences.getBool('notificationsSet') ?? false);
    return notificationsSet;
  }

  static List<int> checkIfProMorningList() {
    String stringPro;
    stringPro = (sharedPreferences.getString('proMorningList') ?? "[0]");

    List<int> proMorningList = json.decode(stringPro).cast<int>();

    return proMorningList;
  }

  static List<int> checkIfProAfternoonList() {
    String stringPro;

    stringPro = (sharedPreferences.getString('proAfternoonList') ?? "[1]");

    List<int> proAfternoonList = json.decode(stringPro).cast<int>();

    return proAfternoonList;
  }

  static List<int> checkIfProEveningList() {
    String stringPro;

    stringPro = (sharedPreferences.getString('proEveningList') ?? "[1]");

    if (kDebugMode) {
      print(stringPro);
    }

    List<int> proEveningList = json.decode(stringPro).cast<int>();

    return proEveningList;
  }

  static bool checkIfHasPlanType(String type) {
    bool planTyle;
    planTyle = (sharedPreferences.getBool(type) ?? false);
    return planTyle;
  }

  static List<String> getDemographicsList() {
    String stringPro;

    if (kDebugMode) {
      print("GETTING DEMO");
    }

    stringPro = (sharedPreferences.getString('demographicsList') ??
        "[" ", " ", " ", " ", " ", " "]");

    if (kDebugMode) {
      print("CONVERT DEMO");
      print(stringPro);
    }
    int beginIndex = 1;
    List<String> demographicsList = [];
    for (int i = 1; i < stringPro.length - 1; i++) {
      if (stringPro[i] == ",") {
        String value = stringPro.substring(beginIndex, i);
        if (kDebugMode) {
          print(value);
        }
        beginIndex = i + 2;
        demographicsList.add(value);
      }
    }
    if (kDebugMode) {
      print(demographicsList);
    }

    /*List<dynamic> reallyAStringList = json.decode(_stringPro);
    for (String string in reallyAStringList) {
      print(string);
    }

    List<String> stringList = (json.decode(_stringPro) as List<dynamic>).cast<String>();
    print(stringList);

    var _demographicsList = json.decode(_stringPro);

    print("FINISH DEMO");
    print(_demographicsList);*/

    return demographicsList;
  }

  static String checkStartDate() {
    String startDate;
    startDate = (sharedPreferences.getString('startDate') ?? "");
    return startDate;
  }

  static String checkEndDate() {
    String endDate;
    endDate = (sharedPreferences.getString('endDate') ?? "");
    return endDate;
  }

  static int getNumUnread() {
    int numUnread;
    numUnread = (sharedPreferences.getInt('numUnread') ?? 0);
    return numUnread;
  }

  static List<String> checkUniqueSourceIds() {
    String stringSourceId;
    stringSourceId = (sharedPreferences.getString('source_id') ?? "[]");

    String conversionStep = stringSourceId.replaceAll('[', '');
    String conversionStepTwo = conversionStep.replaceAll(']', '');
    List<String> uniqueSourceIds = conversionStepTwo.split(', ');
    if (kDebugMode) {
      print("UNIQUES == $uniqueSourceIds");
    }

    return uniqueSourceIds;
  }

  static String checkDisplayName() {
    String displayName;
    displayName = (sharedPreferences.getString('displayName') ?? "");
    return displayName;
  }

  static String checkGroupName() {
    String groupName;
    groupName = (sharedPreferences.getString('groupName') ?? "Group 1");
    return groupName;
  }

  static String checkUserId() {
    String userId;
    userId = (sharedPreferences.getString('userId') ?? "");
    return userId;
  }

  static List<String> checkProSubmissions() {
    List<String> proSubmissions;
    proSubmissions = (sharedPreferences.getStringList('proSubmissions') ?? []);
    return proSubmissions;
  }

  static List<String> checkObservationSubmissions() {
    List<String> observationSubmissions;
    observationSubmissions =
        (sharedPreferences.getStringList('observationSubmissions') ?? []);
    return observationSubmissions;
  }

  static List<String> checkDeviceSubmissions() {
    List<String> deviceSubmissions;
    deviceSubmissions =
        (sharedPreferences.getStringList('deviceSubmissions') ?? []);
    return deviceSubmissions;
  }

  static List<String> checkSendNoteMessageSubmissions() {
    List<String> sendNoteMessageSubmissions;
    sendNoteMessageSubmissions =
        (sharedPreferences.getStringList('sendNoteMessageSubmissions') ?? []);
    return sendNoteMessageSubmissions;
  }

  static List<String> checkSendNoteActivitiesSubmissions() {
    List<String> sendNoteActivitiesSubmissions;
    sendNoteActivitiesSubmissions =
        (sharedPreferences.getStringList('sendNoteActivitiesSubmissions') ??
            []);
    return sendNoteActivitiesSubmissions;
  }

  static List<String> checkSendNoteButtonTextSubmissions() {
    List<String> sendNoteButtonTextSubmissions;
    sendNoteButtonTextSubmissions =
        (sharedPreferences.getStringList('sendNoteButtonTextSubmissions') ??
            []);
    return sendNoteButtonTextSubmissions;
  }

  static bool checkIfSignedInWithApple() {
    bool apple;
    apple = (sharedPreferences.getBool('signedInWithApple') ?? false);
    return apple;
  }

  static bool checkIfMicGranted() {
    bool mic;
    mic = (sharedPreferences.getBool('mic') ?? false);
    return mic;
  }

  static bool checkIfMicSTTGranted() {
    bool micSTT;
    micSTT = (sharedPreferences.getBool('micSTT') ?? false);
    return micSTT;
  }

  static bool checkIfLocationGranted() {
    bool loc;
    loc = (sharedPreferences.getBool('location') ?? false);
    return loc;
  }

  static DateTime getLastPull() {
    int lastPull;
    lastPull = (sharedPreferences.getInt('lastPull'));
    return DateTime.fromMillisecondsSinceEpoch(lastPull);
  }

  static void setAsPatient() {
    sharedPreferences.setBool('patient', true);
  }

  static void setAsCaregiver() {
    sharedPreferences.setBool('caregiver', true);
  }

  static void setAsNotPatient() {
    sharedPreferences.setBool('patient', false);
  }

  static void setAsNotCaregiver() {
    sharedPreferences.setBool('caregiver', false);
  }

  static void setAsHealthGranted() {
    sharedPreferences.setBool('healthPermission', true);
  }

  static void setAsHealthDenied() {
    sharedPreferences.setBool('healthPermission', false);
  }

  static void setAsConsentGranted() {
    sharedPreferences.setBool('consentPermission', true);
  }

  static void setAsConsentDenied() {
    sharedPreferences.setBool('consentPermission', false);
  }

  static void setAsConsentGranted2() {
    sharedPreferences.setBool('consentPermission2', true);
  }

  static void setAsConsentDenied2() {
    sharedPreferences.setBool('consentPermission2', false);
  }

  static void setAsNotificationsSet() {
    sharedPreferences.setBool('notificationsSet', true);
  }

  static void setAsNotificationsNotSet() {
    sharedPreferences.setBool('notificationsSet', false);
  }

  static void setAsPlanType(String planType) {
    sharedPreferences.setBool(planType, true);
  }

  static void setAsNotPlanType(String planType) {
    sharedPreferences.setBool(planType, false);
  }

  static void setAsSignedInWithApple() {
    sharedPreferences.setBool('signedInWithApple', true);
  }

  static void setAsSignedInWithGoogle() {
    sharedPreferences.setBool('signedInWithApple', false);
  }

  static void setAsFitbitGranted() {
    sharedPreferences.setBool('fitbit', true);
  }

  static bool checkIfFitbitGranted() {
    bool isFitbitGranted;
    isFitbitGranted = sharedPreferences.getBool('fitbit') ?? false;
    // if (_isFitbitGranted) {
    //   healthKitState.fitbitStateEnum = FitbitStateEnum.granted;
    // } else {
    //   healthKitState.fitbitStateEnum = FitbitStateEnum.denied;
    // }
    return isFitbitGranted;
  }

  static String checkFitbitAccessToken() {
    String accessToken;
    accessToken = sharedPreferences.getString('fitbitAccessToken') ?? "";
    return accessToken;
  }

  static String checkFitbitRefreshToken() {
    String refreshToken;
    refreshToken = sharedPreferences.getString('fitbitRefreshToken') ?? "";
    return refreshToken;
  }

  static String checkFitbitUserId() {
    String userId;
    userId = sharedPreferences.getString('fitbitUserId') ?? "";
    return userId;
  }

  static String checkUserHeight() {
    String height;
    height = sharedPreferences.getString('height') ?? "";
    return height;
  }

  static String checkUserWeight() {
    String weight;
    weight = sharedPreferences.getString('weight') ?? "";
    return weight;
  }

  static String checkUserBirthday() {
    String birthday;
    birthday = sharedPreferences.getString('birthday') ?? "";
    return birthday;
  }

  static String checkUserGender() {
    String gender;
    gender = sharedPreferences.getString('gender') ?? "";
    return gender;
  }

  static void setAsMicGranted() {
    sharedPreferences.setBool('mic', true);
  }

  static void setAsMicDenied() {
    sharedPreferences.setBool('mic', false);
  }

  static void setAsSTTGranted() {
    sharedPreferences.setBool('micSTT', true);
  }

  static void setAsSTTDenied() {
    sharedPreferences.setBool('micSTT', false);
  }

  static void setAsLocationGranted() {
    sharedPreferences.setBool('location', true);
  }

  static void setAsLocationDenied() {
    sharedPreferences.setBool('location', false);
  }
}
