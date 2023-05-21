// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

enum StateRendererType {
  // Popup
  popupLoadingState,
  popupErrorState,
  popupSuccess,

  // Full Screen
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  // General
  contentState
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function retryActionFunc;

  const StateRenderer({
    Key? key,
    required this.stateRendererType,
    this.message = AppStrings.loading,
    this.title = "",
    required this.retryActionFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopupDialog(
          context: context,
          children: [
            _getAnimatedImage(JsonAssets.loading),
          ],
        );
      case StateRendererType.popupErrorState:
        return _getPopupDialog(
          context: context,
          children: [
            _getAnimatedImage(JsonAssets.error),
            _getMessage(message),
            _getRetryButton(
              title: AppStrings.ok,
              context: context,
            ),
          ],
        );
      case StateRendererType.popupSuccess:
        return _getPopupDialog(
          context: context,
          children: [
            _getAnimatedImage(JsonAssets.success),
            _getMessage(message),
            _getRetryButton(
              title: AppStrings.ok,
              context: context,
            ),
          ],
        );
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn(children: [
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn(
          children: [
            _getAnimatedImage(JsonAssets.error),
            _getMessage(message),
            _getRetryButton(
              title: AppStrings.retryAgain,
              context: context,
            ),
          ],
        );
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn(
          children: [
            _getAnimatedImage(JsonAssets.empty),
            _getMessage(message),
          ],
        );
      case StateRendererType.contentState:
        return Container(); // TODO show content

      default:
        return _getItemsColumn(
          children: [
            _getMessage("no state"),
          ],
        );
    }
  }

  Widget _getPopupDialog({
    required BuildContext context,
    required List<Widget> children,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: ColorManager.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppRadius.r14),
          boxShadow: const [
            BoxShadow(
              color: ColorManager.black26,
            ),
          ],
        ),
        child: _getDialogContent(
          context: context,
          childern: children,
        ),
      ),
    );
  }

  Widget _getDialogContent({
    required BuildContext context,
    required List<Widget> childern,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: childern,
    );
  }

  Widget _getItemsColumn({required List<Widget> children}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s150,
      width: AppSize.s150,
      child: Lottie.asset(
        animationName,
        // repeat: false,
      ),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: getRegularStyle(
            fontColor: ColorManager.black,
            fontSize: 14,
          ).copyWith(height: 2),
        ),
      ),
    );
  }

  Widget _getRetryButton({
    required String title,
    required BuildContext context,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (stateRendererType == StateRendererType.fullScreenErrorState) {
                // call retry function
                retryActionFunc.call();
              } else {
                // Popup error state
                Navigator.of(context).pop();
              }
            },
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
