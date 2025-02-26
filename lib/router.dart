import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/chat_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_recording_screen.dart';

final routerProvider = Provider(
  (ref) {
    // ref.watch(authState); 이 부분은 변화감지 . redirect 부분이 변화감지 후 실제 동작
    //ref.watch(authState);
    return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;

        if (!isLoggedIn) {
          /*subloc 은 sublocation으로 user가 있는 위치
         */
          if (state.subloc != SignUpScreen.routeURL &&
              state.subloc != LoginScreen.routeURL) {
            return SignUpScreen.routeURL;
          }
        } else
          null;
        return null;
      },
      routes: [
        //study -> commit 했던 거 이력 찾아서 확인
        GoRoute(
          name: SignUpScreen.routeName,
          path: SignUpScreen.routeURL,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          name: LoginScreen.routeName,
          path: LoginScreen.routeURL,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: InterestsScreen.routeName,
          path: InterestsScreen.routeURL,
          builder: (context, state) => const InterestsScreen(),
        ),
        GoRoute(
          name: MainNavigationScreen.routeName,
          // "/:tab" 이런식으로 하면 tab에 오는 어떤 거든 사용가능해지는데,
          // 제한 둘때는 괄호속에 입력  "/:tab(home|discover|inbox|profile)"
          path: "/:tab(home|discover|inbox|profile)",
          builder: (context, state) {
            final tab = state.params["tab"]!;
            return MainNavigationScreen(
              tab: tab,
            );
          },
        ),
        GoRoute(
          name: ActivityScreen.routeName,
          path: ActivityScreen.routeURL,
          builder: (context, state) => const ActivityScreen(),
        ),
        GoRoute(
          name: ChatScreen.routeName,
          path: ChatScreen.routeURL,
          builder: (context, state) => const ChatScreen(),
          routes: [
            GoRoute(
              name: ChatDetailScreen.routeName,
              path: ChatDetailScreen.routURL,
              builder: (context, state) {
                final chatId = state.params["chatId"]!;
                return ChatDetailScreen(chatId: chatId);
              },
            ),
          ],
        ),
        GoRoute(
          name: VideoRecordingScreen.routeName,
          path: VideoRecordingScreen.routeURL,
          //builder: (context, state) => const VideoRecordingScreen(),

          //pageBuilder 사용해서 cutomize 하려고
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const VideoRecordingScreen(),
            transitionDuration: const Duration(
              milliseconds: 200,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              //bottom에서 올라오도록 animation 만듦.
              final position = Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation);
              return SlideTransition(
                position: position,
                child: child,
              );
            },
          ),
        )
      ],
    );
  },
);
