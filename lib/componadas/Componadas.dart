import 'package:flutter/material.dart';

Future Nevigator({ page, context, boolen=false}){
  return Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=> page),(Route route)=>boolen);
}