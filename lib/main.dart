import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/router.dart';

//import 'package:flutter_gen/gen_l10n/intl_generated.dart';

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
    //아래처럼하면 휴대폰에서 설정안바꿔도됨.
    //S.load(const Locale("en"));

    //go_routere 사용하면서 MaterailApp 말고 MaterialApp.router 사용
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false, // debug 할 때 우측상단에 뜨는거 삭제제
      title: 'TikTok Clone',

      // 강제 바꿀때는 페이지를  아래와 같잉 Localizations.override( widdget으로 감싸기기
      /*
      Localizations.override(
      context:context,
      locale: const Locale("es"),
       */

      //flutter에서 제공하는 default 번역파일
      /*        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
         */
      //이렇게 하면 알아서 휴대폰의 언어 파악해서 기본 widget은 번역됨
/*       localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,

        //아래는 직접 만든거
        AppLocalizations.delegate,
      ], */
/*       supportedLocales: const [
        Locale("en"),
        Locale("ko"),
        Locale("es"),
      ], */
      // flutter gen-l10n로 "-l10n.yaml" 직접 만들면 AppLocalization이 몇 개 있는지 아는
      //localizationsDelegates: AppLocalizations.localizationsDelegates,
      //supportedLocales: AppLocalizations.supportedLocales,

      localizationsDelegates: const [
        S.delegate, //S 입력하면 파일자동 import가능
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("ko"),
      ],

      //themeMode만 한다고 되는게아님. theme 내부에 dartkTheme해야함
      //아래내용은 폰이 light 모드여도 dark로 한다  ThemeMode.dark,
      //또는 폰이 dark모드인데도 light모드를 할것이다를 정하는 것.  ThemeMode.light,
      //  ThemeMode.sysstem, 으로 하면됨됨
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        useMaterial3: true,
        //텍스트에 설정된 기본 글자 color(색지정안했을때)
        brightness: Brightness.dark,
        // 1_여기서 flutter 코드 copy"https://m2.material.io/design/typography/the-type-system.html#type-scale"
        //2_ material 3에 해당하는 실물크기 확인 :https://m3.material.io/styles/typography/type-scale-tokens
        //3_또는 GoogleFonts.(원하는폰트)
/*         textTheme: GoogleFonts.itimTextTheme(
          ThemeData(
            brightness: Brightness.dark,
          ).textTheme,
        ),
     */
        scaffoldBackgroundColor: Colors.black,
        //4_직접사이즈 같은거 하고 싶을때때 font랑 칼라만 있는거 사용용  textTheme : Typography.blackMountainView,
        textTheme: Typography.whiteMountainView,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        primaryColor: const Color(0xFFE9435A),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
        ),

        appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
          iconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
          surfaceTintColor: Colors.grey.shade900,
          backgroundColor: Colors.grey.shade900,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),

        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.grey.shade700,
          labelColor: Colors.white,
          indicatorColor: Colors.white,
        ),
      ),

//사실 ThemeDatA로 다 정의안하고, 이미 있는 값 사용가능.
//https://pub.dev/packages/flex_color_scheme
      theme: ThemeData(
        useMaterial3: true,
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade50,
        ),

/*         textTheme: GoogleFonts.itimTextTheme(), */
        //직접사이즈 같은거 하고 싶을때때 -- Typography.blackCupertino,

        textTheme: Typography.blackMountainView,
        brightness: Brightness.light,
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
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),

        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.grey.shade500,
          labelColor: Colors.black,
          indicatorColor: Colors.black,
        ),

        listTileTheme: const ListTileThemeData(
          iconColor: Colors.black,
        ),
      ),
      // home: const SignUpScreen(),
    );
  }
}
