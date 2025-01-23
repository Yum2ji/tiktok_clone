import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;

  const AuthButton({
    super.key,
    required this.text, 
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      //FractionallySizedBox relative size to parents widget
      widthFactor: 1, //1이면 fathersize
      child: Container(
         padding : const EdgeInsets.symmetric(
            horizontal: Sizes.size14,
            vertical: Sizes.size14,
          ),
        decoration: BoxDecoration(
          border: Border.all(
            color : Colors.grey.shade300,
            width: Sizes.size1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center ,
          children: [
            //Align 은 특정1개만 widget만 움직임 insde Stack
            Align(
              alignment: Alignment.centerLeft,
              child : icon,
            ),
            Text(text,
            style: const TextStyle(
              fontSize: Sizes.size16,
              fontWeight : FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
