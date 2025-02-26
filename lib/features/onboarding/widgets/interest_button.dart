import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class InterestButton extends StatefulWidget {
  const InterestButton({
    super.key,
    required this.interest,
  });

  final String interest;

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 300,
        ),
        //ListView는 APi 에서 가져온 데이터 갯수 모르거나 할때.
        // 여기서는 갯수가 적은 데이터라 for 사용
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size24,
        ),
        decoration: BoxDecoration(
          color:_isSelected? Theme.of(context).primaryColor: isDarkMode(context)? Colors.grey.shade700 :Colors.white,
          borderRadius: BorderRadius.circular(Sizes.size28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ],
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        child: Text(
          widget.interest,
          style:  TextStyle(
            fontWeight: FontWeight.bold,
            color : _isSelected? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
