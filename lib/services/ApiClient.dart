import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
part 'ApiClient.g.dart';

@RestApi(baseUrl: "https://dco-leave-app-api.herokuapp.com/")
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  static ApiClient getServices() {
    final dio = Dio();
    dio.options = BaseOptions(connectTimeout: 15000);
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

  //get student records
  @GET('api/records/sid/{sid}')
  Future<String> getStudentRecords(@Path("sid") String studentId);

  //get particuler record
  @GET('api/records/{recordId}')
  Future<String> getParticulerRecord(@Path("recordId") String recordId);

  //cancel request
  @DELETE('api/records/{recordId}')
  Future<String> deleteRecord(@Path("recordId") String recordId);

  //update profile
  @POST('api/student/update')
  Future<String> updateProfile(@Body() Map<String, dynamic> progileData);
}
