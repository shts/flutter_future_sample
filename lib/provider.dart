import 'package:future_sample/api_service.dart';
import 'package:future_sample/message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math';

/// --------------------------------------------------------------------------------
/// FutureProvider
/// --------------------------------------------------------------------------------

final asyncTaskProvider = FutureProvider.family<String, String>((_, name) {
  // ignore: avoid_print
  print('exec asyncTaskProvider. $name');
  int waitSeconds = Random().nextInt(10);
  return Future.delayed(Duration(seconds: waitSeconds), () {
    // ignore: avoid_print
    print('return. $name');
    return "complete. $name";
  });
});

final taskListProvider = FutureProvider((ref) {
  return Future.wait([
    // future を渡すと ref.refresh できない。
    ref.watch(asyncTaskProvider("${Random().nextInt(10)}").future),
    ref.watch(asyncTaskProvider("${Random().nextInt(10)}").future),
    ref.watch(asyncTaskProvider("${Random().nextInt(10)}").future),
  ]);
});

/// --------------------------------------------------------------------------------
/// Provider
/// --------------------------------------------------------------------------------

final taskProvider = Provider.family<Future<String>, String>((_, name) {
  // ignore: avoid_print
  print('exec taskProvider. $name');
  int waitSeconds = Random().nextInt(10);
  return Future.delayed(Duration(seconds: waitSeconds), () {
    // ignore: avoid_print
    print('return. $name');
    return "complete. $name";
  });
});

final tasksProvider = FutureProvider((ref) {
  return Future.wait([
    ref.watch(taskProvider("${Random().nextInt(10)}")),
    ref.watch(taskProvider("${Random().nextInt(10)}")),
    ref.watch(taskProvider("${Random().nextInt(10)}")),
  ]);
});

/// --------------------------------------------------------------------------------
/// リモートサーバーへ接続する Provider
/// --------------------------------------------------------------------------------

final echoProvider = Provider.family<Future<Message>, String>((ref, message) {
  return ref.watch(apiServiceProvider).echoMessage(message);
});

final echosProvider = FutureProvider((ref) {
  return Future.wait([
    Future.delayed(const Duration(seconds: 3)),
    ref.watch(echoProvider("${Random().nextInt(10)}")),
    ref.watch(echoProvider("${Random().nextInt(10)}")),
    ref.watch(echoProvider("${Random().nextInt(10)}")),
  ]);
});

/// dummy 用
final updateProvider =
    Provider((ref) => Future.delayed(const Duration(seconds: 3)));
