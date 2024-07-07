
import 'package:udevs_tz/src/core/resourses/data_state.dart';
import 'package:udevs_tz/src/features/data/data_source/remote/api_service.dart';

class GetLocationRepository {
  final ApiService apiService;
  const GetLocationRepository(this.apiService);

  Future<DataSate> getLocation({
    required double lat,
    required double lon,
  }) async {
    return apiService.getLocationName(lat: lat, lon: lon);
  }
}
