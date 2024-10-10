import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_video_player/cubit/video_player_cubit.dart';
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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    return BlocProvider(
      create: (_) => _videoPlayerCubit,
      child: Center(
        child: GestureDetector(
          onTap: () => _videoPlayerCubit.toggleControls(),
          child: BlocConsumer<VideoPlayerCubit, VideoPlayerState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.isError) {
                return Container(
                  color: Colors.black,
                  height: isLandscape
                      ? mediaQuery.size.height
                      : mediaQuery.size.width / (16 / 9),
                  width: mediaQuery.size.width,
                  child: TextButton(
                    child: const Text('Retry'),
                    onPressed: () {
                      _videoPlayerCubit.initialize();
                    },
                  ),
                );
              }
              return Container(
                color: Colors.black,
                height: isLandscape
                    ? mediaQuery.size.height
                    : mediaQuery.size.width / (16 / 9),
                width: mediaQuery.size.width,
                child: !state.isInitialized
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Stack(
                        fit: StackFit.loose,
                        alignment: Alignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.fill,
                            child: SizedBox(
                              height: isLandscape
                                  ? mediaQuery.size.height
                                  : mediaQuery.size.width /
                                      _controller.value.aspectRatio,
                              width: mediaQuery.size.width,
                              child: AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              colors: const VideoProgressColors(
                                playedColor: Colors.blue,
                                bufferedColor: Colors.grey,
                                backgroundColor: Colors.black,
                              ),
                            ),
                          ),
                          if (state.showControls)
                            Column(
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
                                        onPressed: () =>
                                            _videoPlayerCubit.skip(),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          state.isFullscreen
                                              ? Icons.fullscreen_exit
                                              : Icons.fullscreen,
                                          color: Colors.white,
                                          size: 36,
                                        ),
                                        onPressed: () => _videoPlayerCubit
                                            .toggleFullscreen(),
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
                                    onPressed: () =>
                                        _videoPlayerCubit.restart(),
                                  ),
                              ],
                            ),
                        ],
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
