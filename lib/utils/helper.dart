import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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


Future<Map<String, dynamic>> safeSupabaseCall(Future<dynamic> Function() request) async {
  try {
    final data = await request();
    return {
      "success": true,
      "status_code": 200,
      "message": "Fetched data successfully",
      "data": data,
    };
  } on PostgrestException catch (error) {
      // switch (error.code) {
      //   case '400':
      //     print("Bad Request: ${error.message}");
      //     break;
      //   case '401':
      //     print("Unauthorized: Please log in again.");
      //     break;
      //   case '404':
      //     print("Not Found: ${error.message}");
      //     break;
      //   case '500':
      //     print("Server error: ${error.message}");
      //     break;
      //   default:
      //     print("Error: ${error.message}");
      // }
    return {
      "success": false,
      "status_code": int.tryParse(error.code ?? '400') ?? 400,
      "message": error.message,
      "data": null,
    };
  } catch (error) {
    return {
      "success": false,
      "status_code": 500,
      "message": "Unexpected error occurred",
      "data": null,
    };
  }
}
