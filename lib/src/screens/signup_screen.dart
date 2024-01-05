import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer_consultant/src/config/app_colors.dart';
import 'package:lawyer_consultant/src/config/app_text_styles.dart';
import 'package:lawyer_consultant/src/config/localization.dart';
import 'package:lawyer_consultant/src/controllers/signin_controller.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';
import '../api_services/post_service.dart';
import '../api_services/urls.dart';
import '../controllers/general_controller.dart';
import '../controllers/signup_controller.dart';
import '../repositories/signup_repo.dart';
import '../routes.dart';
import '../widgets/auth_text_form_field_widget.dart';
import '../widgets/button_widget.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final Localization localization = Localization();
  final logic = Get.put(SignUpController());

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  final GlobalKey<FormState> _signUpFromKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return GetBuilder<SignUpController>(builder: (signUpController) {
        return GestureDetector(
            onTap: () {
              generalController.focusOut(context);
            },
            child: ModalProgressHUD(
                progressIndicator: const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
                inAsyncCall: generalController.formLoaderController,
                child: Scaffold(
                  backgroundColor: AppColors.offWhite,
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 58, 18, 0),
                      child: Form(
                        key: _signUpFromKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/law-hammer.png"),
                            const SizedBox(height: 28),
                            Text(
                              localization.stanslate('Create an account'),
                              style: AppTextStyles.bodyTextStyle8,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              localization
                                  .stanslate('Create an account as a Customer'),
                              style: AppTextStyles.bodyTextStyle1,
                            ),
                            const SizedBox(height: 28),
                            AuthTextFormFieldWidget(
                              hintText: localization.stanslate('First Name'),
                              prefixIconColor: AppColors.primaryColor,
                              prefixIcon: "assets/icons/User.png",
                              controller:
                                  signUpController.signUpFirstNameController,
                              validator: (value) {
                                if ((value ?? "").isEmpty) {
                                  return localization
                                      .stanslate('Field Required');
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            AuthTextFormFieldWidget(
                              hintText: localization.stanslate('Last Name'),
                              prefixIconColor: AppColors.primaryColor,
                              prefixIcon: "assets/icons/User.png",
                              controller:
                                  signUpController.signUpLastNameController,
                              validator: (value) {
                                if ((value ?? "").isEmpty) {
                                  return localization
                                      .stanslate('Field Required');
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            AuthTextFormFieldWidget(
                              hintText: 'Email',
                              prefixIconColor: AppColors.primaryColor,
                              prefixIcon: "assets/icons/Message.png",
                              controller:
                                  signUpController.signUpEmailController,
                              errorText: signUpController.emailValidator,
                              onChanged: (value) {
                                signUpController.emailValidator = null;
                                signUpController.update();
                              },
                              validator: (value) {
                                if ((value ?? "").isEmpty) {
                                  return localization
                                      .stanslate('Field Required');
                                }
                                if (!GetUtils.isEmail(value!)) {
                                  return localization.stanslate(
                                      'Please make sure your email address is valid');
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            AuthPasswordFormFieldWidget(
                              hintText: localization.stanslate('Password'),
                              prefixIconColor: AppColors.primaryColor,
                              prefixIcon: "assets/icons/Unlock.png",
                              errorText: signUpController.passwordValidator,
                              controller:
                                  signUpController.signUpPasswordController,
                              onChanged: (value) {
                                signUpController.passwordValidator = null;
                                signUpController.update();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return localization
                                      .stanslate('Field Required');
                                } else if (value.length < 8) {
                                  return localization.stanslate(
                                      'Password must contains 8 digit');
                                }
                                return null;
                              },
                              suffixIcon: Icon(
                                obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                                color: AppColors.lightGrey,
                              ),
                              suffixIconOnTap: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                              obsecureText: obscurePassword,
                            ),
                            const SizedBox(height: 16),
                            AuthPasswordFormFieldWidget(
                              hintText:
                                  localization.stanslate('Confirm Password'),
                              prefixIconColor: AppColors.primaryColor,
                              prefixIcon: "assets/icons/Unlock.png",
                              errorText: signUpController.passwordValidator,
                              controller: signUpController
                                  .signUpConfirmPasswordController,
                              onChanged: (value) {
                                signUpController.passwordValidator = null;
                                signUpController.update();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return localization
                                      .stanslate('Field Required');
                                } else if (signUpController
                                        .signUpPasswordController.text !=
                                    signUpController
                                        .signUpConfirmPasswordController.text) {
                                  return localization
                                      .stanslate('Password does not match');
                                }
                                return null;
                              },
                              suffixIcon: Icon(
                                obscureConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                                color: AppColors.lightGrey,
                              ),
                              suffixIconOnTap: () {
                                setState(() {
                                  obscureConfirmPassword =
                                      !obscureConfirmPassword;
                                });
                              },
                              obsecureText: obscureConfirmPassword,
                            ),
                            const SizedBox(height: 16),
                            ButtonWidgetOne(
                              borderRadius: 10,
                              buttonColor: AppColors.primaryColor,
                              buttonText: localization.stanslate('Signup'),
                              buttonTextStyle: AppTextStyles.buttonTextStyle1,
                              onTap: () {
                                ///---keyboard-close
                                // FocusScopeNode currentFocus =
                                //     FocusScope.of(context);
                                // if (!currentFocus.hasPrimaryFocus) {
                                //   currentFocus.unfocus();
                                // }

                                ///
                                if (_signUpFromKey.currentState!.validate()) {
                                  ///loader
                                  // generalController.changeLoaderCheck(true);
                                  generalController
                                      .updateFormLoaderController(true);
                                  signUpController.emailValidator = null;
                                  signUpController.passwordValidator = null;
                                  signUpController.update();
                                  generalController.focusOut(context);

                                  ///post-method
                                  postMethod(
                                      context,
                                      signUpWithEmailURL,
                                      {
                                        'email': signUpController
                                            .signUpEmailController.text,
                                        'first_name': signUpController
                                            .signUpFirstNameController.text,
                                        'last_name': signUpController
                                            .signUpLastNameController.text,
                                        'password': signUpController
                                            .signUpPasswordController.text,
                                        'password_confirmation':
                                            signUpController
                                                .signUpConfirmPasswordController
                                                .text,
                                        'login_as': "customer",
                                      },
                                      true,
                                      signUpWithEmailRepo);
                                }
                              },
                            ),
                            const SizedBox(height: 28),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(PageRoutes.signinScreen);
                              },
                              child: Text(
                                  localization.stanslate(
                                      'Have already account please sign in'),
                                  style: AppTextStyles.underlineTextStyle1),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              children: [
                                Expanded(child: Divider(color: AppColors.grey)),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      localization.stanslate('Or'),
                                      style: AppTextStyles.bodyTextStyle7,
                                    ),
                                  ),
                                ),
                                Expanded(child: Divider(color: AppColors.grey)),
                              ],
                            ),
                            SizedBox(height: 18.h),
                            ButtonWidgetThree(
                              buttonIcon: "assets/icons/Google.png",
                              buttonText:
                                  localization.stanslate('Login Via Google'),
                              iconHeight: 25.h,
                              onTap: () {},
                            ),
                            SizedBox(height: 14.h),
                            ButtonWidgetThree(
                              buttonIcon: "assets/icons/Facebook.png",
                              buttonText:
                                  localization.stanslate('Login Via Facebook'),
                              iconHeight: 25.h,
                              onTap: () {
                                Get.find<SigninController>()
                                    .signinWithFacebook();
                              },
                            ),
                            SizedBox(height: 18.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
      });
    });
  }
}
