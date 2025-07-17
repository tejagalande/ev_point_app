
import 'package:ev_point/app.dart';
import 'package:ev_point/controllers/onboard_provider.dart';
import 'package:ev_point/controllers/signup_provider.dart';
import 'package:ev_point/services/supabase_manager.dart';
import 'package:ev_point/utils/size_config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';





void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await SupabaseManager().init();



 

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OnboardProvider(),
          
        ),
        ChangeNotifierProvider(
          create: (_) => SignupProvider(),
        )
      ],
      child: MyApp(),
    )
    );
}


