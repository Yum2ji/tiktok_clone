import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class SliverPracticeScreen extends StatefulWidget {
  const SliverPracticeScreen({super.key});

  @override
  State<SliverPracticeScreen> createState() => _SliverPracticeScreenState();
}

class _SliverPracticeScreenState extends State<SliverPracticeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      //기본적으로 Android에서는 ClampingScrollPhysics()가 사용되고, iOS에서는 BouncingScrollPhysics()가 기본값으로 적용됩니다.
      //stretching 하는 효과가 안먹는 것으로 보이는 이유. 내가 android 쓰면서.
      physics: const BouncingScrollPhysics(),
      slivers: [
        //sliver관련 -- scroll view와 관련된 widget만 사용가능능
        SliverAppBar(
          // floating, stretch, pinned 같은거는 아래 SpliverFixedExtentlist에 영향주므로
          // 개발할 때 지우고 하는 것도 좋음.
          //snap: true, //floating 시킬때 appbar가 엄청 빨리 내려오는.
          //floating: true, //scroll을 올릴때 어느 위치에서든지 appbar가 뜸.
          stretch: true,
          pinned: true, // background+text를 top에 닿을 때까지 보여줌.
          collapsedHeight: 80,
          expandedHeight: 200,
          backgroundColor: Colors.teal,
          // elevation:1,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              //stretchmode는 sliverappbar에 floating, stretch 조건이 true로 설정할때 같이
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
              StretchMode.zoomBackground,
            ],
            background: Image.asset(
              "assets/images/image1.jpg",
              fit: BoxFit.cover, // AppBar 크기를 다 덮도록
            ),
            centerTitle: true,
            title: const Text("Hello"),
          ),
        ),

        //일반 widgete 들 쓸 때는 SliverToBoxAdaptor 활용하는 방법있음.
        const SliverToBoxAdapter(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 20,
              )
            ],
          ),
        ),

        //CustomScrollView 에서 ListView 사용할때 예시
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            childCount: 50, // 이렇게 하면 SliverFixedExtentListdml itemExtent를 따르지않음
            (context, index) => Container(
              color: Colors.amber[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text("Item $index"),
              ),
            ),
          ),
          itemExtent: 100,
        ),
        SliverPersistentHeader(
          delegate: CustomDelegate(),
          pinned: true,
          floating: true, //SliverAppBar 에서 floating이 false여야. 해당 floating이 뭔지 제대로 동작 // scroll up 할때 해당 header가 뜸.
        ),

        //CustomScrollView 에서 SliverGrid 예시시
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              color: Colors.blue[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text("Item $index"),
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            mainAxisSpacing: Sizes.size20,
            crossAxisSpacing: Sizes.size20,
            childAspectRatio: 1,
          ),
        ),
      ],
    );
  }
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  //우리가 보는 widget을 build 하는
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.indigo,
      child: const FractionallySizedBox(
        //parent widget으로 받을 수 있는 것을 최대 받음.
        heightFactor: 1,
        child: Center(
          child: Text(
            "Title!!!!",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  //maxExtent, minExtent는 animation에서 말하는 효과
  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 80;

//shouldRebuild 가 나중에 보여주는 header이름을 호출하는?메서드
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false; //나중에 true로 바꾸기.
  }
}
