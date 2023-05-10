import 'package:flutter/material.dart';

import '../../../data/constants.dart';
import '../../resources/strings_manager.dart';
import '../state_renderer/state_renderer.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

// Loading state (Popup, Full Screen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({
    required this.stateRendererType,
    this.message = AppStrings.loading,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Error state (Popup, Full Screen)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState({
    required this.stateRendererType,
    required this.message,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Content state
class ContentState extends FlowState {
  @override
  String getMessage() => DataConstants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

// Error state
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget({
    required BuildContext context,
    required Widget contentScreenWidget,
    required Function retryActionFunction,
  }) {
    switch (runtimeType) {
      case LoadingState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            // Show popup loading
            showPopup(
              context: context,
              stateRendererType: getStateRendererType(),
              message: getMessage(),
            );
            // Show content
            return contentScreenWidget;
          } else {
            // Full screen loading
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunc: retryActionFunction,
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            // Show popup loading
            showPopup(
              context: context,
              stateRendererType: getStateRendererType(),
              message: getMessage(),
            );
            // Show content
            return contentScreenWidget;
          } else {
            // Full screen loading
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunc: retryActionFunction,
            );
          }
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunc: retryActionFunction,
          );
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)!.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopup({
    required BuildContext context,
    required StateRendererType stateRendererType,
    required String message,
  }) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (context) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          retryActionFunc: DataConstants.doNothing,
        ),
      ),
    );
  }
}
