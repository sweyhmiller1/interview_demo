import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../theme/locale.dart';
import '../theme/theme.dart';
import '../util/no_transitions_builder.dart';

const List<Breakpoint> __breakpoints = [
  Breakpoint(start: 0, end: 480, name: MOBILE),
  Breakpoint(start: 481, end: 768, name: TABLET),
  Breakpoint(start: 769, end: 1024, name: DESKTOP),
  Breakpoint(start: 1200, end: double.infinity, name: 'XL'),
];

/// A wrapper for an app, containing a `MaterialApp`. It sets
/// up various theming properties as well as responsive
/// breakpoints for layouts. In addition, it manages the routes
/// used for pages in the app.
class AppWrapper extends StatelessWidget {
  const AppWrapper({
    Key? key,
    required this.appTitle,
    required this.initialRoute,
    this.routes = const {},
    this.providers = const [],
    this.isTestMode = false,
    this.navigatorKey,
    this.onGenerateRoute,
  }) : super(key: key);

  /// A flag indicating whether the application is running in test
  /// mode (default is `false`).
  final bool isTestMode;

  /// The title of the application.
  final String appTitle;

  /// The initial route to navigate to when the application starts.
  final String initialRoute;

  /// A map that associates routes (route names) with builder
  /// functions that create corresponding widgets.
  final Map<String, Widget Function(BuildContext)> routes;

  /// Provides data to various node widgets.
  final List<SingleChildWidget> providers;

  /// An optional navigator key used to navigate the app without using
  /// the BuildContext.
  final GlobalKey<NavigatorState>? navigatorKey;

  /// An optional onGenerateRoute function that is called when the
  /// application tries to navigate to a named route that is not
  /// defined in the [routes] map.
  final Route<dynamic> Function(RouteSettings)? onGenerateRoute;

  @override
  Widget build(BuildContext context) {
    return ModelBinding(
      initialModel: ThemeOptions(
        themeMode: ThemeMode.system,
        textScaleFactor: AppThemeData.systemTextScaleFactorOption,
        customTextDirection: CustomTextDirection.localeBased,
        locale: deviceLocale,
        timeDilation: timeDilation,
        platform: defaultTargetPlatform,
        isTestMode: isTestMode,
      ),
      child: _OptionalMultiProvider(
        providers: providers,
        child: Builder(
          builder: (context) {
            //The main application for the user
            return MaterialApp(
              builder: (context, child) => ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: __breakpoints,
                breakpointsLandscape: __breakpoints,
              ),
              //banner to remind one of the debugging state
              debugShowCheckedModeBanner: false,
              // base our theme off of the system running the application
              themeMode: ThemeMode.system,
              //   light theme is default
              theme: AppThemeData.lightThemeData.copyWith(
                platform: defaultTargetPlatform,
                pageTransitionsTheme: PageTransitionsTheme(
                  builders: {
                    for (final platform in TargetPlatform.values)
                      platform: const NoTransitionsBuilder(),
                  },
                ),
              ),
              //  dark is the alternative
              darkTheme: AppThemeData.darkThemeData.copyWith(
                platform: defaultTargetPlatform,
                pageTransitionsTheme: PageTransitionsTheme(
                  builders: {
                    for (final platform in TargetPlatform.values)
                      platform: const NoTransitionsBuilder(),
                  },
                ),
              ),
              title: appTitle,
              initialRoute: initialRoute,
              routes: routes,
              navigatorKey: navigatorKey,
              onGenerateRoute: onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}

class _OptionalMultiProvider extends StatelessWidget {
  const _OptionalMultiProvider({
    Key? key,
    required this.providers,
    required this.child,
  }) : super(key: key);

  final List<SingleChildWidget> providers;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (providers.isNotEmpty) {
      return MultiProvider(
        providers: providers,
        child: child,
      );
    }
    return child;
  }
}