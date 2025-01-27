import 'package:flutter/material.dart';


// 원래 mainnavigation_screen.dart에서 사용하도록 
// 되어 있었으나 삭제함. -> 교육중 naviagtion 탭별로 count 하는 거 보여주시려던 것일 뿐


class StfScreen extends StatefulWidget {
  const StfScreen({super.key});

  @override
  State<StfScreen> createState() => _StfScreenState();
}


class _StfScreenState extends State<StfScreen> {
  int _clicks = 0;

  void _increase() {
    setState(() {
      _clicks++;
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$_clicks",
            style: const TextStyle(
              fontSize: 48,
            ),
          ),
          TextButton(onPressed: _increase, child: const Text("+"))
        ],
      ),
    );
  }
}
