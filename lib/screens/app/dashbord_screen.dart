import 'package:flutter/material.dart';
import 'package:flutter_dignal_2025/providers/devices_provider.dart';
import 'package:flutter_dignal_2025/providers/users_provider.dart';
import 'package:flutter_dignal_2025/screens/app/screens.dart';
import 'package:flutter_dignal_2025/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static String route = "/app-dashboard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const _DashboardBody(),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody();

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsersProvider>(context).users;
    final devices = Provider.of<DevicesProvider>(context).devices;
    final usersRoute = UsersScreen.route;
    final devicesRoute = DevicesScreen.route;

    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      padding: const EdgeInsets.all(20),
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pushNamed(usersRoute),
          child: CustomSectionDataCard(
            value: "${users.length}",
            color: Colors.red.shade200,
            section: 'Usuarios',
            icon: Icons.people,
          ),
        ),
        InkWell(
          onTap: () => Navigator.of(context).pushNamed(devicesRoute),
          child: CustomSectionDataCard(
            value: "${devices.length}",
            color: Colors.purple.shade200,
            icon: Icons.memory,
            section: 'Dispositivos',
          ),
        ),
      ],
    );
  }
}

class CustomSectionDataCard extends StatelessWidget {
  final String value;
  final String section;
  final Color color;
  final IconData? icon;

  const CustomSectionDataCard({
    super.key,
    required this.value,
    this.section = '',
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 30,
                ),
              if (icon != null && section.isNotEmpty)
                const SizedBox(
                  width: 8,
                ),
              if (section.isNotEmpty)
                Text(
                  section,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
