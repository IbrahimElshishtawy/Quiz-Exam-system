import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController usernameCtrl;
  final TextEditingController passwordCtrl;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmit;

  const LoginForm({
    super.key,
    required this.usernameCtrl,
    required this.passwordCtrl,
    required this.formKey,
    required this.onSubmit,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final RxBool isPasswordHidden = true.obs;
  final RxBool isEmailValid = false.obs;
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.usernameCtrl.addListener(_validateEmail);
  }

  @override
  void dispose() {
    widget.usernameCtrl.removeListener(_validateEmail);
    _emailFocusNode.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final text = widget.usernameCtrl.text.trim();
    // Regex or simple check for email
    if (text.contains('@') && text.contains('.')) {
      isEmailValid.value = true;
    } else {
      isEmailValid.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    final isAr = Get.locale?.languageCode == 'ar';

    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Username / Email input
          Obx(() {
            final valid = isEmailValid.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: widget.usernameCtrl,
                  focusNode: _emailFocusNode,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'email_or_username'.tr,
                    hintText: 'student@eduassess.ai',
                    labelStyle: GoogleFonts.notoKufiArabic(
                      fontSize: 12,
                      color: _emailFocusNode.hasFocus ? primaryColor : const Color(0xFF64748B),
                    ),
                    prefixIcon: const Icon(Icons.person_outline, size: 22),
                    suffixIcon: valid
                        ? const Icon(Icons.check_circle_outline_rounded, color: Colors.green, size: 22)
                        : null,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: valid ? Colors.green : const Color(0xFFE2E8F0),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: valid ? Colors.green : primaryColor,
                        width: 2.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'enter_username'.tr;
                    }
                    return null;
                  },
                ),
                if (valid) ...[
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      'email_registered_desc'.tr,
                      textAlign: isAr ? TextAlign.right : TextAlign.left,
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 11,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            );
          }),
          const SizedBox(height: 16),

          // Password Field
          Obx(
            () => TextFormField(
              controller: widget.passwordCtrl,
              obscureText: isPasswordHidden.value,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => widget.onSubmit(),
              decoration: InputDecoration(
                labelText: 'password'.tr,
                hintText: '••••••••',
                prefixIcon: const Icon(Icons.lock_outline, size: 22),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: primaryColor, width: 2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
                ),
                suffixIcon: IconButton(
                  onPressed: () => isPasswordHidden.toggle(),
                  icon: Icon(
                    isPasswordHidden.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFF64748B),
                    size: 22,
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
          const SizedBox(height: 10),

          // Forgot Password Link
          Align(
            alignment: isAr ? Alignment.centerLeft : Alignment.centerRight,
            child: TextButton(
              onPressed: () => Get.snackbar('alert'.tr, 'not_available_demo'.tr),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'forgot_password'.tr,
                style: GoogleFonts.notoKufiArabic(
                  color: primaryColor,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
