import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_botton.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();
  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(initialDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    //init에서는 super 먼저 init, dispose는 super.dispose가 마지막
    super.dispose();
  }

  void _onNextTap() {
    //여기서는 context로 input 받지않음. stateful 위젯으로 하면 context 받음
    //context input으로정의해도 되긴함.

// Navogator.of(context).push를 쓰면 로그인하고 다음 페이지 넘어가도 다시 뒤로로 가는 문제존재.
// 따라서, pushAndRemoveUntil을 사용.
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const InterestsScreen()),
            (route) {
              //predicate, 여기는 previous route 쓸지 안쓸지를 정하는 부분임.
              //return false 하면 항상, 모든 내용을 안쓰게 됨.
          return false;
        });
  
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
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
              "When's your birthday?",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v8,
            const Text(
              "Your birthday won't be shown publicly",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              enabled: false,
              controller: _birthdayController,
              decoration: InputDecoration(
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
                onTap: _onNextTap, child: const FormButton(disabled: false)),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height : 200,
        child: SizedBox(
          height: 300,
          child: CupertinoDatePicker(
            maximumDate: initialDate,
            initialDateTime: initialDate,
            mode : CupertinoDatePickerMode.date,
            onDateTimeChanged: _setTextFieldDate,
          ),
        ),
      ),
    );
  }
}
