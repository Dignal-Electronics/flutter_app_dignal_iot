import 'package:flutter/material.dart';
import 'package:flutter_dignal_2025/providers/user_form_provider.dart';
import 'package:flutter_dignal_2025/providers/users_provider.dart';
import 'package:provider/provider.dart';

class UsersFormScreen extends StatelessWidget {
  const UsersFormScreen({super.key});

  static String route = "/app-users-form";

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChangeNotifierProvider(
          create: (_) => UserFormProvider(userProvider.selectedUser),
          child: UserForm(),
        ),
      ),
    );
  }
}

class UserForm extends StatelessWidget {
  UserForm({super.key});

  final borderInputTextDecoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30)
  );

  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<UserFormProvider>(context);
    final user = userForm.user;

    return Form(
      key: userForm.formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: user.name,
            decoration: InputDecoration(
              border: borderInputTextDecoration,
              labelText: 'Nombre',
              errorText: null
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es requerido';
              }
              return null;
            },
            onSaved: (value) => user.name = value!,
          ),
          SizedBox(height: 20,),
          TextFormField(
            initialValue: user.username,
            decoration: InputDecoration(
              border: borderInputTextDecoration,
              labelText: 'Nombre de usuario'
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es requerido';
              }
              return null;
            },
            onSaved: (value) => user.username = value!,
          ),
          SizedBox(height: 20,),
          TextFormField(
            initialValue: user.password,
            decoration: InputDecoration(
              border: borderInputTextDecoration,
              labelText: 'Contraseña'
            ),
            validator: (value) {
              if (user.id == null) {
                if (value == null || value.isEmpty) {
                  return 'Este campo es requerido';
                }
              }

              return null;
            },
            obscureText: true,
            onSaved: (value) => user.password = value!,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: userForm.isLoading
                  ? null
                  : () async {
                      if (userForm.validate()) {
                        Navigator.of(context).pop();
                      }
                    },
              child: userForm.isLoading
                  ? Padding(
                      padding: EdgeInsets.all(5),
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Text(user.id == null ? 'Crear' : 'Actualizar', style: TextStyle(fontSize: 18),),
            ),
          ),
        ],
      ),
    );
  }
}
