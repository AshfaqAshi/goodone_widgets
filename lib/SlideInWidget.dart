import 'package:flutter/material.dart';
import 'package:goodone_widgets/IntroAnimWidget.dart';
class SlideInWidget extends StatefulWidget{
  Widget? child;
  int duration;
  int? delay;
  SlideInWidget({this.child, this.delay,this.duration=400});
  _textBoxState createState()=>_textBoxState();
}

class _textBoxState extends State<SlideInWidget>{
  bool showWidget=false;
  bool disposed=false;
  IntroAnimController controller=IntroAnimController();
  void initState(){

    super.initState();
    _startAnimation();
  }


  _startAnimation()async{

    Future.delayed(Duration(milliseconds: widget.delay!),(){
      if(!disposed){
        setState(() {
          showWidget=true;
        });
      }
    });
  }

  @override
  void dispose() {
    disposed=true;
    super.dispose();
  }
  Widget build(BuildContext context){
    if(showWidget)
      return IntroAnimWidget(
        showAnimationDuration: widget.duration,
        isBottomTop: true,
        controller: controller,
        child: widget.child,
      );
    else
      return Container();
  }
}