import 'dart:convert';

import 'package:dynamic_form/models/form_model.dart';

class FormPageModel {
  final String id;
  final String label;
  final String description;
  final List<FormConfig> formConfig;

  FormPageModel({
    required this.id,
    required this.label,
    required this.description,
    required this.formConfig,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'label': label,
      'description': description,
      'form_config': formConfig.map((x) => x.toMap()).toList(),
    };
  }

  factory FormPageModel.fromMap(Map<String, dynamic> map) {
    return FormPageModel(
      id: map['id'] as String,
      label: map['label'] as String,
      description: map['description'] as String,
      formConfig: List<FormConfig>.from(
        (map['form_config'] as List<Map<String, dynamic>>).map(
          (x) => FormConfig.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FormPageModel.fromJson(String source) =>
      FormPageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
