import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_video_player/cubit/choose_video_cubit.dart';
import 'package:flutter_video_player/cubit/video_cubit/video_cubit.dart';
import 'package:flutter_video_player/model/video_model.dart';
import 'package:flutter_video_player/view/widget/video_player_widget.dart';

import 'widget/list_video_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<VideoCubit, VideoState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is VideoSuccess) {
              return Column(
                children: [
                  BlocBuilder<ChooseVideoCubit, Result?>(
                    builder: (context, state) {
                      if (state == null) {
                        return const SizedBox(
                          height: 200,
                          child: Center(
                            child: Text('Choose Video'),
                          ),
                        );
                      }
                      return VideoPlayerWidget(
                        key: ValueKey(state.previewUrl),
                        videoUrl: state.previewUrl!,
                      );
                    },
                  ),
                  isLandscape
                      ? const SizedBox()
                      : ListVideoWidget(
                          responseModel: state.responseModel,
                        ),
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
                        context.read<VideoCubit>().fetchVideo();
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
    );
  }
}
