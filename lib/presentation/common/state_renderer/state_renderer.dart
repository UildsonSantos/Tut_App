import 'package:flutter/material.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';

enum StateRendererType {
  // PopUp States
  popupLoadingState,
  popUpErrorState,

  // Full Screen states
  fullScreenLoadingState,
  fullScreenErrorState,
  contentScreenState, // The UI of the screen
  emptyScreenState, // Empty View when we receive no data from api side for list screen
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  Failure failure;
  String message;
  String title;
  Function retryActionFunction;

  StateRenderer({
    Key? key,
    required this.stateRendererType,
    Failure? failure,
    String? message,
    String? title,
    required this.retryActionFunction,
  })  : message = message ?? AppStrings.loading,
        title = title ?? empty,
        failure = failure ?? DefaultFailure(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _getStateWidget() {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        // TODO: Handle this case.
        break;
      case StateRendererType.popUpErrorState:
        // TODO: Handle this case.
        break;
      case StateRendererType.fullScreenLoadingState:
        _getItemsInColumn();
        break;
      case StateRendererType.fullScreenErrorState:
        // TODO: Handle this case.
        break;
      case StateRendererType.contentScreenState:
        // TODO: Handle this case.
        break;
      case StateRendererType.emptyScreenState:
        // TODO: Handle this case.
        break;
      default:
        return Container();
    }
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
