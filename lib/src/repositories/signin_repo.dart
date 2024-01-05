import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer_consultant/src/controllers/pusher_beams_controller.dart';
import 'package:lawyer_consultant/src/controllers/signin_controller.dart';

import '../config/app_colors.dart';
import '../controllers/general_controller.dart';
import '../models/signin_user_model.dart';
import '../routes.dart';
import '../widgets/custom_dialog.dart';

signInWithEmailRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<SigninController>().signInUserModel =
        GetSignInUserModel.fromJson(response);

    if (Get.find<SigninController>().signInUserModel.success == true) {
      Get.find<GeneralController>().storageBox.write('authToken',
          Get.find<SigninController>().signInUserModel.data!.token);

      log("${Get.find<GeneralController>().storageBox.read('authToken')} Logged IN User Token");
      Get.find<GeneralController>().storageBox.write('userID',
          Get.find<SigninController>().signInUserModel.data!.user!.id);
      log("${Get.find<GeneralController>().storageBox.read('userID')} Logged IN User UserID");
      Get.find<GeneralController>().storageBox.write('login_as', "customer");
      Get.find<GeneralController>().storageBox.write('userData',
          jsonEncode(Get.find<SigninController>().signInUserModel.data!.user));

      Get.find<PusherBeamsController>().initPusherBeams();

      if (Get.find<SigninController>().signInUserModel.data!.user!.isCustomer ==
          true) {
        Get.find<GeneralController>().updateFormLoaderController(false);
        print("Login As Customer");
        Get.toNamed(PageRoutes.homeScreen);
      } else {
        Get.find<GeneralController>().updateFormLoaderController(false);
      }
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Vui lòng thử lại",
              titleColor: AppColors.customDialogErrorColor,
              descriptions: '${response["message"]} TT',
              text: "Ok",
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/icons/dialog_error.png',
            );
          });
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Vui lòng thử lại",
            titleColor: AppColors.customDialogErrorColor,
            descriptions:
                '${Get.find<SigninController>().signInUserModel.message}',
            text: "Ok",
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/icons/dialog_error.png',
          );
        });
  }
}

socialSignInWithEmailRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<SigninController>().signInUserModel =
        GetSignInUserModel.fromJson(response);
    if (Get.find<SigninController>().signInUserModel.success.toString() ==
        'true') {
      Get.find<GeneralController>().storageBox.write('authToken',
          Get.find<SigninController>().signInUserModel.data!.token);

      log("${Get.find<GeneralController>().storageBox.read('authToken')} Logged IN User Token");
      Get.find<GeneralController>().storageBox.write('userID',
          Get.find<SigninController>().signInUserModel.data!.user!.id);

      Get.find<GeneralController>().storageBox.write('login_as', "customer");
      Get.find<GeneralController>().storageBox.write('userData',
          jsonEncode(Get.find<SigninController>().signInUserModel.data!.user));
      Get.find<PusherBeamsController>().initPusherBeams();
      if (Get.find<SigninController>().signInUserModel.data!.user!.isCustomer ==
          true) {
        Get.find<GeneralController>().updateFormLoaderController(false);
        print("Login As Customer");
        Get.toNamed(PageRoutes.homeScreen);
      } else {
        Get.find<GeneralController>().updateFormLoaderController(false);
      }
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Vui lòng thử lại",
              titleColor: AppColors.customDialogErrorColor,
              descriptions: '${response["message"]} TT',
              text: "Ok",
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/icons/dialog_error.png',
            );
          });
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Vui lòng thử lại",
            titleColor: AppColors.customDialogErrorColor,
            descriptions: '${response["message"]} TT',
            text: "Ok",
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/icons/dialog_error.png',
          );
        });
  }
}
