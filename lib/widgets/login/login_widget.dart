import 'dart:developer';

import 'package:expenses/services/api_services/interceptors.dart';
import 'package:expenses/services/models/login_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_service.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late TextEditingController _userNameController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKey;
  late LoginService _loginService;
  bool rememberMe = false;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginService = context.read<LoginService>();
  }

  InputDecoration getTextFieldDecoration(String hintText) {
    return InputDecoration(
      border: OutlineInputBorder(),
      hintText: hintText,
    );
  }

  String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required Field';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                decoration: getTextFieldDecoration("Username"),
                controller: _userNameController,
                validator: validateField),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Password",
                suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      if (showPassword) {
                        setState(() {
                          showPassword = false;
                        });
                      } else {
                        setState(() {
                          showPassword = true;
                        });
                      }
                    }),
              ),
              controller: _passwordController,
              validator: validateField,
              obscureText: !showPassword,
            ),
            CheckboxListTile(
              title: Text(
                "Remember Me?",
              ),
              tristate: true,
              value: rememberMe,
              onChanged: (newValue) {
                setState(() {
                  rememberMe = newValue ?? false;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var loginInformation = await _loginService.loginAsync(
                    LoginInput(
                      userNameOrEmailAddress: _userNameController.value.text,
                      password: _passwordController.value.text,
                      rememberMe: rememberMe,
                    ),
                  );
                  log(prettyJson(loginInformation));
                }
              },
              child: Text("Sign in"),
            ),
          ],
        ),
      ),
    );
  }
}
