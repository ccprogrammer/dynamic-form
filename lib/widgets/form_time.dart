import 'package:dynamic_form/models/form_model.dart';
import 'package:dynamic_form/providers/form_provider.dart';
import 'package:dynamic_form/widgets/form_label.dart';
import 'package:dynamic_form/widgets/form_warning_label.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FormTime extends StatelessWidget {
  const FormTime({super.key, required this.config});
  final FormConfig config;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FormProvider>();

    final String selectedValue = config.value ?? '';

    DateTime? dateTime = selectedValue.isNotEmpty
        ? DateFormat("h:mm a").parse(selectedValue)
        : null;

    TimeOfDay timeOfDay =
        dateTime != null ? TimeOfDay.fromDateTime(dateTime) : TimeOfDay.now();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FormLabel(config: config),
          GestureDetector(
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: timeOfDay,
              );
              if (time != null) {
                if (context.mounted) {
                  provider.selectTime(
                    id: config.id,
                    value: time.format(context),
                  );
                }
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
                  Image.asset('assets/images/icon-time.png', width: 24),
                  const SizedBox(width: 8),
                  selectedValue.isEmpty
                      ? const Text('Select Time')
                      : Text(selectedValue),
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
