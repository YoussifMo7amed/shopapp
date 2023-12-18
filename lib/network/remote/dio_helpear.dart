// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
     
    ));
  }

 static Future<Response> getData({
    required String url,
     Map<String, dynamic>? query,
        String lang='ar',
    String?Token
  }) async {
      dio!.options.headers={
'lang':lang,
'Authorization':Token??'',
'Content-Type':'application/json'
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang='ar',
    String?Token
  }) async
  {
    dio!.options.headers={
'lang':lang,
'Authorization':Token??'',
'Content-Type':'application/json'
    };
    {

    }
return await dio!.post(
  url,
  queryParameters: query,
  data: data
);
  }

   static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang='ar',
    String?Token
  }) async
  {
    dio!.options.headers={
'lang':lang,
'Authorization':Token??'',
'Content-Type':'application/json'
    };
    {

    }
return await dio!.put(
  url,
  queryParameters: query,
  data: data
);
  }
}
