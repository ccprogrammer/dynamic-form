import 'package:dynamic_form/models/form_model.dart';
import 'package:dynamic_form/providers/form_provider.dart';
import 'package:dynamic_form/widgets/form_label.dart';
import 'package:dynamic_form/widgets/form_warning_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormDropdown extends StatelessWidget {
  const FormDropdown({super.key, required this.config});

  final FormConfig config;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FormProvider>();

    String selectedValue = config.value ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FormLabel(config: config),
          PopupMenuButton(
            position: PopupMenuPosition.under,
            offset: const Offset(1, 0),
            itemBuilder: (context) => config.props.options!
                .map(
                  (value) => PopupMenuItem(
                    value: config.value,
                    child: Text(value),
                    onTap: () {
                      provider.selectDropdown(
                        id: config.id,
                        value: value,
                      );
                    },
                  ),
                )
                .toList(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: config.props.isWarned
                      ? Colors.red.withOpacity(0.6)
                      : Colors.black12,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedValue.isEmpty ? 'Select Option' : selectedValue,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
          FormWarningLabel(isWarned: config.props.isWarned),
        ],
      ),
    );
  }
}
