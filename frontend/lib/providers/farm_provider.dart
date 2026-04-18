import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';

class FarmProvider extends StateNotifier<List<dynamic>> {
  final ApiService apiService;

  FarmProvider(this.apiService) : super([]);

  Future<void> fetchFarms(String userId) async {
    try {
      final farms = await apiService.getFarms(userId);
      state = farms;
    } catch (e) {
      state = [];
    }
  }
}

final farmProvider = StateNotifierProvider<FarmProvider, List<dynamic>>((ref) {
  return FarmProvider(ApiService());
});
