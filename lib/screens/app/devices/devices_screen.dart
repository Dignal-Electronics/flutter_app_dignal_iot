import 'package:flutter/material.dart';
import 'package:flutter_dignal_2025/models/models.dart';
import 'package:flutter_dignal_2025/providers/devices_provider.dart';
import 'package:flutter_dignal_2025/screens/app/screens.dart';
import 'package:provider/provider.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  static String route = "/app-devices";

  @override
  Widget build(BuildContext context) {
    final deviceProvider = Provider.of<DevicesProvider>(context);
    final devices = deviceProvider.devices;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispositivos'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                deviceProvider.getDevices();
              },
              icon: const Icon(
                Icons.replay,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, index) => CustomDeviceListTile(
          device: devices[index],
        ),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: devices.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final devicesProvider =
              Provider.of<DevicesProvider>(context, listen: false);
          devicesProvider.selectedDevice = Device();
          Navigator.of(context).pushNamed(DevicesFormScreen.route);
        },
      ),
    );
  }
}

class CustomDeviceListTile extends StatelessWidget {
  final Device device;

  const CustomDeviceListTile({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(device.name),
      subtitle: device.key == '' ? null : Text(device.key),
      leading: Icon(
        Icons.circle,
        color: device.active ? Colors.green : Colors.red,
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Editar dispositivo'),
                    onTap: () {
                      final devicesProvider =
                          Provider.of<DevicesProvider>(context, listen: false);
                      devicesProvider.selectedDevice = device;
                      Navigator.of(context)
                          .popAndPushNamed(DevicesFormScreen.route);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.bar_chart_outlined),
                    title: Text('Ver detalle'),
                    onTap: () {
                      final devicesProvider =
                          Provider.of<DevicesProvider>(context, listen: false);
                      devicesProvider.selectedDevice = device;
                      Navigator.of(context)
                          .popAndPushNamed(DevicesDetailScreen.route);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.do_not_disturb_alt_rounded),
                    title: Text(
                      'Deshabilitar dispositivo',
                      style: TextStyle(color: Colors.red.shade400),
                    ),
                    onTap: () {},
                  ),
                ],
              );
            });
      },
    );
  }
}
