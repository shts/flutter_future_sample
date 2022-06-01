import 'package:dio/dio.dart';
import 'package:future_sample/message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

/// $ flutter pub run build_runner build --delete-conflicting-outputs

final dioProvider = Provider((_) {
  return Dio(
    BaseOptions(
      baseUrl: "http://f1a1-240f-65-315e-1-4570-4def-9ff6-c9ae.ngrok.io",
    ),
  );
});

final apiServiceProvider = Provider((ref) => ApiService(ref.read));

@RestApi()
abstract class ApiService {
  factory ApiService(Reader reader) => _ApiService(
        Dio(
          BaseOptions(
            baseUrl: "http://f1a1-240f-65-315e-1-4570-4def-9ff6-c9ae.ngrok.io",
          ),
        ),
      );

  @GET('/echo')
  Future<Message> echoMessage(@Query("message") String message);
}
