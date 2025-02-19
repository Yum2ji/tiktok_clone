import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/video_playback_config_repo.dart';

//Provider 를 사용하는 방식에서는 view 부분이 바뀌고 변화 인지하는 것을
//ChangeNotifier 가 했음.
/* class PlaybackConfigViewModel extends ChangeNotifier {
  final PlaybackConfigRepository _repository;

  late final PlaybackConfigModel _model = PlaybackConfigModel(
    muted: _repository.isMuted(),
    autoplay: _repository.isAutoplay(),
  );

  PlaybackConfigViewModel(this._repository);

  // 지금 여기는 View Model 부분인데
  // 아래내용은 메서드를 View로 보내주는
  // view(ui) 가 set하는 걸 vm에 보내주면
  // disk에 persist 하고 _repository.setMuted(value);
  // 우리는 data 고치고  _model.muted =value;
  //notifyListeners 데이터를 listen하는 screen에 보여줄것
  void setMuted(bool value){
    _repository.setMuted(value);
    _model.muted =value;
    notifyListeners();
  }

    void setAutoplay(bool value){
    _repository.setAutoplay(value);
    _model.autoplay =value;
    notifyListeners();
  }

  //repository 나 model을 공개하고 싶지 않음(직접 적고싶지 않음)
  //공개하는 경우네는 PlaybackConfigViewModel._repository. 이런식이겠지
  // PlaybackConfigViewModel._mdodel
  bool get muted => _model.muted;
  bool get autoplay => _model.autoplay;
}
 */

//riverpod 사용하는 경우에는 ChangeNotifier 사용하지 않아도됨.
//여기서는 Notifier 를 사용
//AsyncNotifierProvider 는 firebase에서 값을 읽어오고 모든 사용자들이 사용가능하게함.
//firebase 사용할때는 futureProvider 사용.

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  //Notifier.build 로 갖는 값은 초기 initialize 데이터 값이 됨 -> 나중에 값은 물론 변경가능함.
  //나중에는 Notifier.build 로 firebase에서 값을 읽어와서 UI상 보여주는 용도로 쓰이는
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  //Notifier 안이면 state 데이터에 접근가능( state.muted = value;)하고 수정도가능함.
  //단 state는 mutate 하는것이 아니라 , create new state 해서 replace 하는 것.
  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(
      muted: value,
      autoplay: state.autoplay,
    );
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(
      muted: state.muted,
      autoplay: value,
    );
  }

//ChangeNotifier에서는 _model initalize 해야했는데 여기서는 그냥 build 안에서 하면됨.
  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoplay(),
    );
  }
}

// 데이터 얻고, 메서드 실행할떄 provider가 쓰임.
// provider expose PlaybackConfigViewModel
//우리가 보여주고 싶어하는 데이터 PlaybackConfigModel 것과

/* 아래처럼하고싶은데 repository를 지금 당장 입력해줄 수 없음
main에서 sharedpreference로 배정해준다음에 써야하기 때문에
creating initialize 할 수 없음.
임시로 throw error 해서 사용 그리고 main에서 override 메서드 하면됨
final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => PlaybackConfigViewModel()
);
 */
final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () =>throw UnimplementedError(),
);
