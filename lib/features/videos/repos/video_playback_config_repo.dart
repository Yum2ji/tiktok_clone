// data persistence and read data
import 'package:shared_preferences/shared_preferences.dart';

class PlaybackConfigRepository  {
//shared_preferences package 필요  -- 기기에서 데이터를 읽고 저장하는는
//firebase 연동시키는 경우에는 여기 repository에서 할 예정.
//MVVM Model View(ui) - Viewmodel - model(datat) -repositiry
static const String _muted ="muted";
static const String _autoPlay ="autoPlay";

final SharedPreferences _preferences;

PlaybackConfigRepository(this._preferences);

 Future<void> setMuted(bool value) async{
  _preferences.setBool(_muted, value);
 }

  Future<void> setAutoplay(bool value) async{
  _preferences.setBool(_autoPlay, value);
 }

  bool isMuted(){
    return _preferences.getBool(_muted) ?? false; //disk 에 없는 경우.
  }

    bool isAutoplay(){
    return _preferences.getBool(_autoPlay) ?? false; //disk 에 없는 경우.
  }

}