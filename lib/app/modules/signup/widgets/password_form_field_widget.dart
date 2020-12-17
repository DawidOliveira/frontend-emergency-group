import 'package:emergency_group/app/modules/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PasswordFormFieldWidget extends StatelessWidget {
  const PasswordFormFieldWidget({
    Key key,
    @required this.controller,
    @required this.hintText,
    @required this.value,
    @required this.onChanged,
  }) : super(key: key);

  final SignupController controller;
  final String hintText;
  final String value;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => TextFormField(
        onChanged: onChanged,
        initialValue: value,
        autocorrect: false,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          suffixIcon: IconButton(
            onPressed: () {
              controller.setVisiblePassword(!controller.passwordVisible);
            },
            icon: Icon(controller.passwordVisible
                ? Icons.visibility
                : Icons.visibility_off),
          ),
        ),
        obscureText: controller.passwordVisible ? false : true,
      ),
    );
  }
}
