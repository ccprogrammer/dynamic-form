import 'package:dynamic_form/models/form_model.dart';
import 'package:dynamic_form/providers/form_provider.dart';
import 'package:dynamic_form/widgets/form_label.dart';
import 'package:dynamic_form/widgets/form_warning_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormCheckbox extends StatelessWidget {
  const FormCheckbox({super.key, required this.config});
  final FormConfig config;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FormProvider>();

    String selectedValue = config.value ?? "";

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
                          child: Checkbox(
                            value: e == selectedValue,
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                  width: 1.0, color: Colors.black38),
                            ),
                            onChanged: (value) {
                              provider.selectRadio(
                                id: config.id,
                                value: e,
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
                          child: Text(e),
                        ),
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
