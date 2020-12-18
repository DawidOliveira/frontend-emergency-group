import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final bool autocorrect;
  final TextInputType keyboardType;
  final String hintText;
  final String value;
  final Function(String) onChanged;
  final TextCapitalization textCapitalization;

  const TextFormFieldWidget({
    Key key,
    this.autocorrect = false,
    this.keyboardType = TextInputType.text,
    @required this.hintText,
    @required this.value,
    @required this.onChanged,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCapitalization,
      autocorrect: autocorrect,
      keyboardType: keyboardType,
      onChanged: onChanged,
      initialValue: value,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
      ),
    );
  }
}
