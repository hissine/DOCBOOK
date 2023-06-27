
import 'package:dio/dio.dart';

class DioHelper{

  static late Dio? dio;

  static init(){
    dio = Dio(
        BaseOptions(
          baseUrl:'https://hospital-ydoz.onrender.com/',
          receiveDataWhenStatusError: true,
        ),
    );
  }
  static Future<Response> getData ({
    required String url,
    Map<String,dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
        'Content-Type':'application/json',
        'Authorization': 'Bearer $token',
      };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
  static Future<Response> postData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String? token,
})async{
    dio!.options.headers = {
        'Content-Type':'application/json',
        'Authorization': 'Bearer $token',
      };
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
  static Future<Response> putData({
  required String url,
    Map<String,dynamic>?query,
    String? token,
    required Map<String,dynamic>data,
})async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'Authorization':'Bearer $token',
    };
    return dio!.put(url,queryParameters: query,data:data);
  }

  static Future<Response> deleteData({
    required String url,
    Map<String,dynamic>?query,
    String? token,
})async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'Authorization':'Bearer $token',
    };
    return dio!.delete(url);
  }
}
//news api https://newsapi.org/
//6d9c95acc4024fc89edf5b1ab84d8f68