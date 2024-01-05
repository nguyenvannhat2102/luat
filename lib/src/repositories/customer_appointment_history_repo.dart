import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer_consultant/src/models/customer_appointment_history_model.dart';
import '../controllers/customer_appointment_history_controller.dart';
import '../controllers/general_controller.dart';

getAllCustomerAppointmentHistoryRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<CustomerAppointmentHistoryController>()
            .getCustomerAppointmentHistoryModel =
        GetCustomerAppointmentHistoryModel.fromJson(response);

    Get.find<CustomerAppointmentHistoryController>()
        .updateCustomerAppointmentHistoryLoader(true);
    log("${Get.find<CustomerAppointmentHistoryController>().getCustomerAppointmentHistoryModel.data!.data!.length.toString()} Tổng lịch sử cuộc hẹn của khách hàng");
    log("${Get.find<CustomerAppointmentHistoryController>().getCustomerAppointmentHistoryModel.data!.data!.where((i) => i.appointmentStatusName == "Completed").toList().length.toString()} Tổng lịch sử cuộc hẹn đã hoàn thành của khách hàng");

    for (var element in Get.find<CustomerAppointmentHistoryController>()
        .getCustomerAppointmentHistoryModel
        .data!
        .data!) {
      Get.find<CustomerAppointmentHistoryController>()
          .updateLawyerListForPagination(element);
    }

    Get.find<GeneralController>().changeGetPaginationProgressCheck(false);

    // if (Get.find<AllLawyersCategoriesController>().getAllLawyerCategoriesDataModel.status == true) {
    // } else {}
  } else if (!responseCheck) {
    Get.find<CustomerAppointmentHistoryController>()
        .updateCustomerAppointmentHistoryLoader(true);
  }
}
