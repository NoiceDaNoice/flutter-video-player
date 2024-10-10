import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  final VideoPlayerController _controller;

  VideoPlayerCubit(this._controller) : super(VideoPlayerState.initial()) {
    initialize();
  }

  void initialize() async {
    try {
      emit(state.copyWith(
        isInitialized: false,
        isError: false,
      ));
      await _controller.initialize();
      _controller.addListener(_onVideoUpdated);
      emit(state.copyWith(
        isInitialized: true,
      ));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(isError: true, isInitialized: false));
    }
  }

  void _onVideoUpdated() {
    try {
      if (_controller.value.position >= _controller.value.duration) {
        emit(state.copyWith(isPlaying: false, showRestartButton: true));
      } else if (_controller.value.isPlaying && state.showRestartButton) {
        emit(state.copyWith(showRestartButton: false));
      }
    } catch (e) {
      emit(state.copyWith(isError: true, isInitialized: false));
    }
  }

  void togglePlayPause() {
    try {
      if (_controller.value.isPlaying) {
        _controller.pause();
        emit(state.copyWith(isPlaying: false));
      } else {
        _controller.play();
        emit(state.copyWith(isPlaying: true));
      }
    } catch (e) {
      emit(state.copyWith(isError: true, isInitialized: false));
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
    _controller.seekTo(Duration.zero).then((_) {
      _controller.play();
      emit(state.copyWith(
        isPlaying: true,
        showRestartButton: false,
      ));
    });
  }

  void toggleControls() {
    emit(state.copyWith(showControls: !state.showControls));
  }

  void toggleFullscreen() {
    if (state.isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    }
    emit(state.copyWith(isFullscreen: !state.isFullscreen));
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
  final bool isFullscreen;
  final bool isError;

  VideoPlayerState({
    required this.isPlaying,
    required this.showControls,
    required this.showRestartButton,
    required this.isInitialized,
    required this.isFullscreen,
    required this.isError,
  });

  factory VideoPlayerState.initial() {
    return VideoPlayerState(
      isPlaying: false,
      showControls: true,
      showRestartButton: false,
      isInitialized: false,
      isFullscreen: false,
      isError: false,
    );
  }

  VideoPlayerState copyWith({
    bool? isPlaying,
    bool? showControls,
    bool? showRestartButton,
    bool? isInitialized,
    bool? isFullscreen,
    bool? isError,
  }) {
    return VideoPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      showControls: showControls ?? this.showControls,
      showRestartButton: showRestartButton ?? this.showRestartButton,
      isInitialized: isInitialized ?? this.isInitialized,
      isFullscreen: isFullscreen ?? this.isFullscreen,
      isError: isError ?? this.isError,
    );
  }
}
