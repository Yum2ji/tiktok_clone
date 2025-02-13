import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_botton.dart';

class UsernameScreen extends StatefulWidget {
  static String routeURL = "username"; // child 방식으로 하면 /가 필요없음음
  static String routeName = "username";
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameConroller = TextEditingController();
  String _username = "";

  @override
  void initState() {
    super.initState();
    _usernameConroller.addListener(() {
      setState(() {
        _username = _usernameConroller.text;
      });
    });
  }

  @override
  void dispose() {
    _usernameConroller.dispose();
    //init에서는 super 먼저 init, dispose는 super.dispose가 마지막
    super.dispose();
  }

  void _onNextTap() {
    if (_username.isEmpty) return;

    //여기서는 context로 input 받지않음. stateful 위젯으로 하면 context 받음
    //context input으로정의해도 되긴함.
/*     Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmailScreen(),
      ),
    ); */

/*     Navigator.pushNamed(
      context,
      EmailScreen.routeName,
      arguments: EmailScreenArgs(
        username: _username,
      ),
    ); */

/*     context.push(
      EmailScreen.routeName, // 여기서는 "/email" 과 같은 url 형태였음
      extra: EmailScreenArgs(
        username: _username,
      ),
    ); */

    context.pushNamed(
      EmailScreen.routeName, // 여기서는 "email" 과 같은 name 형태임.
      extra: EmailScreenArgs(
        username: _username,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "Create username",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v8,
            const Text(
              "You can always change this later.",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _usernameConroller,
              decoration: InputDecoration(
                hintText: "Username",
                //enabledBorder , focusedBorder 2개 조합을 같게해서 항상 같은 색나오게
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v16,
            //TextButton 같은거로 써도되긴하는데 anaimated하기 더편한
            GestureDetector(
                onTap: _onNextTap,
                child: FormButton(disabled: _username.isEmpty)),
          ],
        ),
      ),
    );
  }
}
