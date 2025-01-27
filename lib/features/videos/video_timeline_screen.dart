import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

//Main_navigation_screen.daart 의 scaffold 의 child 이므로
//여기서는 scaffold 필요없음.
class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  //infinite 스크롤 처럼 PageView.builder의 onPage Changed사용할때 필요
  int _itemCount = 4;

  final PageController _pageController = PageController();

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.teal,
  ];

  void _onPageChanged(int page) {
    //_pageController.animateToPage
      //사용자가 원하는 화면 page로 갔을 때
      // anaimation =>  curve에 설정하는 값이 animation 으로
      // duration 시간동안만 animation 유지하기 

      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 150),
        curve: Curves.linear,
      );


    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      colors.addAll(
        [
          Colors.blue,
          Colors.red,
          Colors.yellow,
          Colors.teal,
        ],
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    //Chapter 7.1
    //ListView.builder 나 PageView.builder 나
    // 둘다 builder 메소드가 있음.
    // builder 는 children 모두 동시에 rendering 하지 않는것.
    // itembuilder

    //Chapter7.1
    //PageView.builder 에서 controller 가 사용자의 사용을 조절해야함.
    //갑자기 첫번째 화면으로 가고 싶을수도 있고 하니까
    // PageView.builder에서 페이지 올리다보면 애니메이션이 입혀진.. 이것도 contorller 가능능

    return PageView.builder(
      onPageChanged: _onPageChanged,
      controller: _pageController,
      //pageSnapping : false : user가 화면 반이상 드래그 햇는데도 다른 화면으로 안바뀌고 그대로
      scrollDirection: Axis.vertical,
      //itemCount 설정안하면 사용자가 드래그 하다가 없는 값에 접근하면서 exception 발생
      itemCount: _itemCount,
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text(
            "Screen $index",
            style: const TextStyle(
              fontSize: 68,
            ),
          ),
        ),
      ),
    );
  }
}
