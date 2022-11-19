import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodone_widgets/helper.dart';

class MyButton extends StatefulWidget {
  ButtonController? controller;
  String? text;
  bool needPadding = true;
  bool centerAlign;
  bool isSecondary;
  bool isDangerType;
  VoidCallback? onClick;
  bool needWaitingSign;
  bool isFullWidth; //If button width needs to fill parent
  MyButtonDefaults? defaults;
  bool isSmall;
  double? height; //height of the button
  Alignment? alignment;
  Color? color;
  IconData? icon;
  MyButton(
      {this.controller,
      this.text,
      this.onClick,
      this.needPadding = true,
      this.centerAlign = false,
      this.isSecondary = false,
      this.needWaitingSign = false,
      this.isFullWidth = false,
      this.isDangerType = false,
      this.defaults,
      this.isSmall = false,
      this.alignment,
      this.icon,
      this.height,
      this.color});

  _roundedState createState() => _roundedState();
}

class _roundedState extends State<MyButton> with TickerProviderStateMixin {
  bool processing = false;
  late AnimationController animController;
  late Animation widthAnimation, borderAnimation;
  bool isDisposed = false;

  bool isIos = false;
  void initState() {
    super.initState();
    if (widget.needWaitingSign) widget.controller!.onDone = _onDone;

    if (!kIsWeb) {
      if (Platform.isIOS) {
        isIos = true;
      }
    }

    animController =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this)
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.dismissed) {
              //reverse animation is over
              if (!isDisposed) {
                setState(() {
                  processing = false;
                });
              }
            }
          });

    widthAnimation = Tween<double>(begin: 90, end: 20).animate(
        CurvedAnimation(parent: animController, curve: Curves.fastOutSlowIn));

    borderAnimation = Tween<double>(begin: 10, end: 150).animate(
        CurvedAnimation(parent: animController, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    isDisposed = true;
    animController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // print('value of boederanim ${borderAnimation.value} and width animation ${widthAnimation.value}');
    if (isIos) {
      return Padding(
        padding: (widget.needPadding) ? EdgeInsets.all(8.0) : EdgeInsets.zero,
        child: Align(
          alignment: widget.centerAlign
              ? Alignment.center
              : widget.alignment ?? Alignment.centerRight,
          child: CupertinoButton(
              color:
                  (widget.isSecondary || widget.isSmall) ? null : _getColor(),
              onPressed: () {
                if (!processing) {
                  setState(() {
                    if (widget.needWaitingSign) {
                      processing = true;
                       animController.forward();
                    }
                    widget.onClick!();
                  });
                }
              },
              child: (!processing)
                  ? texts.plainText(widget.text!,
                      color: (widget.isSecondary || widget.isSmall)
                          ? widget.defaults!.bgColor
                          : colors.foreColorInverse)
                  : CupertinoActivityIndicator()),
        ),
      );
    }

        return ButtonTheme(
          height: widget.isSmall ? 30 : widget.height ?? 50,
          minWidth: widget.isFullWidth
              ? double.infinity
              : widthAnimation.value, //:90,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: (widget.needPadding) ? EdgeInsets.all(8.0) : EdgeInsets.zero,
            child: Align(
                alignment: widget.centerAlign
                    ? Alignment.center
                    : widget.alignment ?? Alignment.centerRight,
                child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                    minimumSize: MaterialStateProperty.all(Size(
                        widget.isFullWidth
                            ? double.infinity
                            : widthAnimation.value, widget.isSmall ? 30 : widget.height ?? 50)),
                      backgroundColor: MaterialStateProperty.all<Color?>(_getColor()),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        // side: BorderSide(width: 1,color:colors.lighten(_getColor(),0.4) ),
                        borderRadius: BorderRadius.circular(15)
                      ))
                  ),
                  // color: _getColor(),
                  // elevation: 5,
                  onPressed: () {
                    if (!processing) {
                      setState(() {
                        if (widget.needWaitingSign) {
                          processing = true;
                        }
                        widget.onClick!();
                      });
                    }
                  },
                  child: (!processing)
                      ? _buttonContent()
                      : SizedBox(
                    width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color?>(
                          widget.defaults!.forecolor),
                  ),
                      ),
                )),
          ),
        );
    /*ButtonTheme(
        height: 50,
        minWidth: widget.isFullWidth?double.infinity:90,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child:
      );*/
  }

  _buttonContent() {
    if (widget.icon == null) {
      return _button_text();
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            widget.icon,
            color:
                widget.isSecondary ? colors.foreColor : colors.foreColorInverse,
          ),
          SizedBox(
            width: 10,
          ),
          _button_text()
        ],
      );
    }
  }

  Color? _getColor() {
    if (widget.color != null) {
      return widget.color;
    } else {
      if (widget.isSecondary) {
        return widget.defaults!.secondaryColor;
      } else {
        if (widget.isDangerType) {
          return colors.dangerButtonBackground;
        } else {
          return widget.defaults!.bgColor;
        }
      }
    }
  }

  _button_text() {
    return texts.buttonText(widget.text!,
        isSmall: widget.isSmall,
        color: widget.isDangerType
            ? colors.foreColorInverse
            : (widget.isSecondary)
                ? widget.defaults!.secondaryForecolor
                : widget.defaults!.forecolor);
  }

  _onDone() {
    // if (animController != null) animController.reverse();
    setState(() {
      processing = false;
    });
  }
}

class ButtonController {
  VoidCallback? onDone;
}

class MyButtonDefaults {
  Color? bgColor;
  Color? forecolor;
  Color? secondaryColor;
  Color? secondaryForecolor;
  MyButtonDefaults(
      {this.bgColor,
      this.forecolor,
      this.secondaryColor,
      this.secondaryForecolor});
}
