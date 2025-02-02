import 'package:flutter/material.dart';
import 'package:flutter_dignal_2025/models/models.dart';
import 'package:flutter_dignal_2025/services/my_server.dart';

class DevicesProvider extends ChangeNotifier {
  DevicesProvider() {
    getDevices();
  }

  late Device selectedDevice;
  // List<Device> devices = List.generate(
  //   20,
  //   (index) => Device(
  //     id: index + 1,
  //     name: 'Device ${index + 1}',
  //     active: Random().nextBool(),
  //   ),
  // );

  List<Device> devices = [];

  bool _isLoading = false;
  get isLoading => _isLoading;
  set isLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  getDevices() async {
    _isLoading = true;
    notifyListeners();
    // await Future.delayed(Duration(seconds: 3));


    final devicesList = await MyServer().getDevices();

    if (devicesList == null) {
      return null;
    }

    devices = devicesList;

    _isLoading = false;
    notifyListeners();
  }
}
