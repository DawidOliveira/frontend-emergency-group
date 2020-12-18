import 'package:emergency_group/app/shared/auth/auth_repository_interface.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  IAuthRepository _authRepository;
  _LoginControllerBase(this._authRepository);

  @observable
  String email;
  @observable
  String password;

  @action
  void setEmail(String value) => email = value;
  @action
  void setPassword(String value) => password = value;

  @observable
  bool passwordVisible = false;

  @observable
  bool isLoading = false;

  @action
  void setVisiblePassword(bool value) => passwordVisible = value;

  @action
  void setIsLoading(bool value) => isLoading = value;

  @action
  Future<void> login(BuildContext context) async {
    isLoading = true;
    if (email == null ||
        password == null ||
        email.isEmpty ||
        password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preencha os campos corretamente'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      isLoading = false;

      return;
    }
    _authRepository
        .signin(
      email: email,
      password: password,
    )
        .then((_) {
      email = '';
      password = '';
      isLoading = false;

      Modular.to.pushReplacementNamed('/home');
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email e/ou senha incorretos!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      isLoading = false;

      return;
    });
  }
}
