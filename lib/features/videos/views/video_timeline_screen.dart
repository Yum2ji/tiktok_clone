import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_view_model.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

//Main_navigation_screen.daart 의 scaffold 의 child 이므로
//여기서는 scaffold 필요없음.
class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  //infinite 스크롤 처럼 PageView.builder의 onPage Changed사용할때 필요
  int _itemCount = 4;

  final PageController _pageController = PageController();

  final _scrollDuration = const Duration(milliseconds: 250);
  final _scrollCurve = Curves.linear;

  void _onPageChanged(int page) {
    //_pageController.animateToPage
    //사용자가 원하는 화면 page로 갔을 때
    // anaimation =>  curve에 설정하는 값이 animation 으로
    // duration 시간동안만 animation 유지하기

    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );

    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      setState(() {});
    }
  }

  void _onVideoFinished() {
    //그다음 영상으로 안넘어가게 return 추가. 자동으로 넘어가게하려면 return 부분만삭제
    return;
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Future.delayed(const Duration(
      seconds: 1,
    ));
  }

  @override
  Widget build(BuildContext context) {
    /*     
    provider에서 async 해서 API 데이터 가져오고 있기 떄문에
    when 을 사용
     */
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "Colud not load videos : $error",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          //videos 는 provider로 부터 오는 videos.length는 default로 0일
          data: (videos) => RefreshIndicator(
            displacement: 50,
            edgeOffset: 30,
            //backgroundColor: Colors.red,
            color: Theme.of(context).primaryColor,
            strokeWidth: 3,
            onRefresh: _onRefresh,
            child: PageView.builder(
              onPageChanged: _onPageChanged,
              controller: _pageController,
              //pageSnapping : false : user가 화면 반이상 드래그 햇는데도 다른 화면으로 안바뀌고 그대로
              scrollDirection: Axis.vertical,
              //itemCount 설정안하면 사용자가 드래그 하다가 없는 값에 접근하면서 exception 발생
              itemCount: videos.length,
              itemBuilder: (context, index) => VideoPost(
                onVideoFinshied: _onVideoFinished,
                index: index,
              ),
            ),
          ),
        );
  }
}
