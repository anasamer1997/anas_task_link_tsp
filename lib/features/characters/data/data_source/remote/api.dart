import 'package:dio/dio.dart';

import 'package:rick_and_morty_explorer/core/helper/log_helper.dart';

abstract class Api {
  dynamic loadCharacters({int page = 0});
}

class ApiImpl implements Api {
  final Dio dio;

  ApiImpl(this.dio);

  @override
  dynamic loadCharacters({int page = 0}) async {
    try {
      final Response<Map<String, dynamic>> response = await dio
          .get('https://rickandmortyapi.com/api/character/?page=$page');

      return response;
    } on DioException catch (e) {
      logger.e(e.toString());
      throw (e);
    }
  }
}
