import 'dart:developer';
import 'dart:io';

import 'package:lawyer_consultant/src/api_services/header.dart';
import 'package:lawyer_consultant/src/api_services/logic.dart';
import 'package:lawyer_consultant/src/controllers/general_controller.dart';
import 'package:lawyer_consultant/src/repositories/main_repo/main_logic.dart';
import 'package:lawyer_consultant/src/widgets/custom_dialog.dart';
import 'package:dio/dio.dart' as dio_instance;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';
import 'urls.dart';

postMethod(
    BuildContext context,
    String apiUrl,
    dynamic postData,
    bool addAuthHeader,
    Function executionMethod // for performing functionalities
    ) async {
  dio_instance.Response response;
  dio_instance.Dio dio = dio_instance.Dio();

  setAcceptHeader(dio);
  setContentHeader(dio);

  if (addAuthHeader &&
      Get.find<GeneralController>().storageBox.hasData('authToken')) {
    log("${Get.find<GeneralController>().storageBox.hasData('authToken')} Sevice Auth");
    setCustomHeader(dio, 'Authorization',
        'Bearer ${Get.find<GeneralController>().storageBox.read('authToken')}');
    setCustomHeader(dio, 'logged-in-as', 'customer');
  }
  if (apiUrl == fcmService) {
    setCustomHeader(dio, 'Content-Type', 'application/json');
    setCustomHeader(dio, 'Authorization',
        'key=${Get.find<MainLogic>().getConfigCredentialModel.data!.firebase![0].value}');
  }
  log('post method api.... $apiUrl');
  log('postData.... $postData');
  log('dioData.... ${dio.options.headers}');

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      Get.find<ApiController>().changeInternetCheckerState(true);

      try {
        response = await dio.post(apiUrl, data: postData);
        if (response.statusCode == 200) {
          // log('response  ....  ${response.data}');
          executionMethod(context, true, response.data);

          return;
        }
        // log('response   ....  $response');
        // executionMethod(context, false, {'status': null});
      } on dio_instance.DioError catch (e) {
        log('Dio Error  ....  ${e.response}');
        executionMethod(context, false, e.response!.data);

        if (e.response != null) {
        } else {}
      }
    }
  } on SocketException catch (_) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Vui lòng thử lại",
            titleColor: AppColors.customDialogErrorColor,
            descriptions: 'Internet không được kết nối!',
            text: "Ok",
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/icons/dialog_error.png',
          );
        });
    Get.find<ApiController>().changeInternetCheckerState(false);
  }
}
