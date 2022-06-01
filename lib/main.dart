import 'package:flutter/material.dart';
import 'package:future_sample/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(echosProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              tasks.when(
                data: (data) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (_, index) => Text("item: ${data[index]}"));
                },
                error: (_, __) => const Text('Error Occured'),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
              ElevatedButton(
                onPressed: () => ref.refresh(echosProvider),
                child: const Text('update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
