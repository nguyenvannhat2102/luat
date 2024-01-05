import 'package:get/get.dart';
import '../models/all_settings_model.dart';

class GetAllSettingsController extends GetxController {
  GetAllSettingsModel getAllSettingsModel = GetAllSettingsModel();

  bool getAllSettingsLoader = false;
  updateAllSettingsLoader(bool newValue) {
    getAllSettingsLoader = newValue;
    update();
  }
}
