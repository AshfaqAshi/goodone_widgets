import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodone_widgets/helper.dart';

class RoundedTextBox extends StatefulWidget {
  TextEditingController? txtController;
  String? hintText;
  double? borderRadius;
  String labelText;
  String helperText;
  String prefixText;
  String? suffixText;
  IconData? prefixIcon;
  IconData? suffixIcon;
  VoidCallback? suffixIconClick;
  Function(String)? onTextChange;
  bool isMultiLine = false;
  bool isEnabled;
  int? maxLines;
  /// minimum lines to be kept. This field is considered only if [isMultiline] is true
  int? minLines;
  FocusNode? focusNode;
  bool isNumber;
  bool isObscured;
  bool needPadding;
  RoundedTextBoxDefaults? defaults;
  TextAlign? textAlign;
  double fontSize;
  TextDirection textDirection;
  bool isBold;
  bool isFilled;
  bool autoFocus;
  Color? fillColor;
  double verticalSpace;
  double horizontalSpace;
  Function(String)? validator;

  RoundedTextBox(
      {this.txtController,
      this.hintText,
      this.isMultiLine = false,
      this.maxLines,
        this.minLines,
      this.borderRadius,
      this.labelText = '',
      this.prefixIcon,
      this.helperText = '',
      this.prefixText = '',
      this.focusNode,
      this.needPadding = true,
      this.isEnabled = true,
      this.isObscured = false,
      this.isNumber = false,
      this.suffixIcon,
      this.suffixIconClick,
      this.defaults,
      this.textAlign,
      this.fontSize = 17,
      this.isBold = false,
      this.suffixText,
      this.onTextChange,
      this.textDirection = TextDirection.ltr,
      this.isFilled = false,
      this.fillColor,
      this.horizontalSpace = 12.0,
      this.verticalSpace = 8.0,
      this.autoFocus = false,
      this.validator});

  _textBoxState createState() => _textBoxState();
}

class _textBoxState extends State<RoundedTextBox> {
  bool isIos = false;

  void initState() {
    super.initState();
    if (!kIsWeb) {
      /// since it ahs been decided to go with a single UI for all platforms, the [isIos] variable is no
      /// longer required. The code has to be refactored accordingly but for the time being set it to false; (commenting below code block)
      // if (Platform.isIOS) {
      //   isIos = true;
      // }
    }
  }

  Widget build(BuildContext context) {
    if (isIos) {
      return Padding(
       padding: widget.needPadding ? EdgeInsets.all(8.0) : EdgeInsets.zero,
        child: CupertinoTextFormFieldRow(
          autofocus: widget.autoFocus,
          placeholder: widget.hintText,
          controller: widget.txtController,
          obscureText: widget.isObscured,
          maxLines: (widget.isMultiLine) ? widget.maxLines : 1,
          minLines: (widget.isMultiLine) ? widget.minLines??2:null,
          onChanged: (newText) {
              if (widget.onTextChange != null) widget.onTextChange!(newText);
            },
          validator: widget.validator as String? Function(String?)?,
            
        ),
      );
    }
    OutlineInputBorder border = OutlineInputBorder(
        borderSide: BorderSide(
            width: 1,
            color: widget.defaults!.borderColor ?? colors.secondaryColor),
        borderRadius: BorderRadius.circular(
            widget.borderRadius == null ? 15 : widget.borderRadius!));

    return Padding(
      padding: widget.needPadding ? EdgeInsets.all(8.0) : EdgeInsets.zero,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 100),
        //height:(widget.helperText=='')?50:70,
        child: TextFormField(
          validator: widget.validator as String? Function(String?)?,
          autofocus: widget.autoFocus,
          controller: widget.txtController,
          focusNode: widget.focusNode,
          keyboardType: (widget.isMultiLine)
              ? TextInputType.multiline
              : (widget.isNumber)
                  ? TextInputType.number
                  : TextInputType.text,
          obscureText: widget.isObscured,
          maxLines: (widget.isMultiLine) ? widget.maxLines : 1,
          minLines: (widget.isMultiLine) ? widget.minLines:null,
          textAlign: widget.textAlign ?? TextAlign.left,
          textDirection: widget.textDirection,
          style: TextStyle(
              color: widget.defaults!.textColor ?? colors.foreColor,
              fontSize: widget.fontSize,
              fontWeight: widget.isBold ? FontWeight.bold : FontWeight.normal),
          enabled: widget.isEnabled,
          onChanged: (newText) {
            if (widget.onTextChange != null) widget.onTextChange!(newText);
          },
          decoration: InputDecoration(
              labelText: widget.labelText == '' ? null : widget.labelText,
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
              prefixText: (widget.prefixText == '') ? null : widget.prefixText,
              prefixStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              suffixText: widget.suffixText,
              suffixStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              helperText: widget.helperText == '' ? null : widget.helperText,
              prefixIcon: widget.prefixIcon == null
                  ? null
                  : Icon(
                      widget.prefixIcon,
                      color: widget.defaults!.iconColor ?? colors.primaryColor,
                    ),
              suffixIcon: widget.suffixIcon == null
                  ? null
                  : IconButton(
                      onPressed: () => widget.suffixIconClick!(),
                      icon: Icon(
                        widget.suffixIcon,
                        color: widget.defaults!.iconColor ?? colors.primaryColor,
                        size: 30,
                      ),
                    ),
              filled: widget.isFilled,
              fillColor: widget.isFilled
                  ? widget.fillColor
                  : widget.defaults!.fillColor ?? colors.bgColor,
              contentPadding: new EdgeInsets.symmetric(
                  vertical: widget.verticalSpace,
                  horizontal: widget.horizontalSpace),
              border: border,
              enabledBorder: border),
        ),
      ),
    );
  }
}

class RoundedTextBoxDefaults {
  Color? textColor;
  Color? iconColor;
  Color? fillColor;
  Color? borderColor;
  RoundedTextBoxDefaults(
      {this.textColor, this.iconColor, this.fillColor, this.borderColor});
}
