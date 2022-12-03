import 'package:dio/dio.dart';
import 'package:flutter_application_1/container_model.dart';

class ContainerApi {
  ContainerApi._internal();

  static ContainerApi get instance => ContainerApi._internal();

  final _dio = Dio();

  Future<List<RouteElement>> execute() async {
    try {
      final Response response = await _dio.post(
          'https://qc.smartcities.pt/server/api/bee2waste_console_v2/status/get_offline_circuit_data',
          queryParameters: {
            'system_id': '327',
            'date_from': '0',
          });
      return Route.fromJson(response.data).routes;
    } catch (e) {
      print(e);

      return [];
    }
  }
}
