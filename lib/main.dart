import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_video_player/cubit/choose_video_cubit.dart';
import 'package:flutter_video_player/cubit/video_cubit/video_cubit.dart';
import 'package:flutter_video_player/view/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VideoCubit()..fetchVideo(),
        ),
        BlocProvider(
          create: (context) => ChooseVideoCubit(),
        ),
      ],
      child: const MaterialApp(
        home: Home(),
      ),
    );
  }
}
