import 'package:flutter/material.dart';
import 'package:goodone_widgets/helper.dart';
import 'package:goodone_widgets/FancyClickWidget.dart';
import 'package:goodone_widgets/SlideInWidget.dart';

class GenderSelector extends StatefulWidget{
  Function(String) onSelected;
  int selectedGenderCode;
  GenderSelector(this.selectedGenderCode,{this.onSelected});

  _genderState createState()=>_genderState();

}

class _genderState extends State<GenderSelector>{
  double genderIconWidth=20;

  Widget build(BuildContext context){
    return
        Column(
          
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: texts.plainText('Choose your gender',isBold: true),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(

                  children: <Widget>[

                    SlideInWidget(
                      delay: 0,
                      child: texts.plainText(widget.selectedGenderCode==0?'Male':''),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            widget.selectedGenderCode=0;
                            widget.onSelected('Male');
                          });
                        },
                        child: SizedBox(
                          width: genderIconWidth,
                          height: _getMaleHeight(genderIconWidth),
                          child: Image.asset('assets/images/gender_male.png',fit: BoxFit.fill,),
                        ),
                      ),
                    ),

                    AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      width: widget.selectedGenderCode==-1?0:widget.selectedGenderCode==0?30:0,
                      height:  widget.selectedGenderCode==-1?0:widget.selectedGenderCode==0?5:0,
                      color: (widget.selectedGenderCode==0)?colors.primaryColor:colors.secondaryColor,
                      //alignment: (selectedGenderCode==0)?Alignment.centerLeft:Alignment.centerRight,
                    ),
                  ],
                ),

                //leave some space
                SizedBox(
                  width: 12,
                ),
                Column(

                  children: <Widget>[

                    SlideInWidget(
                      delay: 0,
                      child: texts.plainText(widget.selectedGenderCode==1?'Female':''),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            widget.selectedGenderCode=1;
                            widget.onSelected('Female');
                          });
                        },
                        child: SizedBox(
                          width: genderIconWidth,
                          height: _getFemaleHeight(genderIconWidth),
                          child: Image.asset('assets/images/gender_female.png',fit: BoxFit.fill,),
                        ),
                      ),
                    ),

                    AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      width:  widget.selectedGenderCode==-1?0:widget.selectedGenderCode==1?30:0,
                      height:  widget.selectedGenderCode==-1?0:widget.selectedGenderCode==1?5:0,
                      color: (widget.selectedGenderCode==1)?colors.primaryColor:colors.secondaryColor,
                      //alignment: (selectedGenderCode==0)?Alignment.centerLeft:Alignment.centerRight,
                    ),
                  ],
                )
              ],
            )
          ],
        );




  }

  _getMaleHeight(double width){
    double ratio=0.4211663;
    double height=width/ratio;
    return height;
  }

  _getFemaleHeight(double width){
    double ratio=0.476190;
    double height=width/ratio;
    return height;
  }
}