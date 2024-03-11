import 'package:flutter/material.dart';

import '../constant/colors.dart';


// ignore: must_be_immutable
class CustomTextButton extends StatefulWidget {
  final Color backgroundColor;
  final double borderWidth;
  final Color borderColor;
  Color? textColor;
  final String text;
  Function() ? onTap;
  double? width;
  double? height;
  EdgeInsets? margin;
  double? fontSize;
  TextAlign? textAlign;
  double? padding;
  FontWeight? fontWeight;
  bool? center=true;
  double? borderCircularRadius = 12;
  CustomTextButton({Key? key,this.padding=5,this.borderCircularRadius =12 ,this.center=true,this.textAlign=TextAlign.center,this.fontSize=22,this.onTap,this.textColor=AppColors.white,this.width,this.height,required this.borderColor,required this.backgroundColor,required this.text, required this.borderWidth,this.margin,this.fontWeight}) : super(key: key);


  @override
  _CustomTextButton createState() => _CustomTextButton();
}

class _CustomTextButton extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 30,
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          height: widget.height,
          width: widget.width,
          margin: widget.margin,

          decoration: BoxDecoration(
            // ignore: unnecessary_null_comparison
              color: widget.backgroundColor== null ? Color(0xFFFA4A71): widget.backgroundColor ,
              borderRadius: BorderRadius.circular(widget.borderCircularRadius!),
              border: Border.all(
                // ignore: unnecessary_null_comparison
                  color: widget.borderColor== null ?Color(0xFFFFFFFF) : widget.borderColor,
                  width: widget.borderWidth
              )
          ),
          child: Padding(
            padding: EdgeInsets.all(widget.padding!),
            child: widget.center!?Center(
              child: Text(widget.text,style: TextStyle(
                  fontSize: widget.fontSize,
                  color: widget.textColor,
                  fontWeight: widget.fontWeight,
              ),textAlign: widget.textAlign,),
            ):Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.text,style: TextStyle(
                      fontSize: widget.fontSize,
                      color: widget.textColor,
                      fontWeight: widget.fontWeight,
                  ),textAlign: widget.textAlign,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final Color backgroundColor;
  final double borderWidth;
  final Color borderColor;
  Color? textColor;
  Function() ? onTap;
  double? width;
  double? height;
  EdgeInsets? margin;
  double? fontSize;
  double? padding;
  FontWeight? fontWeight;
  bool? center=true;
  double? borderCircularRadius = 12;
  IconData? iconData ;
  double? iconSize;
  CustomButton({Key? key,this.iconSize ,this.iconData=Icons.arrow_forward_ios_outlined,this.padding=5,this.borderCircularRadius =12 ,this.center=true,this.fontSize=22,this.onTap,this.textColor=AppColors.white,this.width,this.height,required this.borderColor,required this.backgroundColor, required this.borderWidth,this.margin,this.fontWeight}) : super(key: key);


  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 30,
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          height: widget.height,
          width: widget.width,
          margin: widget.margin,

          decoration: BoxDecoration(
            // ignore: unnecessary_null_comparison
              color: widget.backgroundColor== null ? Color(0xFFFA4A71): widget.backgroundColor ,
              borderRadius: BorderRadius.circular(widget.borderCircularRadius!),
              border: Border.all(
                // ignore: unnecessary_null_comparison
                  color: widget.borderColor== null ?Color(0xFFFFFFFF) : widget.borderColor,
                  width: widget.borderWidth
              )
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: widget.center!?Center(
              child: Icon(widget.iconData,color: AppColors.white,size: widget.iconSize,)
            ):Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(widget.iconData,color: AppColors.white,size :widget.iconSize)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
