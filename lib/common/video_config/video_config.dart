/* import 'package:flutter/material.dart';

class VideoConfigData extends InheritedWidget {
  // const VideoConfigData({super.key, required super.child});
  //IngeritedWidget쪽은 업데이트가 불가능하니까 이건 이제 statefulwidget쪽
  //final bool autoMute = false;
  //stateful 로 변경되면서 아래 2개 형태가 됨됨
  const VideoConfigData({
    super.key,
    required super.child,
    required this.autoMute,
    required this.toggleMuted,
  });
  final bool autoMute;
  final void Function() toggleMuted;

  static VideoConfigData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // 나중에 VideoConfig를 상속받는 애들이
    // VideoConfig 가 변경되면 안내를 받는지 아닌지의 정보
    return true;
  }
}

// InheritedWidget 이걸로만 진행하면, 값을 업데이트는 할 수 없음
// 그래서, statefulwidget도 함께정의
class VideoConfig extends StatefulWidget {
  final Widget child;

  const VideoConfig({
    super.key,
    required this.child,
  });

  @override
  State<VideoConfig> createState() => _VideoConfigState();
}

class _VideoConfigState extends State<VideoConfig> {
  bool autoMute = false;

  void _toggleMuted() {
    setState(() {
      autoMute = !autoMute;
    });
  }

  //상태변경은 stateful widget에서 하고
  //상태 변경될때마다 ingerited widget을 rebuild 하는 느낌임.
  @override
  Widget build(BuildContext context) {
    return VideoConfigData(
      toggleMuted : _toggleMuted,
      autoMute: autoMute,
      child: widget.child,
    );
  }
}
 */



import 'package:flutter/foundation.dart';

//ChangeNotifier 는 value가 많을때 쓰기 좋음
// 값이 1개라면 ChangeNotifier 가아니라 vAlueNotifier 쓸것것
/* class VideoConfig extends ChangeNotifier {
  bool autoMute = true;
  
  void toggleAutoMute(){
    autoMute = !autoMute;
    //setstate하지 않아도 됨. 
    //화면이 변경되는 것을 듣고 있는 부분만 존재하면됨.
    //이건 ChangeNotifier에 있음
    notifyListeners();
  }
}

final videoConfig = VideoConfig(); */

//값이 하나인 경우
/* final videoConfig = ValueNotifier(
  false
); */

//Provider 예시
class VideoConfig extends ChangeNotifier{
  bool isMuted = false;
  bool isAutoplay = false;

  void toggleIsMuted(){
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleAUtoplay(){
    isAutoplay = !isAutoplay;
    notifyListeners();
  }

}





