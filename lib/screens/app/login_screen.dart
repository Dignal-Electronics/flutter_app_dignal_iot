import 'package:flutter/material.dart';
import 'package:flutter_dignal_2025/providers/login_form_provider.dart';
import 'package:flutter_dignal_2025/screens/app/dashbord_screen.dart';
import 'package:flutter_dignal_2025/screens/app/screens.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static String route = "/app-login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: LoginForm(),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final borderInputTextDecoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30)
  );

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginFormProvider>(context);
    print('LoginForm');
    print('username: ${loginProvider.username}');
    print('password: ${loginProvider.password}');
    return Form(
      key: loginProvider.formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: borderInputTextDecoration,
              labelText: 'Usuario',
              hintText: 'Ingresa tu usuario',
              prefixIcon: Icon(Icons.person),
              focusColor: Colors.red,
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es requerido';
              }
              return null;
            },
            onSaved: (newValue) => loginProvider.username = newValue!,
          ),
          SizedBox(
            height: 20
          ),
          TextFormField(
            initialValue: loginProvider.password,
            decoration: InputDecoration(
              border: borderInputTextDecoration,
              labelText: 'Contraseña',
              hintText: 'Ingresa tu contraseña',
              prefixIcon: Icon(Icons.vpn_key),
            ),
            textInputAction: TextInputAction.next,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es requerido';
              }
              return null;
            },
            onSaved: (newValue) => loginProvider.password = newValue!,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: loginProvider.isLoading
                  ? null
                  : () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (loginProvider.validate()) {
                        final response = await loginProvider.login();
                        if (response) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context)
                              .pushReplacementNamed(DashboardScreen.route);
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Hubo un error en la solicitud",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      }
                    },
              child: Padding(
                padding: EdgeInsets.all(12),
                child: loginProvider.isLoading
                    ? SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 3,
                        ),
                      )
                    : Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
