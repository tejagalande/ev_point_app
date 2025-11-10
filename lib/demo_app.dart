import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DateTime> selectedDates = [];
  DateTime? selectedDate ;
  DateTime? _currentDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Calendar"),
      ),
      body: Center(
        child: Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = date);
      },
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      selectedDayButtonColor: Colors.brown.shade200,
      thisMonthDayBorderColor: Colors.grey,
      pageSnapping: true,
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
      // customDayBuilder: (   /// you can provide your own build function to make custom day containers
      //   bool isSelectable,
      //   int index,
      //   bool isSelectedDay,
      //   bool isToday,
      //   bool isPrevMonthDay,
      //   TextStyle textStyle,
      //   bool isNextMonthDay,
      //   bool isThisMonthDay,
      //   DateTime day,
      // ) {
      //     /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
      //     /// This way you can build custom containers for specific days only, leaving rest as default.

      //     // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
      //     if (day.day == 15) {
      //       return Center(
      //         child: Icon(Icons.local_airport),
      //       );
      //     } else {
      //       return null;
      //     }
      // },
      weekFormat: false,
      // markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate,
      daysHaveCircularBorder: null, /// null for not rendering any border, true for circular border, false for rectangular border
    ),
  )
      ),
    );
  }
}