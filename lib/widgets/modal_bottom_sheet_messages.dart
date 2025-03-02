import 'package:flutter/material.dart';
import 'package:flutter_dignal_2025/providers/devices_provider.dart';
import 'package:provider/provider.dart';

class ModalBottomSheetMessages extends StatefulWidget {
  const ModalBottomSheetMessages({super.key});

  @override
  State<ModalBottomSheetMessages> createState() => _ModalBottomSheetMessagesState();
}

class _ModalBottomSheetMessagesState extends State<ModalBottomSheetMessages> {
  @override
  Widget build(BuildContext context) {

    final devicesProvider = Provider.of<DevicesProvider>(context, listen: true);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: devicesProvider.messagesOpenai.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade700
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      devicesProvider.messagesOpenai[index]!.date,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      devicesProvider.messagesOpenai[index]!.text,
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}