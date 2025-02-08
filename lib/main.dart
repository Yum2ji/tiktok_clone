import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';

// 본래 async 없어도 되나, futter 특성사용하면서 쓰게됨.
void main() async {
  /*
  아래내용처럼 하면, 화면을 옆으로 기울여도 항상 portrait 모드로 움직임.
  */

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  /*
  아래의 dark 모드는 main에서 할 필요 없음.
  각 페이지별로 하면 됨.
  */
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );

  //widget이 생성되기 전에 engine셋팅하고 싶으면 이 부분 이전에.
  //engin하고 widget 연결확실하게   --WidgetsFlutterBinding.ensureInitialized();
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // debug 할 때 우측상단에 뜨는거 삭제제
      title: 'TikTok Clone',
      theme: ThemeData(
        //길게 눌렀을 때 번쩍이는 효과를 ㄹ없애는 방법 highlightcolor를 transparent로
        // highlightColor: Colors.transparent,
        //tap 했을 때, 번쩍이는 효과 없애는 방법 splashcolor를 transparent로
        splashColor: Colors.transparent,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        appBarTheme: const AppBarTheme(
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
      home: const SignUpScreen(),
    );
  }
}
