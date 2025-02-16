import 'package:flutter/material.dart';
import 'package:flutter_dignal_2025/screens/app/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 100,
            child: Center(
              child: Image.asset('assets/logo.png'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () => Navigator.of(context).pop(),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people_alt_outlined),
            title: Text('Usuarios'),
            trailing: Icon(Icons.chevron_right),
            onTap: () =>
                Navigator.of(context).popAndPushNamed(UsersScreen.route),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.memory),
            title: Text('Dispositivos'),
            trailing: Icon(Icons.chevron_right),
            onTap: () =>
                Navigator.of(context).popAndPushNamed(DevicesScreen.route),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar sesión'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              await prefs.remove('user');
              await prefs.remove('username');
              await prefs.remove('id');
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacementNamed(LoginScreen.route);
            },
          ),
        ],
      ),
    );
  }
}
