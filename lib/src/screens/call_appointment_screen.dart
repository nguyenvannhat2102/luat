import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:lawyer_consultant/src/widgets/button_widget.dart';
import 'package:resize/resize.dart';

import '../api_services/get_service.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../controllers/general_controller.dart';
import '../controllers/lawyer_book_appointment_controller.dart';
import '../controllers/stripe_payment_controller.dart';
import '../repositories/lawyer_book_appointment_repo.dart';

import '../widgets/appbar_widget.dart';

class CallAppointmentScreen extends StatefulWidget {
  // final num? appointmentTypeId;
  const CallAppointmentScreen({
    super.key,
    // this.appointmentTypeId,
  });

  @override
  State<CallAppointmentScreen> createState() => _CallAppointmentScreenState();
}

class _CallAppointmentScreenState extends State<CallAppointmentScreen> {
  final lawyerAppointmentSchdulelogic =
      Get.put(LawyerAppointmentScheduleController());
  final stripePaymentLogic = Get.put(StripePaymentController());

  var appointmentTypeId = Get.parameters["appointmentTypeId"];
  String? screenTitle = Get.parameters["screenTitle"];
  String formattedDate = DateFormat.yMd().format(DateTime.now());
  String values = 'no';
  int indexPage = 0;
  int activeStep = 3;
  int upperBound = 4;
  bool boolValue = false;
  int? value;
  var selectedSlot;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor, // <-- SEE HERE
              onPrimary: AppColors.black, // <-- SEE HERE
              onSurface: AppColors.black, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: AppTextStyles.bodyTextStyle2,
                primary: AppColors.black, // button text color
              ),
            ),
            textTheme: const TextTheme(
              headline5:
                  AppTextStyles.bodyTextStyle2, // Selected Date landscape
              headline6: AppTextStyles.bodyTextStyle2, // Selected Date portrait
              overline: AppTextStyles.headingTextStyle4, // Title - SELECT DATE
              bodyText1: AppTextStyles.bodyTextStyle2, // year gridbview picker
              subtitle1: AppTextStyles.bodyTextStyle2, // input
              subtitle2: AppTextStyles.bodyTextStyle2, // month/year picker
              caption: AppTextStyles.bodyTextStyle2, // days
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // selectedDate = formattedDate;
        getMethod(
            context,
            '$getLawyerBookAppointment${Get.find<GeneralController>().selectedLawyerForView.userName}/book_appointment',
            {"appointment_type_id": appointmentTypeId, "date": selectedDate},
            false,
            getLawyerBookAppointmentRepo);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // log("${Get.parameters['appointmentId']} PARAMETERS");
    log("$appointmentTypeId PARAMETERS2");
    print(
        "${Get.find<GeneralController>().selectedLawyerForView.userName} LawyerUsername1");
    getMethod(
        context,
        '$getLawyerBookAppointment${Get.find<GeneralController>().selectedLawyerForView.userName}/book_appointment',
        {"appointment_type_id": appointmentTypeId, "date": selectedDate},
        false,
        getLawyerBookAppointmentRepo);
    print("$selectedDate DateNow");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LawyerAppointmentScheduleController>(
        builder: (lawyerBookAppointmentController) {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: AppBarWidget(
            richTextSpan: TextSpan(
              text: screenTitle,
              style: AppTextStyles.appbarTextStyle2,
              children: const <TextSpan>[],
            ),
            leadingIcon: "assets/icons/Expand_left.png",
            leadingOnTap: () {
              if (indexPage > 0) {
                setState(() {
                  indexPage--;
                });
              } else {
                Get.back();
                indexPage = 0;
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: lawyerBookAppointmentController.getLawyerBookAppointmentLoader
              ? lawyerBookAppointmentController
                          .getLawyerAppointmentScheduleModel.data!.schedule !=
                      null
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Divider(
                                  thickness: 4,
                                  height: 4,
                                  color: indexPage >= 0
                                      ? AppColors.primaryColor
                                      : AppColors.lightGrey,
                                ),
                              ),
                            ),
                            Container(
                              height: 21,
                              width: 21,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: indexPage >= 0
                                    ? AppColors.primaryColor
                                    : AppColors.lightGrey,
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Divider(
                                  thickness: 4,
                                  height: 4,
                                  color: indexPage >= 1
                                      ? AppColors.primaryColor
                                      : AppColors.lightGrey,
                                ),
                              ),
                            ),
                            Container(
                              height: 21,
                              width: 21,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: indexPage >= 1
                                    ? AppColors.primaryColor
                                    : AppColors.lightGrey,
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Divider(
                                  thickness: 4,
                                  height: 4,
                                  color: indexPage >= 2
                                      ? AppColors.primaryColor
                                      : AppColors.lightGrey,
                                ),
                              ),
                            ),
                            Container(
                              height: 21,
                              width: 21,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: indexPage >= 2
                                    ? AppColors.primaryColor
                                    : AppColors.lightGrey,
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Divider(
                                  thickness: 4,
                                  height: 4,
                                  color: indexPage >= 3
                                      ? AppColors.primaryColor
                                      : AppColors.lightGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        indexPage == 0
                            ? personalInformation()
                            : indexPage == 1
                                ? !lawyerBookAppointmentController
                                        .getLawyerBookAppointmentLoader
                                    ? Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 250.h, 0, 250.h),
                                        child: const CircularProgressIndicator(
                                          backgroundColor:
                                              AppColors.transparent,
                                          color: AppColors.primaryColor,
                                        ),
                                      )
                                    : timeSchedule()
                                : indexPage == 2
                                    ? paymentMethod()
                                    : paymentMethod(),
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(0, 100.h, 0, 100.h),
                      child: const Center(
                        child: Text(
                          "Không tìm thấy dữ liệu nào",
                          style: AppTextStyles.bodyTextStyle10,
                        ),
                      ),
                    )
              : Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 100.h, 0, 100.h),
                    child: const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
        ),
      );
    });
  }

  // Review and Rating
  Widget reviewAndRating() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Đánh giá luật sư này",
            style: AppTextStyles.headingTextStyle4,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 18),
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            decoration: BoxDecoration(
                color: AppColors.offWhite,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Giao tiếp",
                  style: AppTextStyles.subHeadingTextStyle1,
                ),
                Image.asset("assets/icons/star.png")
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            decoration: BoxDecoration(
                color: AppColors.offWhite,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "kỹ năng chuyên nghiệp",
                  style: AppTextStyles.subHeadingTextStyle1,
                ),
                Image.asset("assets/icons/star.png")
              ],
            ),
          ),
          TextField(
            style: AppTextStyles.hintTextStyle1,
            maxLines: 5,
            // controller: controller,
            decoration: InputDecoration(
              hintText: "Viết phản hồi của bạn ở đây",
              hintStyle: AppTextStyles.hintTextStyle1,
              labelStyle: AppTextStyles.hintTextStyle1,
              contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              isDense: true,
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ButtonWidgetOne(
              onTap: () {
                setState(() {
                  indexPage++;
                });
              },
              buttonText: "Tiếp Tục",
              buttonTextStyle: AppTextStyles.bodyTextStyle8,
              borderRadius: 10,
              buttonColor: AppColors.primaryColor),
        ],
      ),
    );
  }

  // Payment Complete Thank You
  Widget paymentThankYou() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.offWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 36, 0, 24),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primaryColor),
                  child: const Icon(
                    Icons.check,
                    size: 36,
                    color: AppColors.offWhite,
                  ),
                ),
                const Text(
                  "Cảm ơn",
                  style: AppTextStyles.headingTextStyle3,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Đối với khoản thanh toán của bạn 50",
                  style: AppTextStyles.bodyTextStyle2,
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
          const SizedBox(height: 36),
          Text(
            "Cuộc gọi video của bạn bắt đầu",
            style: AppTextStyles.bodyTextStyle2,
          ),
          const SizedBox(height: 8),
          Text(
            "00:55",
            style: AppTextStyles.bodyTextStyle9,
          ),
          const SizedBox(height: 36),
          ButtonWidgetOne(
              onTap: () {
                setState(() {
                  indexPage++;
                });
              },
              buttonText: "Thử Lại",
              buttonTextStyle: AppTextStyles.bodyTextStyle8,
              borderRadius: 10,
              buttonColor: AppColors.primaryColor),
        ],
      ),
    );
  }

// Payment Method
  Widget paymentMethod() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Chọn Phương thức thanh toán của bạn",
            style: AppTextStyles.headingTextStyle4,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              gradient: AppColors.gradientThree,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Tổng bạn phải thanh toán: ",
                  style: AppTextStyles.subHeadingTextStyle1,
                ),
                Text(
                  "\$ ${Get.find<LawyerAppointmentScheduleController>().getLawyerAppointmentScheduleModel.data!.schedule!.fee!}",
                  style: AppTextStyles.subHeadingTextStyle2,
                )
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.white, //background color of dropdown button
              border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1), //border of dropdown button
              borderRadius:
                  BorderRadius.circular(10), //border raiuds of dropdown button
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
                  value: "Stripe",
                  decoration: const InputDecoration.collapsed(hintText: ''),
                  items: [
                    //add items in the dropdown
                    DropdownMenuItem(
                      value: "Stripe",
                      child: Row(
                        children: [
                          Image.asset(
                              "assets/icons/mastercard-full-svgrepo-com 1.png"),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text("Stripe"),
                        ],
                      ),
                    ),
                    // DropdownMenuItem(
                    //   value: "Visa Card",
                    //   child: Row(
                    //     children: [
                    //       Image.asset(
                    //           "assets/icons/mastercard-full-svgrepo-com 1.png"),
                    //       const SizedBox(
                    //         width: 8,
                    //       ),
                    //       const Text("Visa Card"),
                    //     ],
                    //   ),
                    // ),
                    // DropdownMenuItem(
                    //   value: "American Express",
                    //   child: Row(
                    //     children: [
                    //       Image.asset(
                    //           "assets/icons/mastercard-full-svgrepo-com 1.png"),
                    //       const SizedBox(
                    //         width: 8,
                    //       ),
                    //       const Text("American Express"),
                    //     ],
                    //   ),
                    // )
                  ],
                  onTap: () async {
                    // await makePayment();
                    Get.find<StripePaymentController>().makePayment(
                        Get.find<GeneralController>().selectedLawyerForView.id,
                        Get.find<LawyerAppointmentScheduleController>()
                                    .getLawyerAppointmentScheduleModel
                                    .data!
                                    .schedule!
                                    .appointmentType!
                                    .displayName ==
                                "Cuộc gọi video"
                            ? Get.find<LawyerAppointmentScheduleController>()
                                .videCallQuestionFieldController
                                .text
                            : Get.find<LawyerAppointmentScheduleController>()
                                        .getLawyerAppointmentScheduleModel
                                        .data!
                                        .schedule!
                                        .appointmentType!
                                        .displayName ==
                                    "Cuộc gọi âm thanh"
                                ? Get.find<
                                        LawyerAppointmentScheduleController>()
                                    .audioCallQuestionFieldController
                                    .text
                                : Get.find<
                                        LawyerAppointmentScheduleController>()
                                    .videCallQuestionFieldController
                                    .text,
                        Get.find<LawyerAppointmentScheduleController>()
                            .getLawyerAppointmentScheduleModel
                            .data!
                            .schedule!
                            .appointmentTypeId!
                            .toInt(),
                        selectedDate.toString(),
                        Get.find<LawyerAppointmentScheduleController>()
                            .getLawyerAppointmentScheduleModel
                            .data!
                            .schedule!
                            .id!
                            .toInt(),
                        Get.find<LawyerAppointmentScheduleController>()
                            .getLawyerAppointmentScheduleModel
                            .data!
                            .schedule!
                            .type,
                        "12345");
                  },
                  onChanged: (value) async {
                    //get value when changed
                    print("Bạn đã chọn $value");
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.secondaryColor,
                  ),
                  iconEnabledColor: Colors.white, //Icon color
                  style: AppTextStyles.subHeadingTextStyle1,
                  dropdownColor: AppColors.white, //dropdown background color
                  isExpanded: true, //make true to make width 100%
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // TextFormFieldWidget(
          //   hintText: 'Card Number',
          //   validator: (String? value) {}, controller: textFieldController,
          //   // initialText: '',
          // ),
          // const SizedBox(height: 20),
          // TextFormFieldWidget(
          //   hintText: 'Card Holder Name',
          //   validator: (String? value) {}, controller: textFieldController,
          //   // initialText: '',
          // ),
          // const SizedBox(height: 20),
          // Row(
          //   children: [
          //     Expanded(
          //       child: TextFormFieldWidget(
          //         hintText: 'Expires on',
          //         validator: (String? value) {},
          //         controller: textFieldController,
          //         // initialText: '',
          //       ),
          //     ),
          //     SizedBox(width: 20.w),
          //     Expanded(
          //       child: TextFormFieldWidget(
          //         hintText: 'CVV Code',
          //         validator: (String? value) {},
          //         controller: textFieldController,
          //         // initialText: '',
          //       ),
          //     ),
          //   ],
          // ),
          // Row(
          //   children: [
          //     Checkbox(
          //       value: boolValue,
          //       tristate: false,
          //       activeColor: AppColors.primaryColor,
          //       visualDensity: VisualDensity(horizontal: -2, vertical: 2),
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(5)),
          //       side: const BorderSide(color: AppColors.primaryColor),
          //       onChanged: (bool? boolValue) {
          //         setState(() {
          //           this.boolValue = boolValue!;
          //         });
          //       },
          //     ),
          //     const Text(
          //       "Save Card Information for future",
          //       style: AppTextStyles.hintTextStyle1,
          //     )
          //   ],
          // ),
          // ButtonWidgetOne(
          //     onTap: () {
          //       // await makePayment();
          // setState(() {
          //   indexPage++;
          // });
          //     },
          //     buttonText: "Make Payment",
          //     buttonTextStyle: AppTextStyles.bodyTextStyle8,
          //     borderRadius: 10,
          //     buttonColor: AppColors.primaryColor),
        ],
      ),
    );
  }

// Time Schedule
  Widget timeSchedule() {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 18.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Chọn ngày để đặt cuộc hẹn",
                style: AppTextStyles.headingTextStyle4,
              ),
              SizedBox(width: 18.w),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 4.h),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      const Text(
                        "Ngày",
                        style: AppTextStyles.buttonTextStyle2,
                      ),
                      SizedBox(width: 4.w),
                      Image.asset(
                        "assets/icons/Date_range.png",
                        height: 22.h,
                      )
                    ],
                  ),
                ),
              ),
              // Text(
              //   // "According to  March 21",
              // Get.find<LawyerBookAppointmentController>()
              //     .getLawyerBookAppointmentModel
              //     .data!
              //     .schedule!
              //     .day!,
              //   style: AppTextStyles.bodyTextStyle7,
              // ),
              // SizedBox(width: 18.w),
              // GestureDetector(
              //   onTap: () => _selectDate(context),
              //   child: Text("${selectedDate.toLocal()}".split(' ')[0]),
              // ),
            ],
          ),
          Get.find<LawyerAppointmentScheduleController>()
                      .getLawyerAppointmentScheduleModel
                      .data!
                      .schedule ==
                  null
              ? Padding(
                  padding: EdgeInsets.fromLTRB(0, 250.h, 0, 250.h),
                  child: const Text(
                    "Không tìm thấy lịch trình",
                    style: AppTextStyles.bodyTextStyle10,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 18.h),
                    Divider(
                        thickness: 1.h,
                        height: 1.h,
                        color: AppColors.lightGrey),
                    SizedBox(height: 18.h),
                    Row(
                      children: [
                        Text(
                          "${Get.find<LawyerAppointmentScheduleController>().getLawyerAppointmentScheduleModel.data!.schedule!.day!.capitalizeFirst!} / ",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.subHeadingTextStyle1,
                        ),
                        Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                          textAlign: TextAlign.start,
                          style: AppTextStyles.subHeadingTextStyle1,
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    Wrap(
                      children: [
                        GridView.builder(
                          itemCount:
                              Get.find<LawyerAppointmentScheduleController>()
                                  .getLawyerAppointmentScheduleModel
                                  .data!
                                  .schedule!
                                  .scheduleSlots!
                                  .length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 2 / 0.75,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  gradient: value == index
                                      ? AppColors.gradientOne
                                      : AppColors.gradientTwo,
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    splashColor: AppColors.transparent,
                                    highlightColor: AppColors.transparent,
                                    canvasColor: AppColors.transparent),
                                child: ChoiceChip(
                                  labelPadding:
                                      EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
                                  visualDensity: const VisualDensity(
                                      horizontal: -1, vertical: -4),
                                  // label: const Text('08:00 - 08:30'),
                                  label: Text(
                                      '${Get.find<LawyerAppointmentScheduleController>().getLawyerAppointmentScheduleModel.data!.schedule!.scheduleSlots![index].startTime} - ${Get.find<LawyerAppointmentScheduleController>().getLawyerAppointmentScheduleModel.data!.schedule!.scheduleSlots![index].endTime}'),
                                  labelStyle: value == index
                                      ? AppTextStyles.chipsTextStyle2
                                      : AppTextStyles.chipsTextStyle1,
                                  backgroundColor: AppColors.transparent,
                                  selectedColor: AppColors.transparent,
                                  disabledColor: AppColors.offWhite,
                                  surfaceTintColor: AppColors.offWhite,
                                  selected: value == index,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      value = selected ? index : null;
                                      selectedSlot =
                                          "${Get.find<LawyerAppointmentScheduleController>().getLawyerAppointmentScheduleModel.data!.schedule!.scheduleSlots!.elementAt(value!).startTime} - ${Get.find<LawyerAppointmentScheduleController>().getLawyerAppointmentScheduleModel.data!.schedule!.scheduleSlots!.elementAt(value!).endTime}";
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(0, 18.h, 0, 18.h),
                            decoration: BoxDecoration(
                                color: AppColors.offWhite.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: AppColors.primaryColor)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Luật Sư",
                                  style: AppTextStyles.headingTextStyle2,
                                ),
                                Text(
                                  Get.find<GeneralController>()
                                      .selectedLawyerForView
                                      .name!,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.subHeadingTextStyle1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(0, 18.h, 0, 18.h),
                            decoration: BoxDecoration(
                                color: AppColors.offWhite.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: AppColors.primaryColor)),
                            child: Column(
                              children: [
                                Text(
                                  "\$ ${Get.find<LawyerAppointmentScheduleController>().getLawyerAppointmentScheduleModel.data!.schedule!.fee!}",
                                  style: AppTextStyles.headingTextStyle2,
                                ),
                                Text(
                                  "${Get.find<LawyerAppointmentScheduleController>().getLawyerAppointmentScheduleModel.data!.schedule!.appointmentType!.displayName} Fee",
                                  style: AppTextStyles.subHeadingTextStyle1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(0, 18.h, 0, 18.h),
                            decoration: BoxDecoration(
                                color: AppColors.offWhite.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: AppColors.primaryColor)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Ngày",
                                    style: AppTextStyles.headingTextStyle2,
                                  ),
                                  Text(
                                    "${selectedDate.toLocal()}".split(' ')[0],
                                    style: AppTextStyles.subHeadingTextStyle1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 18.w),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(0, 18.h, 0, 18.h),
                            decoration: BoxDecoration(
                                color: AppColors.offWhite.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: AppColors.primaryColor)),
                            child: Column(
                              children: [
                                const Text(
                                  "Thời gian",
                                  style: AppTextStyles.headingTextStyle2,
                                ),
                                Text(
                                  value != null ? "$selectedSlot" : "-",
                                  style: AppTextStyles.subHeadingTextStyle1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     const Text(
                    //       "Afternoon",
                    //       style: AppTextStyles.headingTextStyle4,
                    //     ),
                    //     const SizedBox(width: 18),
                    //     Image.asset("assets/icons/🦆 icon _Sun_.png")
                    //   ],
                    // ),
                    // const SizedBox(height: 18),
                    // Wrap(
                    //   children: [
                    //     GridView.builder(
                    //       itemCount: 6,
                    //       shrinkWrap: true,
                    //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //           childAspectRatio: 2 / 0.8,
                    //           crossAxisCount: 3,
                    //           crossAxisSpacing: 6,
                    //           mainAxisSpacing: 6),
                    //       itemBuilder: (BuildContext context, int index) {
                    //         return Container(
                    //           decoration: BoxDecoration(
                    //               gradient: value == index
                    //                   ? AppColors.gradientOne
                    //                   : AppColors.gradientTwo,
                    //               border: Border.all(
                    //                 color: AppColors.primaryColor,
                    //               ),
                    //               borderRadius: BorderRadius.circular(8)),
                    //           child: Theme(
                    //             data: Theme.of(context).copyWith(
                    //                 splashColor: AppColors.transparent,
                    //                 highlightColor: AppColors.transparent,
                    //                 canvasColor: AppColors.transparent),
                    //             child: ChoiceChip(
                    //               visualDensity:
                    //                   const VisualDensity(horizontal: -1, vertical: -4),
                    //               label: const Text('08:00 - 08:30'),
                    //               labelStyle: value == index
                    //                   ? AppTextStyles.chipsTextStyle2
                    //                   : AppTextStyles.chipsTextStyle1,
                    //               backgroundColor: AppColors.transparent,
                    //               selectedColor: AppColors.transparent,
                    //               disabledColor: AppColors.offWhite,
                    //               surfaceTintColor: AppColors.offWhite,
                    //               selected: value == index,
                    //               onSelected: (bool selected) {
                    //                 setState(() {
                    //                   value = selected ? index : null;
                    //                 });
                    //               },
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 18),
                    // Row(
                    //   children: [
                    //     const Text(
                    //       "Evening",
                    //       style: AppTextStyles.headingTextStyle4,
                    //     ),
                    //     const SizedBox(width: 18),
                    //     Image.asset("assets/icons/🦆 icon _Sun_.png")
                    //   ],
                    // ),
                    // const SizedBox(height: 18),
                    // Wrap(
                    //   children: [
                    //     GridView.builder(
                    //       itemCount: 6,
                    //       shrinkWrap: true,
                    //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //           childAspectRatio: 2 / 0.8,
                    //           crossAxisCount: 3,
                    //           crossAxisSpacing: 6,
                    //           mainAxisSpacing: 6),
                    //       itemBuilder: (BuildContext context, int index) {
                    //         return Container(
                    //           decoration: BoxDecoration(
                    //               gradient: value == index
                    //                   ? AppColors.gradientOne
                    //                   : AppColors.gradientTwo,
                    //               border: Border.all(
                    //                 color: AppColors.primaryColor,
                    //               ),
                    //               borderRadius: BorderRadius.circular(8)),
                    //           child: Theme(
                    //             data: Theme.of(context).copyWith(
                    //                 splashColor: AppColors.transparent,
                    //                 highlightColor: AppColors.transparent,
                    //                 canvasColor: AppColors.transparent),
                    //             child: ChoiceChip(
                    //               visualDensity:
                    //                   const VisualDensity(horizontal: -1, vertical: -4),
                    //               label: const Text('08:00 - 08:30'),
                    //               labelStyle: value == index
                    //                   ? AppTextStyles.chipsTextStyle2
                    //                   : AppTextStyles.chipsTextStyle1,
                    //               backgroundColor: AppColors.transparent,
                    //               selectedColor: AppColors.transparent,
                    //               disabledColor: AppColors.offWhite,
                    //               surfaceTintColor: AppColors.offWhite,
                    //               selected: value == index,
                    //               onSelected: (bool selected) {
                    //                 setState(() {
                    //                   value = selected ? index : null;
                    //                 });
                    //               },
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 18),
                    ButtonWidgetOne(
                        onTap: () {
                          setState(() {
                            indexPage++;
                          });
                        },
                        buttonText: "Tiếp tục",
                        buttonTextStyle: AppTextStyles.bodyTextStyle8,
                        borderRadius: 10,
                        buttonColor: AppColors.primaryColor),
                  ],
                ),
        ],
      ),
    );
  }

// Personal Information
  Widget personalInformation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Nhập thông tin của bạn",
            style: AppTextStyles.headingTextStyle4,
          ),
          const SizedBox(height: 18),
          TextField(
            style: AppTextStyles.hintTextStyle1,
            maxLines: 5,
            controller: Get.find<LawyerAppointmentScheduleController>()
                        .getLawyerAppointmentScheduleModel
                        .data!
                        .schedule!
                        .appointmentTypeId! ==
                    1
                ? Get.find<LawyerAppointmentScheduleController>()
                    .videCallQuestionFieldController
                : Get.find<LawyerAppointmentScheduleController>()
                            .getLawyerAppointmentScheduleModel
                            .data!
                            .schedule!
                            .appointmentTypeId! ==
                        2
                    ? Get.find<LawyerAppointmentScheduleController>()
                        .audioCallQuestionFieldController
                    : Get.find<LawyerAppointmentScheduleController>()
                        .videCallQuestionFieldController,
            decoration: InputDecoration(
              hintText: "Viết câu hỏi của bạn ở đây",
              hintStyle: AppTextStyles.hintTextStyle1,
              labelStyle: AppTextStyles.hintTextStyle1,
              contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              isDense: true,
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Bạn có hình ảnh không?",
            style: AppTextStyles.subHeadingTextStyle1,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: const Text(
                    "No",
                    style: AppTextStyles.bodyTextStyle7,
                  ),
                  activeColor: AppColors.primaryColor,
                  selected: true,
                  value: "no",
                  groupValue: values,
                  onChanged: (value) {
                    setState(() {
                      values = value.toString();
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: const Text(
                    "Yes",
                    style: AppTextStyles.bodyTextStyle7,
                  ),
                  activeColor: AppColors.primaryColor,
                  value: "yes",
                  groupValue: values,
                  onChanged: (value) {
                    setState(() {
                      values = value.toString();
                    });
                  },
                ),
              ),
            ],
          ),
          values == 'no'
              ? Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 24),
                )
              : Container(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 24),
                  decoration: BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primaryColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Tải lên ảnh của bạn",
                        style: AppTextStyles.buttonTextStyle7,
                      ),
                      const SizedBox(width: 10),
                      Image.asset("assets/icons/Upload.png")
                    ],
                  ),
                ),
          ButtonWidgetOne(
              onTap: () {
                setState(() {
                  indexPage++;
                });
              },
              buttonText: "Tiếp tục",
              buttonTextStyle: AppTextStyles.bodyTextStyle8,
              borderRadius: 10,
              buttonColor: AppColors.primaryColor),
        ],
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: const Text('Kế Tiếp'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: const Text('Trước đó'),
    );
  }
}
