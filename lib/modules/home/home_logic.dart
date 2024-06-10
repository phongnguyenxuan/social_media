import 'package:blog/modules/home/home_state.dart';
import 'package:blog/service/network/apis/api_client.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  final ApiClient apiClient = ApiClient();

  void loadData() async {}
}
