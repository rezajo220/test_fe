import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String identifier,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({Dio? dio}) : dio = dio ?? DioClient.instance;

  @override
  Future<UserModel> login({
    required String identifier,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        AppConstants.loginEndpoint,
        data: {
          'identifier': identifier,
          'password': password,
        },
      );

      if (response.data['success'] == true) {
        return UserModel.fromJson(response.data['data']);
      }

      throw ServerException(
        response.data['message'] ?? 'Login failed',
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException(
          e.response?.data['message'] ?? 'Invalid credential',
        );
      }
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException('No internet connection');
      }
      throw ServerException(
        e.response?.data['message'] ?? e.message ?? 'Server error',
      );
    }
  }
}