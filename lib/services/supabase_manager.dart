import 'dart:developer';

import 'package:ev_point/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {

  static final SupabaseManager _instance = SupabaseManager._internal();

  factory SupabaseManager(){
    return _instance;
  }


  SupabaseManager._internal();


  late final SupabaseClient client;

  Future<void> init() async{
    await Supabase.initialize(
      url: Constants.supabaseUrl, anonKey: Constants.anonKey ?? "").then((value) {
        log("supabase client created: ${value.client.hashCode}");
      },).catchError( (error) {
        log("supabase client initialized error: $error");
      },);

    client = Supabase.instance.client;
  }

  static SupabaseClient get supabaseClient => _instance.client;
  
}