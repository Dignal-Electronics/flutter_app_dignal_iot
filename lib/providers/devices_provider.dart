import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dignal_2025/models/models.dart';
import 'package:flutter_dignal_2025/screens/app/screens.dart';
import 'package:flutter_dignal_2025/services/my_server.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


enum WebsocketConnectionStatus {
  online,
  offline
}

class DevicesProvider extends ChangeNotifier {
  DevicesProvider() {
    getDevices();
  }

  late Device selectedDevice;
  List<Device> devices = [];
  bool _isLoading = false;

  // websocket
  WebsocketConnectionStatus websocketConnection = WebsocketConnectionStatus.offline;
  double luminosity = 0;
  double temperature = 0;
  List<TemperatureSerie> temperatures = [
    TemperatureSerie(time: DateTime.now(), data: 0)
  ];
  bool led = false;
  final socket = MyServer().socket;

  get isLoading => _isLoading;
  set isLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  getDevices() async {
    _isLoading = true;
    notifyListeners();

    final devicesList = await MyServer().getDevices();

    if (devicesList == null) {
      return null;
    }

    devices = devicesList;

    _isLoading = false;
    notifyListeners();
  }


  void initSocket() {
    // Establecemos la conexión con el websocket.
    socket.connect();

    socket.onConnect((_) {
      print('Websocket conectado');

      socket.emit('devices', selectedDevice.key);
      websocketConnection = WebsocketConnectionStatus.online;
      notifyListeners();
      emitLed(false);
    });

    socket.onDisconnect((_) {
      print('Websocket desconectado');

      websocketConnection = WebsocketConnectionStatus.offline;
      notifyListeners();
    });

    socket.on('luminosidad', (data) {
      // Asignamos el valor recibido del dispositivo
      luminosity = data['value'];
      // Notificamos a todos los puntos donde se use este valor,
      // que el mismo se ha actualizado.
      notifyListeners();
    });

    socket.on('temperatura', (temp) {
      temperature = temp['value'];

      temperatures.add(
        TemperatureSerie(time: DateTime.now(), data: temp['value'])
      );

      notifyListeners();
    });

    socket.on('led', (data) {
      led = data['value'];
      notifyListeners();
    });
  }

  emitLed(status) {
    led = status;

    print('***IO.socker $socket');

    socket?.emit('led', status);
    notifyListeners();

    print('led $status');
  }
}
