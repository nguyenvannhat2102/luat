import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import '../config/app_font.dart';

class IndicatorSliderWidget extends StatefulWidget {
  IndicatorSliderWidget({Key? key}) : super(key: key);

  @override
  State<IndicatorSliderWidget> createState() => _IndicatorSliderWidgetState();
}

class _IndicatorSliderWidgetState extends State<IndicatorSliderWidget> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 1,
                enlargeCenterPage: true,
                enlargeFactor: 0.5,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageSliders.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                  width: _current == entry.key ? 30.0 : 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius:
                        _current == entry.key ? BorderRadius.circular(4) : null,
                    shape: _current == entry.key
                        ? BoxShape.rectangle
                        : BoxShape.circle,
                    color: _current == entry.key
                        ? AppColors.primaryColor
                        : AppColors.white,
                  )),
            );
          }).toList(),
        ),
      ],
    );
  }
}

final List<Widget> imageSliders = [
  SliderImageStyle(
    img: 'assets/images/intro-slider-image.png',
    description:
        'Luật sư đam mê mong muốn đóng góp chuyên môn pháp lý và sự siêng năng cho một đội ngũ năng động, chuyên nghiệp trong việc cung cấp các giải pháp pháp lý toàn diện.',
    tagLine: RichText(
      // Controls how the text should be aligned horizontally
      textAlign: TextAlign.center,
      // Whether the text should break at soft line breaks
      softWrap: true,
      text: const TextSpan(
        text: 'Gặp chúng tôi ',
        style: TextStyle(
            color: AppColors.white,
            fontFamily: AppFont.primaryFontFamily,
            fontSize: 20,
            fontWeight: FontWeight.w700),
        children: <TextSpan>[
          TextSpan(
            text: 'Luật sư\nchuyên nghiệp ',
            style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: AppFont.primaryFontFamily,
                fontSize: 22,
                fontWeight: FontWeight.w700),
          ),
          TextSpan(
            text: 'trong vài phút',
            style: TextStyle(
                color: AppColors.white,
                fontFamily: AppFont.primaryFontFamily,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    ),
  ),
  SliderImageStyle(
    img: 'assets/images/intro-slider-image.png',
    description:
        'Luật sư đam mê mong muốn đóng góp chuyên môn pháp lý và sự siêng năng cho một đội ngũ năng động, chuyên nghiệp trong việc cung cấp các giải pháp pháp lý toàn diện.',
    tagLine: RichText(
      // Controls how the text should be aligned horizontally
      textAlign: TextAlign.center,
      // Whether the text should break at soft line breaks
      softWrap: true,
      text: const TextSpan(
        text: 'Gặp chúng tôi ',
        style: TextStyle(
            color: AppColors.white,
            fontFamily: AppFont.primaryFontFamily,
            fontSize: 20,
            fontWeight: FontWeight.w700),
        children: <TextSpan>[
          TextSpan(
            text: 'Luật sư\nchuyên nghiệp ',
            style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: AppFont.primaryFontFamily,
                fontSize: 22,
                fontWeight: FontWeight.w700),
          ),
          TextSpan(
            text: 'trong vài phút',
            style: TextStyle(
                color: AppColors.white,
                fontFamily: AppFont.primaryFontFamily,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    ),
  ),
  SliderImageStyle(
    img: 'assets/images/intro-slider-image.png',
    description:
        'Luật sư đam mê mong muốn đóng góp chuyên môn pháp lý và sự siêng năng cho một đội ngũ năng động, chuyên nghiệp trong việc cung cấp các giải pháp pháp lý toàn diện.',
    tagLine: RichText(
      // Controls how the text should be aligned horizontally
      textAlign: TextAlign.center,
      // Whether the text should break at soft line breaks
      softWrap: true,
      text: const TextSpan(
        text: 'Gặp chúng tôi ',
        style: TextStyle(
            color: AppColors.white,
            fontFamily: AppFont.primaryFontFamily,
            fontSize: 20,
            fontWeight: FontWeight.w700),
        children: <TextSpan>[
          TextSpan(
            text: 'Luật sư\nchuyên nghiệp ',
            style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: AppFont.primaryFontFamily,
                fontSize: 22,
                fontWeight: FontWeight.w700),
          ),
          TextSpan(
            text: 'trong vài phút',
            style: TextStyle(
                color: AppColors.white,
                fontFamily: AppFont.primaryFontFamily,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    ),
  ),
];

class SliderImageStyle extends StatelessWidget {
  final String img, description;
  final RichText tagLine;
  const SliderImageStyle({
    Key? key,
    required this.img,
    required this.description,
    required this.tagLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        children: [
          Image.asset(img, fit: BoxFit.cover),
          const SizedBox(height: 18),
          Row(
            children: [Expanded(child: tagLine)],
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColors.white,
                      fontFamily: AppFont.primaryFontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
