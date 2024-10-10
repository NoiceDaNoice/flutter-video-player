import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_video_player/cubit/video_cubit/video_cubit.dart';
import 'package:flutter_video_player/video_player_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late VideoCubit _videoCubit;
  @override
  void initState() {
    _videoCubit = VideoCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => _videoCubit..fetchVideo(),
          child: BlocConsumer<VideoCubit, VideoState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is VideoSuccess) {
                return Column(
                  children: [
                    const VideoPlayerWidget(
                      videoUrl:
                          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                    ),
                    isLandscape
                        ? const SizedBox()
                        : Expanded(
                            child: ListView.builder(
                              itemCount: state.responseModel.results!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text(state
                                    .responseModel.results![index].trackName!);
                              },
                            ),
                          )
                  ],
                );
              } else if (state is VideoFailed) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.error),
                      TextButton(
                        onPressed: () {
                          _videoCubit.fetchVideo();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
