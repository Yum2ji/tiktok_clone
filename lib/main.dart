import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok Clone',
      theme: ThemeData(
        //길게 눌렀을 때 번쩍이는 효과를 ㄹ없애는 방법 highlightcolor를 transparent로
       // highlightColor: Colors.transparent,
        //tap 했을 때, 번쩍이는 효과 없애는 방법 splashcolor를 transparent로
       splashColor: Colors.transparent,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor:  Color(0xFFE9435A),
        ),
      scaffoldBackgroundColor:  Colors.white,
       primaryColor:  const Color(0xFFE9435A),
       appBarTheme:  const AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: Sizes.size16 + Sizes.size2,
          fontWeight: FontWeight.w600,
        ),
       ),
      ),
      home: const ActivityScreen()
    );
  }
}

