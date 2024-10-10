import 'package:dio/dio.dart';
import 'package:flutter_video_player/video_model.dart';

class Api {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://itunes.apple.com/search?term=jack+johnson&entity=musicVideo';

  Future<ResponseModel?> fetchVideoModel() async {
    try {
      final response = await _dio.get(_baseUrl);
      return responseModelFromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
