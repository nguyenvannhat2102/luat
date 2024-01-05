import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer_consultant/src/controllers/all_law_firms_controller.dart';
import 'package:lawyer_consultant/src/models/all_law_firms_model.dart';
import '../controllers/general_controller.dart';

getAllLawFirmsRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<AllLawFirmsController>().getAllLawFirmsModel =
        GetAllLawFirmsModel.fromJson(response);

    Get.find<AllLawFirmsController>().updateLawFirmsLoader(true);
    log("${Get.find<AllLawFirmsController>().getAllLawFirmsModel.data!.data!.length.toString()} Tổng số công ty luật");

    for (var element
        in Get.find<AllLawFirmsController>().getAllLawFirmsModel.data!.data!) {
      Get.find<AllLawFirmsController>()
          .updateLawFirmsListForPagination(element);
    }

    Get.find<GeneralController>().changeGetPaginationProgressCheck(false);

    // if (Get.find<AllLawyersCategoriesController>().getAllLawyerCategoriesDataModel.status == true) {
    // } else {}
  } else if (!responseCheck) {
    Get.find<AllLawFirmsController>().updateLawFirmsLoader(true);
  }
}
