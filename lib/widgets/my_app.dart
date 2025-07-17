// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: OnboardingScreen(),
//     );
//   }
// }

// class OnboardingScreen extends StatefulWidget {
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _controller = PageController();
//   bool isLastPage = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           PageView(
//             controller: _controller,
//             onPageChanged: (index) {
//               setState(() {
//                 isLastPage = index == 2;
//               });
//             },
//             children: [
//               buildPage(
//                 color: Colors.blueAccent,
//                 title: "Welcome",
//                 description: "Find EV charging stations easily",
//               ),
//               buildPage(
//                 color: Colors.green,
//                 title: "Real-time Status",
//                 description: "Check availability in real-time",
//               ),
//               buildPage(
//                 color: Colors.deepPurple,
//                 title: "Get Started",
//                 description: "Join us and go electric!",
//               ),
//             ],
//           ),
//           Positioned(
//             bottom: 80,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: SmoothPageIndicator(
//                 controller: _controller,
//                 count: 3,
//                 effect: WormEffect(
//                   dotColor: Colors.grey,
//                   activeDotColor: Colors.white,
//                   dotHeight: 12,
//                   dotWidth: 12,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             right: 20,
//             child: isLastPage
//                 ? ElevatedButton(
//                     onPressed: () {
//                       // Navigate to home screen
//                     },
//                     child: Text("Get Started"),
//                   )
//                 : TextButton(
//                     onPressed: () {
//                       _controller.nextPage(
//                         duration: Duration(milliseconds: 500),
//                         curve: Curves.easeInOut,
//                       );
//                     },
//                     child: Text("Next"),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildPage({required Color color, required String title, required String description}) {
//     return Container(
//       color: color,
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(40.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.ev_station, size: 100, color: Colors.white),
//               SizedBox(height: 30),
//               Text(title, style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
//               SizedBox(height: 20),
//               Text(description, style: TextStyle(color: Colors.white70, fontSize: 18), textAlign: TextAlign.center),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void main() => runApp(MaterialApp(home: OTPPage()));

// class OTPPage extends StatefulWidget {
//   @override
//   State<OTPPage> createState() => _OTPPageState();
// }

// class _OTPPageState extends State<OTPPage> {
//   final int _otpLength = 6;

//   late List<TextEditingController> _controllers;
//   late List<FocusNode> _focusNodes;

//   @override
//   void initState() {
//     super.initState();
//     _controllers = List.generate(_otpLength, (_) => TextEditingController());
//     _focusNodes = List.generate(_otpLength, (_) => FocusNode());
//   }

//   @override
//   void dispose() {
//     _controllers.forEach((c) => c.dispose());
//     _focusNodes.forEach((f) => f.dispose());
//     super.dispose();
//   }

//   void _onChanged(String value, int index) {
//     if (value.length == 1) {
//       if (index + 1 < _otpLength) {
//         FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
//       } else {
//         FocusScope.of(context).unfocus(); // All done
//       }
//     }
//   }

//   void _onKey(RawKeyEvent event, int index) {
//     if (event is RawKeyDownEvent &&
//         event.logicalKey == LogicalKeyboardKey.backspace) {
//       if (_controllers[index].text.isEmpty && index > 0) {
//         FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
//         _controllers[index - 1].clear();
//       }
//     }
//   }

//   Widget _buildOtpField(int index) {
//     return SizedBox(
//       width: 50,
//       child: RawKeyboardListener(
//         focusNode: FocusNode(), // A dummy node for RawKeyboardListener
//         onKey: (event) => _onKey(event, index),
//         child: TextField(
//           controller: _controllers[index],
//           focusNode: _focusNodes[index],
//           keyboardType: TextInputType.number,
//           textAlign: TextAlign.center,
//           maxLength: 1,
//           style: TextStyle(fontSize: 24),
//           decoration: InputDecoration(counterText: ''),
//           onChanged: (value) => _onChanged(value, index),
//           inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Enter OTP')),
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(_otpLength, (index) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: _buildOtpField(index),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'dart:io' show Platform;

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Android settings
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   // iOS settings (optional)
//   final DarwinInitializationSettings initializationSettingsDarwin =
//       DarwinInitializationSettings();

//   // Initialize settings
//   final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsDarwin,
//   );

//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//   );

//   await requestNotificationPermissions();


//   runApp(MyApp());
// }

// Future<void> requestNotificationPermissions() async {
//   if (Platform.isAndroid) {
//     final androidPlugin = flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    
//     final granted = await androidPlugin?.requestNotificationsPermission();
//     print('Android notification permission granted: $granted');
//   }

//   if (Platform.isIOS) {
//     final iosPlugin = flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    
//     final granted = await iosPlugin?.requestPermissions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     print('iOS notification permission granted: $granted');
//   }
// }



// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Local Notification Demo',
//       home: Scaffold(
//         appBar: AppBar(title: Text('Local Notification')),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () async {
//               await showSimpleNotification();
//             },
//             child: Text('Show Notification'),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> showSimpleNotification() async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'channel_id',
//       'channel_name',
//       channelDescription: 'channel_description',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const NotificationDetails notificationDetails = NotificationDetails(
//       android: androidDetails,
//     );

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Hello!',
//       'This is a local notification',
//       notificationDetails,
//     );
//   }
// }

