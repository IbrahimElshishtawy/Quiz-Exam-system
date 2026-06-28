import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final isPasswordHidden = true.obs;

    void submit() {
      FocusManager.instance.primaryFocus?.unfocus();

      if (!(formKey.currentState?.validate() ?? false)) return;

      controller.login(usernameCtrl.text, passwordCtrl.text);
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),

                    // Header
                    const Icon(Icons.lock_rounded, size: 56),
                    const SizedBox(height: 12),
                    Text(
                      'welcome_back'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'sign_in_continue'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                    ),

                    const SizedBox(height: 28),

                    // Username
                    TextFormField(
                      controller: usernameCtrl,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'username'.tr,
                        hintText: 'student / instructor / developer',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'enter_username'.tr;
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 14),

                    // Password
                    Obx(
                      () => TextFormField(
                        controller: passwordCtrl,
                        obscureText: isPasswordHidden.value,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => submit(),
                        decoration: InputDecoration(
                          labelText: 'password'.tr,
                          hintText: '1234 / dev123',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          suffixIcon: IconButton(
                            onPressed:
                                () =>
                                    isPasswordHidden.value =
                                        !isPasswordHidden.value,
                            icon: Icon(
                              isPasswordHidden.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'enter_password'.tr;
                          }
                          if (v.trim().length < 3) {
                            return 'password_short_login'.tr;
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Login button
                    Obx(
                      () => SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value ? null : submit,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child:
                              controller.isLoading.value
                                  ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : Text(
                                      'login'.tr,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),
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
