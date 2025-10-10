import 'package:ev_point/controllers/station/station_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StationDetailScreen extends StatefulWidget {
  const StationDetailScreen({super.key});

  @override
  State<StationDetailScreen> createState() => _StationDetailScreenState();
}

class _StationDetailScreenState extends State<StationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StationDetailProvider(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("Expandable App Bar"),
                background: Image.network(
                  "https://via.placeholder.com/300",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            
          ],
        ),
      ),
    );
  }
}
