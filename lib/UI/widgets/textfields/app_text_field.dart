import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final bool? enabled;
  final bool? showOutline;
  final bool? autofocus;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final Color? background;
  final Color? colorText;
  final Color? borderColor;
  final double? borderRadius;
  final double? fontSize;
  final double? widthBorder;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final bool? isCollapsed;
  final Color? hintTextColor;
  final int? minLines;
  final int? maxLines;
  final EdgeInsets padding;
  final bool isShowButton;
  final Widget? widgetPrefix;
  final Color? cursorColor;
  final String? prefixIcon;
  final String? suffixIcon;
  final VoidCallback? onTapSuffixIcon;
  final bool enableValidator;
  final String? noteText;
  final String? title;
  final Color? noteTextColor;
  final FontWeight? fontWeight;

  const AppTextField({
    Key? key,
    this.hintText,
    this.enabled,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.controller,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.validator,
    this.focusNode,
    this.obscureText = false,
    this.enableValidator = false,
    this.textCapitalization = TextCapitalization.none,
    this.background,
    this.borderColor,
    this.borderRadius = 8,
    this.colorText,
    this.fontSize = 20,
    this.widthBorder = 5,
    this.margin = EdgeInsets.zero,
    this.showOutline = false,
    this.alignment,
    this.isCollapsed = false,
    this.hintTextColor,
    this.cursorColor,
    this.minLines,
    this.maxLines = 1,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    this.isShowButton = false,
    this.widgetPrefix,
    this.prefixIcon,
    this.suffixIcon,
    this.onTapSuffixIcon,
    this.autofocus = false,
    this.noteText,
    this.noteTextColor,
    this.fontWeight,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 25,
            ),
            Visibility(
              visible: (title ?? "").isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  title ?? "",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff663300),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: background ?? Colors.white,
                borderRadius: BorderRadius.circular(borderRadius ?? 15),
                boxShadow: [
                  // BoxShadow(
                  //   color: Colors.grey.withOpacity(0.7),
                  //   spreadRadius: 1,
                  //   blurRadius: 2,
                  //   offset: const Offset(2, 2), // changes position of shadow
                  // ),
                ],
              ),
              child: TextFormField(
                maxLines: maxLines,
                minLines: minLines,
                textAlignVertical: TextAlignVertical.center,
                obscureText: obscureText,
                textCapitalization: textCapitalization,
                enabled: enabled,
                controller: controller,
                onChanged: onChanged,
                autofocus: autofocus ?? false,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                onFieldSubmitted: onFieldSubmitted,
                validator: validator,
                focusNode: focusNode,
                autocorrect: false,
                enableSuggestions: false,
                key: key,
                style: TextStyle(
                  fontFamily: 'AlumniSans',
                  fontSize: fontSize!,
                  color: colorText ?? Colors.black,
                  fontWeight: fontWeight ?? FontWeight.w500,
                ),
                cursorColor: cursorColor,
                decoration: InputDecoration(
                  contentPadding: padding,
                  isCollapsed: isCollapsed!,
                  border: InputBorder.none,
                  errorText: null,
                  errorStyle: const TextStyle(
                    color: Colors.transparent,
                    fontSize: 0,
                    height: 0.01,
                  ),
                  hintText: hintText,
                  labelStyle: TextStyle(
                    fontSize: fontSize!,
                    color: colorText ?? Colors.white,
                  ),
                  hintStyle: TextStyle(
                    fontSize: fontSize!,
                    color: hintTextColor ?? Color(0xFF535050),
                    fontWeight: fontWeight ?? FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 8),
                    borderSide: BorderSide(
                      color:
                          showOutline! ? Color(0xff663300) : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 8),
                    borderSide: BorderSide(
                      color: showOutline! ? Colors.white : Colors.transparent,
                      width: widthBorder ?? 1,
                    ),
                  ),
                  prefixIcon: (prefixIcon ?? "").isNotEmpty
                      ? Image.asset(
                          prefixIcon!,
                          width: 25,
                          height: 25,
                        )
                      : null,
                  suffixIcon: (suffixIcon ?? "").isNotEmpty
                      ? InkWell(
                          onTap: onTapSuffixIcon?.call,
                          child: Image.asset(
                            suffixIcon!,
                            width: 18,
                            height: 18,
                          ),
                        )
                      : null,
                ),
                inputFormatters: inputFormatters,
              ),
            ),
            if ((noteText ?? "").isNotEmpty)
              Positioned(
                left: 0,
                top: 5,
                right: 10,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    noteText ?? "",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              )
          ],
        ),
        _errorWidget,
      ],
    );
  }

  Widget get _errorWidget {
    if (controller == null || !enableValidator) return const SizedBox();
    return ValueListenableBuilder(
      valueListenable: controller!,
      builder: (context, TextEditingValue controller, child) {
        final isValid = validator?.call(controller.text) ?? "";
        if (isValid.isEmpty) return const SizedBox();
        return Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            isValid,
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        );
      },
    );
  }
}
