import 'meta.dart';

class Response<T> {
  T data;
  Meta meta;

  Response({
    required this.data,
    required this.meta,
  });
}