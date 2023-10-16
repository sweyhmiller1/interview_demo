//services
//settings and components
import 'package:exhibition/services/data_reporting/offline/local_get_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../../components/backdrops/frosted_tile.dart';
import '../../components/pop_ups/base_dialog.dart';
import '../../services/data_reporting/online/data_stored_firebase.dart';
import '../../services/sensors/sensor_manager.dart';
import '../../services/user/user_offline/send_local_to_firebase.dart';
import '../../services/user_progress/user_progress.dart';
import '../components/buttons/corner_icon_button.dart';
import '../components/buttons/styled_basic_button.dart';
import '../components/buttons/styled_dropdown_button.dart';
import '../components/graphs/line_graph.dart';
import '../components/inputs/styled_slider.dart';
import '../components/pop_ups/option_select_dialog.dart';
import '../components/texts/text_widgets.dart';
import '../components/theme/colors.dart';
import '../components/theme/layout.dart';
import '../services/internet_manager.dart';
import '../services/user.dart';
import '../settings/settings.dart';

//TODO: implement using stream controllers
/// These are the two main classes used to pass information

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool textFieldFocused = false;
  String currentLoginID = "";

  @override
  void initState() {
    super.initState();
    User.instance.setup();
  }

  void showGraph(List<List<double>> data, List<String> titles,
      List<double> averages, BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        int selectedGraph = 0;

        return StatefulBuilder(builder: (context, setState) {
          return BaseDialog(
            title: HeadlineText("Insights", color: ThemeColors.onBackground),
            content: SingleChildScrollView(
              child: data.isNotEmpty
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StyledDropdownButton(
                          text: titles[selectedGraph].replaceAll("_", " "),
                          label: "Current chart:",
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return OptionSelectDialog(
                                  title: "Select a chart",
                                  options: titles
                                      .map(
                                          (title) => title.replaceAll("_", " "))
                                      .toList(),
                                  onPressed: (val) {
                                    setState(() {
                                      selectedGraph = val;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: Layout.minContainerSpacing * 3),
                        AspectRatio(
                          aspectRatio: 1,
                          child: LineGraph(
                            context: context,
                            data: data[selectedGraph],
                          ),
                        ),
                        const SizedBox(height: Layout.minContainerSpacing),
                        Flexible(
                          child: LabelText(
                            "Average: ${averages[selectedGraph]}",
                            color: ThemeColors.onBackground,
                          ),
                        ),
                        const SizedBox(height: Layout.minContainerSpacing),
                        StyledBasicButton(
                          text: "Show values",
                          isWide: true,
                          onPressed: (_, __) {
                            int selectedDataPoint = 0;

                            showDialog(
                              context: context,
                              builder: (context) => StatefulBuilder(
                                builder: (context, setState) {
                                  return BaseDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        StyledSlider(
                                          leftLabel: "First test",
                                          rightLabel: "Last test",
                                          leftValue: 0,
                                          rightValue:
                                              data[selectedGraph].length - 1,
                                          onChanged: (val) {
                                            setState(() {
                                              selectedDataPoint = val;
                                            });
                                          },
                                        ),
                                        const SizedBox(
                                            height:
                                                Layout.minContainerSpacing * 3),
                                        Flexible(
                                          child: HeadlineText(
                                            "${titles[selectedGraph].replaceAll("_", " ")} (${selectedDataPoint + 1}/${data[selectedGraph].length}):\n${data[selectedGraph][selectedDataPoint]}",
                                            color: ThemeColors.onBackground,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  : LabelText(
                      "No Data Available - Try Taking A Test",
                      color: ThemeColors.onBackground,
                    ),
            ),
          );
        });
      },
    );
  }

  /// TODO(raph): Remove and organize once done debugging
  doStuff(SettingsController settings, BuildContext context) async {
    /// Dev option -- uncomment code and set your data to a group
    // FirebaseData firebaseData =
    //     FirebaseData(group: 'caretest_v21', name: 'nick');

    late Map<String, dynamic> dataToBeSent;
    if (await InternetManager().isOnline) {
      FirebaseData firebaseData = FirebaseData(
          group:
              '${settings.groupName.value}_v${await PackageInfo.fromPlatform().then((value) => value.buildNumber)}',
          name: settings.playerName.value);
      dataToBeSent = await firebaseData.queryAllAndReturnGraphingData();
    } else {
      dataToBeSent = await LocalGetData().queryDataAndOrganizeMapForGraphing();
    }

    showGraph(dataToBeSent["data"], dataToBeSent["titles"],
        dataToBeSent["averages"], context);
  }

  @override
  Widget build(BuildContext context) {
    User.instance.userProgress = context.watch<UserProgress>();
    SendLocalToFirebase()
        .startTransactionBetweenLocalDeviceAndAPI(settings, context);
    return Container(
      height: Layout.getScreenHeight(context),
      color: Theme.of(context).colorScheme.background,
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(Layout.pagePadding),
              alignment: Alignment.center,
              child: Visibility(
                visible: !textFieldFocused,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (MediaQuery.of(context).size.height >= 550)
                      const Flexible(child: BrandIcon()),
                    DisplayText(
                      "EZ-Aware",
                      selectable: false,
                      color: Theme.of(context).colorScheme.primary,
                      fontSizeVariant: FontSizeVariant.large,
                    ),
                    SizedBox(height: Layout.minButtonSpacing),
                    if (MediaQuery.of(context).size.height >= 400)
                      FrostedTile(
                        child: MediaQuery.of(context).size.height < 400
                            ? BodyText(
                                "A brief cognition and memory test",
                                selectable: false,
                                color: Theme.of(context).colorScheme.onSurface,
                              )
                            : DisplayText("A brief cognition and memory test",
                                selectable: false,
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSizeVariant: FontSizeVariant.large),
                      ),
                    MediaQuery.of(context).size.height < 350
                        ? const SizedBox.shrink()
                        : SizedBox(height: Layout.minButtonSpacing * 2),
                    StyledBasicButton(
                      text: "Start",
                      isWide: true,
                      onPressed: (_, __) async {
                        SensorManager.instance.ttsManager.setup();
                        await SensorManager.instance.micManager
                            .checkPermissions();
                        await SensorManager.instance.micManager.setUpAnon();
                        await SensorManager.instance.locManager
                            .checkPermissions();
                        User.instance
                            .start("start_position", context, settings);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              children: [
                CornerIconButton(
                  icon: Icons.insights,
                  side: CornerIconButtonSide.bottomRight,
                  onPressed: () {
                    doStuff(settings, context);
                  },
                ),
                const Spacer(),
                CornerIconButton(
                  icon: Icons.settings,
                  side: CornerIconButtonSide.bottomLeft,
                  onPressed: () {
                    setState(() {
                      if (settings.fullModeOn.value) {
                        if (kDebugMode) {
                          print("It's in full mode!");
                        }
                      }
                      Navigator.pushNamed(context, '/settings');
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BrandIcon extends StatelessWidget {
  const BrandIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 200,
          maxHeight: 200,
        ),
        child: Image.asset(
          "images/starticon.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
