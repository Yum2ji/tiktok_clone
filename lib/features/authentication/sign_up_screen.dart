import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLogInTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  const Text(
                    "Sign up for Tiktok",
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  const Text(
                    "Create a profile, follow other accounts, make your own videos, and more.",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: Colors.black45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    GestureDetector(
                      onTap: () => _onEmailTap(context),
                      child: const AuthButton(
                        icon: FaIcon(
                          FontAwesomeIcons.user,
                        ),
                        text: "Use phoe or email",
                      ),
                    ),
                    Gaps.v16,
                    const AuthButton(
                      icon: FaIcon(
                        FontAwesomeIcons.apple,
                      ),
                      text: "Continue with Apple",
                    ),
                  ],
                  if (orientation == Orientation.landscape) ...[
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onEmailTap(context),
                            child: const AuthButton(
                              icon: FaIcon(
                                FontAwesomeIcons.user,
                              ),
                              text: "Use phoe or email",
                            ),
                          ),
                        ),
                        Gaps.h16,
                        //AuthButton은 FractionallySizedBox 로 구성됨.
                        // Row의 자식노드에 FractionallySizedBox가 있다면, 부모크기 아 있어야함.
                        // Expanded는 부모 크기에 알아서 맞춰줌.
                        const Expanded(
                          child: AuthButton(
                            icon: FaIcon(
                              FontAwesomeIcons.apple,
                            ),
                            text: "Continue with Apple",
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.grey.shade50,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an acount?'),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLogInTap(context),
                    child: Text(
                      'Log in',
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
