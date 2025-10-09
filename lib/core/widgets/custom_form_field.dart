import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormField extends StatelessWidget {
  CustomFormField({
    super.key,
    required this.controller,
    this.validator,
    this.maxLines,
    required this.hinttext,
  });
  TextEditingController controller;
  String? Function(String?)? validator;
  String hinttext;
  int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      maxLines: maxLines,
      controller: controller,
      style: Theme.of(context).textTheme.labelSmall,
      decoration: InputDecoration(hint: Text(hinttext)),
    );
  }
}
