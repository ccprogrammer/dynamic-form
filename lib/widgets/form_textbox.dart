import 'package:dynamic_form/models/form_model.dart';
import 'package:dynamic_form/providers/form_provider.dart';
import 'package:dynamic_form/widgets/form_label.dart';
import 'package:dynamic_form/widgets/form_warning_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormTextBox extends StatefulWidget {
  const FormTextBox({
    super.key,
    required this.config,
  });

  final FormConfig config;

  @override
  State<FormTextBox> createState() => _FormTextBoxState();
}

class _FormTextBoxState extends State<FormTextBox> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = widget.config.value ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FormProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FormLabel(config: widget.config),
          TextFormField(
            controller: textController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.config.props.isWarned
                      ? Colors.red.withOpacity(0.6)
                      : Colors.black12,
                ),
              ),
              fillColor: Colors.red,
            ),
            onChanged: (value) {
              provider.selectTextInput(id: widget.config.id, value: value);
            },
          ),
          FormWarningLabel(isWarned: widget.config.props.isWarned),
        ],
      ),
    );
   }
}
