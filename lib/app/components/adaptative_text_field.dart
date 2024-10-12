import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(String) onSubmit;
  const AdaptativeTextField(
      {super.key,
      required this.controller,
      required this.onSubmit,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: onSubmit,
            placeholder: label,
          )
        : TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: onSubmit,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
