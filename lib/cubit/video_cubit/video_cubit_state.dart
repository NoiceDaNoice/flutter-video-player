part of 'video_cubit.dart';

sealed class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

final class VideoInitial extends VideoState {}

final class VideoLoading extends VideoState {}

final class VideoFailed extends VideoState {
  final String error;

  const VideoFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];
}

final class VideoSuccess extends VideoState {
  final ResponseModel responseModel;
  const VideoSuccess(this.responseModel);

  @override
  // TODO: implement props
  List<Object> get props => [responseModel];
}
