import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/ui/commons/common_dialog.dart';

import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as datetime_picker;
import 'package:get/get.dart';

class AppDialog {
  static void deleteDialog({
    String? title,
    String message = "",
    String? textConfirm,
    String? textCancel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) async {
    if (message.isEmpty) {
      return;
    }

    await Get.dialog(
      CommonDialog(
        centerTitle: true,
        title: title ?? 'S.current.confirm_delete',
        message: message,
        titleConfirm: textConfirm,
        titleCancel: textCancel,
        onConfirm: onConfirm == null
            ? null
            : () {
                Get.back();
                onConfirm.call();
              },
        onCancel: () {
          Get.back();
          onCancel?.call();
        },
      ),
      barrierDismissible: true,
    );
  }

  static void tkCommonDialog({
    String? title,
    String message = "",
    String? textConfirm,
    String? textCancel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) async {
    if (message.isEmpty) {
      return;
    }

    await Get.dialog(
      CommonDialog(
        centerTitle: true,
        title: title ?? 'S.current.confirm_delete',
        message: message,
        titleConfirm: textConfirm,
        titleCancel: textCancel,
        onConfirm: onConfirm == null
            ? null
            : () {
                Get.back();
                onConfirm.call();
              },
        onCancel: () {
          Get.back();
          onCancel?.call();
        },
        cancelBgColor: AppColors.redE20F0F,
        confirmBgColor: AppColors.tkPrimary,
        titleBackGround: AppColors.tkPrimary,
        borderColor: AppColors.tkPrimary,
      ),
      barrierDismissible: true,
    );
  }

  static void showDatePicker(
    BuildContext context, {
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onConfirm,
    LocaleType locale = LocaleType.en,
    DateTime? currentTime,
  }) {
    DatePicker.showDatePicker(
      context,
      minTime: minTime,
      maxTime: maxTime,
      onConfirm: onConfirm,
      locale: locale,
      currentTime: currentTime,
      theme: const datetime_picker.DatePickerTheme(),
    );
  }

  static void showDateTimePicker(
    BuildContext context, {
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onConfirm,
    LocaleType locale = LocaleType.en,
    DateTime? currentTime,
  }) {
    DatePicker.showDateTimePicker(
      context,
      minTime: minTime,
      maxTime: maxTime,
      onConfirm: onConfirm,
      locale: LocaleType.vi,
      currentTime: currentTime,
      theme: const datetime_picker.DatePickerTheme(),
    );
  }

  static void showTimePicker(
    BuildContext context, {
    DateChangedCallback? onConfirm,
    LocaleType locale = LocaleType.en,
    DateTime? currentTime,
  }) {
    DatePicker.showTimePicker(
      context,
      onConfirm: onConfirm,
      locale: locale,
      currentTime: currentTime,
      showSecondsColumn: false,
      theme: const datetime_picker.DatePickerTheme(),
    );
  }

  static void defaultErrorDialog({
    String? title,
    String message = "",
    String? textConfirm,
    String? textCancel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    Get.defaultDialog(
      title: title ?? 'S.current.notification',
      radius: 10,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          "$message \n",
          textAlign: TextAlign.center,
        ),
      ),
      onConfirm: onConfirm == null
          ? null
          : () {
              Get.back();
              onConfirm.call();
            },
      onCancel: onCancel == null
          ? null
          : () {
              Get.back();
              onCancel.call();
            },
      textConfirm: textConfirm,
      textCancel: textCancel,
      confirm: (textConfirm ?? "").isEmpty
          ? null
          : AppButton(
              width: 150,
              title: textConfirm ?? "",
              backgroundColor: AppColors.textFieldFocusedBorder,
              onPressed: () {
                Get.back();
                onConfirm?.call();
              },
            ),
      cancel: (textCancel ?? "").isEmpty
          ? null
          : AppButton(
              width: 150,
              title: textConfirm ?? "",
              onPressed: () {
                Get.back();
                onCancel?.call();
              },
            ),
      confirmTextColor: Colors.black,
      cancelTextColor: Colors.black,
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
    );
  }

  static Future<void> commonDialog({
    Key? key,
    String? title,
    String message = "",
    String? textConfirm,
    String? textCancel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isShowTitle = true,
    bool centerTitle = true,
    bool barrieDismissible = false,
    bool isAutoClose = true,
  }) async {
    if (message.isEmpty) {
      return;
    }

    await Get.dialog(
      CommonDialog(
        key: key,
        centerTitle: centerTitle,
        isShowTitle: isShowTitle,
        title: title ?? ' S.current.warning',
        message: message,
        titleConfirm: textConfirm,
        titleCancel: textCancel,
        onCancel: onCancel == null
            ? null
            : () {
                if (isAutoClose) Get.back();
                onCancel.call();
              },
        onConfirm: () {
          if (isAutoClose) Get.back();
          onConfirm?.call();
        },
      ),
      barrierDismissible: barrieDismissible,
    );
  }
}
