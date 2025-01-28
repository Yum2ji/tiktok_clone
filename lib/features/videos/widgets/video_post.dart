import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinshied;
  final int index;
  const VideoPost({
    super.key,
    required this.onVideoFinshied,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video_flag.mp4");

  void _onVideoChanged() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinshied();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    //  _videoPlayerController.play();

    _videoPlayerController.addListener(_onVideoChanged);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  //이건 ios 에서만 해당되는듯
  //android 폰에서는 다음페이지로 사용자가 드래그해서 넘길때
  // 한개의 동영상만 보임.. 둘다 동시에 재생되지는 않음
  // ios에서는 그렇기 때문에, 둘다 동시에 동영상 재생되는 것을 막으려는 옵션이라고 보면됨.
  // 리소스 줄일 때 필요함.
  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  void _togglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _togglePause,
            ),
          ),
          //Position 은 항상 위에 Stack
          const Positioned.fill(
            //Icon부분을 눌러도 위에 GestureDetector _togglePause로 동작하게
            //Ignorepointer로 감싸는 것임.
            child: IgnorePointer(
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.play,
                  color: Colors.white,
                  size: Sizes.size52,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
