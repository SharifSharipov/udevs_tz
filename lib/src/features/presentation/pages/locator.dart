import 'package:get_it/get_it.dart';

import '../../data/data_source/local/database.dart';
import '../../data/data_source/remote/api_service.dart';
import '../../data/repository/event_repository.dart';
import '../../data/repository/get_location_repository.dart';

final GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerFactory(() => GetLocationRepository(ApiService()));
  locator.registerFactory(() => EventRepository(LocalDataBase()));
}
