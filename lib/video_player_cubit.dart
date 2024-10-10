import 'package:bloc/bloc.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  final VideoPlayerController _controller;

  VideoPlayerCubit(this._controller) : super(VideoPlayerState.initial()) {
    _controller.addListener(_onVideoUpdated);
    _controller.initialize().then(
          (_) => emit(
            state.copyWith(isInitialized: true),
          ),
        );
  }

  void _onVideoUpdated() {
    if (_controller.value.position >= _controller.value.duration) {
      emit(state.copyWith(isPlaying: false, showRestartButton: true));
    } else if (_controller.value.isPlaying && state.showRestartButton) {
      emit(state.copyWith(showRestartButton: false));
    }
  }

  void togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      emit(state.copyWith(isPlaying: false));
    } else {
      _controller.play();
      emit(state.copyWith(isPlaying: true));
    }
  }

  void rewind() {
    final newPosition = _controller.value.position - const Duration(seconds: 5);
    _controller.seekTo(newPosition);
  }

  void skip() {
    final newPosition = _controller.value.position + const Duration(seconds: 5);
    _controller.seekTo(newPosition);
  }

  void restart() {
    emit(state.copyWith(
      isPlaying: true,
      showRestartButton: false,
    ));

    _controller.seekTo(Duration.zero).then((_) {
      _controller.play();
    });
  }

  void toggleControls() {
    emit(state.copyWith(showControls: !state.showControls));
  }

  @override
  Future<void> close() {
    _controller.removeListener(_onVideoUpdated);
    _controller.dispose();
    return super.close();
  }
}

class VideoPlayerState {
  final bool isPlaying;
  final bool showControls;
  final bool showRestartButton;
  final bool isInitialized;

  VideoPlayerState({
    required this.isPlaying,
    required this.showControls,
    required this.showRestartButton,
    required this.isInitialized,
  });

  factory VideoPlayerState.initial() {
    return VideoPlayerState(
      isPlaying: false,
      showControls: true,
      showRestartButton: false,
      isInitialized: false,
    );
  }

  VideoPlayerState copyWith({
    bool? isPlaying,
    bool? showControls,
    bool? showRestartButton,
    bool? isInitialized,
  }) {
    return VideoPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      showControls: showControls ?? this.showControls,
      showRestartButton: showRestartButton ?? this.showRestartButton,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}
