import 'dart:convert';
import 'dart:developer';

import 'package:ev_point/services/supabase_manager.dart';
import 'package:ev_point/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:ev_point/models/station_model.dart';

class StationListProvider extends ChangeNotifier {
  StationListProvider() {
    _getAllStations();
  }

  List<Data>? _stationList;
  List<Data>? get stationList => _stationList;


  bool isLoading = false;

  _getAllStations() async {
    isLoading = true;
    notifyListeners();

    if (_stationList == null) {
      final response = await safeSupabaseCall(() async {
        return await SupabaseManager.supabaseClient
            .from('station')
            .select('id, name, address, location')
            .order('id');
      });

      if (response.isEmpty) {
        log("stations not found.");
        isLoading = false;
        notifyListeners();
      } else {
        StationModel stationModel = StationModel.fromJson(response);
        if (stationModel.success!) {
          _stationList = stationModel.data;
          notifyListeners();
        }
        log("station list: ${jsonEncode(response)}");

         isLoading = false;
        notifyListeners();
      }
    }
    else{
       isLoading = false;
        notifyListeners();
      log("list has data already. Did not call API.");
    }
  }
}
