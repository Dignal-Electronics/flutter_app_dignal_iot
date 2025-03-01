import 'package:flutter/material.dart';
import 'package:flutter_dignal_2025/providers/devices_provider.dart';
import 'package:flutter_dignal_2025/providers/estados_provider.dart';
import 'package:flutter_dignal_2025/providers/users_provider.dart';
import 'package:flutter_dignal_2025/screens/estados_provider_screen.dart';
import 'package:flutter_dignal_2025/screens/estados_screen.dart';
import 'package:flutter_dignal_2025/screens/formularios_screen.dart';
import 'package:flutter_dignal_2025/screens/listview_screen.dart';
import 'package:flutter_dignal_2025/screens/mensajes_screen.dart';
import 'package:flutter_dignal_2025/screens/widgets_estructura_screen.dart';
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

        debugShowCheckedModeBanner: false,

        initialRoute: LoginScreen.route,
        routes: {
          //Pantallas de Aplicacion
          LoginScreen.route: (context) => LoginScreen(),
          DashboardScreen.route: (context) => DashboardScreen(),
          UsersScreen.route: (context) => UsersScreen(),
          UsersFormScreen.route: (context) => UsersFormScreen(),
          DevicesScreen.route: (context) => DevicesScreen(),
          DevicesFormScreen.route: (context) => DevicesFormScreen(),
          DevicesDetailScreen.route: (context) => DevicesDetailScreen(),
          //Pantallas Base
          ListviewScreen.route: (context) => ListviewScreen(),
          WidgetsEstructuraScreen.route: (context) => WidgetsEstructuraScreen(),
          EstadosScreen.route: (context) => EstadosScreen(),
          EstadosProviderScreen.route: (context) => EstadosProviderScreen(),
          MensajesScreen.route: (context) => MensajesScreen(),
          FormulariosScreen.route: (context) => FormulariosScreen(),
        },
      ),
    );
  }
}
