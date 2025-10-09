import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
 const CustomCheckBox({super.key, required this.value, this.onChanged});

  final bool value;
  final void Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Color(0xff15B86C),
      value: value,
      onChanged: onChanged,
    );
  }
}
