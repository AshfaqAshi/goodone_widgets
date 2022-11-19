import 'package:flutter/material.dart';
//import 'package:goodone_widgets/helpers/helper.dart';
import 'package:goodone_widgets/FancyClickWidget.dart';

class BorderChangingWidget extends StatefulWidget{
  double endRadius;
  Color color;
  bool isChatMessageBox;
  bool? isUserMessgae;
  bool waitForAnimation=false;
  Widget? child;
  VoidCallback? onClick;
  VoidCallback? onDoubleClick;
  bool noAnimation;
  bool noPadding;
  BorderChangingWidget({this.child,this.endRadius=10,this.color=Colors.white,this.onClick,this.isUserMessgae,this.isChatMessageBox=false,this.waitForAnimation=false,this.noPadding=false,
  this.noAnimation=false, this.onDoubleClick});


  _widgetState createState()=>_widgetState();
}

class _widgetState extends State<BorderChangingWidget> with TickerProviderStateMixin {
  late AnimationController borderController;
  AnimationController? colorController;
  AnimationController? sizeController;
  late Animation borderAnimation;
  late Animation sizeAnimation;
  Animation? colorAnimation;
  double opacity=1.0;
  bool disposed=false;
  bool startColorAnimation=false;

  void initState(){
    super.initState();


   //print('calling initState..');
    borderController=AnimationController(duration: Duration(milliseconds: 600),vsync: this)..addStatusListener((AnimationStatus status){
      if(status==AnimationStatus.completed){

      }
    });

    /*colorController=AnimationController(duration: Duration(milliseconds: 600),vsync: this)..addStatusListener((AnimationStatus status){
      if(status==AnimationStatus.completed){
        borderController.stop();
      }
    });*/


    borderAnimation=Tween<double>(begin: 150.0,end: widget.endRadius).animate(
      CurvedAnimation(parent: borderController,curve: Curves.fastOutSlowIn)
    );

   // colorAnimation=ColorTween(begin:widget.previousColor??widget.color,end: widget.color).animate(colorController);

    sizeAnimation=Tween<double>(begin: 0.3,end:1.0).animate(
        CurvedAnimation(parent: borderController,curve: Curves.fastOutSlowIn)
    );

    if(!widget.noAnimation){
      if(widget.waitForAnimation){
        Future.delayed(Duration(milliseconds: 200),(){
          if(!disposed) {
            borderController.forward();
          }
        });
      }else{
        borderController.forward();
      }
    }

    //sizeController.forward();
  }



  @override
  void dispose(){
    borderController.dispose();
    disposed=true;
    super.dispose();
  }
  Widget build(BuildContext context){
    //print('animation ${borderAnimation.value}');

    return GestureDetector(
      onTapDown: (TapDownDetails details){
      if(widget.onClick!=null){
        setState(() {
          opacity=0.3;
        });
      }

      },
      onTapUp: (TapUpDetails details){
        if(widget.onClick!=null) {
          setState(() {
            widget.onClick!();
            opacity = 1.0;
          });
        }
      },

      onDoubleTap: (){
        if(widget.onDoubleClick!=null){
          widget.onDoubleClick!();
        }
      },
      onTapCancel: (){
        if(widget.onClick!=null) {
          setState(() {
            opacity = 1.0;
          });
        }
      },
      child: AnimatedBuilder(
        animation: borderController,
        builder: (context, child){
          return  Padding(
            padding: widget.noPadding?EdgeInsets.zero: EdgeInsets.all(8.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 350),
              opacity: widget.noAnimation?1.0:opacity,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 120,
                ),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                    padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color:widget.color,
                    borderRadius:widget.isChatMessageBox? _getBorders():BorderRadius.circular(widget.noAnimation?20:borderAnimation.value)
                  ),
                  child: child,
                  ),
              ),

            ),
          );
        },

        child:  widget.noAnimation?widget.child:
        ScaleTransition(
              scale: sizeAnimation as Animation<double>,
              child:widget.child,

            ),

      ),
    );
  }

  _getBorders(){
    return BorderRadius.only(topLeft: widget.isUserMessgae!?Radius.circular(_getBorderValue()):Radius.zero,
    topRight:widget.isUserMessgae!?Radius.zero:Radius.circular(_getBorderValue()), bottomRight: Radius.circular(_getBorderValue()),
    bottomLeft: Radius.circular(_getBorderValue()));
  }

  _getBorderValue(){
    return widget.noAnimation?20.0:borderAnimation.value;
  }
}

class ColorController{
  bool? startAnimation;
  VoidCallback? tween;
}