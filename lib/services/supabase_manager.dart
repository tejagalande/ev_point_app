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
      url: Constants.supabaseUrl, anonKey: Constants.anonKey ?? "");

    client = Supabase.instance.client;
  }

  static SupabaseClient get supabaseClient => _instance.client;
  
}