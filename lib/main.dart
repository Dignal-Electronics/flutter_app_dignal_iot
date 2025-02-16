import 'package:flutter/material.dart';
import 'package:flutter_dignal_2025/providers/devices_provider.dart';
import 'package:flutter_dignal_2025/providers/estados_provider.dart';
import 'package:flutter_dignal_2025/providers/users_provider.dart';
import 'package:flutter_dignal_2025/screens/app/screens.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EstadosProvider(),
        ),
        ChangeNotifierProvider(create: ((context) => UsersProvider())),
        ChangeNotifierProvider(create: ((context) => DevicesProvider())),
      ],
      child: MaterialApp(
        title: 'App Dignal',
 
        theme: ThemeData.dark(),

        initialRoute: LoginScreen.route,
        routes: {
          LoginScreen.route: (context) => LoginScreen(),
          DashboardScreen.route: (context) => DashboardScreen(),
          UsersScreen.route: (context) => UsersScreen(),
          UsersFormScreen.route: (context) => UsersFormScreen(),
          DevicesScreen.route: (context) => DevicesScreen(),
          DevicesFormScreen.route: (context) => DevicesFormScreen(),
          DevicesDetailScreen.route: (context) => DevicesDetailScreen(),
        },
      ),
    );
  }
}
