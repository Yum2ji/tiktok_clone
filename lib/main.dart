import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/common/video_config/video_config.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/repos/video_playback_config_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/firebase_options.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/router.dart';

//import 'package:flutter_gen/gen_l10n/intl_generated.dart';

// 본래 async 없어도 되나, futter 특성사용하면서 쓰게됨.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /*
  아래내용처럼 하면, 화면을 옆으로 기울여도 항상 portrait 모드로 움직임.
  */
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

  //shared_preferences 사용하고 있음.
  //videos >> repos >> video_playback_config_repo
  //repository 는 preference를 넘겨져서 초기화 되어야지만  PlaybackConfigViewModel 에서 쓸 수 있음.
  final preferences = await SharedPreferences.getInstance();
  final repository = PlaybackConfigRepository(preferences);

  // preferences 값 자체를 TikTokApp에서 할 수 없음. main에서만 가느함
  // 그렇기 때문에 Multiprovider로 감싸는 것도 TikTokApp 이 아닌 main 에서 사용하는.
  //provider 사용하는 경우는 아래
/*   runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlaybackConfigViewModel(repository),
        )
      ],
      child: const TikTokApp(),
    ),
  ); */

//riverpod 사용하려면 이거거
  runApp(
    ProviderScope(overrides: [
      playbackConfigProvider.overrideWith(
        () => PlaybackConfigViewModel(repository),
      ),
    ], child: const TikTokApp()),
  );
}

class TikTokApp extends ConsumerWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    //아래처럼하면 휴대폰에서 설정안바꿔도됨.
    //S.load(const Locale("en"));

    //1)주의 VideoConfig 로 build 될 때 child도 같이 rebuid 되는데
    //MAterialApp.router가 child 이므로 해당 widget 전체가 항상 같이 rebuild 된다는 걸 알고

    //2)  provier관련 - MaterialApp.router를 ChangeNotifierProvider로 감싸는 경우

    //3 provider 여러개인 경우
    //이렇게 Multiprovider로 하면 context.read 또는 context.watch로 어디에서든 지 접근가능
/*     MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VideoConfig(),
        ),
      ], */

    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
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

/*
terminal에 검색한 것-> 말고 cmd에서 할것
1. flutter와 firebase 연결할때.
Firebase cli window 설치 및 로그인 후.
flutter terminal에서 입력력 
=>> dart pub global activate flutterfire_cli 

2. firebase와 통신하기 위한 config
==> flutterfire configure

3.
=>flutter pub add firebase_core

4. flutterfire configure

5. flutter pub add firebase_auth
flutter pub add cloud_firestore
flutter pub add firebase_storage

6. flutterfire configure

*/

/*

1. git 연동 후  C:\Users\wda93\nomad\tiktok_clone\android> 경로 터미널에서 아래 내용 검색
app<->firebase 사이에 signature를 받는거

./gradlew signinReport


 */