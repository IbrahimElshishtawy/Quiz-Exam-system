import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/room_controller.dart';

class JoinRoomView extends GetView<RoomController> {
  const JoinRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RoomController());

    return Scaffold(
      appBar: AppBar(title: const Text('Join Room')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Room Code')),
            const TextField(decoration: InputDecoration(labelText: 'Password (Optional)')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.joinRoom('ROOM123'),
              child: const Text('Join')
            ),
          ],
        ),
      ),
    );
  }
}
