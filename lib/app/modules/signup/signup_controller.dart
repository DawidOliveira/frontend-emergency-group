import 'package:emergency_group/app/shared/auth/auth_repository_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'signup_controller.g.dart';

@Injectable()
class SignupController = _SignupControllerBase with _$SignupController;

abstract class _SignupControllerBase with Store {
  final IAuthRepository _authRepository;
  _SignupControllerBase(this._authRepository);

  @observable
  String email;
  @observable
  String password;
  @observable
  String username;
  @observable
  String fullname;
  @observable
  bool isLoading = false;
  @observable
  bool passwordVisible = false;

  @action
  void setIsLoading(bool value) => isLoading = value;
  @action
  void setVisiblePassword(bool value) => passwordVisible = value;
  @action
  void setEmail(String value) => email = value;
  @action
  void setPassword(String value) => password = value;
  @action
  void setUsername(String value) => username = value;
  @action
  void setFullname(String value) => fullname = value;

  Future<void> signup(BuildContext context) async {
    isLoading = true;

    if (email == null ||
        password == null ||
        fullname == null ||
        username == null ||
        fullname.isEmpty ||
        username.isEmpty ||
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
        .signup(
      email: email,
      fullname: fullname,
      password: password,
      username: username,
    )
        .then((_) {
      email = '';
      password = '';
      username = '';
      fullname = '';
      isLoading = false;

      Modular.to.popUntil((route) => route.isFirst);
      Modular.to.pushReplacementNamed('/home');
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao fazer cadastro'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      isLoading = false;

      return;
    });
  }
}
