

import 'package:udevs_tz/src/features/data/data_source/remote/dio_exceptions.dart';

abstract class DataSate {
  final dynamic data;
  final DioCustomException? dioException;

  const DataSate({
    this.data,
    this.dioException,
  });
}

class DataSuccess extends DataSate {
  DataSuccess({
    dynamic data,
  }) : super(data: data);
}

class DataFailure extends DataSate {
  const DataFailure({
    required DioCustomException dioException,
  }) : super(dioException: dioException);
}
