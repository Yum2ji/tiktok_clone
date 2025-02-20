import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

//AsyncNotifier 는 listener 같은거 따로 안해줘도됨.
class TimeLineViwModel extends AsyncNotifier<List<VideoModel>>{

  List<VideoModel> _list =[
   // VideoModel(title: "First video"),
  ]; // api에서 오는 데이터

  void uploadVideo() async {
    state = const AsyncValue.loading(); // initiate 를 다시하는 
     await Future.delayed(
      const Duration(seconds:2,), // 데이터 가져오는데 2초정도 지연한 상황으로 가정정.
    );
    final newVideo =VideoModel(title: "${DateTime.now()}");
  
    _list = [..._list, newVideo];
    state = AsyncValue.data(_list);
  }

  //api에서 가져오는 부분.
  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(
      const Duration(seconds:5,),
    );
    /*
    데이터 가져오다가 에러난 경우에는 throwexception 하도록 함
    ref.watch(timelineProvider).when 이렇게 해서 error 입력하는 곳에
    어떤 text 인지적어주면 같이 동작함.
     */
    //throw Exception("OMG can't fatch");
    return _list;
  }

}

// AsyncNotifier의 provider는 아래와 같음.
// viewmodel을 view로 보내주는 역할.
//<viewmodel 먼저쓰고, expose해야하는 데이터 쓰기>
final timelineProvider = AsyncNotifierProvider<TimeLineViwModel,List<VideoModel>>(
  ()=> TimeLineViwModel(),
);