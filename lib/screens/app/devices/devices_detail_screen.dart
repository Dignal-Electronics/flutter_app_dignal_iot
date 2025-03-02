import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dignal_2025/providers/devices_provider.dart';
import 'package:flutter_dignal_2025/widgets/custom_pretty_gauge.dart';
import 'package:flutter_dignal_2025/widgets/icon_buttom_notification.dart';
import 'package:flutter_dignal_2025/widgets/modal_bottom_sheet_messages.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:provider/provider.dart';

class DevicesDetailScreen extends StatelessWidget {
  const DevicesDetailScreen({super.key});

  static String route = "/app-devices-detail";


  void _showModalBottomOpenai(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ModalBottomSheetMessages();
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final devicesProvider = Provider.of<DevicesProvider>(context, listen: true);
    devicesProvider.initSocket();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dispositivo: ${devicesProvider.selectedDevice.key}'),
        actions: [
          IconButtomNotification(
            onPressed: () {
              _showModalBottomOpenai(context);
            },
          )
        ],
      ),
      body: _DeviceDetail(),
    );
  }
}


class TemperatureSerie {
  final DateTime time;
  final double data;

  TemperatureSerie({required this.time, required this.data});
}

class _DeviceDetail extends StatelessWidget {
  const _DeviceDetail({super.key});

  Color getColorStatus(status) {
    // status = online | offline
    if (status == WebsocketConnectionStatus.online) {
      return Colors.green;
    }

    if (status == WebsocketConnectionStatus.offline) {
      return Colors.red;
    }

    return Colors.amber;
  }


  String getStatus(status) {
    if (status == WebsocketConnectionStatus.online) {
      return 'Conectado';
    }

    if (status == WebsocketConnectionStatus.offline) {
      return 'Desconectado';
    }

    return 'Desconocido';
  }

  @override
  Widget build(BuildContext context) {

    final devicesProvider = Provider.of<DevicesProvider>(context, listen: true);
    bool led = devicesProvider.led;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Text(getStatus(devicesProvider.websocketConnection)),
                      Icon(
                        Icons.circle,
                        color: getColorStatus(devicesProvider.websocketConnection),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Text('Led'),
                      Switch(
                        value: led,
                        onChanged: (value) {
                          devicesProvider.emitLed(value);
                        }
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CustomPrettyGauge(
                    title: 'Luminosidad',
                    value: devicesProvider.luminosity,
                    maxValue: 1023,
                    unitValue: 'lm',
                    segments: [
                      GaugeSegment('Low', devicesProvider.luminosity, Colors.yellow),
                      GaugeSegment('Medium', 1023 - devicesProvider.luminosity, Colors.blueGrey),
                    ],
                  ),
                ),
                Expanded(
                  child: CustomPrettyGauge(
                    title: 'Temperatura',
                    value: devicesProvider.temperature,
                    unitValue: '°',
                    segments: [
                      GaugeSegment('Low', 20, Colors.lightBlueAccent),
                      GaugeSegment('Low', 20, Colors.yellow),
                      GaugeSegment('Low', 20, Colors.green),
                      GaugeSegment('Low', 20, Colors.orange),
                      GaugeSegment('Medium', 20, Colors.red),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 300,
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(
                    border: Border.all(
                      color: Colors.white,
                      width: 3
                    )
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: devicesProvider.temperatures
                        .map(
                          (ts) => FlSpot(
                            ts.time.millisecondsSinceEpoch.toDouble(),
                            ts.data
                          )
                        )
                        .toList(),
                      // spots: [
                      //   FlSpot(1, 1),
                      //   FlSpot(20, 10),
                      //   FlSpot(30, 5),
                      // ]
                    )
                  ]
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}