import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer_consultant/src/config/localization.dart';

import '../config/app_colors.dart';
import '../config/app_text_styles.dart';

import '../widgets/appbar_widget.dart';
import '../widgets/button_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen> {
  final Localization localization = Localization();
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBarWidget(
          leadingIcon: 'assets/icons/Expand_left.png',
          leadingOnTap: () {
            Get.back();
          },
          richTextSpan: const TextSpan(
            text: 'Ví',
            style: AppTextStyles.appbarTextStyle2,
            children: <TextSpan>[],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.gradientOne,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  Text(
                    localization.stanslate('Available Amount'),
                    style: AppTextStyles.bodyTextStyle5,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "\$250",
                    style: AppTextStyles.bodyTextStyle5,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36, 12, 36, 18),
                    child: ButtonWidgetOne(
                      borderRadius: 10,
                      buttonColor: AppColors.offWhite,
                      buttonText: localization.stanslate('Add to Wallet'),
                      buttonTextStyle: AppTextStyles.buttonTextStyle7,
                      onTap: () {},
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localization.stanslate('Transactions History'),
                  style: AppTextStyles.headingTextStyle4,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: 0),
                    backgroundColor: AppColors.primaryColor,
                    // minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localization.stanslate('Filter'),
                        style: AppTextStyles.buttonTextStyle2,
                      ),
                      Image.asset("assets/icons/Filter_alt_fill.png"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 16,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Dismissible(
                    key: Key(item),

                    onDismissed: (direction) {
                      DismissDirection.startToEnd;
                      setState(() {
                        items.removeAt(index);
                      });

                      // Then show a snackbar.
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$item dismissed')));
                    },
                    // Show a red background as the item is swiped away.
                    background: Container(
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: AppColors.gradientOne,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Image.asset("assets/icons/View.png"),
                      ),
                    ),

                    child: Container(
                      padding: const EdgeInsets.fromLTRB(14, 17, 14, 17),
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        color: AppColors.offWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "01",
                            style: AppTextStyles.bodyTextStyle1,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              localization.stanslate('Wallet Cashback'),
                              style: AppTextStyles.bodyTextStyle1,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "\$50",
                            style: AppTextStyles.bodyTextStyle1,
                          ),
                          SizedBox(width: 10),
                          Text(
                            localization.stanslate('date'),
                            style: AppTextStyles.bodyTextStyle1,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
