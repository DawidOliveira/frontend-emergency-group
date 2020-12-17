import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login_controller.dart';
import './widgets/text_form_field_widget.dart';
import './widgets/password_form_field_widget.dart';
import './widgets/button_gradient_widget.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: SizedBox(
                  width: 100,
                  child: Image.asset('assets/images/logoIcon.png'),
                ),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Form(
                    child: Column(
                      children: [
                        TextFormFieldWidget(
                          onChanged: controller.setEmail,
                          value: controller.email,
                          hintText: 'E-mail',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        PasswordFormFieldWidget(
                          onChanged: controller.setPassword,
                          value: controller.password,
                          controller: controller,
                          hintText: 'Password',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonGradientWidget(
                          fn: () async {
                            controller.setIsLoading(true);
                            await controller.login(context);
                            controller.setIsLoading(false);
                          },
                          text: 'Acessar',
                          controller: controller,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Não tem uma conta? '),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/signup');
                        },
                        child: Text(
                          'Cadastre-se',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
