import 'package:emergency_group/app/modules/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ButtonGradientWidget extends StatelessWidget {
  const ButtonGradientWidget({
    Key key,
    @required this.text,
    this.fn,
    this.controller,
  }) : super(key: key);

  final String text;
  final Function fn;
  final SignupController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withAlpha(170),
            Theme.of(context).primaryColor,
          ],
        ),
      ),
      height: 50,
      width: MediaQuery.of(context).size.width / 1.2,
      child: Observer(
        builder: (context) => RaisedButton(
          onPressed: fn,
          color: Colors.transparent,
          highlightElevation: 0,
          focusElevation: 0,
          elevation: 0,
          textColor: Colors.white,
          child: controller.isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              : Text(text),
        ),
      ),
    );
  }
}
