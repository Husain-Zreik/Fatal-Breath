import 'package:fatal_breath_frontend/config/local.storage.config.dart';
import 'package:fatal_breath_frontend/enums/request.methods.dart';
import 'package:fatal_breath_frontend/enums/local.types.dart';
import 'package:dio/dio.dart';

final options = BaseOptions(
  baseUrl: "http://192.168.1.5:8000",
  contentType: Headers.jsonContentType,
);

final dioClient = Dio(options);

Future sendRequest(
    {required String route,
    RequestMethods method = RequestMethods.GET,
    Map? load}) async {
  final String? token =
      await getLocal(type: LocalTypes.String, key: "access_key");

  if (token != null) {
    final BaseOptions authorizeOptions =
        dioClient.options.copyWith(headers: {"Authorization": "Bearer $token"});

    dioClient.options = authorizeOptions;
  }

  if (method == RequestMethods.GET) {
    final response = await dioClient.get(route, data: load);
    final data = response.data;
    return data;
  } else if (method == RequestMethods.POST) {
    final response = await dioClient.post(route, data: load);
    final data = response.data;
    return data;
  } else if (method == RequestMethods.DELETE) {
    final response = await dioClient.delete(route, data: load);
    final data = response.data;
    return data;
  } else if (method == RequestMethods.PUT) {
    final response = await dioClient.put(route, data: load);
    final data = response.data;
    return data;
  }

  return Future(() {
    return "NULL";
  });
}
