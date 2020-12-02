import 'package:flutter/material.dart';
//import 'package:hu/helpers/classes/User.dart';
//import 'package:hu/helpers/helper.dart';
class FancyClickWidget extends StatefulWidget{
  VoidCallback onClick;
  bool isScaleAnimation;
  double displacement;
  Widget child;
  FancyClickWidget({this.onClick, this.child,this.isScaleAnimation=true,this.displacement=0.25});

  _fancyClickState createState()=>_fancyClickState();
}

class _fancyClickState extends State<FancyClickWidget> with TickerProviderStateMixin {

  AnimationController scaleDownController, scaleUpController;
  Animation scaleUpAnimation, scaleDownAnimation;

  bool istapIn = false;
  bool isTapOut = false;
  double currentScaleValue=1.0;
  double opacity=1.0;
  bool aimationPlayed = true; //this is to bring the widget back to its normal condition after animation is played

  void initState() {
    super.initState();
    scaleDownController =
    AnimationController(duration: Duration(milliseconds: 150), vsync: this)
      ..addStatusListener(
              (AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                //set current value to 1 so that the ScaleUpController can start from first frame.
                currentScaleValue=1;
                istapIn = false;
                isTapOut=true;
                scaleUpController.reset();
                scaleUpController.forward();
              });
            }
          }
      );

    /*scaleDownController.addListener((){
     // print('currnt value $currentScaleValue');
      currentScaleValue=scaleDownController.value;
    });*/

    scaleUpController =
    AnimationController(duration: Duration(milliseconds: 150), vsync: this)
      ..addStatusListener(
              (AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              //setState(() {
               // aimationPlayed =
                //true; //Animation played should be made true only when the ScaleUp animation has completed
                //isTapOut = false;
                widget.onClick();
              //});
            }
          }
      );

    scaleUpAnimation = Tween<double>(begin: 0.75, end: 1).animate(
        CurvedAnimation(
            parent: scaleUpController, curve: Curves.fastOutSlowIn));
    /*slideRightAnimation = Tween<Offset>(begin: Offset(0.0,-widget.displacement), end: Offset(0.0,0.0)).animate(
        CurvedAnimation(
            parent: scaleUpController, curve: Curves.fastOutSlowIn));*/

    scaleDownAnimation = Tween<double>(begin: 1, end: 0.75).animate(
        CurvedAnimation(
            parent: scaleDownController, curve: Curves.fastOutSlowIn));
    /*slideLeftAnimation = Tween<Offset>(begin: Offset(0.0,0.0), end: Offset(0.0,-widget.displacement)).animate(
        CurvedAnimation(
            parent: scaleDownController, curve: Curves.fastOutSlowIn));*/


  }

  @override
  void dispose() {
    scaleDownController.dispose();
    scaleUpController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        //print('curScale value: $currentScaleValue');
        setState(() {
         // aimationPlayed = false;
          istapIn = true;
          isTapOut = false;
          if(widget.isScaleAnimation) {
            scaleDownController.reset();
            scaleDownController.forward();
          }else{
            opacity=0.6;
          }
        });
      },

        onTapCancel: (){
        //print('tap cancel');
         /*setState(() {
          if(widget.isScaleAnimation){
            aimationPlayed=true;
          }
         });*/
        },

      onTapUp: (TapUpDetails details) {
          /*setState(() {
            isTapOut = true;
            istapIn = false;
            if(widget.isSlideAnimation) {
              scaleUpController.reset();
              //scaleUp should start from exactly where scaleDown stopped
              //[from] takes a value between 0.0 and 1.0 which covers the entire animation.
              //i.e, [from] takes a value to begin the animation which shall be a percentage of the entire animation.
              //Here [currentScaleValue] gets updated on each frame of [scaleDownController].
              //[currentScaleValue] reperesents the percentaage completed of the [scaleDownAnimator]
              //therefore (1-currentScaleValue) is the percentage from where [scaleUpAnimator] should start playing

              if (currentScaleValue <= 0.4)
                currentScaleValue = 0.4;
              //A limit of 0.4 is given to the [currentScaleValue] because a minimum animation has to be played
              scaleUpController.forward(from: 1 - currentScaleValue);
            }else{
              opacity=1.0;
            }
          });*/
      },


      child:
          widget.isScaleAnimation?
      ScaleTransition(
        scale: (isTapOut) ? scaleUpAnimation : scaleDownAnimation,
        child: widget.child,
      ):
              AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                opacity: opacity,
                child: widget.child,
              )
    );
  }

}