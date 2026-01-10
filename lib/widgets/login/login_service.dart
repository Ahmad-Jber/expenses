import 'package:expenses/services/models/loaded_model.dart';
import 'package:expenses/services/models/login_models.dart';
import 'package:expenses/services/user_services.dart';
import 'package:flutter/material.dart';

class LoginService extends ChangeNotifier {
  late UserServices _userServices;
  LoginService({required UserServices userServices}): _userServices=userServices;
  Future<LoadedModel<AuthenticationResultDto>> loginAsync(LoginInput input) async {
    var response = await _userServices.login(input);
    return LoadedModel(response: response, response.accessToken==null || response.accessToken.isEmpty);
  }
}
