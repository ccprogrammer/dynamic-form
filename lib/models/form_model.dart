import 'dart:convert';

class FormConfig {
  final String id;
  final String type;
  final String label;
  final FormProps props;
  dynamic value;

  FormConfig({
    required this.id,
    required this.type,
    required this.label,
    required this.props,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'label': label,
      'props': props.toMap(),
      'value': value,
    };
  }

  factory FormConfig.fromMap(Map<String, dynamic> map) {
    return FormConfig(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      label: map['label'] ?? '',
      props: FormProps.fromMap(map['props'] as Map<String, dynamic>),
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FormConfig.fromJson(String source) =>
      FormConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FormConfig(id: $id, type: $type, label: $label, props: $props, value: $value)';
  }
}

class FormProps {
  final bool? isRequired;
  bool isWarned;
  final List? options;

  FormProps({this.isRequired, this.isWarned = false, this.options});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'required': isRequired,
      'is_warned': isWarned,
      'options': options,
    };
  }

  factory FormProps.fromMap(Map<String, dynamic> map) {
    return FormProps(
      isRequired: map['required'] != null ? map['required'] as bool : null,
      isWarned: map['is_warned'],
      options: map['options'] != null
          ? List.from((map['options'] as List)).toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormProps.fromJson(String source) =>
      FormProps.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FormProps(isRequired: $isRequired, isWarned: $isWarned, options: $options)';
}
