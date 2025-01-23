import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/password_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_botton.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailConroller = TextEditingController();
  String _email = "";

  @override
  void initState() {
    super.initState();
    _emailConroller.addListener(() {
      setState(() {
        _email = _emailConroller.text;
      });
    });
  }

  @override
  void dispose() {
    _emailConroller.dispose();
    //init에서는 super 먼저 init, dispose는 super.dispose가 마지막
    super.dispose();
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;

    final reExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!reExp.hasMatch(_email)) {
      return "Not Valid";
    }
    return null;
  }

  // gesture로 ontap지정된 부분 외에 다른 영역에서
  // 클릭되면 활성화된 키보드가 없어진다거나 하는
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
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
                "What is your email?",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: _emailConroller,
                //keyboard 에 @ 표현되는
                keyboardType: TextInputType.emailAddress,
                //키보드에 있는 done버튼 누르면된느거
                // onsubmitted 옵션도 있는데, 들어가는 값을 아는 경우에 사용((value) =>). obsubmit 써도되지만 우리는 onEditingcomplete(() =>)
                onEditingComplete :_onSubmit,
                //키보드 자동완성부분 없애는
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "Email",
                  errorText: _isEmailValid(),

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
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(disabled: _email.isEmpty || _isEmailValid() != null)),
            ],
          ),
        ),
      ),
    );
  }
}
