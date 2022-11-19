import 'package:flutter/material.dart';

verticalSpace({double height=6}){
  return SizedBox(
    height:height ,
    width: 1,
  );
}


class texts{

  static Widget linkText(String link){
    return Text(link,style: TextStyle(decoration: TextDecoration.underline, color: Colors.blueAccent, fontWeight: FontWeight.bold),);
  }

  static Widget specialMessage(String text){
    return Opacity(
      opacity: 0.5,
      child: Text(text, maxLines:null,style: TextStyle(color:colors.foreColor,
          fontStyle: FontStyle.italic
      ),),
    );
  }

  static Widget dateText(String date,{bool isUread=false}){
    return Text(date, style: TextStyle(color:isUread?colors.unread_date_color:colors.dateColor,
        fontStyle: FontStyle.italic, fontSize: 11),);
  }

  static messageText(String message,{bool isUnread=false}){
    return Text(message, maxLines:null,style: TextStyle(color:isUnread?colors.unreadMessageTextColor:colors.foreColor,
        fontWeight: isUnread?FontWeight.bold:FontWeight.normal
    ),);
  }

  static chatHeadMessage(String message,{bool isUnread=false}){
    return Text(message, maxLines:null,style: TextStyle(color:isUnread?colors.unreadMessageTextColor:colors.foreColor,
        fontWeight: isUnread?FontWeight.bold:FontWeight.normal
    ),overflow: TextOverflow.ellipsis,);
  }

  static postBoldText(String boldText, String text, {double fontSize=23, Color color}){
    //List<String> boldTexts=text.split('/\{(.*?))\}');
    return RichText(
        text:TextSpan(text: text,
            children: <TextSpan>[
              TextSpan(text: boldText, style: TextStyle(fontWeight: FontWeight.bold))
            ])
    );
  }

  static preBoldText(String boldText, String text, {double fontSize=23, Color color}){
    //List<String> boldTexts=text.split('/\{(.*?))\}');
    return RichText(
        text:TextSpan(text: boldText,
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(text: text,)
            ])
    );
  }

  static messageHeaderText(String header,{bool isUnread=false}){
    return Text(header, style: TextStyle(color:isUnread?colors.secondaryColor:colors.foreColor,
        fontWeight: FontWeight.bold, fontSize: 16),);
  }

  static footerLabelText(String label, bool isSelected){
    return Text(label,style: TextStyle(fontSize: 12, color: isSelected?colors.secondaryColor:colors.foreColorInverse),);
  }

  static buttonText(String text,{Color color, bool isSmall=false}){
    return Text(text,style: TextStyle(fontSize: isSmall?14:16, fontWeight: FontWeight.normal,color: color??colors.foreColor),);
  }

  static titleText(String text,{double fontSize=23, Color color, }){
    return Text(text,style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color:color??colors.foreColorInverse,),);
  }

  static infoPageText(String text){
    return Text(text,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colors.foreColorInverse,),textAlign: TextAlign.left,maxLines: null,);
  }

  static plainText(String text,{bool isBold=false, double size=14, Color color, bool isMultiLine=false, isItalic=false}){
    return Text(text,style: TextStyle(fontWeight: isBold?FontWeight.bold:FontWeight.normal, fontSize: size,color: color??colors.foreColor, fontStyle: isItalic?FontStyle.italic:FontStyle.normal),maxLines: isMultiLine?null:1,);
  }


}

class colors{
  static Color primaryColor= Color(0xFF232F34);
  static Color card_background=Color(0xffffffff);
  static Color secondaryColor=Color(0xffDFCC25);
  static Color bgColor = Color(0xffB4B3B3);
  static const Color foreColor=Color(0xff272626);
  static Color foreColorInverse = Color(0xffFFFFFF);
  static Color buttonBackground_ok = Color(0xff920084);
  static Color dateColor=Color(0xff5C5C5C);
  static Color unread_date_color=Color(0xff4E6873);
  static Color dateColorInverse=Color(0xff626262);
  static Color searchForeColor=Color(0xff000000);
  static Color userMessageBackground=Color(0xff6990A0);
  static Color partnerMessageBackground=Color(0xffFFFFFF);
  static Color buttonSecondary=Color(0xffACACAC);
  static Color topicTileParticipants=Color(0xff1F9541);
  static Color subscribedTopicBg=Color(0xffD3D4D5);

  //static Color unreadMessageTextColor=Color(0xff028810);
  static Color unreadMessageTextColor=Color(0xffffffff);
  static Color userMessageDeliveredStatus=Color(0xffFFBE5A);
  static Color dangerButtonBackground=Color(0xffFA0000);

  static var userMessageGradients=[Color(0xff055D17), Color(0xff037219)];
  static var partnerMessageGradients=[Color(0xff8E8E8E), Color(0xff9E9B9B),Color(0xffAAA7A7)];
  //Material color
  static int _r=35, _g=47, _b=52;
  static Map<int, Color> materialColorCode =
  {
    50:Color.fromRGBO(_r,_g,_b, .1),
    100:Color.fromRGBO(_r,_g,_b, .2),
    200:Color.fromRGBO(_r,_g,_b, .3),
    300:Color.fromRGBO(_r,_g,_b, .4),
    400:Color.fromRGBO(_r,_g,_b, .5),
    500:Color.fromRGBO(_r,_g,_b, .6),
    600:Color.fromRGBO(74,101,114, .7),
    700:Color.fromRGBO(52,73,85, .8),
    800:Color.fromRGBO(_r,_g,_b, .9),
    900:Color.fromRGBO(_r,_g,_b, 1),
  };

  static MaterialColor primeswatch = MaterialColor(0xFF232F34, materialColorCode);


  static Color lighten(Color color, [double amount = .1]) {
    ///returns a lighter version of the given color
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}