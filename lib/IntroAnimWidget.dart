import 'package:flutter/material.dart';
import 'package:goodone_widgets/helper.dart';

class IntroAnimWidget extends StatefulWidget{
  Widget child;
  bool isBottomTop;//Animation from bottom to top instead of from right to left
  IntroAnimController controller;
  VoidCallback onHidden;
  VoidCallback onShown;
  int showAnimationDuration,hideAnimationDuration;
  IntroAnimWidget({this.child,this.controller, this.isBottomTop=false,this.onHidden,this.onShown,this.showAnimationDuration=400,this.hideAnimationDuration=400,
  Key key}):super(key:key);

  _animState createState()=>_animState();
}
class _animState extends State<IntroAnimWidget> with TickerProviderStateMixin{
  Animation showAnim, hideAnim;
  Animation currentOpacityAnim, opacityShowAnim, opacityHideAnim;
  AnimationController showAnimController, hideAnimController;
  Offset showOffsetBegin, showOffsetEnd, hideOffsetBegin, hideOffsetEnd;
  bool show=true;


  void initState(){
    super.initState();
    _getOffset();

    showAnimController=AnimationController(duration: Duration(milliseconds: widget.showAnimationDuration),vsync: this)..addStatusListener((AnimationStatus status){
      if(status==AnimationStatus.completed){
        if(widget.onShown!=null)
          widget.onShown();
      }
    });


    hideAnimController=AnimationController(duration: Duration(milliseconds: widget.hideAnimationDuration),vsync: this)..addStatusListener((AnimationStatus status){
      if(status==AnimationStatus.completed){
        if(widget.onHidden!=null)
          widget.onHidden();
      }
    });

  //  print('showOffsetBegin x ${showOffsetBegin.dx} and y ${showOffsetBegin.dy} showOffsetEnd x ${showOffsetEnd.dx} and y ${showOffsetEnd.dy}');
    showAnim=Tween<Offset>(begin: showOffsetBegin, end: showOffsetEnd).animate(
      CurvedAnimation(parent: showAnimController, curve: Curves.fastOutSlowIn)
    );

    hideAnim=Tween<Offset>(begin: hideOffsetBegin, end: hideOffsetEnd).animate(
        CurvedAnimation(parent: hideAnimController, curve: Curves.fastOutSlowIn)
    );


    opacityHideAnim=Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(
        parent: showAnimController,
        curve:Interval(0.0,0.75)
    ))..addListener(()=>setState((){}));


    //opacity animation for the fade in effect of the new widgets coming when switching to Signup mode
    opacityShowAnim=Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
        parent: showAnimController,
        curve:Interval(0.0,0.50)
    ))..addListener(()=>setState((){}));

    widget.controller.hide=onDone;
    currentOpacityAnim=opacityShowAnim;
    showAnimController.forward();
  }

  _getOffset(){
    if(widget.isBottomTop){
      showOffsetBegin=Offset(0.0,1.0);
      showOffsetEnd=Offset(0.0,0.0);

      hideOffsetBegin=Offset(0.0,0.0);
      hideOffsetEnd=Offset(0.0,-1.0);
    }else{
      showOffsetBegin=Offset(1.0,0.0);
      showOffsetEnd=Offset(0.0,0.0);

      hideOffsetBegin=Offset(0.0,0.0);
      hideOffsetEnd=Offset(-1,0.0);
    }
  }

  onDone(){
    setState(() {
      show=false;
      currentOpacityAnim=opacityHideAnim;
      hideAnimController.reset();
      hideAnimController.forward();
    });
  }
  @override
  void dispose() {
    showAnimController.dispose();
    hideAnimController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context){
    return  AnimatedOpacity(
      opacity: currentOpacityAnim.value,
      duration: Duration(milliseconds: widget.showAnimationDuration>widget.hideAnimationDuration?widget.hideAnimationDuration:widget.showAnimationDuration),
      child: SlideTransition(
          position: show?showAnim:hideAnim,
          child: widget.child,
        ),
    );
  }

}


class IntroAnimController{
  VoidCallback hide;
}