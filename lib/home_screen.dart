import 'package:dynamic_form/form_screen.dart';
import 'package:dynamic_form/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FormProvider>().initiate(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Forms'),
      ),
      body: Consumer<FormProvider>(builder: (context, provider, _) {
        if (provider.isLoadingInitiate) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (provider.formPages.isEmpty) {
          return const Center(
            child: Text('No Form Available'),
          );
        }

        return ListView.separated(
          itemCount: provider.formPages.length,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
          itemBuilder: (context, index) {
            final form = provider.formPages[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormScreen(formformId: form.id),
                    ),
                  );
                },
                title: Text(
                  form.label,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  form.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
