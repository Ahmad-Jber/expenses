import 'package:expenses/services/api_services/base_models.dart';
import 'package:expenses/services/api_services/dio.dart';
import 'package:expenses/services/local_storage.dart';
import 'package:expenses/services/models/login_models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserServices {
  UserServices({required ApiClient client}) : _client = client;
  late final ApiClient _client;

  Future<AuthenticationResultDto> login(LoginInput input) async {
    var loginUrl = dotenv.env["LOGIN_URL"] ?? "";
    var result = await _client.send(
      ApiRequest<AuthenticationResultDto>(
          path: loginUrl,
          method: HttpMethod.post,
          body: input,
          parser: (json) => AuthenticationResultDto.fromJson(json)),
    );
    await LocalStorage.storeData("AccessToken", result.accessToken);
    await LocalStorage.storeData("RefreshToken", result.refreshToken);
    // LocalStorage.storeData("EncryptedToken", result.encryptedToken);
    await LocalStorage.storeData(
        "ExpirationDate", result.expirationDate!.toIso8601String());
    return result;
  }
}
