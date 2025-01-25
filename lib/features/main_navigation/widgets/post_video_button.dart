import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class PostVideoButton extends StatelessWidget {
  const PostVideoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return               Stack(
                clipBehavior: Clip.none,
                children: [
                  //position은 어떤거 기준으로 left, right인지 명시필요
                  //그래서 다른 자식으로 Container
                  Positioned(
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size8,
                      ),
                      height: 30,
                      width: 25,
                      decoration: BoxDecoration(
                        color: const Color(0xff61D4F0),
                        borderRadius: BorderRadius.circular(
                          Sizes.size8,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size8,
                      ),
                      height: 30,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(
                          Sizes.size8,
                        ),
                      ),
                    ),
                  ),

                  //stack 자식노드여서 Contianerheight이 다른자식노드와크기가 같으면
                  //overflow 되는 것때문에 가려질수도 그러니까 stack 조건 clipbehavior 을 clip.none으로로
                  //
                  Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        Sizes.size6,
                      ),
                    ),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: Colors.black,
                        
                        size: Sizes.size16+Sizes.size2,
                      ),
                    ),
                  ),
                ],
              );
  }
}