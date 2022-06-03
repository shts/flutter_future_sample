import 'package:flutter/material.dart';
import 'package:future_sample/full_screen_progress_dialog.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends HookConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// NOTE: ここで FullScreenProgress を表示させようとするとエラーになる。
    /// build() 関数内で Navigator 操作できないが、FullScreenProgress は内部で Navigator を操作してるっぽい。
    final tasks = ref.watch(echosProvider);
    return Scaffold(
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
              error: (error, stack) => const Text('Error Occured'),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
            ElevatedButton(
              onPressed: () => ref.refresh(echosProvider),
              child: const Text('update'),
            ),
            ElevatedButton(
              onPressed: () {
                print("onPressed");
                // show fullscreen progress
                showFullScreenProgressDialog(context);
                // ref.watch だと2回目呼ばれないので refresh する
                ref.refresh(updateProvider).whenComplete(() {
                  // dismiss fullscreen progress
                  Navigator.of(context, rootNavigator: true).pop();
                });
              },
              child: const Text('progresss'),
            ),
          ],
        ),
      ),
    );
  }
}
