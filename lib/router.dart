import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';

final router = GoRouter(
  routes: [
    /*
    /username/email 와 같은 nested 형태
     */
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
      routes: [
        GoRoute(
          path: UsernameScreen.routeURL,
          name: UsernameScreen.routeName,
          builder: (context, state) => const UsernameScreen(),
          routes: [
            GoRoute(
              name : EmailScreen.routeName,
                path: EmailScreen.routeURL,
                //builder: (context, state) => const EmailScreen(),
                builder: (context, state) {
                  final args = state.extra as EmailScreenArgs;
                  return EmailScreen(username: args.username);
                }),
          ],
        ),
      ],
    ),
/*     GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ), */

/* child route 사용하기 전.    

 GoRoute(
      //이렇게 name이 설정되면 pushNamed로 사용
      // child router 사용할때 name 사용하는 것이 더 유용?편리?
      name: "username_screen", 
      path: UsernameScreen.routeName,

      //기본 builder
      //builder: (context, state) => const UsernameScreen(),
      //animation 넣는 builder
     pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const UsernameScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
        );
      },
     ), 
     
         GoRoute(
        path: EmailScreen.routeName,
        //builder: (context, state) => const EmailScreen(),
        builder: (context, state) {
          final args = state.extra as EmailScreenArgs;
          return EmailScreen(username: args.username);
        }),
     
     
     */

    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final username = state.params['username'];
        //   final tab = state.queryParams["show"];
        return UserProfileScreen(
          username: username!,
        );
        //return   UserProfileScreen(username : username!, tab : tab!);
      },
    ),
  ],
);
