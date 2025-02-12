import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  void _stopCommenting() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8, // leading 하고 title 사이
          leading: Stack(
            clipBehavior: Clip.none,
            children: [
              const CircleAvatar(
                radius: Sizes.size24,
                foregroundImage: NetworkImage(
                  "https://i.ytimg.com/vi/LYKTtPFB9b4/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBHxhTHbXz0HzU6pp4GLK-98XPQnw",
                ),
                child: Text("Yumi"),
              ),
              Positioned(
                top: 25,
                left: 25,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 4,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: const Text(
            "Yumi",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text("Active now"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: isDark ? Colors.grey.shade400 : Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: isDark ? Colors.grey.shade400 : Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: _stopCommenting,
        child: Stack(
          children: [
            ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20,
                horizontal: Sizes.size14,
              ),
              itemBuilder: (context, index) {
                final isMine = index % 2 == 0;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(
                        Sizes.size14,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(
                              Sizes.size20,
                            ),
                            topRight: const Radius.circular(
                              Sizes.size20,
                            ),
                            bottomLeft: Radius.circular(
                              isMine ? Sizes.size20 : Sizes.size5,
                            ),
                            bottomRight: Radius.circular(
                              !isMine ? Sizes.size20 : Sizes.size5,
                            )),
                        color: isMine
                            ? Colors.blue
                            : Theme.of(context).primaryColor,
                      ),
                      child: const Text(
                        "This is message",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: 10,
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: BottomAppBar(
                //  color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size10,
                    vertical: Sizes.size5,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          showCursor: false,
                          decoration: InputDecoration(
                            hintText: "Send a message...",
                            hintStyle: TextStyle(
                              color:
                                  isDark ? Colors.grey.shade700 : Colors.grey,
                              fontSize: Sizes.size18,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.size20,
                              ),
                              borderSide: BorderSide.none, // margin 같은거 의미
                            ),
                            filled: true,
                            fillColor:
                                isDark ? Colors.grey.shade300 : Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size12,
                              // vertical: Sizes.size10, -> 제대로 동작안해서 TextFiled를 Sizedbox로 감싸야함.
                            ),
                            suffix: const FaIcon(
                              FontAwesomeIcons.faceSmile,
                              size: Sizes.size24,
                            ),
                          ),
                        ),
                      ),
                      Gaps.h20,
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.paperPlane,
                            size: Sizes.size20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
