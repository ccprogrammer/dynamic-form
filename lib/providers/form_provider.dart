import 'package:dynamic_form/models/form_page_model.dart';
import 'package:dynamic_form/models/form_model.dart';
import 'package:dynamic_form/models/form_value_model.dart';
import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier {
  BuildContext? _context;
  BuildContext? get context => _context;

  bool _isLoadingInitiate = true;
  bool get isLoadingInitiate => _isLoadingInitiate;

  List<FormPageModel> _formPages = [];
  List<FormPageModel> get formPages => _formPages;

  String? _currentFormId;
  String? get currentFormId => _currentFormId;

  FormPageModel get form =>
      _formPages.firstWhere((element) => element.id == _currentFormId);

  bool _isLoadingSubmit = false;
  bool get isLoadingSubmit => _isLoadingSubmit;

  /// Initiate Forms Screen
  void initiate({required BuildContext context}) {
    _context = context;
    _isLoadingInitiate = false;
    _formPages = mappingForm();
  }

  /// Selecting form from [HomeScreen] ListTile
  void initiateFormPage({required String formId}) {
    _currentFormId = formId;
  }

  /// Responsible to mapping all form value
  Future<List<FormValueModel>?> formValueMapping() async {
    final List<FormValueModel> tmpFormValues = [];
    bool isValid = true;
    for (var obj in form.formConfig) {
      final isRequired = obj.props.isRequired ?? false;
      final isEmptyValue = obj.value == null || obj.value == '';

      // if value is null this will inject warning boolean to the form field
      // to show a warning text
      obj.props.isWarned = false;
      if (isRequired && isEmptyValue) {
        obj.props.isWarned = true;
        isValid = false;
        notifyListeners();
      } else {
        final valueObject = FormValueModel(
          id: obj.id,
          label: obj.label,
          value: obj.value,
        );
        tmpFormValues.add(valueObject);
      }
    }

    if (isValid) {
      _isLoadingSubmit = true;
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 500));

      _isLoadingSubmit = false;
      notifyListeners();

      return tmpFormValues;
    } else {
      return null;
    }
  }

  // Form Value Input Section
  void selectTextInput({required String id, required String value}) {
    final config = form.formConfig.firstWhere((element) => element.id == id);
    config.props.isWarned = false;
    config.value = value;
    notifyListeners();
  }

  void selectDropdown({required String id, required String value}) {
    final config = form.formConfig.firstWhere((element) => element.id == id);
    config.props.isWarned = false;
    config.value = value;
    notifyListeners();
  }

  void selectRadio({required String id, required String value}) {
    final config = form.formConfig.firstWhere((element) => element.id == id);
    config.props.isWarned = false;
    config.value = value;
    notifyListeners();
  }

  void selectCheckbox({required String id, required String value}) {
    final config = form.formConfig.firstWhere((element) => element.id == id);
    config.props.isWarned = false;
    config.value = value;
    notifyListeners();
  }

  void selectMulticheckbox({required String id, required String value}) {
    final config = form.formConfig.firstWhere((element) => element.id == id);
    config.props.isWarned = false;

    final bool isValueNull = config.value == null ? true : false;

    if (isValueNull) {
      config.value = <String>[];
    }

    final List<String> formValue = config.value;

    if (formValue.contains(value)) {
      formValue.remove(value);
    } else {
      formValue.add(value);
    }

    notifyListeners();
  }

  void selectDate({required String id, required String value}) {
    final config = form.formConfig.firstWhere((element) => element.id == id);
    config.props.isWarned = false;
    config.value = value;
    notifyListeners();
  }

  void selectTime({required String id, required String value}) {
    final config = form.formConfig.firstWhere((element) => element.id == id);
    config.props.isWarned = false;
    config.value = value;
    notifyListeners();
  }

  // Testing Data
  List<FormPageModel> mappingForm() {
    final List<FormPageModel> forms = [
      FormPageModel(
        id: 'Jhaowhe283',
        label: 'Form One',
        description: 'Form Description',
        formConfig: [
          FormConfig(
            id: 'asdoj',
            type: 'input',
            label: 'Input Form',
            props: FormProps(
              isRequired: true,
            ),
          ),
          FormConfig(
            id: 'fd324',
            type: 'textarea',
            label: 'Text Area Form',
            props: FormProps(
              isRequired: true,
            ),
          ),
          FormConfig(
            id: 'cxgvr3',
            type: 'dropdown',
            label: 'Dropdown Form',
            props: FormProps(
              isRequired: true,
              options: [
                'Option 1',
                'Option 2',
                'Option 3',
              ],
            ),
          ),
          FormConfig(
            id: 'bdgf4',
            type: 'checkbox',
            label: 'Checkbox Form',
            props: FormProps(
              isRequired: true,
              options: [
                'Option 1',
                'Option 2',
                'Option 3',
              ],
            ),
          ),
          FormConfig(
            id: 'cg3r4',
            type: 'multicheckbox',
            label: 'Multicheckbox Form',
            props: FormProps(
              isRequired: true,
              options: [
                'Option 1',
                'Option 2',
                'Option 3',
              ],
            ),
          ),
          FormConfig(
            id: 'ghj52',
            type: 'radio',
            label: 'Radio Form',
            props: FormProps(
              isRequired: true,
              options: [
                'Option 1',
                'Option 2',
                'Option 3',
              ],
            ),
          ),
          FormConfig(
            id: 'f34r5',
            type: 'date',
            label: 'Date Form',
            props: FormProps(
              isRequired: true,
            ),
          ),
          FormConfig(
            id: 'fvbvdr',
            type: 'time',
            label: 'Time Form',
            props: FormProps(
              isRequired: true,
            ),
          ),
        ],
      ),
      FormPageModel(
        id: 'gweorj29',
        label: 'Form Two',
        description: 'Form Description',
        formConfig: [
          FormConfig(
            id: 'cdg3',
            type: 'textarea',
            label: 'Text Area Form',
            props: FormProps(
              isRequired: true,
            ),
          ),
        ],
      ),
    ];

    return forms;
  }
}
