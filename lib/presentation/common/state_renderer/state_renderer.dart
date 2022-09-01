import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/font_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/resources/styles_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

enum StateRendererType {
  // PopUp States
  popUpLoadingState,
  popUpErrorState,

  // Full Screen states
  fullScreenLoadingState,
  fullScreenErrorState,
  contentScreenState, // The UI of the screen
  emptyScreenState, // Empty View when we receive no data from api side for list screen
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function? retryActionFunction;

  StateRenderer({
    Key? key,
    required this.stateRendererType,
    String? message,
    String? title,
    required this.retryActionFunction,
  })  : message = message ?? AppStrings.loading,
        title = title ?? empty,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popUpLoadingState:
        return _getPopUpDialog(
          context,
          [
            _getAnimatedImage(JsonAssets.loading),
          ],
        );
      case StateRendererType.popUpErrorState:
        return _getPopUpDialog(
          context,
          [
            _getAnimatedImage(JsonAssets.error),
            _getMessage(message),
            _getRetryButton(AppStrings.ok, context)
          ],
        );
      case StateRendererType.fullScreenLoadingState:
        return _getItemsInColumn(
          [
            _getAnimatedImage(JsonAssets.loading),
            _getMessage(message),
          ],
        );
      case StateRendererType.fullScreenErrorState:
        return _getItemsInColumn(
          [
            _getAnimatedImage(JsonAssets.error),
            _getMessage(message),
            _getRetryButton(AppStrings.retryAgain, context)
          ],
        );
      case StateRendererType.contentScreenState:
        return Container();
      case StateRendererType.emptyScreenState:
        return _getItemsInColumn(
          [
            _getAnimatedImage(JsonAssets.empty),
            _getMessage(message),
          ],
        );
      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: AppSize.s12,
                offset: Offset(AppSize.s0, AppSize.s12),
              )
            ]),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          style: getMediumStyle(
            color: ColorManager.black,
            fontSize: FontSize.s16,
          ),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(
              onPressed: () {
                if (stateRendererType ==
                    StateRendererType.fullScreenErrorState) {
                  retryActionFunction
                      ?.call(); // to call the API function again to retry
                } else {
                  Navigator.of(context)
                      .pop(); // popup state error so we need to dismiss the dialog
                }
              },
              child: Text(buttonTitle)),
        ),
      ),
    );
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
