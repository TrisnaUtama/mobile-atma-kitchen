

import 'package:dio/dio.dart';

const String API_URL = 'http://10.0.2.2:8000/';
const String ENDPOINT = 'api/v1';
final Dio client = Dio();

class forgotPasswordController{
  Future sendRequest(String email) async{
    try{
      final res = await client.post(
        '$API_URL${ENDPOINT}/lupaPassword/create',
        options: Options(
          headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },),
        data:{
          'email': email,
        },
      );
      return res;
    } on DioException catch(e){
      return e.response;
    }catch(e){
      throw e.toString();
    }
  }
  Future changePassword(String password, String confirm_password, String token) async{
    try{
      final res = await client.post(
        '$API_URL${ENDPOINT}/reset/$token',
        options: Options(
          headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },),
        data: {
          'password': password,
          'confirmasi_pass': confirm_password,
        },
      );
      return res;
    } on DioException catch(e){
      return e.response;
    } catch(e){
      throw e.toString();
    }
  }
}