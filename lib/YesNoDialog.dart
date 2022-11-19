import 'package:flutter/material.dart';
//import 'package:hu/helpers/db.dart';
import 'package:goodone_widgets/helper.dart';
import 'package:goodone_widgets/IntroAnimWidget.dart';

import 'MyButton.dart';
import 'RoundedTextBox.dart';
import 'SlideInWidget.dart';
class YesNoDialog extends StatefulWidget{
  String message;
  String header;
  YesNoDialog(this.header,this.message);
  _dialogState createState()=>_dialogState();
}

class _dialogState extends State<YesNoDialog>{
  IntroAnimController introController=IntroAnimController();

  Future<bool> _onBack()async{
    Navigator.pop(context,false);
    return false;
  }
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: _onBack,
      child: IntroAnimWidget(
        controller: introController,
        child: Dialog(
            elevation: 12,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            ),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colors.primaryColor
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SlideInWidget(
                    delay: 50,
                    child:
                    texts.titleText(widget.header),
                  ),
                  verticalSpace(height: 12),
                  SlideInWidget(
                    delay: 120,
                    child: Opacity(
                      opacity: 0.6,
                      child: texts.infoPageText(widget.message),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SlideInWidget(
                        delay: 200,
                        child: MyButton(
                          text: 'Yes',
                          onClick: (){
                            Navigator.pop(context,true);
                          },
                        ),
                      ),

                      SlideInWidget(
                        delay: 200,
                        child: MyButton(
                          isSecondary: true,
                          text: 'No',
                          onClick: (){
                            Navigator.pop(context,false);
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}