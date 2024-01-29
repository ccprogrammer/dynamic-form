import 'package:dynamic_form/widgets/form_checkbox.dart';
import 'package:dynamic_form/widgets/form_date.dart';
import 'package:dynamic_form/widgets/form_dropdown.dart';
import 'package:dynamic_form/widgets/form_multicheckbox.dart';
import 'package:dynamic_form/widgets/form_radio.dart';
import 'package:dynamic_form/widgets/form_textarea.dart';
import 'package:dynamic_form/widgets/form_textbox.dart';
import 'package:dynamic_form/widgets/form_time.dart';
import 'package:dynamic_form/models/form_model.dart';
import 'package:dynamic_form/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Responsible to show all form field type
class FormBuilder extends StatelessWidget {
  const FormBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, provider, _) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.form.formConfig.length,
          itemBuilder: (context, index) {
            final FormConfig config = provider.form.formConfig[index];

            switch (config.type) {
              case 'input':
                return FormTextBox(config: config);
              case 'textarea':
                return FormTextArea(config: config);
              case 'dropdown':
                return FormDropdown(config: config);
              case 'checkbox':
                return FormCheckbox(config: config);
              case 'multicheckbox':
                return FormMultiCheckbox(config: config);
              case 'radio':
                return FormRadio(config: config);
              case 'date':
                return FormDate(config: config);
              case 'time':
                return FormTime(config: config);
              default:
                const Text('Form failed to render');
            }
            return null;
          },
        );
      },
    );
  }
}
