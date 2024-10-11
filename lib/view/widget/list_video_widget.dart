import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_video_player/cubit/choose_video_cubit.dart';

import '../../model/video_model.dart';
import 'package:flutter/material.dart';

class ListVideoWidget extends StatelessWidget {
  final ResponseModel responseModel;
  const ListVideoWidget({
    super.key,
    required this.responseModel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ChooseVideoCubit, Result?>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: responseModel.results!.length,
            itemBuilder: (BuildContext context, int index) {
              final isSelected = state == responseModel.results![index];
              return InkWell(
                onTap: () {
                  context
                      .read<ChooseVideoCubit>()
                      .selectResult(responseModel.results![index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    color: isSelected ? Colors.grey : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              responseModel.results![index].trackName!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
