import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_video_player/video_player_cubit.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late VideoPlayerCubit _videoPlayerCubit;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _videoPlayerCubit = VideoPlayerCubit(_controller);
  }

  @override
  void dispose() {
    _videoPlayerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _videoPlayerCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Video Player'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => _videoPlayerCubit.toggleControls(),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                    BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
                      builder: (context, state) {
                        if (!state.isInitialized) {
                          return const CircularProgressIndicator();
                        }

                        return Visibility(
                          visible: state.showControls,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (!state.showRestartButton)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.replay_5,
                                          color: Colors.white, size: 36),
                                      onPressed: () =>
                                          _videoPlayerCubit.rewind(),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        state.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                        size: 36,
                                      ),
                                      onPressed: () =>
                                          _videoPlayerCubit.togglePlayPause(),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.forward_5,
                                          color: Colors.white, size: 36),
                                      onPressed: () => _videoPlayerCubit.skip(),
                                    ),
                                  ],
                                ),
                              if (state.showRestartButton)
                                IconButton(
                                  icon: const Icon(
                                    Icons.replay,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                  onPressed: () => _videoPlayerCubit.restart(),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
                builder: (context, state) {
                  return VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    colors: const VideoProgressColors(
                      playedColor: Colors.blue,
                      bufferedColor: Colors.grey,
                      backgroundColor: Colors.black,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
