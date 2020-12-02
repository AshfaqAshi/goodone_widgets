import 'package:flutter/material.dart';
import 'package:goodone_widgets/helper.dart';

class RoundedTextBox extends StatefulWidget{
  TextEditingController txtController;
  String hintText;
  double borderRadius;
  String labelText;
  String helperText;
  String prefixText;
  String suffixText;
  IconData prefixIcon;
  IconData suffixIcon;
  VoidCallback suffixIconClick;
  Function(String) onTextChange;
  bool isMultiLine=false;
  bool isEnabled;
  int maxLines;
  FocusNode focusNode;
  bool isNumber;
  bool isObscured;
  bool needPadding;
  RoundedTextBoxDefaults defaults;
  TextAlign textAlign;
  double fontSize;
  TextDirection textDirection;
  bool isBold;
  RoundedTextBox({this.txtController, this.hintText, this.isMultiLine=false, this.maxLines, this.borderRadius,
                 this.labelText='',this.prefixIcon, this.helperText='', this.prefixText='',this.focusNode,this.needPadding=true,
                  this.isEnabled=true,this.isObscured=false,this.isNumber=false, this.suffixIcon, this.suffixIconClick,this.defaults,this.textAlign,
  this.fontSize=17,this.isBold=false,this.suffixText,this.onTextChange,this.textDirection=TextDirection.ltr});

  _textBoxState createState()=>_textBoxState();
}

class _textBoxState extends State<RoundedTextBox>{

  Widget build(BuildContext context){
    OutlineInputBorder border=OutlineInputBorder(
        borderSide: BorderSide(width: 1, color:widget.defaults.borderColor??colors.secondaryColor),
        borderRadius: BorderRadius.circular(widget.borderRadius==null?20:widget.borderRadius));

    return Padding(
      padding: widget.needPadding?EdgeInsets.all(8.0):EdgeInsets.zero,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 100
        ),
        //height:(widget.helperText=='')?50:70,
        child: TextField(
          controller: widget.txtController,
          focusNode: widget.focusNode,
          keyboardType: (widget.isMultiLine)?TextInputType.multiline:(widget.isNumber)?TextInputType.number:TextInputType.text,
          obscureText: widget.isObscured,
          maxLines: (widget.isMultiLine)?widget.maxLines:1,
          textAlign: widget.textAlign??TextAlign.left,
          textDirection: widget.textDirection,
          style: TextStyle(color: widget.defaults.textColor??colors.foreColor,fontSize: widget.fontSize,fontWeight: widget.isBold?FontWeight.bold:FontWeight.normal),
          enabled: widget.isEnabled,
          onChanged: (newText){
            if(widget.onTextChange!=null)
              widget.onTextChange(newText);
          },
          decoration: InputDecoration(
            labelText: widget.labelText==''?null:widget.labelText,
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
              prefixText: (widget.prefixText=='')?null:widget.prefixText,
              prefixStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              suffixText: widget.suffixText,
              suffixStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              helperText: widget.helperText==''?null:widget.helperText,

              prefixIcon: widget.prefixIcon==null?null:Icon(widget.prefixIcon,color: widget.defaults.iconColor??colors.primaryColor,),
              suffixIcon: widget.suffixIcon==null?null:IconButton(onPressed: ()=>widget.suffixIconClick(),icon:
                Icon(widget.suffixIcon,color: widget.defaults.iconColor??colors.primaryColor,size: 30,),),
              filled: false,
              fillColor: widget.defaults.fillColor??colors.bgColor,
              contentPadding: new EdgeInsets.symmetric(vertical:12,horizontal: 12),
              border: border,
            enabledBorder: border
          ),
        ),
      ),
    );
  }
}

class RoundedTextBoxDefaults{
  Color textColor;
  Color iconColor;
  Color fillColor;
  Color borderColor;
  RoundedTextBoxDefaults({this.textColor, this.iconColor,this.fillColor,this.borderColor});
}