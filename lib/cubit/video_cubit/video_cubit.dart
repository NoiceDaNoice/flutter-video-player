import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_video_player/service/api.dart';
import 'package:flutter_video_player/model/video_model.dart';

part 'video_cubit_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoInitial());

  void fetchVideo() async {
    try {
      emit(VideoLoading());
      var response = await Api().fetchVideoModel();
      emit(VideoSuccess(response!));
    } catch (e) {
      emit(VideoFailed(e.toString()));
    }
  }
}
