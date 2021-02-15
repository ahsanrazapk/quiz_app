import 'package:flutter/material.dart';

Widget appBar(BuildContext context){
  return RichText(
    text: TextSpan(
        style: TextStyle(
          fontSize: 20.0,
        ),
        children: <TextSpan>[
          TextSpan(text: 'Quiz ' ,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black54,
                  fontWeight:FontWeight.w500)
          ),
          TextSpan(text: 'Hub' ,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ) ),
        ]
    ),
  );
}
Widget blueButton({BuildContext context,String label,buttonWidth}){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30),
    ),
    alignment: Alignment.center,
    width: buttonWidth!=null ? buttonWidth: MediaQuery.of(context).size.width-48,
    child: Text(label,style: TextStyle(fontSize:20.0,color: Colors.white, fontWeight: FontWeight.bold),),
  );
}