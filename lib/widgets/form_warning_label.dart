import 'package:flutter/material.dart';

class FormWarningLabel extends StatelessWidget {
  const FormWarningLabel({
    super.key,
    required this.isWarned,
  });

  final bool isWarned;

  @override
  Widget build(BuildContext context) {
    if (isWarned) {
      return const Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text(
          'Please fill the form correctly',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return const SizedBox();
  }
}
