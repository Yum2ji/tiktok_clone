import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/video_config/video_config.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_comments.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

//ConsumerWidget 에서는 build에서 무조건 ref 입력해야했는데데
//ConsumerStatefulWidget 를 사용하면  안해도괜찮음
class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinshied;
  final int index;
  const VideoPost({
    super.key,
    required this.onVideoFinshied,
    required this.index,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video_flag.mp4");

  bool _isPaused = false;

  // bool _autoMute = videoConfig.value;
//   bool _autoMute = videoConfig.autoMute; // 이건 changenotifier

  final Duration _animationDuration = const Duration(milliseconds: 200);

  //Animation 위젯을 직접만드는 경우. AnimationOpacity 같은거 사용하지않고 직접 customize.
  late final AnimationController _animationController;

  bool _isSeeMore = false;
  double _currentVolume = 0.0;

  void _setVolume(double volume) async {
    await _videoPlayerController.setVolume(volume);
    setState(() {
      _currentVolume = volume;
    });
  }

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

    //동영상 끝나면 반복재생하도록함.
    //video_timeline_screen에서도 비디오 끝나면 return하도록 해놓아서 같이쓰는기능
    await _videoPlayerController.setLooping(true);

    if (kIsWeb) {
      _setVolume(0);
    }

    _videoPlayerController.addListener(_onVideoChanged);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      //this 로 호출 하면 class _VideoPostState extends State<VideoPost> 이 widget을 호출하겠다는 건데
      //vsync 에 this 란 with으로 부른 SingleTickerProviderStateMixingle 임.(ticker)
      // vsync 는 offscreen일때 로딩을 막는 -> 1) ticker가 하는 역할
      // SingleTickerProviderStateMixingle 도 보면 current tree 활성할 동안에만 ticker 유지.
      // 또한 ticker의 역할 2)로 ticker는 매 프레임마다 에니메이션 callback을해줌.

      // + 여러 ticker 사용하는 경우에는 SingleTickerProviderStateMixingle가 아닌
      // TickerProviderStateMixin 으로 사용.--> multiple animation controller

      vsync: this,

      // 지금은 size관련 animation 만드는 것이므로 작은 사이즈는1.0 큰 건 1.5
      lowerBound: 1.0,
      upperBound: 1.5,
      // value 는 default==starting position 값을 의미
      value: 1.5,
      duration: _animationDuration,
    );

// 아래 코드는 provider 쓸때
/*     context
        .read<PlaybackConfigViewModel>()
        .addListener(_onPlaybackConfigChanged); */

    //이걸 하지 않으면 _animationController.revere, forward만 했을 때 끊겨 보임.
    //우리는 lower/upper 사이에 중간값들로 setsTate 해서 build 해줘야함.
    //Animatedopacity를 Transform.scale로 직접 감싸는 경우에만 사용
    //그렇지 않으면 AnimatedBuilder 사용하면, 필요없음
    // _animationController.addListener(() {
    //   setState(() {

    //   });
    // });

    // videoConfig.automute 값이 바뀌는 걸 이렇게해야함.
    //settingscreen에서와 같이 animationbuilder로 쓰는 방법도 있고
    // 아래처럼 addLister로 쓰는 방법도 있음.
/*     videoConfig.addListener((){
        setState(() {
          _autoMute = videoConfig.value;
        // _autoMute = videoConfig.autoMute; //이건 changenotifier 사용할때때
      });
    }
    ); */
  }

  void _onPlaybackConfigChanged() {
    //dead video (_videoPlayerController)의 값을 사용하면 에러 날 수 있음
    //mounted로 구분분
    if (!mounted) return;
    // provider 쓰는 경우
    // final muted = context.read<PlaybackConfigViewModel>().muted;
/*     if (muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    } */
    if (ref.read(playbackConfigProvider).muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
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
    //이전 영상을 stop하고 내려갔다가 다시올라가면 exception발생.
    //이전 내용 _videoPlayerController가 dispose되었다면면 "!_videoPlayerController.value.isPlaying" 이 조건에서 error남. 없는값을 부르니까까
    //mounted 는 widgettree에서 삭제되었는지아닌지를 말함.
    if (!mounted) return;

    if (info.visibleFraction == 1 &&
        !_isPaused //_isPaused 조건을 추가함 android는 괜찮은데. 강의ㅣ에서 영상 멈춘상태로-> refresh 하면 바로 restart되는 현상있어서 추가
        &&
        !_videoPlayerController.value.isPlaying) {
      //Provider만 쓰는 경우
      /* final autoplay = context.read<PlaybackConfigViewModel>().autoplay;
      if (autoplay) {
        _videoPlayerController.play();
      } */

      //riverpod 쓰는경우
      if (ref.read(playbackConfigProvider).autoplay) {
        _videoPlayerController.play();
      }
    }

    //main_navigation에서 offstage으로 되면 이론적으로 안보일 뿐 alive 는 되어있는거야.
    ////dispose가 안됨.
    //// 다른 화면 갔다오도록 해놓았는데.
    //다른 화면 갔다올 때 멈추도록 설정
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _togglePause();
    }
  }

  void _togglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      //reverse는 animationcontroller의 upper/lower bound 사이에 방향 바꿔주는
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      //forward는 바뀐 방향을 다시
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onSeeMoreTap() {
    setState(() {
      _isSeeMore = !_isSeeMore;
    });
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _togglePause();
    }
    //await 은 여기서는 user가 bottomsheet 해제할때임.
    await showModalBottomSheet(
      //barrierColor: Colors.red,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      //이렇게해서 bottomsheet 연것은 navigator 로 새로운 위젯열듯이 열린것
      //VideoComments에서 뒤로가기 버튼이 동작하는 이유
      builder: (context) => const VideoComments(),
    );
    _togglePause();
  }

  @override
  Widget build(BuildContext context) {
    //상위 위젯에 있는 값 접근 가능
    // Video_config.dart에 of 관련해서 정의안되면 아래내용
    // final videoConfg = context.dependOnInheritedWidgetOfExactType<VideoConfig>();
    // print(videoConfg?.autoMute);
    // of 생성자 정의하면 아래처럼 간단히 사용가능
    // VideoConfig.of(context).autoMute;

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
          Positioned.fill(
            //Icon부분을 눌러도 위에 GestureDetector _togglePause로 동작하게
            //Ignorepointer로 감싸는 것임.
            child: IgnorePointer(
              child: Center(
                //AnimatedBuilder는 animatedController가 바뀔때마다 실행.
                //setstate 따로 하지 않아도 괜찮음.
                child: AnimatedBuilder(
                  //내부에서 따로 setSate
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  animation: _animationController,
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 20,
            top: 40,
            child: IconButton(
              onPressed: () {
                _onPlaybackConfigChanged();
                //아래 내용은 Provider
/*                 context.read<PlaybackConfigViewModel>().setMuted(
                      //여기는 read로 읽음 어차피 onpressed 할때 실행된다는 거아니까
                      //watch로 계속 보지는 않는
                      !context.read<PlaybackConfigViewModel>().muted,
                    ); */

                //context.read<VideoConfig>().toggleIsMuted() 이런형식은 multiprovider로 main 정의될때때
                //context.read<VideoConfig>().toggleIsMuted();
                // videoConfig.value = !videoConfig.value;
              },
              // videoConfig.toggleAutoMute, // 이건 changenotifier쓸때
              //VideoConfigData.of(context).toggleMuted,
              icon:  FaIcon(
                //watch는muted 값이 바뀌는지 아닌지를를 notify 하고 있음.
                ref.watch(playbackConfigProvider).muted
                    //provider 쓰는 경우
                    //       context.watch<PlaybackConfigViewModel>().muted
                    /*                 아래 내용은 multiprovider로 정의될때임./*  */
                    context.watch<VideoConfig>().isMuted
 */ // _autoMute
                    // VideoConfigData.of(context).autoMute
                    ? FontAwesomeIcons.volumeOff
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "@유미",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Row(
                  children: [
                    Text(
                      _isSeeMore
                          ? "This is my house in Thailand!!! Only for the vacation"
                          : "This is my house in Thailand!!!",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: Sizes.size16,
                      ),
                    ),
                    Gaps.h2,
                    GestureDetector(
                      onTap: _onSeeMoreTap,
                      child: Text(
                        _isSeeMore ? "Short sentence" : "See more",
                        style: TextStyle(
                          color: _isSeeMore ? Colors.red : Colors.blue,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
/*                 GestureDetector(
                  onTap: () {
                    _currentVolume == 0 ? _setVolume(20) : _setVolume(0);
                  },
                  child: FaIcon(
                    _currentVolume == 0
                        ? FontAwesomeIcons.volumeXmark
                        : FontAwesomeIcons.volumeHigh,
                    color: Colors.white,
                    size: Sizes.size40,
                  ),
                ), */
                Gaps.v24,
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                      "https://i.ytimg.com/vi/LYKTtPFB9b4/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBHxhTHbXz0HzU6pp4GLK-98XPQnw"),
                  child: Text("유미"),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: S.of(context).likeCount(987898),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(65654),
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
