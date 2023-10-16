import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview_demo/services/app_lifecycle.dart';
import 'package:interview_demo/services/shared_preferences_helper.dart';
import 'package:interview_demo/services/user.dart';
import 'package:interview_demo/views/start_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/framework/app_wrapper.dart';

// Toggle this to cause an async error to be thrown during initialization
// and to test that runZonedGuarded() catches the error
const _kShouldTestAsyncErrorOnInit = false;

// Toggle this for testing Crashlytics in your app locally.
const _kTestingCrashlytics = true;

late SharedPreferences prefs;

Future<void> main() async {
  //zoned to capture Flutter errors to crashlytics
  runZonedGuarded(() async {
    //Binding ensures that async functions are settled and null check unnecessary
    WidgetsFlutterBinding.ensureInitialized();

    //await initEchowearComponents();

    prefs = await SharedPreferencesHelper.load();

    //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    //this catches errors that do not lead to fatal crashes
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
    // Makes gradients smoother
    Paint.enableDithering = true;
    //run the main application, set test mode accordingly
    runApp(MyApp());
  }, (error, stack) {
    //Use this to report errors/bugs when deployed
    //FirebaseCrashlytics.instance.recordError(error, stack);
  });
  //This isolate listens to main applications errors
  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    /*await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
    );*/
  }).sendPort);
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //test function for init errors .. can be removed
  Future<void> _testAsyncErrorOnInit() async {
    Future<void>.delayed(const Duration(seconds: 2), () {
      final List<int> list = <int>[];
      if (kDebugMode) {
        print(list[100]);
      }
    });
  }

  // Define an async function to initialize FlutterFire
  /*Future<void> _initializeCrashlytics() async {
    if (_kTestingCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }

    if (_kShouldTestAsyncErrorOnInit) {
      await _testAsyncErrorOnInit();
    }
  }*/

  //setup the shared preferences and initialize with firebase crashlytics
  @override
  void initState() {
    super.initState();
    //_initializeCrashlytics();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: AppWrapper(
        appTitle: "Demo",
        initialRoute: "/start",
        //would normally include an auth provider for some form of sign in
        routes: {
          // main - actively used
          '/start': (context) => const StartPage(),
        },
      ),
    );
  }
}