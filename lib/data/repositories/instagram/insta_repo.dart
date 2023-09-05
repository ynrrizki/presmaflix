import 'package:dio/dio.dart';

class InstagramRepository {
  static const String baseUrl = "https://api.instagram.com";
  final String accessToken;
  Dio? _dio;

  InstagramRepository(this.accessToken) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Map<String, dynamic>> getUser(String username) async {
    const url = "/v1/users/self/";
    final response =
        await _dio!.get(url, queryParameters: {"access_token": accessToken});
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("Failed to fetch user data");
    }
  }

  Future<Map<String, dynamic>> getUserMedia(String userId) async {
    final url = "/v1/users/$userId/media/recent/";
    final response =
        await _dio!.get(url, queryParameters: {"access_token": accessToken});
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("Failed to fetch user media");
    }
  }

  Future<Map<String, dynamic>> likeMedia(String mediaId) async {
    final url = "/v1/media/$mediaId/likes";
    final response = await _dio!.post(url, data: {"access_token": accessToken});
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("Failed to like media");
    }
  }

  Future<Map<String, dynamic>> unlikeMedia(String mediaId) async {
    final url = "/v1/media/$mediaId/likes";
    final response =
        await _dio!.delete(url, data: {"access_token": accessToken});
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("Failed to unlike media");
    }
  }
}
