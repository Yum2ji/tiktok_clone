import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/video_playback_config_repo.dart';

class PlaybackConfigViewModel extends ChangeNotifier {
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
