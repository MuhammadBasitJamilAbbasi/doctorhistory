import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void ErrorhandlingDialoge (BuildContext context,String title,String message,String type)
{
  if(type=="S")
    {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: title,
        titleTextStyle: const TextStyle(color: Colors.black),
        desc: message,
        btnOkColor: Colors.red,
        btnOkOnPress: () {},
      ).show();
    }else
      {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.leftSlide,
          title: title,
          titleTextStyle: const TextStyle(color: Colors.black),
          desc: message,
          btnOkOnPress: () {},
        ).show();
      }

}



