// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DynamicFormValueModel {
  final int id;
  final String label;
  List<FormValueModel> values;

  DynamicFormValueModel({
    required this.id,
    required this.label,
    required this.values,
  });

  @override
  String toString() =>
      '\nDynamicFormValueModel => id: $id,\nlabel: $label,\nvalues: $values\n';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'label': label,
      'values': values.map((x) => x.toMap()).toList(),
    };
  }

  factory DynamicFormValueModel.fromMap(Map<String, dynamic> map) {
    return DynamicFormValueModel(
      id: map['id'] as int,
      label: map['label'] as String,
      values: List<FormValueModel>.from((map['values'] as List<int>).map<FormValueModel>((x) => FormValueModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory DynamicFormValueModel.fromJson(String source) => DynamicFormValueModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FormValueModel {
  final String id;
  final String label;
  final dynamic value;

  FormValueModel({required this.id, required this.label, required this.value});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'label': label,
      'value': value,
    };
  }

  factory FormValueModel.fromMap(Map<String, dynamic> map) {
    return FormValueModel(
      id: map['id'] as String,
      label: map['label'] as String,
      value: map['value'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormValueModel.fromJson(String source) =>
      FormValueModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      '\nForm Value => id: $id,\nlabel: $label,\nvalue: $value\n';
}
