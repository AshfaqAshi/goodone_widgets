import 'package:flutter/material.dart';
import 'package:goodone_widgets/helper.dart';

class MyButton extends StatefulWidget {
  ButtonController? controller;
  String? text;
  bool? needPadding = true;
  bool? centerAlign;
  bool? isSecondary;
  bool? isDangerType;
  VoidCallback? onClick;
  bool? needWaitingSign;
  bool? isFullWidth; //If button width needs to fill parent
  MyButtonDefaults? defaults;
  bool? isSmall;
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

  void initState() {
    super.initState();
    if (widget.needWaitingSign!) widget.controller?.onDone = _onDone;

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
  void dispose(){
    isDisposed=true;
    animController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context){
   // print('value of boederanim ${borderAnimation.value} and width animation ${widthAnimation.value}');
    return AnimatedBuilder(
      animation: animController,
      builder: (context, child){
        return ButtonTheme(
          height: widget.isSmall! ? 30 : widget.height ?? 50,
          minWidth: widget.isFullWidth!
              ? double.infinity
              : widthAnimation.value, //:90,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderAnimation.value)),
          child: child!,
        );
      },

      child: Padding(
        padding: (widget.needPadding!) ? EdgeInsets.all(8.0) : EdgeInsets.zero,
        child: Align(
            alignment: widget.centerAlign!
                ? Alignment.center
                : widget.alignment ?? Alignment.centerRight,
            child: RaisedButton(
              color: _getColor(),
              elevation: 5,
              onPressed: () {
                if (!processing) {
                  setState(() {
                    if (widget.needWaitingSign!) {
                      processing = true;
                      animController.forward();
                    }
                    widget.onClick!();
                  });
                }
              },
              child: (!processing)
                  ? _buttonContent()
                  : CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          widget.defaults!.forecolor),
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

  _buttonContent(){
    if(widget.icon==null){
      return _button_text();
      }else{
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            widget.icon,
            color: widget.isSecondary!
                ? colors.foreColor
                : colors.foreColorInverse,
          ),
        SizedBox(
          width: 10,
        ),
        _button_text()
        ],
      );
    }

  }

  Color _getColor(){
    if (widget.color != null) {
      return widget.color!;
    } else {
      if (widget.isSecondary!) {
        return widget.defaults!.secondaryColor;
      } else {
        if (widget.isDangerType!) {
          return colors.dangerButtonBackground;
        } else {
          return widget.defaults!.bgColor;
        }
      }
    }
  }

  _button_text(){
    return texts.buttonText(widget.text!,
        isSmall: widget.isSmall!,
        color: widget.isDangerType!
            ? colors.foreColorInverse
            : (widget.isSecondary!)
                ? widget.defaults!.secondaryForecolor
                : widget.defaults!.forecolor);
  }

  _onDone(){
    animController.reverse();

  }
}

class ButtonController {
  VoidCallback? onDone;
}

class MyButtonDefaults{
  Color bgColor;
  Color forecolor;
  Color secondaryColor;
  Color secondaryForecolor;

  MyButtonDefaults(
      {required this.bgColor,
      required this.forecolor,
      required this.secondaryColor,
      required this.secondaryForecolor});
}