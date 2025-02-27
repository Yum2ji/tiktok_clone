import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/router.dart';
import 'package:tiktok_clone/utils.dart';

//자동으로  복사가 안된다는 단점.
//import 'package:flutter_gen/gen_l10n/intl_generated.dart';

class SignUpScreen extends ConsumerWidget {
  static String routeURL = "/";
  static const routeName = "signUp";
  const SignUpScreen({super.key});

  void _onLogInTap(BuildContext context) async {
/*     final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
    print(result); */

//router version1
/*     final result = await  Navigator.of(context).pushNamed(LoginScreen.routeName);
    print(result); */

    //router version2 - go_router
    //  context.push(LoginScreen.routeName);
    //go 는 stack으로 쌓이는 구조는 아닌 => web에서 back 버튼이 없어지는 stack 구조가 아니라.
    // context.go(LoginScreen.routeName);

    context.pushNamed(LoginScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
/*
      PageRouteBuilder(
        transitionDuration: const Duration(
          seconds: 1,
        ),
        reverseTransitionDuration: const Duration(
          seconds: 1,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);
          final opacityAnimation = Tween(
            begin:0.5,
            end:1.0,
          ).animate(animation);


          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: opacityAnimation,
              child: child,
            ),
          );
        },
// transitionsBuilder ScaleTransition 으로 감싸는 경우는 arrow로 표기하면됨됨
/*                    =>     ScaleTransition(
              
              child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
            ),
 */

        pageBuilder: (context, animation, secondaryAnimation) =>
            const UsernameScreen(),
      ),
    ); */

    //   Navigator.of(context).pushNamed(UsernameScreen.routeName);

    //변수를 주소에 넣어주는 경우 -param 사용
    // context.push("/users/yumi?show=likes");
    //go router에서 name 설정안된경우
    // context.push(UsernameScreen.routeName);
    // go router에서 name 설정된 경우
    // context.pushNamed("username_screen");
    //go router에서 child router 사용하는경우우
//context.pushNamed(UsernameScreen.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //OrientationBuilder 휴대폰 화면관련 기능능
    return OrientationBuilder(
      builder: (context, orientation) {
        //아래처럼 휴대폰 회전되었을 때 사용자께 화면을 띄우는 방법
        //또는 아래처럼 화면띄우지 말고, main 쪽에서 처리하는 방법있음.
/*         if(orientation == Orientation.landscape){
          return const Scaffold(
            body: Center(
              child: Text("Plez rotate your  the phone."),
            ),
          );
        } */

        print(orientation);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    S.of(context).signUptitle("TikTok"),
                    /*
                 {
  "signUptitle": "Sign up for {nameofTheApp} {when}",
  "@signUptitle": {
    "description": "The title people see when they open the app for the fist time.",
    "placeholders": {
      "nameofTheApp": {
        "type": "String",
        "example": "TikTok"
      },
      "when":{
        "type": "DateTime",
        "format": "y",
        "isCustomDateFormat": "true"
      }
    }
  },
                 */
                    //                S.of(context).signUptitle("TikTok",  DateTime.now()),
                    //style: Theme.of(context).textTheme.headlineMedium,
/*                     style:Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.red
                    ), */
                    //아래처럼 일부만 특정폰트로도 가능
/*                     style: GoogleFonts.abrilFatface(
                      textStyle: const TextStyle(
                        fontSize: Sizes.size24,
                        fontWeight: FontWeight.w700,
                        
                      ),
                    ), */
                    style: const TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      S.of(context).signUpSubtitle(0),
/*                       style: TextStyle(
                        fontSize: Sizes.size16,

                        // black45처럼 특정 color 지정한경우.
                        //아래처럼 함수써서 color를 직접 선언하는 방법도 있지만 dark모드 쓰는 경우 그냥
                        //Opacity로 감싸는 방법도있음음
                        /*                       color: isDarkMode(context)
                            ? Colors.grey.shade300
                            : Colors.black45, */
                      ), */
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    GestureDetector(
                      onTap: () => _onEmailTap(context),
                      child: AuthButton(
                        icon: const FaIcon(
                          FontAwesomeIcons.user,
                        ),
                        text: S.of(context).emailPasswordButton,
                      ),
                    ),
                    Gaps.v16,
                    GestureDetector(
                      onTap: () =>
                          ref.read(socialAuthProvider.notifier).githubSignIn(context),
                      child: const AuthButton(
                        icon: FaIcon(
                          FontAwesomeIcons.github,
                        ),
                        text: "Continue with Github",
                      ),
                    ),
                  ],
                  if (orientation == Orientation.landscape) ...[
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onEmailTap(context),
                            child: AuthButton(
                              icon: const FaIcon(
                                FontAwesomeIcons.user,
                              ),
                              text: S.of(context).emailPasswordButton,
                            ),
                          ),
                        ),
                        Gaps.h16,
                        //AuthButton은 FractionallySizedBox 로 구성됨.
                        // Row의 자식노드에 FractionallySizedBox가 있다면, 부모크기 아 있어야함.
                        // Expanded는 부모 크기에 알아서 맞춰줌.
                        Expanded(
                          child: GestureDetector(
                            onTap: () => ref
                                .read(socialAuthProvider.notifier)
                                .githubSignIn(context),
                            child: const AuthButton(
                              icon: FaIcon(
                                FontAwesomeIcons.github,
                              ),
                              text: "Continue with Github",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          //Material3를 쓰면 bottomappbar 모양이 달라질 수도
          ////BottomAppBar 대신 container사용, 그리고 padding다시
          bottomNavigationBar: Container(
            //darkmode 구분하려면 Main에서 구분분
            color: isDarkMode(context) ? null : Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size32,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).alreadyHaveAnAcount),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLogInTap(context),
                    child: Text(
                      S.of(context).logIn("female"),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
