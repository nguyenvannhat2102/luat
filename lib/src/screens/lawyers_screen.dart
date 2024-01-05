import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lawyer_consultant/src/config/localization.dart';
import 'package:resize/resize.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../controllers/all_lawyers_controller.dart';
import '../controllers/general_controller.dart';
import '../controllers/search_controller.dart';
import '../routes.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_skeleton_loader.dart';
import '../widgets/search_filter_widget.dart';

class LawyersScreen extends StatefulWidget {
  const LawyersScreen({super.key});

  @override
  State<LawyersScreen> createState() => _LawyersScreenState();
}

class _LawyersScreenState extends State<LawyersScreen> {
  final Localization localization = Localization();
  final logic = Get.put(AllLawyersController());

  @override
  void initState() {
    super.initState();
    // postMethod(
    //     context, '$getAllLawyers?page=1', null, false, getAllLawyersRepo);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return GetBuilder<AllLawyersController>(builder: (allLawyersController) {
        return !allLawyersController.allLawyersLoader
            ? CustomVerticalSkeletonLoader(
                height: 200.h,
                highlightColor: AppColors.grey,
                seconds: 2,
                totalCount: 5,
                width: 140.w,
              )
            : Scaffold(
                backgroundColor: AppColors.white,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 18),
                      SearchFilterWidget(
                        onSearchTap: () {},
                        controller:
                            Get.find<SearchController>().searchTextController,
                      ),
                      ...List.generate(
                          allLawyersController.lawyerListForPagination.length,
                          (index) {
                        return Container(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          margin: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                          decoration: BoxDecoration(
                            color: AppColors.offWhite,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: allLawyersController
                                            .lawyerListForPagination[index]
                                            .image
                                            ?.length !=
                                        null
                                    ? Image(
                                        image: NetworkImage(
                                            "$mediaUrl${allLawyersController.lawyerListForPagination[index].image}"),
                                        height: 110.h,
                                      )
                                    : Image(
                                        image: const AssetImage(
                                            'assets/images/lawyer-image.png'),
                                        height: 110.h,
                                      ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 0, 6, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${allLawyersController.lawyerListForPagination[index].name}",
                                        textAlign: TextAlign.start,
                                        style: AppTextStyles.bodyTextStyle2,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                        child: ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: List.generate(
                                            allLawyersController
                                                .lawyerListForPagination[index]
                                                .lawyerCategories!
                                                .length,
                                            (index1) {
                                              return Text(
                                                "${allLawyersController.lawyerListForPagination[index].lawyerCategories![index1].name} | ",
                                                textAlign: TextAlign.start,
                                                style: AppTextStyles
                                                    .bodyTextStyle3,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        localization.stanslate(
                                            'LLB | Master of Dispute Resolution | Master of Legal Studies | Master of Laws'),
                                        textAlign: TextAlign.start,
                                        style: AppTextStyles.bodyTextStyle4,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 14, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                RatingBar.builder(
                                                  initialRating:
                                                      allLawyersController
                                                          .lawyerListForPagination[
                                                              index]
                                                          .rating!
                                                          .toDouble(),
                                                  minRating: 1,
                                                  itemSize: 15.h,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  ignoreGestures: true,
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 0.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate:
                                                      (double value) {},
                                                ),
                                                SizedBox(width: 5.w),
                                                Text(
                                                  // '4.5',
                                                  allLawyersController
                                                      .lawyerListForPagination[
                                                          index]
                                                      .rating
                                                      .toString(),
                                                  textAlign: TextAlign.start,
                                                  style: AppTextStyles
                                                      .bodyTextStyle4,
                                                ),
                                              ],
                                            ),
                                            ButtonWidgetOne(
                                              buttonText: 'Hồ sơ',
                                              onTap: () {
                                                generalController
                                                    .updateSelectedLawyerForView(
                                                        allLawyersController
                                                                .lawyerListForPagination[
                                                            index]);

                                                Get.toNamed(PageRoutes
                                                    .lawyerProfileScreen);
                                              },
                                              buttonTextStyle: AppTextStyles
                                                  .buttonTextStyle2,
                                              borderRadius: 5,
                                              buttonColor:
                                                  AppColors.secondaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),

                      // allLawyersController
                      //         .lawyerListForPagination.isNotEmpty
                      allLawyersController.lawyerListForPagination.length ==
                              allLawyersController
                                  .getAllLawyersModel.data!.data!.length
                          ? Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                              width: MediaQuery.of(context).size.width * .35,
                              child:
                                  generalController.getPaginationProgressCheck
                                      ? Container(
                                          height: generalController
                                                  .getPaginationProgressCheck
                                              ? 50.0
                                              : 0,
                                          color: Colors.transparent,
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        )
                                      : ButtonWidgetOne(
                                          buttonText: 'Tải thêm',
                                          onTap: () {
                                            allLawyersController
                                                .paginationDataLoad(context);
                                          },
                                          buttonTextStyle:
                                              AppTextStyles.buttonTextStyle7,
                                          borderRadius: 5,
                                          buttonColor: AppColors.primaryColor,
                                        ))
                          : const SizedBox(),
                    ],
                  ),
                ),
              );
      });
    });
  }
}
