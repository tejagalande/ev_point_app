import 'dart:math';

import 'package:flutter/material.dart';

extension NumberToAsterikExtension on String{
  String numberToAsterik(String value){
    String output = "";
    for (var i = 0; i < value.length; i++) {
      if(i <= 6){
        output = '*';
      }
      else{
        output = value[i];
      }
    }
    return output;
  }
}