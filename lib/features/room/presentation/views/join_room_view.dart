import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/room_controller.dart';

class JoinRoomView extends StatefulWidget {
  const JoinRoomView({super.key});

  @override
  State<JoinRoomView> createState() => _JoinRoomViewState();
}

class _JoinRoomViewState extends State<JoinRoomView> {
  late final RoomController controller;
  final _formKey = GlobalKey<FormState>();

  final _roomCodeCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  final _hidePassword = true.obs;

  @override
  void initState() {
    super.initState();
    // لو عندك Binding بيرجّع Controller موجود
    controller =
        Get.isRegistered<RoomController>()
            ? Get.find<RoomController>()
            : Get.put(RoomController());
  }

  @override
  void dispose() {
    _roomCodeCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) return;

    final code = _roomCodeCtrl.text.trim().toUpperCase();
    final pass = _passwordCtrl.text.trim();

    // لو joinRoom عندك بياخد code بس:
    controller.joinRoom(code);

    // لو joinRoom عندك ممكن يستقبل password كمان، استخدم ده بدل اللي فوق:
    // controller.joinRoom(code, password: pass.isEmpty ? null : pass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Join Room')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),

                    // Header
                    const Icon(Icons.meeting_room_outlined, size: 56),
                    const SizedBox(height: 12),
                    Text(
                      'Enter Room Details',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Use the room code provided by your instructor.',
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                    ),

                    const SizedBox(height: 22),

                    // Card container
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _roomCodeCtrl,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.characters,
                              decoration: InputDecoration(
                                labelText: 'Room Code',
                                hintText: 'e.g. ROOM123',
                                prefixIcon: const Icon(
                                  Icons.confirmation_number_outlined,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              validator: (v) {
                                final value = (v ?? '').trim();
                                if (value.isEmpty) return 'اكتب كود الغرفة';
                                if (value.length < 4) return 'كود الغرفة قصير';
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),

                            Obx(
                              () => TextFormField(
                                controller: _passwordCtrl,
                                obscureText: _hidePassword.value,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => _submit(),
                                decoration: InputDecoration(
                                  labelText: 'Password (Optional)',
                                  hintText: 'Leave empty if not required',
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed:
                                        () =>
                                            _hidePassword.value =
                                                !_hidePassword.value,
                                    icon: Icon(
                                      _hidePassword.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            SizedBox(
                              height: 48,
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _submit,
                                icon: const Icon(Icons.login_rounded),
                                label: const Text(
                                  'Join',
                                  style: TextStyle(fontSize: 16),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Tip: Room codes are usually uppercase letters and numbers.',
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
