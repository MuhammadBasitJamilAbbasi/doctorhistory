import 'package:flutter/material.dart';
class paitentdetailswidget extends StatelessWidget{
  String title,values;
  paitentdetailswidget({required this.title,required this.values});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
          Spacer(),
          Text(values,style: TextStyle(fontSize: 13),),
        ]
      ),
    );
  }

}