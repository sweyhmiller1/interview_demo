import 'dart:async';
import 'dart:io';
import 'package:cron/cron.dart';
import 'package:exhibition/services/user/NavigationSystem.dart';
import 'package:exhibition/services/firebase/firestore_stream.dart';
import 'package:exhibition/services/notifications/set_notifications.dart';
import 'package:exhibition/services/user/user_offline/save_local_storage.dart';
import 'package:exhibition/services/user_progress/persistence/user_progress_persistence.dart';
import 'package:exhibition/services/user_progress/user_progress.dart';
import 'package:exhibition/services/sensors/imu_sensor.dart';
import 'package:exhibition/views/settings/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../sensors/sensor_manager.dart';

class User {
  static User? _instance;

  User._();

  static User get instance => _instance ??= User._();

  ///TODO: @Raph: Please revise FireStoreStream to be private
  FireStoreStream fireStoreStream = FireStoreStream();
  NavigationSystem navigationSystem = NavigationSystem();
  late UserProgress userProgress;
  late SaveLocalStorage localStoragePlayerData;

  late Stream locationStream;

  Map<String, dynamic> progress = {};

  var cron = Cron();

  bool onWords = false;
  bool onNums = false;

  Future<void> setup() async {
    await signInAnon();
    cron.schedule(Schedule.parse('0 0 * * *'), () async {
      Notifications().setUpNotifications();
    });
    //_requestLocationPermission();
    //await User.instance.listenForMic();
    Timer(const Duration(seconds: 2), () {
      //noListenForMic();
    });
  }

  Future<void> start(String position, BuildContext context,
      SettingsController settings) async {
    userProgress.id = DateTime.now().millisecondsSinceEpoch;
    localStoragePlayerData = SaveLocalStorage(fileName: ("${userProgress.id}"));
    addProgress("id", userProgress.id);

    /// Checking internet
    if (!kIsWeb) {
      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
          await initialize(context, settings, userProgress);
          SensorManager.instance.locManager.initStream();
          SensorManager.instance.locManager.uploadLocation(position);
          //uploadLocation(position);
        }
      } on SocketException catch (_) {
        print('not connected');
      }
    } else {
      await initialize(context, settings, userProgress);
      SensorManager.instance.locManager.initStream();
      SensorManager.instance.locManager.uploadLocation(position);
      //uploadLocation(position);
    }
    userProgress.score = 0;
    navigationSystem.currentIdx = 0;
    navigationSystem.orderPages();
    goToNextPage(context);
  }

  Future<void> signInAnon() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      print(e);
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  Future<void> initialize(BuildContext context, SettingsController settings,
      UserProgress playerProgress) async {
    await fireStoreStream.initializeDocument(playerProgress, settings, context);
  }

  ///Sets a value at key in the progress map
  void setProgress(String key, dynamic value) {
    progress[key] = value;
  }

  ///Increments value at key by given amount
  void addProgress(String key, dynamic amount) {
    if (progress.containsKey(key)) {
      progress[key] += amount;
    } else {
      progress[key] = amount;
    }
  }

  String getValue(String key) {
    if (progress.containsKey(key)) return progress[key].toString();

    return "[$key] not found in progress map";
  }

  void uploadIMU(String fragmentName, var samples) {
    fireStoreStream.updateRawCollectionIMU(fragmentName, samples);
  }

  //starts listening for IMU
  void listenForIMU() {
    IMUSensor.listen();
  }

  ///Uploads the longitude and latitude of the player in the UI collection
  ///Pass in the name of fragment how you want it to appear in firebase ("start_position"/"end_position")
  void uploadLocation(String fragmentName, var position) {
    fireStoreStream.updateUICollectionStartLocation(fragmentName, position);
  }

  void sendAllTaskFirebase(
      List<String> keys, List<dynamic> values, List<String> types) {
    if (kDebugMode) {
      print("Sending to firebase...");
      print("keys: $keys");
      print("values: $values");
    }

    /// Saving the localJson
    sendAllTaskLocal(keys, values, types);

    for (int i = 0; i < types.length; i++) {
      if (types[i] == "score") {
        uploadScore(keys[i], values[i]);
      } else if (types[i] == "ui") {
        uploadToUI(keys[i], values[i]);
      } else {
        uploadToRaw(keys[i], values[i]);
      }
    }
  }

  Future<void> sendAllTaskLocal(
      List<String> keys, List<dynamic> values, List<String> types) async {
    /// Formatting our json and preparing to send to local file
    Map<String, dynamic>? jsonLocal = await localStoragePlayerData.readLocal();

    /// if readingLocalJson is null, set to default string
    jsonLocal ??= {"score": {}, "ui": {}, "raw": {}};

    print(values);

    /// do operation on the json...
    for (int i = 0; i < types.length; i++) {
      /// During instructions, sometimes tries to send task,
      /// this value is of type Position, therefore if we find
      /// this, just skip;
      if (values[i] is Position) {
        continue;
      }

      if (types[i] == "score") {
        jsonLocal[types[i]][keys[i]] = values[i];
      } else {
        jsonLocal[types[i]][keys[i]] = {"input": {}};
        jsonLocal[types[i]][keys[i]]["input"] = values[i];
      }
    }

    /// Sending our json to a local file
    File currentJson = await localStoragePlayerData.writeLocalTxt(jsonLocal);
    print("File -- ");
    print(await currentJson.readAsString());
  }

  void uploadScore(String key, dynamic score) {
    fireStoreStream.updateScore(key, score);
  }

  void uploadToUI(String key, dynamic value) {
    fireStoreStream.uploadToUICollection(key, value);
  }

  void uploadToRaw(String key, dynamic value) {
    fireStoreStream.updateRawCollection(key, value);
  }

  void goToNextPage(BuildContext context) {
    if (kDebugMode) {
      print("go to next page");
    }
    navigationSystem.nextPage(context);
  }
}
