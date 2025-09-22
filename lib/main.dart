
import 'package:ev_point/app.dart';
import 'package:ev_point/controllers/home/station_list_provider.dart';
import 'package:ev_point/controllers/home/station_map_provider.dart';
import 'package:ev_point/controllers/home_provider.dart';
import 'package:ev_point/controllers/main_provider.dart';
import 'package:ev_point/controllers/onboardProfile_provider.dart';
import 'package:ev_point/controllers/onboard_provider.dart';
import 'package:ev_point/controllers/selfieCamera_provider.dart';
import 'package:ev_point/controllers/signup_provider.dart';
import 'package:ev_point/services/supabase_manager.dart';
import 'package:ev_point/utils/shared_pref.dart';
import 'package:ev_point/utils/size_config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';





void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await SupabaseManager().init();
  await SharedPref.init();

 

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OnboardProvider(),
          
        ),
        ChangeNotifierProvider(
          create: (_) => SignupProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OnboardprofileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SelfiecameraProvider(),
        ),
        ChangeNotifierProvider(create:(context) => MainProvider(),),
        ChangeNotifierProvider(create:(context) => HomeProvider(),),
        ChangeNotifierProvider(create:(context) => StationListProvider(),),
        ChangeNotifierProvider(create:(context) => StationMapProvider(),),
      ],
      child: MyApp(),
    )
    );
}


