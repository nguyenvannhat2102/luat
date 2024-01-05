import 'dart:convert';
import 'dart:developer';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer_consultant/src/config/app_colors.dart';
import 'package:lawyer_consultant/src/config/app_text_styles.dart';
import 'package:lawyer_consultant/src/controllers/sign_out_user_controller.dart';
import 'package:lawyer_consultant/src/controllers/signin_controller.dart';
import 'package:lawyer_consultant/src/repositories/sign_out_user_repo.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

import '../api_services/get_service.dart';
import '../api_services/urls.dart';
import '../controllers/general_controller.dart';
import '../controllers/logged_in_user_controller.dart';
import '../models/logged_in_user_model.dart';
import '../routes.dart';
import '../screens/category_screen.dart';
import '../screens/home_screen.dart';
import '../screens/lawyers_screen.dart';
import 'appbar_widget.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final loggedInUserLogic = Get.put(LoggedInUserController());
  final signInLogic = Get.put(SigninController());
  final signOutUserLogic = Get.put(SignOutUserController());
  int _currentIndex = 1;

  @override
  void initState() {
    if (Get.find<GeneralController>().storageBox.hasData('userData')) {
      Get.find<GeneralController>().currentUserModel = User.fromJson(jsonDecode(
          Get.find<GeneralController>().storageBox.read('userData')));
    }
    log("${Get.find<GeneralController>().storageBox.read('userData')} Bottom User Data");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetScreens = <Widget>[
      LawyersScreen(),
      HomeScreen(allCategoryOnTap: () => setState(() => _currentIndex = 2)),
      CategoryScreen(),
    ];
    return GetBuilder<LoggedInUserController>(builder: (loggedInUserLogic) {
      return ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
        inAsyncCall: Get.find<GeneralController>().formLoaderController,
        child: Scaffold(
          backgroundColor: AppColors.white,
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: AppBarWidget(
              richTextSpan: TextSpan(
                text: _currentIndex == 1
                    ? 'Giải Pháp '
                    : _currentIndex == 0
                        ? 'Luật sư chuyên nghiệp'
                        : _currentIndex == 2
                            ? 'Thể loại'
                            : '',
                style: AppTextStyles.appbarTextStyle2,
                children: <TextSpan>[
                  _currentIndex == 1
                      ? const TextSpan(
                          text: 'Luật',
                          style: AppTextStyles.appbarTextStyle1,
                        )
                      : const TextSpan(),
                ],
              ),
              leadingIcon: "assets/icons/Sort.png",
              leadingOnTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          body: Center(
            child: widgetScreens.elementAt(_currentIndex),
          ),
          drawer: Drawer(
            backgroundColor: AppColors.offWhite,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                      gradient: AppColors.gradientOne), //BoxDecoration
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Get.find<GeneralController>()
                                    .storageBox
                                    .read('authToken') !=
                                null
                            ? Get.find<GeneralController>()
                                        .currentUserModel!
                                        .loginInfo!
                                        .image !=
                                    null
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        '$mediaUrl${Get.find<GeneralController>().currentUserModel!.loginInfo!.image}'),
                                    radius: 35.h,
                                  )
                                : Image.asset(
                                    "assets/icons/user-avatar.png",
                                    height: 60.h,
                                  )
                            : Image.asset(
                                "assets/icons/user-avatar.png",
                                height: 60.h,
                                fit: BoxFit.contain,
                              ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Get.find<GeneralController>()
                                      .storageBox
                                      .read('authToken') !=
                                  null
                              ? Text(
                                  "${Get.find<GeneralController>().currentUserModel!.loginInfo!.name} ",
                                  style: AppTextStyles.bodyTextStyle5,
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Get.toNamed(PageRoutes.signinScreen);
                                  },
                                  child: const Text(
                                    "Đăng nhập ",
                                    style: AppTextStyles.bodyTextStyle5,
                                  ),
                                ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            Get.find<GeneralController>()
                                        .storageBox
                                        .read('authToken') !=
                                    null
                                // ? "${loggedInUserLogic.loggedInUserModel.data!.email}"
                                ? "${Get.find<GeneralController>().currentUserModel!.email} "
                                : "",
                            style: AppTextStyles.subHeadingTextStyle3,
                          ),
                        ],
                      ),
                    ],
                  ),
                ), //DrawerHeader
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Get.find<GeneralController>()
                                  .storageBox
                                  .read('authToken') !=
                              null
                          ? ListTile(
                              isThreeLine: false,
                              dense: true,
                              visualDensity: const VisualDensity(
                                  vertical: -3, horizontal: -3),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 0),
                              leading: const ImageIcon(
                                AssetImage("assets/icons/User.png"),
                                color: AppColors.secondaryColor,
                              ),
                              title: const Text(
                                'Hồ sơ',
                                style: AppTextStyles.subHeadingTextStyle1,
                              ),
                              onTap: () {
                                Get.toNamed(PageRoutes.userProfileScreen);
                              },
                            )
                          : const SizedBox(),
                      // ListTile(
                      //   isThreeLine: false,
                      //   dense: true,
                      //   visualDensity:
                      //       const VisualDensity(vertical: -1, horizontal: -3),
                      //   contentPadding: const EdgeInsets.symmetric(
                      //       horizontal: 12, vertical: 0),
                      //   leading: const ImageIcon(
                      //     AssetImage("assets/icons/Bell_pin.png"),
                      //     color: AppColors.secondaryColor,
                      //   ),
                      //   title: const Text(
                      //     'Notifications',
                      //     style: AppTextStyles.subHeadingTextStyle1,
                      //   ),
                      //   onTap: () {
                      //     Get.toNamed(PageRoutes.notificationsScreen);
                      //   },
                      // ),
                      // ListTile(
                      //   isThreeLine: false,
                      //   dense: true,
                      //   visualDensity:
                      //       const VisualDensity(vertical: -1, horizontal: -3),
                      //   contentPadding: const EdgeInsets.symmetric(
                      //       horizontal: 12, vertical: 0),
                      //   leading: const ImageIcon(
                      //     AssetImage("assets/icons/Wallet_alt.png"),
                      //     color: AppColors.secondaryColor,
                      //   ),
                      //   title: const Text(
                      //     'Wallet',
                      //     style: AppTextStyles.subHeadingTextStyle1,
                      //   ),
                      //   onTap: () {
                      //     Get.toNamed(PageRoutes.walletScreen);
                      //   },
                      // ),
                      ListTile(
                        isThreeLine: false,
                        dense: true,
                        visualDensity:
                            const VisualDensity(vertical: -1, horizontal: -3),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        leading: const ImageIcon(
                          AssetImage("assets/icons/Folders_light.png"),
                          color: AppColors.secondaryColor,
                        ),
                        title: const Text(
                          'Lịch sử cuộc hẹn',
                          style: AppTextStyles.subHeadingTextStyle1,
                        ),
                        onTap: Get.find<GeneralController>()
                                    .storageBox
                                    .read('authToken') !=
                                null
                            ? () {
                                Get.toNamed(
                                    PageRoutes.appointmentHistoryScreen);
                              }
                            : () {},
                      ),
                      ListTile(
                        isThreeLine: false,
                        dense: true,
                        visualDensity:
                            const VisualDensity(vertical: -1, horizontal: -3),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        leading: const ImageIcon(
                          AssetImage("assets/icons/law-firms-icon.png"),
                          color: AppColors.secondaryColor,
                        ),
                        title: const Text(
                          'Công ty luật',
                          style: AppTextStyles.subHeadingTextStyle1,
                        ),
                        onTap: () {
                          Get.toNamed(PageRoutes.lawFirmsScreen);
                        },
                      ),
                      // ListTile(
                      //   isThreeLine: false,
                      //   dense: true,
                      //   visualDensity:
                      //       const VisualDensity(vertical: -1, horizontal: -3),
                      //   contentPadding: const EdgeInsets.symmetric(
                      //       horizontal: 12, vertical: 0),
                      //   leading: const ImageIcon(
                      //     AssetImage("assets/icons/services-icon.png"),
                      //     color: AppColors.secondaryColor,
                      //   ),
                      //   title: const Text(
                      //     'Quick Buy Services',
                      //     style: AppTextStyles.subHeadingTextStyle1,
                      //   ),
                      //   onTap: () {
                      //     Get.toNamed(PageRoutes.quickBuyServices);
                      //   },
                      // ),
                      ListTile(
                        isThreeLine: false,
                        dense: true,
                        visualDensity:
                            const VisualDensity(vertical: -1, horizontal: -3),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        leading: const ImageIcon(
                          AssetImage("assets/icons/blog-icon.png"),
                          color: AppColors.secondaryColor,
                        ),
                        title: const Text(
                          'Bài Viết',
                          style: AppTextStyles.subHeadingTextStyle1,
                        ),
                        onTap: () {
                          Get.toNamed(PageRoutes.blogsScreen);
                        },
                      ),
                      ListTile(
                        isThreeLine: false,
                        dense: true,
                        visualDensity:
                            const VisualDensity(vertical: -1, horizontal: -3),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        leading: const ImageIcon(
                          AssetImage("assets/icons/Group.png"),
                          color: AppColors.secondaryColor,
                        ),
                        title: const Text(
                          'Về chúng tôi',
                          style: AppTextStyles.subHeadingTextStyle1,
                        ),
                        onTap: () {
                          Get.toNamed(PageRoutes.aboutusScreen);
                        },
                      ),
                      ListTile(
                        isThreeLine: false,
                        dense: true,
                        visualDensity:
                            const VisualDensity(vertical: -1, horizontal: -3),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        leading: const ImageIcon(
                          AssetImage("assets/icons/Message.png"),
                          color: AppColors.secondaryColor,
                        ),
                        title: const Text(
                          'Liên hệ chúng tôi',
                          style: AppTextStyles.subHeadingTextStyle1,
                        ),
                        onTap: () {
                          Get.toNamed(PageRoutes.contactusScreen);
                        },
                      ),
                      ListTile(
                        isThreeLine: false,
                        dense: true,
                        visualDensity:
                            const VisualDensity(vertical: -1, horizontal: -3),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        leading: const ImageIcon(
                          AssetImage("assets/icons/Chield_alt.png"),
                          color: AppColors.secondaryColor,
                        ),
                        title: const Text(
                          'Chính sách bảo mật',
                          style: AppTextStyles.subHeadingTextStyle1,
                        ),
                        onTap: () {
                          Get.toNamed(PageRoutes.privacyPolicyScreen);
                        },
                      ),
                      // ListTile(
                      //   isThreeLine: false,
                      //   dense: true,
                      //   visualDensity:
                      //       const VisualDensity(vertical: -1, horizontal: -3),
                      //   contentPadding: const EdgeInsets.symmetric(
                      //       horizontal: 12, vertical: 0),
                      //   leading: const ImageIcon(
                      //     AssetImage("assets/icons/setting-icon.png"),
                      //     color: AppColors.secondaryColor,
                      //   ),
                      //   title: const Text(
                      //     'Settings',
                      //     style: AppTextStyles.subHeadingTextStyle1,
                      //   ),
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      // ),
                      // ListTile(
                      //   isThreeLine: false,
                      //   dense: true,
                      //   visualDensity:
                      //       const VisualDensity(vertical: -1, horizontal: -3),
                      //   contentPadding: const EdgeInsets.symmetric(
                      //       horizontal: 12, vertical: 0),
                      //   leading: const ImageIcon(
                      //     AssetImage("assets/icons/language-icon.png"),
                      //     color: AppColors.secondaryColor,
                      //   ),
                      //   title: const Text(
                      //     'Languages',
                      //     style: AppTextStyles.subHeadingTextStyle1,
                      //   ),
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      // ),
                      Get.find<GeneralController>()
                                  .storageBox
                                  .read('authToken') !=
                              null
                          ? ListTile(
                              isThreeLine: false,
                              dense: true,
                              visualDensity: const VisualDensity(
                                  vertical: -1, horizontal: -3),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 0),
                              leading: const ImageIcon(
                                AssetImage("assets/icons/Sign_out_circle.png"),
                                color: AppColors.secondaryColor,
                              ),
                              title: const Text(
                                'Đăng xuất',
                                style: AppTextStyles.subHeadingTextStyle1,
                              ),
                              onTap: () {
                                Get.find<GeneralController>()
                                    .updateFormLoaderController(true);
                                getMethod(context, signOutURL, null, true,
                                    signOutUserRepo);

                                // Get.toNamed(PageRoutes.homeScreen);
                              },
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: _currentIndex,
            backgroundColor: AppColors.offWhite,
            showElevation: true,
            itemCornerRadius: 24,
            curve: Curves.easeIn,
            onItemSelected: (index) => setState(() => _currentIndex = index),
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                icon: const ImageIcon(
                  AssetImage("assets/icons/Group.png"),
                  size: 28,
                  color: AppColors.secondaryColor,
                ),
                title: const Text(
                  'Luật sư',
                  style: AppTextStyles.bodyTextStyle2,
                ),
                activeColor: AppColors.primaryColor,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: const ImageIcon(
                  AssetImage("assets/icons/Home.png"),
                  size: 30,
                  color: AppColors.secondaryColor,
                ),
                title: const Text(
                  'Trang chủ',
                  style: AppTextStyles.bodyTextStyle2,
                ),
                activeColor: AppColors.primaryColor,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: const ImageIcon(
                  AssetImage("assets/icons/File_dock.png"),
                  color: AppColors.secondaryColor,
                ),
                title: const Text(
                  'Loại',
                  style: AppTextStyles.bodyTextStyle2,
                ),
                activeColor: AppColors.primaryColor,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    });
  }
}
