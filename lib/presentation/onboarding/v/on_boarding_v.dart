// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:advanced_flutter/app/app_preferences.dart';
import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/login/v/login_v.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/slider_object.dart';
import '../../../domain/entities/slider_view_object.dart';
import '../../resources/colors_manager.dart';
import '../../resources/constants_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../vm/on_boarding_vm.dart';

class OnBoardingV extends StatefulWidget {
  const OnBoardingV({super.key});

  @override
  State<OnBoardingV> createState() => _OnBoardingVState();
}

class _OnBoardingVState extends State<OnBoardingV> {
  final PageController _pageController = PageController();
  final OnBoardingVM _onBoardingVM = OnBoardingVM();
  final AppPreferences _appPreferences = gi<AppPreferences>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _appPreferences.setIsOnBoardingViewed();
    _onBoardingVM.start();
  }

  @override
  void dispose() {
    _onBoardingVM.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _onBoardingVM.outputSliderViewObjeect,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return const Center(child: Text("SliderViewObject Is Null!"));
    }
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: ColorManager.white,
      body: PageView.builder(
        controller: _pageController,
        itemCount: sliderViewObject.slidesCount,
        onPageChanged: _onBoardingVM.onPageChanged,
        itemBuilder: (context, index) =>
            OnBoardingPage(sliderViewObject.sliderObject),
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                },
                child: Text(
                  AppStrings.skip,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            _getBottomSheetWidget(sliderViewObject),
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: const SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: Icon(
                  Icons.arrow_back,
                  color: ColorManager.white,
                ),
              ),
              onTap: () {
                // Go to previous slide
                _pageController.animateToPage(
                  _onBoardingVM.goPrevious(),
                  duration: const Duration(
                    microseconds: ViewConstants.sliderAnimation,
                  ),
                  curve: Curves.bounceInOut,
                );
              },
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.slidesCount; i++)
                _getProperCircle(i, sliderViewObject.curretPageIndex)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: const SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: Icon(
                  Icons.arrow_forward,
                  color: ColorManager.white,
                ),
              ),
              onTap: () {
                // Go to next slide
                _pageController.animateToPage(
                  _onBoardingVM.goNext(),
                  duration: const Duration(
                    microseconds: ViewConstants.sliderAnimation,
                  ),
                  curve: Curves.bounceInOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int slideIndex, int currentPageIndex) => Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Icon(
          (slideIndex == currentPageIndex)
              ? Icons.circle
              : Icons.circle_outlined,
          size: AppSize.s16,
          color: Colors.white,
        ),
      );
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;
  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: AppSize.s60),
        SvgPicture.asset(
          _sliderObject.image,
          height: 200,
          width: 200,
        ),
      ],
    );
  }
}
