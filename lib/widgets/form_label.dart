import 'package:dynamic_form/models/form_model.dart';
import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  const FormLabel({
    super.key,
    required this.config,
  });

  final FormConfig config;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Flexible(
            child: Text(
              config.label,
              style: Theme.of(context).textTheme.labelLarge!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          if (config.props.isRequired ?? false)
            Text(
              '*',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
 }
}
