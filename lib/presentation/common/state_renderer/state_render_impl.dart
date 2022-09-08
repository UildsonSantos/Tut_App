import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

// Loading State (popUp, full Screen)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({
    required this.stateRendererType,
    String? message,
  }) : message = message ?? AppStrings.loading.tr();

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error state (popUp,full Loading)

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Content state

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => empty;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.contentScreenState;
}

// Empty state

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.emptyScreenState;
}

// success state
class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popUpSuccess;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.popUpLoadingState) {
            // showing popup dialog
            showPopUp(
              context,
              getStateRendererType(),
              getMessage(),
            );
            // return the content ui of the screen
            return contentScreenWidget;
          } else {
            // StateRendererType.fullScreenLoadingState
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popUpErrorState) {
            // showing popup dialog
            showPopUp(
              context,
              getStateRendererType(),
              getMessage(),
            );
            // return the content ui of the screen
            return contentScreenWidget;
          } else {
            // StateRendererType.fullScreenErrorState
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case ContentState:
        {
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
          );
        }
      case SuccessState:
        {
          // i should check if we are showing loading popup to remove it before showing success popup
          dismissDialog(context);

          // show popup
          showPopUp(
            context,
            StateRendererType.popUpSuccess,
            getMessage(),
            title: AppStrings.success.tr(),
          );
          // return content ui of the screen
          return contentScreenWidget;
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(
      BuildContext context, StateRendererType stateRendererType, String message,
      {String title = empty}) {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          title: title,
          retryActionFunction: () {},
        ),
      ),
    );
  }
}
