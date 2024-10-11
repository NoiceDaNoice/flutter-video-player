import 'package:bloc/bloc.dart';
import 'package:flutter_video_player/model/video_model.dart';

class ChooseVideoCubit extends Cubit<Result?> {
  ChooseVideoCubit() : super(null);

  void selectResult(Result result) {
    emit(result == state ? null : result);
  }

  bool isSelected(Result result) => result == state;
}
