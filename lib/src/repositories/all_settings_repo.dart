import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:pusher_beams/pusher_beams.dart';

import '../config/app_configs.dart';
import '../controllers/all_settings_controller.dart';
import '../models/all_settings_model.dart';

getAllSettingsRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GetAllSettingsController>().getAllSettingsModel =
        GetAllSettingsModel.fromJson(response);

    Get.find<GetAllSettingsController>().updateAllSettingsLoader(true);
    log("${Get.find<GetAllSettingsController>().getAllSettingsModel.data} Tất cả cài đặt");

    if (Get.find<GetAllSettingsController>().getAllSettingsModel.success ==
        true) {
      PusherBeams.instance.start(AppConfigs.pusherBeamsInstanceId);
      Stripe.publishableKey = AppConfigs.stripeKey;
      log("${AppConfigs.stripeKey} STRIPEKEY");
    }
  } else if (!responseCheck) {
    Get.find<GetAllSettingsController>().updateAllSettingsLoader(false);
  }
}
