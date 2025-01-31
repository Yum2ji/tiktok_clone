import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;
  final ScrollController _scrollController = ScrollController();

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

//_stopCommenting 는 키보드 닫히게 하려고 다른 영역을 눌렀을 대 동작
// body에 gesturedetector 가 scaffold 감싸는 이유임.
  void _stopCommenting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = !_isWriting;
    });
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      //scaffold 둥그렇게 모서리 접히게 하려면 deco 말고도 clipbehavior 필요
      clipBehavior: Clip.hardEdge,
      //아래처럼 height 바꾸는건 video_post에서 isScrollControlled도 조절해야함.
      height: size.height * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size14,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "22796 comments",
          ),
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(
                FontAwesomeIcons.xmark,
              ),
            )
          ],
        ),
        body: GestureDetector(
          onTap: _stopCommenting,
          child: Stack(
            children: [
              Scrollbar(
                controller:_scrollController ,
                child: ListView.separated(
                  //ListView.separted의 controller도 sccrollbar와 동일 controller를 사용한다함.-댓글에서 봄
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    top: Sizes.size10,
                    left: Sizes.size16,
                    right :Sizes.size16,
                    
                    //bottom을 엄청 크게줘야. bottomAppBar 뒤에 안가려지는는
                    //사실 안드로이드에서는 가려지지는 않는것 같지만, scroll 햇을 정도 여겨짐짐
                    bottom: Sizes.size96+Sizes.size1, 
                  ),
                  itemCount: 10,
                  separatorBuilder: (context, index) => Gaps.v20,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        child: Text("유미"),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "유미",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Gaps.v3,
                            const Text(
                              "That's not it I've seen the same thing but also in a cave",
                            ),
                          ],
                        ),
                      ),
                      Gaps.h10,
                      Column(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size20,
                            color: Colors.grey.shade500,
                          ),
                          Gaps.v2,
                          Text(
                            "52.2K",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                // bottomnavigation으로 scaffold에 만들어주면 
                //키보드 생겼을때 적고 있는 값이 안보여서 이렇게 할 수밖에 없음.
                child: BottomAppBar(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size4,
                      vertical: Sizes.size5,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey.shade500,
                          foregroundColor: Colors.white,
                          child: const Text("유미"),
                        ),
                        Gaps.h10,
                        Expanded(
                          child: SizedBox(
                            height: Sizes.size44,
                            child: TextField(
                              onTap: _onStartWriting,

                              //textInputAction 으로 return 버튼 누르면 키보드 닫힘.
                              //textfield 확장가능하도록 expands 사용필요.
                              //단, minimumline, maximumline null로 설정해놓아야함.
                              expands: true,
                              minLines: null,
                              maxLines: null,
                              //키보드가 뜰 대, done 버튼이 아니라 return 버튼사용
                              //카카오 톡 같은 것이 그럼.
                              textInputAction: TextInputAction.newline,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    right: Sizes.size14,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.at,
                                        color: Colors.grey.shade900,
                                      ),
                                      Gaps.h10,
                                      FaIcon(
                                        FontAwesomeIcons.gift,
                                        color: Colors.grey.shade900,
                                      ),
                                      Gaps.h10,
                                      FaIcon(
                                        FontAwesomeIcons.faceSmile,
                                        color: Colors.grey.shade900,
                                      ),
                                      Gaps.h10,
                                      if (_isWriting)
                                        GestureDetector(
                                          onTap: _stopCommenting , // 여기는 나중에 firebae연동하고 바꿀것
                                          child: FaIcon(
                                            FontAwesomeIcons.circleArrowUp,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                hintText: "Write a comment ....",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size12,
                                  ),
                                  borderSide: BorderSide.none, // margin 같은거 의미
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size12,
                                  // vertical: Sizes.size10, -> 제대로 동작안해서 TextFiled를 Sizedbox로 감싸야함.
                                ),
                              ),
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
      ),
    );
  }
}
