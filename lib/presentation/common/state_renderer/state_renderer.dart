// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:advanced_flutter/presentation/resources/colors_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import 'package:advanced_flutter/data/failures/failure.dart';

enum StateRendererType {
  // Popup
  popupLoadingState,
  popupErrorState,

  // Full Screen
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  // General
  contentState
}

class StateRenderer extends StatelessWidget {
  late StateRendererType stateRendererTyp;
  String message;
  String title;
  Function retryActionFunc;

  StateRenderer({
    Key? key,
    required this.stateRendererTyp,
    this.message = AppStrings.loading,
    this.title = "",
    required this.retryActionFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererTyp) {
      // case StateRendererType.popupLoadingState:
      //   // TODO: Handle this case.
      //   break;
      // case StateRendererType.popupErrorState:
      //   // TODO: Handle this case.
      //   break;
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn(children: [
          _getAnimatedJson(),
          _getMessage("message"),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn(children: [
          _getAnimatedJson(),
          _getMessage("message"),
          _getRetryButton(
            title: AppStrings.retryAgain,
            context: context,
          ),
        ]);
      // case StateRendererType.fullScreenEmptyState:
      //   // TODO: Handle this case.
      //   break;
      // case StateRendererType.contentState:
      //   // TODO: Handle this case.
      //   break;
      default:
        return _getItemsColumn(children: []);
    }
  }

  Widget _getItemsColumn({required List<Widget> children}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedJson() {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Container(), // TODO add json animation here
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          style: getRegularStyle(fontColor: ColorManager.black),
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
              if (stateRendererTyp == StateRendererType.fullScreenErrorState) {
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
