
import 'package:ev_point/app.dart';
import 'package:ev_point/controllers/onboard_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OnboardProvider(),
          
        )
      ],
      child: MyApp(),
    )
    );
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             spacing: 10,
//             children: [
//               // Text("Demo", style: TextStyles.h1Regular48
              
//               //    ),
//               //    Text("Demo", style: TextStyles.h1Medium48
              
//               //    ),
//               //    Text("Demo", style: TextStyles.h1SemiBold48
              
//               //    ),
//               //    Text("Demo", style: TextStyles.h1Bold48
              
//               //    ),

//               CustomCircularLoader()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }