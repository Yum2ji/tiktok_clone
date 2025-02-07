import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class MatchData extends StatelessWidget {
  final String val;
  final String info;
  const MatchData({super.key, required this.val, required this.info});

  @override
  Widget build(BuildContext context) {
    return Column(
                      children: [
                         Text(
                          val,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size18,
                          ),
                        ),
                        Gaps.v3,
                        Text(
                          info,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    );
  }
}