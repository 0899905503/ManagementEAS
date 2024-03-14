import 'package:flutter/material.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_dimens.dart';
import 'package:meas/widgets/textfields/app_circular_progress_indicator.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  final bool isLoading;
  final bool isShadow;

  final double? height;
  final double? width;
  final double? borderWidth;
  final double? cornerRadius;

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  final TextStyle? textStyle;

  final VoidCallback? onPressed;

  const AppButton({
    Key? key,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.isShadow = false,
    this.height,
    this.width,
    this.borderWidth,
    this.cornerRadius,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.textColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Utils.hideKeyboard(context);
        onPressed?.call();
      },
      child: Container(
        height: height ?? AppDimens.buttonHeight,
        width: width ?? 367,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            cornerRadius ?? AppDimens.buttonLogin,
          ),
          color: backgroundColor ?? AppColors.buttonLogin,
          border: Border.all(
            color: borderColor ?? AppColors.buttonLogin,
            width: borderWidth ?? 0,
          ),
          boxShadow: isShadow
              ? const [
                  BoxShadow(
                    color: AppColors.textFieldEnabledBorder,
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]
              : [],
        ),
        child: _buildChildWidget(),
      ),
    );
  }

  Widget _buildChildWidget() {
    if (isLoading) {
      return AppCircularProgressIndicator(
        color: backgroundColor ?? AppColors.buttonLogin,
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leadingIcon ?? Container(),
          title != null
              ? Text(
                  title!,
                  style: textStyle ??
                      TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: textColor ?? Colors.white,
                      ),
                )
              : Container(),
          trailingIcon ?? Container(),
        ],
      );
    }
  }
}
