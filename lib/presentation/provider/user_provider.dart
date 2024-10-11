import 'package:flutter/material.dart';

import '../../data/datasource/remote_data_source.dart';
import '../../data/model/user_model.dart';



class RobotProvider with ChangeNotifier {
  List<Robot> _robots = [];
  bool _isLoading = false;
  String? _error;

  List<Robot> get robots => _robots;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final RobotService _robotService = RobotService();

  RobotProvider() {
    fetchRobots();
  }

  Future<void> fetchRobots() async {
    _isLoading = true;
    notifyListeners();

    try {
      _robots = await _robotService.fetchRobots();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}