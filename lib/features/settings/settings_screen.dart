import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/video_config/video_config.dart';
import 'package:tiktok_clone/constants/breakpoint.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notification = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notification = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Localizations.override(
      context: context,
      locale: const Locale("es"),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Settings"),
          // CloseButton(), iconbutton 같은 거 없이도 뒤로가는 widget. 여기서는 안씀

          //body 부분에서 ListWheelScrollView를 쓸수도 있음음
          //   ListWheelScrollView(

          //   diameterRatio: 1.5,
          //   offAxisFraction: 1.5,

          //  // useMagnifier: true,
          //  // magnification: 1.5,

          //   itemExtent: 200,
          //   children: [
          //     for (var x in [
          //       1,
          //       2,
          //       3,
          //       4,
          //       5,
          //       6,
          //       5,
          //       8,
          //       9,
          //       8,
          //     ])
          //       FractionallySizedBox(
          //         widthFactor: 1,
          //         child: Container(
          //           color: Colors.teal,
          //           alignment: Alignment.center,
          //           child: const Text(
          //             "Pick me",
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 39,
          //             ),
          //           ),
          //         ),
          //       )
          //   ],
          // ),

          // 이런  Indicator widget들도 있음
          //  Column(
          //   children: [
          //     CupertinoActivityIndicator(
          //       radius: 40,
          //       //animating: false,
          //     ),
          //     CircularProgressIndicator(),
          //     // CircularProgressIndicator.adaptive(), 내용은 ios 이든 android 든 실행되는는
          //     //android 에서는 andorid 모양으로 ios 에는 ios 모양으로.
          //     CircularProgressIndicator.adaptive(),
          //   ],
          // ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: width > Breakpoints.sm ? Breakpoints.sm : width,
              ),
              child: ListView(
                children: [
                  // SwitchListTile.adaptive의 value 값은 초기 set 해준 값임.
                  //그렇기 때문에 AnimatedBuilder 같은거로 값을 listen? 및 변경해줄수 있는 것이 필요함.
                  // changenotifier를 사용하지 않은 경우(inherited 인 경우)에는 무관함.
                  // 장점은 rebuild 되는 영역이 딱 AnimatedBuilder라고 된 부분일뿐
                  // 왜냐면 기존에 Inherited 썼을 때는 main에서 MaterialApp.router 자체를 VideoConfig로 감싸는 일이 필요해서
                  // 전체가 다 rebuild 필요했음
                  //AnimatedBuilder 대신 valueListeablebuilder 도 사용가능능
/*                   AnimatedBuilder(
                    animation: videoConfig,
                    //다른 종류의switch는ㄴ git 가서 확인.
                    builder: (context, child) =>  SwitchListTile.adaptive(
                      value: videoConfig.value,
                      //videoConfig.autoMute, // 이거는 ChangeNotifier 쓸때때
                      //VideoConfigData.of(context).autoMute,
                      onChanged: (value) {
                        videoConfig.value = !videoConfig.value;
                       // videoConfig.toggleAutoMute();  // 이거는 ChangeNotifier 쓸때때
                        //  VideoConfigData.of(context).toggleMuted();
                      },
                      title: const Text(
                        "Auto Mute",
                      ),
                      subtitle: const Text(
                        "Videos will be muted by default",
                      ),
                    ),
                  ),
 */
/*                   ValueListenableBuilder(
                    valueListenable: videoConfig,
                    //다른 종류의switch는ㄴ git 가서 확인.
                    builder: (context, value, child) => SwitchListTile.adaptive(
                      value: videoConfig.value,
                      //videoConfig.autoMute, // 이거는 ChangeNotifier 쓸때때
                      //VideoConfigData.of(context).autoMute,
                      onChanged: (value) {
                        videoConfig.value = !videoConfig.value;
                        // videoConfig.toggleAutoMute();  // 이거는 ChangeNotifier 쓸때때
                        //  VideoConfigData.of(context).toggleMuted();
                      },
                      title: const Text(
                        "Auto Mute",
                      ),
                      subtitle: const Text(
                        "Videos will be muted by default",
                      ),
                    ),
                  ),
 */

//아래내용은 main 에서  multiprovider 사용하는 경우 해당당
/*                   SwitchListTile.adaptive(
                    value: context.watch<VideoConfig>().isMuted,
                    onChanged: (value) => context.read<VideoConfig>().toggleIsMuted(),
                    title: const Text(
                      "Auto Mute",
                    ),
                    subtitle: const Text(
                      "Videos muted by defaults",
                    ),
                  ), */

                  SwitchListTile.adaptive(
                    value: context.watch<PlaybackConfigViewModel>().muted,
                    onChanged: (value) => context.read<PlaybackConfigViewModel>().setMuted(value),
                    title: const Text(
                      "Mute video",
                    ),
                    subtitle: const Text(
                      "Video will be muted by default",
                    ),
                  ),


                  SwitchListTile.adaptive(
                    value: context.watch<PlaybackConfigViewModel>().autoplay,
                    onChanged: (value) => context.read<PlaybackConfigViewModel>().setAutoplay(value),
                    title: const Text(
                      "autoplay",
                    ),
                    subtitle: const Text(
                      "Video will start playing automatically",
                    ),
                  ),

                  //adaptive를 쓰면 android는 android 용, ios는 ios 용. web은 web용
                  SwitchListTile.adaptive(
                    value: _notification,
                    onChanged: _onNotificationsChanged,
                    title: const Text(
                      "Enable notification",
                    ),
                    subtitle: const Text(
                      "sub-Enable notification",
                    ),
                  ),

                  // //adaptive를 쓰면 android는 android 용, ios는 ios 용. web은 web용
                  CheckboxListTile.adaptive(
                    checkColor: Colors.white,
                    activeColor: Colors.black,
                    value: _notification,
                    onChanged: _onNotificationsChanged,
                    title: const Text(
                      "Enable notification",
                    ),
                  ),

                  ListTile(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1980),
                        lastDate: DateTime(2030),
                      );
                      if (kDebugMode) {
                        print(date);
                      }

                      if (!mounted) return;
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (kDebugMode) {
                        print(time);
                      }

                      if (!mounted) return;
                      final booking = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(1980),
                        lastDate: DateTime(2030),
                        //ios 사용하면 save 버튼이 안 보임. 따라서 ThemeDAta를 만들어줌.
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData(
                              appBarTheme: const AppBarTheme(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (kDebugMode) {
                        print(booking);
                      }
                    },
                    title: const Text(
                      "What is your birthday",
                    ),
                    subtitle: const Text("I need to Know"),
                  ),
                  //위에서 ListTile로 만들었는데 해당부분말고 AboutTlistTile로 해도 됨.

                  // showCupertinoDialog 이거대신 CupertinoModalpopup 를 사용하면 dismiss 기능이 있음 배경누르면 알아서 alert down
                  ListTile(
                    title: const Text(
                      "Log out (ios style)",
                    ),
                    textColor: Colors.red,
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text("Are you sure?"),
                          content: const Text("Please don't go"),
                          actions: [
                            CupertinoDialogAction(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                "No",
                              ),
                            ),
                            CupertinoDialogAction(
                              onPressed: () => Navigator.of(context).pop(),
                              isDestructiveAction: true,
                              child: const Text(
                                "Yes",
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  ListTile(
                    title: const Text(
                      "Log out (android style)",
                    ),
                    textColor: Colors.red,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          icon: const FaIcon(FontAwesomeIcons.skull),
                          title: const Text("Are you sure?"),
                          content: const Text("Please don't go"),
                          actions: [
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const FaIcon(FontAwesomeIcons.car),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                "Yes",
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  //ShowCuptertinoDIalog +CupertinoActionShee를썼으면  ios 에서는  botton 이 아닌 상단표기 + dismissbla 동작안함함
                  ListTile(
                    title: const Text(
                      "Log out (ios/bottom)",
                    ),
                    textColor: Colors.red,
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          title: const Text(
                            "Are you sure?",
                          ),
                          message: const Text(
                            "Plz don't go",
                          ),
                          actions: [
                            CupertinoActionSheetAction(
                              isDefaultAction: true, // default 값은 글씨 bold체
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                "Not log out",
                              ),
                            ),
                            CupertinoActionSheetAction(
                              isDestructiveAction: true, // color red로 되는는
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                "Yes Plz",
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const AboutListTile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
