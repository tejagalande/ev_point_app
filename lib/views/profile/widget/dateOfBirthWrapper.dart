import 'package:flutter/material.dart';

class Dateofbirthwrapper extends FormField<String> {
  Dateofbirthwrapper({
    required TextEditingController controller,
    required String? Function(String?) validator,
    Key? key,
    
    required Widget Function(
      TextEditingController controller,
      String? errorText,
      TextStyle? style,
    )
    builder,
    this.style
  
  }) : super(
    
         key: key,
         
         validator: validator,
         initialValue: controller.text,
         builder: (field) {
           controller.addListener(() {
             field.didChange(controller.text);
           });
           return builder(controller, field.errorText, style);
         },
       );

       final TextStyle? style;
}
