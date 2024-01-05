import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:lawyer_consultant/src/config/app_colors.dart';
import 'package:lawyer_consultant/src/config/localization.dart';
import 'package:lawyer_consultant/src/controllers/search_controller.dart';
import 'package:lawyer_consultant/src/widgets/home_banner_slider_widget.dart';

import '../config/app_text_styles.dart';
import '../controllers/general_controller.dart';
import '../controllers/lawyer_appointment_types_controller.dart';
import '../routes.dart';
import '../widgets/home_all_lawyers_list_widget.dart';
import '../widgets/home_categories_list_widget.dart';
import '../widgets/home_featured_lawyers_list_widget.dart';
import '../widgets/home_law_firms_list_widget.dart';
import '../widgets/home_top_rated_lawyers_list_widget.dart';
import '../widgets/home_upcoming_events_list_widget.dart';
import '../widgets/search_filter_widget.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback allCategoryOnTap;
  const HomeScreen({super.key, required this.allCategoryOnTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Localization localization = Localization();
  int isLawyerListSelected = 0;

  final lawyerAppointmentTypeslogic =
      Get.put(LawyerAppointmentTypesController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 30),
                child: HomeBannerSliderWidget(),
              ),
              generalController.storageBox.read('authToken') != null
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
                      child: RichText(
                        textAlign: TextAlign.start,
                        softWrap: true,
                        text: TextSpan(
                          text:
                              "Hello ${generalController.currentUserModel!.loginInfo!.name} ",
                          style: AppTextStyles.headingTextStyle1,
                          children: const <TextSpan>[
                            TextSpan(
                              text: '| Tìm nhà tư vấn của bạn',
                              style: AppTextStyles.headingTextStyle2,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(PageRoutes.signinScreen);
                        },
                        child: RichText(
                          textAlign: TextAlign.start,
                          softWrap: true,
                          text: const TextSpan(
                            text: 'Đăng Nhập ',
                            style: AppTextStyles.headingTextStyle1,
                            children: <TextSpan>[
                              TextSpan(
                                text: '| Tìm nhà tư vấn của bạn',
                                style: AppTextStyles.headingTextStyle2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              SearchFilterWidget(
                onSearchTap: () {},
                controller: Get.find<SearchController>().searchTextController,
              ),
              // Container(
              //   margin: const EdgeInsets.fromLTRB(18, 0, 18, 30),
              //   padding: const EdgeInsets.fromLTRB(10, 9, 10, 9),
              //   decoration: BoxDecoration(
              //     color: AppColors.primaryColor.withOpacity(0.4),
              //     borderRadius: BorderRadius.circular(5.0),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       Image.asset(
              //         "assets/icons/Pin_fill.png",
              //         height: 32.h,
              //       ),
              //       const Text(
              //         "Choose your Address",
              //         style: AppTextStyles.hintTextStyle1,
              //       ),
              //       Image.asset(
              //         "assets/icons/Gps_fixed.png",
              //         height: 32.h,
              //       )
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      localization.stanslate('Categories'),
                      style: AppTextStyles.headingTextStyle2,
                    ),
                    GestureDetector(
                      onTap: widget.allCategoryOnTap,
                      child: Text(
                        localization.stanslate('ALL'),
                        style: AppTextStyles.headingTextStyle3,
                      ),
                    ),
                  ],
                ),
              ),
              HomeCategoriesListWidget(
                categoryOnTap: widget.allCategoryOnTap,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      localization.stanslate('Qualified Lawyers'),
                      style: AppTextStyles.headingTextStyle2,
                    ),
                    Row(
                      children: [
                        isLawyerListSelected == 0
                            ? Container(
                                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  localization.stanslate('ALL'),
                                  style: AppTextStyles.buttonTextStyle6,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isLawyerListSelected = 0;
                                  });
                                },
                                child: Text(
                                  localization.stanslate('ALL'),
                                  style: AppTextStyles.buttonTextStyle4,
                                ),
                              ),
                        const SizedBox(width: 10),
                        isLawyerListSelected == 1
                            ? Container(
                                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  localization.stanslate('Top Rated'),
                                  style: AppTextStyles.buttonTextStyle6,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isLawyerListSelected = 1;
                                  });
                                },
                                child: Text(
                                  localization.stanslate('Top Rated'),
                                  style: AppTextStyles.buttonTextStyle4,
                                ),
                              ),
                        const SizedBox(width: 10),
                        isLawyerListSelected == 2
                            ? Container(
                                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  localization.stanslate('Featured'),
                                  style: AppTextStyles.buttonTextStyle6,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isLawyerListSelected = 2;
                                  });
                                },
                                child: Text(
                                  localization.stanslate('Featured'),
                                  style: AppTextStyles.buttonTextStyle4,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              isLawyerListSelected == 0
                  ? const HomeAllLawyersListWidget()
                  : isLawyerListSelected == 1
                      ? const HomeTopRatedLawyersListWidget()
                      : isLawyerListSelected == 2
                          ? const HomeFeaturedLawyersListWidget()
                          : const SizedBox(
                              child: Center(
                                child: Text(
                                  "Không tìm thấy dữ liệu nào",
                                  style: AppTextStyles.bodyTextStyle2,
                                ),
                              ),
                            ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      localization.stanslate('Law Firms'),
                      style: AppTextStyles.headingTextStyle2,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(PageRoutes.lawFirmsScreen);
                      },
                      child: Text(
                        localization.stanslate('ALL'),
                        style: AppTextStyles.headingTextStyle3,
                      ),
                    ),
                  ],
                ),
              ),
              const HomeLawFirmsListWidget(),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(18, 20, 18, 14),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       const Text(
              //         "Quick buy Services",
              //         style: AppTextStyles.headingTextStyle2,
              //       ),
              //       GestureDetector(
              //         onTap: () {
              //           Get.toNamed(PageRoutes.eventsScreen);
              //         },
              //         child: const Text(
              //           "All",
              //           style: AppTextStyles.headingTextStyle3,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const HomeBuyServicesListWidget(),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      localization.stanslate('Upcoming Events'),
                      style: AppTextStyles.headingTextStyle2,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(PageRoutes.eventsScreen);
                      },
                      child: Text(
                        localization.stanslate('ALL'),
                        style: AppTextStyles.headingTextStyle3,
                      ),
                    ),
                  ],
                ),
              ),
              const HomeUpcomingEventsListWidget(),
            ],
          ),
        ),
      );
    });
  }
}
