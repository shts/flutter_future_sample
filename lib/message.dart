import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

/// $ flutter pub run build_runner build --delete-conflicting-outputs

@freezed
class Message with _$Message {
  const factory Message(
    String message,
  ) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
