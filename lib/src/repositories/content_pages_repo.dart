import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/content_pages_controller.dart';

import '../models/content_pages_model.dart';

getContentPagesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GetContentPagesController>().getContentPagesModel =
        GetContentPagesModel.fromJson(response);

    Get.find<GetContentPagesController>().updateContentPagesLoader(true);
    log("${Get.find<GetContentPagesController>().getContentPagesModel.data} Dữ liệu trang nội dung");
  } else if (!responseCheck) {
    Get.find<GetContentPagesController>().updateContentPagesLoader(false);
  }
}
