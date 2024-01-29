import 'dart:developer';
import 'package:dynamic_form/models/form_model.dart';
import 'package:dynamic_form/providers/form_provider.dart';
import 'package:dynamic_form/widgets/form_label.dart';
import 'package:dynamic_form/widgets/form_warning_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormRadio extends StatelessWidget {
  const FormRadio({super.key, required this.config});
  final FormConfig config;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FormProvider>();

    final String selectedValue = config.value ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FormLabel(config: config),
          Column(
            children: config.props.options!
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: Radio(
                            value: e,
                            groupValue: selectedValue,
                            fillColor: MaterialStateColor.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return Theme.of(context).primaryColor;
                              } else {
                                return Colors.black12;
                              }
                            }),
                            onChanged: (value) {
                              log('value: $value');
                              provider.selectRadio(
                                id: config.id,
                                value: value,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                            onTap: () {
                              provider.selectRadio(
                                id: config.id,
                                value: e,
                              );
                            },
                            child: Text(e)),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          FormWarningLabel(isWarned: config.props.isWarned),
        ],
      ),
    );
  }
}
