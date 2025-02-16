import 'package:flutter/material.dart';
import 'package:flutter_dignal_2025/providers/device_form_provider.dart';
import 'package:flutter_dignal_2025/providers/devices_provider.dart';
import 'package:flutter_dignal_2025/widgets/custom_button_loading.dart';
import 'package:provider/provider.dart';

class DevicesFormScreen extends StatelessWidget {
  const DevicesFormScreen({super.key});

  static String route = "/app-devices-form";

  @override
  Widget build(BuildContext context) {
    final devicesProvider = Provider.of<DevicesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear dispositivo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChangeNotifierProvider(
          create: (_) => DeviceFormProvider(devicesProvider.selectedDevice),
          child: DeviceForm(),
        ),
      ),
    );
  }
}

class DeviceForm extends StatelessWidget {
  DeviceForm({
    super.key,
  });

  final borderInputTextDecoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30)
  );

  @override
  Widget build(BuildContext context) {
    final deviceForm = Provider.of<DeviceFormProvider>(context);
    final device = deviceForm.device;
    return Form(
      key: deviceForm.formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: device.name,
            decoration: InputDecoration(
              border: borderInputTextDecoration,
              labelText: 'Nombre',
              errorText: deviceForm.errors.containsKey('name')
                  ? deviceForm.errors['name'][0]
                  : null),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es requerido';
              }
              return null;
            },
            onSaved: (value) => device.name = value!,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: deviceForm.isLoading
                  ? null
                  : () async {
                      if (deviceForm.validate()) {
                        Navigator.of(context).pop();
                      }
                    },
              child: deviceForm.isLoading
                  ? Padding(
                      padding: EdgeInsets.all(5),
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Text(device.id == null ? 'Crear' : 'Actualizar', style: TextStyle(fontSize: 18),),
            ),
          ),
    
        ],
      ),
    );
  }
}
