import 'package:dynamic_form/form_builder.dart';
import 'package:dynamic_form/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_view/flutter_json_view.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.formformId});
  final String formformId;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  void initState() {
    super.initState();

    context.read<FormProvider>().initiateFormPage(formId: widget.formformId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, provider, child) {
        final form = provider.form;
        return Scaffold(
          bottomNavigationBar: BottomAppBar(
            surfaceTintColor: Colors.white,
            height: 64,
            child: ElevatedButton(
              onPressed: provider.isLoadingSubmit
                  ? null
                  : () async {
                      final submitedValue = await provider.formValueMapping();
                      if (submitedValue != null) {
                        if (!context.mounted) return;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Container(
                                height: 500,
                                padding: const EdgeInsets.all(24),
                                child: ListView(
                                  children: submitedValue
                                      .map(
                                        (e) => JsonView.string(
                                           e.toJson(),
                                          theme: jsonTheme,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
              child: provider.isLoadingSubmit
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : const Text(
                      'Submit',
                    ),
            ),
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  form.label,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  form.description,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              const FormBuilder(),
            ],
          ),
        );
      },
    );
  }
}

const jsonTheme = JsonViewTheme(
  backgroundColor: Colors.transparent,
  keyStyle: TextStyle(
    color: Colors.black54,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
  doubleStyle: TextStyle(
    color: Colors.green,
    fontSize: 16,
  ),
  intStyle: TextStyle(
    color: Colors.green,
    fontSize: 16,
  ),
  stringStyle: TextStyle(
    color: Colors.green,
    fontSize: 16,
  ),
  boolStyle: TextStyle(
    color: Colors.green,
    fontSize: 16,
  ),
  closeIcon: Icon(
    Icons.keyboard_arrow_down_sharp,
    color: Colors.green,
    size: 20,
  ),
  openIcon: Icon(
    Icons.keyboard_arrow_right_sharp,
    color: Colors.green,
    size: 20,
  ),
  separator: Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    child: Text(':'),
  ),
);
