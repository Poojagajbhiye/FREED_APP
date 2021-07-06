import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
part 'ApiClient.g.dart';

@RestApi(baseUrl: "https://dco-leave-app-api.herokuapp.com/")
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  static ApiClient getServices() {
    final dio = Dio();
    return ApiClient(dio);
  }

  //student registration
  @POST('api/auth/register/student')
  Future<String> requestSignUp(@Body() Map<String, dynamic> map);

  //student login
  @POST('api/auth/login/student')
  Future<String> requestLogin(@Body() Map<String, dynamic> map);

  //get info from token
  @POST('api/auth/spread_token')
  Future<String> tokenDecodeRequest(@Header('x-leave-auth-token') String token);

  //student new leave request
  @POST('api/records/new')
  Future<String> newLeaveRequest(@Body() Map<String, dynamic> requestBody);
}
