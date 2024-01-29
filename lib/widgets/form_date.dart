import 'package:dynamic_form/models/form_model.dart';
import 'package:dynamic_form/providers/form_provider.dart';
import 'package:dynamic_form/widgets/form_label.dart';
import 'package:dynamic_form/widgets/form_warning_label.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FormDate extends StatelessWidget {
  const FormDate({super.key, required this.config});
  final FormConfig config;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FormProvider>();

    final String selectedValue = config.value ?? '';

    final String convertedDate = selectedValue.isNotEmpty
        ? DateFormat.yMMMMd().format(DateTime.parse(selectedValue))
        : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FormLabel(config: config),
          GestureDetector(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.tryParse(selectedValue),
                firstDate: DateTime(DateTime.now().year - 1000),
                lastDate: DateTime(DateTime.now().year + 1000),
              );
              if (date != null) {
                provider.selectDate(
                  id: config.id,
                  value: date.toString(),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              width: MediaQuery.of(context).size.width / 1.6,
              decoration: BoxDecoration(
                border: Border.all(
                  color: config.props.isWarned
                      ? Colors.red.withOpacity(0.6)
                      : Colors.black12,
                  width: 0.8,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/icon-date.png', width: 24),
                  const SizedBox(width: 8),
                  selectedValue.isEmpty
                      ? const Text('Select Date')
                      : Text(convertedDate),
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
