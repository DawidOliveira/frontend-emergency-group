import 'package:emergency_group/app/modules/signup/widgets/button_gradient_widget.dart';
import 'package:emergency_group/app/modules/signup/widgets/password_form_field_widget.dart';
import 'package:emergency_group/app/modules/signup/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'signup_controller.dart';

class SignupPage extends StatefulWidget {
  final String title;
  const SignupPage({Key key, this.title = "Cadastre-se"}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends ModularState<SignupPage, SignupController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: SizedBox(
                  width: 100,
                  child: Image.asset('assets/images/logoIcon.png'),
                ),
              ),
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Form(
                    child: Column(
                      children: [
                        TextFormFieldWidget(
                          onChanged: controller.setUsername,
                          value: controller.username,
                          hintText: 'Usuário',
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormFieldWidget(
                          onChanged: controller.setFullname,
                          value: controller.fullname,
                          hintText: 'Nome completo',
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                            controller.signup(context);
                          },
                          text: 'Cadastrar',
                          controller: controller,
                        ),
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
                      Text('Já tem uma conta?'),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: Text(
                          'Login',
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
