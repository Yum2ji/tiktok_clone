import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Scaffold(
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
      body: ListView(
        children: [
          // ListTile(
          //   //showAboutDiaglog는 자동으로 만들어있는함수.
          //   //여기서 Licnese 누르면 관련있는 소스정보들이 다 나와있음.
          //   // 어플은 사용중인 모든 오픈소스 소프트웨어 및 라이센스를 고지해야함.
          //   onTap: () => showAboutDialog(
          //       context: context,
          //       applicationVersion: "1.0",
          //       applicationLegalese:
          //           "All rights reserved. Please don't copy me."),
          //   title: const Text(
          //     "About",
          //     style: TextStyle(
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          //   subtitle: const Text("About this app....."),
          // ),

          // CupertinoSwitch(
          //   value: _notification,
          //   onChanged: _onNotificationsChanged,
          // ),

          // Switch(
          //   value: _notification,
          //   onChanged: _onNotificationsChanged,
          // ),
          // //adaptive를 쓰면 android는 android 용, ios는 ios 용. web은 web용
          // Switch.adaptive(
          //   value: _notification,
          //   onChanged: _onNotificationsChanged,
          // ),

          // SwitchListTile(
          //   value: _notification,
          //   onChanged: _onNotificationsChanged,
          //   title: const Text(
          //     "Enable notification",
          //   ),
          // ),

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

          // Checkbox(
          //   value: _notification,
          //   onChanged: _onNotificationsChanged,
          // ),

          // CheckboxListTile(
          //   checkColor: Colors.white,
          //   activeColor: Colors.black,
          //   value: _notification,
          //   onChanged: _onNotificationsChanged,
          //   title: const Text(
          //     "Enable notification",
          //   ),
          // ),

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
              print(date);

              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              print(time);

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
              print(booking);
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
    );
  }
}
