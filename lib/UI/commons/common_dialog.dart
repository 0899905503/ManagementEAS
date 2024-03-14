import 'package:flutter/material.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/widgets/buttons/app_button.dart';

class CommonDialog extends StatefulWidget {
  final String? title;
  final String message;
  final String? titleConfirm;
  final String? titleCancel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool centerTitle;
  final bool isShowTitle;
  final Color? titleBackGround;
  final Color? borderColor;
  final Color? cancelBgColor;
  final Color? confirmBgColor;

  const CommonDialog({
    Key? key,
    this.title,
    this.message = '',
    this.titleConfirm,
    this.titleCancel,
    this.onConfirm,
    this.onCancel,
    this.centerTitle = true,
    this.isShowTitle = true,
    this.titleBackGround,
    this.borderColor,
    this.cancelBgColor,
    this.confirmBgColor,
  }) : super(key: key);

  @override
  State<CommonDialog> createState() => CommonDialogState();
}

class CommonDialogState extends State<CommonDialog> {
  bool get _hasTwoButton => widget.onConfirm != null && widget.onCancel != null;

  late bool _isLoading;

  String get _titleConfirm => widget.titleConfirm ?? ' S.current.confirm';

  String get _titleCancel => widget.titleCancel ?? 'S.current.cancel';

  void onLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
            color: widget.borderColor ?? AppColors.primary, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: widget.isShowTitle,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: widget.titleBackGround ?? AppColors.primary,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Align(
                alignment: widget.centerTitle
                    ? Alignment.center
                    : Alignment.centerLeft,
                child: Text(
                  widget.title ?? '',
                  style: AppTextStyle.whiteS22Bold.copyWith(fontSize: 24),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              widget.message,
              style: AppTextStyle.blackS18.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: _hasTwoButton
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildCancelButton,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildConfirmButton,
                      ),
                    ],
                  )
                : (widget.onConfirm != null)
                    ? _buildConfirmButton
                    : _buildCancelButton,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget get _buildCancelButton {
    return AppButton(
      width: 150,
      title: _titleCancel,
      cornerRadius: 50,
      backgroundColor:
          (widget.cancelBgColor ?? AppColors.primary).withOpacity(0.5),
      onPressed: widget.onCancel ?? () {},
    );
  }

  Widget get _buildConfirmButton {
    return AppButton(
      width: 150,
      cornerRadius: 50,
      isLoading: _isLoading,
      title: _titleConfirm,
      onPressed: widget.onConfirm ?? () {},
      backgroundColor: widget.confirmBgColor,
    );
  }
}
