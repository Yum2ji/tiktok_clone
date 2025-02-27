import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/video_config/video_config.dart';
import 'package:tiktok_clone/constants/breakpoint.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

//riverpot 쓰면서 ConsumerWidget 으로 바꿈 listen 히려고
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

/*   bool _notification = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notification = newValue;
    });
  }
 */
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Localizations.override(
      context: context,
      locale: const Locale("es"),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Settings"),
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
                  SwitchListTile.adaptive(
                    value: ref.watch(playbackConfigProvider).muted,
                    onChanged: (value) => ref
                        .read(playbackConfigProvider.notifier)
                        .setMuted(value),
                    title: const Text(
                      "Mute video",
                    ),
                    subtitle: const Text(
                      "Video will be muted by default",
                    ),
                  ),

                  SwitchListTile.adaptive(
                    value: ref.watch(playbackConfigProvider).autoplay,
                    onChanged: (value) => ref
                        .read(playbackConfigProvider.notifier)
                        .setAutoplay(value),
                    title: const Text(
                      "autoplay",
                    ),
                    subtitle: const Text(
                      "Video will start playing automatically",
                    ),
                  ),

                  SwitchListTile.adaptive(
                    value: false,
                    onChanged: (value) {},
                    title: const Text(
                      "Enable notification",
                    ),
                    subtitle: const Text(
                      "sub-Enable notification",
                    ),
                  ),

                  CheckboxListTile.adaptive(
                    checkColor: Colors.white,
                    activeColor: Colors.black,
                    value: false,
                    onChanged: (value) {},
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

                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (kDebugMode) {
                        print(time);
                      }

                      final booking = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(1980),
                        lastDate: DateTime(2030),
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
                              onPressed: () {
                                ref.read(authRepo).signOut();
                                context.go("/"); // router에서 ref.watch(authState); 이렇게 되었다면 없어도 되는 부분
                              },
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
