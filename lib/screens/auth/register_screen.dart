import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    // ===== BREAKPOINT & SCALE HELPERS =====
    // Batas bawah & atas supaya tidak "meledak" di tablet atau
    // "kepotong" di HP kecil (mis. iPhone SE / lebar ~320).
    final bool isSmallPhone = width < 360;
    final bool isTablet = width >= 600;

    // Skala dasar dihitung dari lebar 375 (ukuran HP standar) lalu di-clamp.
    double scale(double base, {double min = 0, double max = 999}) {
      final value = base * (width / 375);
      return value.clamp(min, max);
    }

    final double horizontalPadding = isTablet
        ? 40
        : scale(24, min: 16, max: 28);
    final double cardPadding = isTablet ? 40 : scale(24, min: 18, max: 30);

    final double logoSize = scale(90, min: 72, max: 110);
    final double logoIconSize = scale(38, min: 30, max: 46);

    final double titleSize = scale(30, min: 24, max: 34);
    final double subtitleSize = scale(15, min: 13, max: 17);
    final double labelSize = scale(16, min: 14, max: 18);
    final double buttonTextSize = scale(18, min: 16, max: 20);

    final double sectionGapLarge = scale(28, min: 18, max: 34);
    final double sectionGapMedium = scale(20, min: 14, max: 24);

    return Scaffold(
      backgroundColor: const Color(0xffF7FBF8),
      // Supaya keyboard tidak menutupi field saat muncul.
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isSmallPhone ? 16 : 25,
              ),
              child: ConstrainedBox(
                // Menjamin konten tetap bisa scroll penuh walau
                // tinggi layar pendek (landscape / HP kecil).
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight -
                      (isSmallPhone ? 32 : 50) -
                      MediaQuery.of(context).viewInsets.bottom,
                ),
                child: IntrinsicHeight(
                  child: Center(
                    child: ConstrainedBox(
                      // Di tablet/desktop, form tidak melebar penuh.
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: cardPadding,
                          vertical: cardPadding,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            isSmallPhone ? 24 : 32,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.08),
                              blurRadius: 30,
                              offset: const Offset(0, 15),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //================ LOGO =================
                            Container(
                              width: logoSize,
                              height: logoSize,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.08),
                                    blurRadius: 15,
                                  ),
                                ],
                              ),
                              child: Container(
                                margin: EdgeInsets.all(logoSize * 0.16),
                                decoration: BoxDecoration(
                                  color: const Color(0xff4F7F5D),
                                  borderRadius: BorderRadius.circular(
                                    logoSize * 0.28,
                                  ),
                                ),
                                child: Icon(
                                  Icons.self_improvement,
                                  color: Colors.white,
                                  size: logoIconSize,
                                ),
                              ),
                            ),

                            SizedBox(height: sectionGapLarge),

                            //================ TITLE =================
                            Text(
                              "Join ZenFit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: titleSize,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff2F5F3D),
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              "Begin your journey to a balanced life.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: subtitleSize,
                                color: Colors.black54,
                              ),
                            ),

                            SizedBox(height: sectionGapLarge),

                            //================ STEP INDICATOR =================
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: scale(52, min: 40, max: 60),
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff2F5F3D),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: scale(28, min: 22, max: 34),
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: scale(28, min: 22, max: 34),
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: sectionGapLarge),

                            //================ FULL NAME =================
                            _FieldLabel(text: "Full Name", fontSize: labelSize),
                            const SizedBox(height: 10),
                            _RoundedTextField(
                              controller: nameController,
                              hint: "Jane Doe",
                              icon: Icons.person_outline,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              isSmallPhone: isSmallPhone,
                            ),

                            SizedBox(height: sectionGapMedium),

                            //================ EMAIL =================
                            _FieldLabel(
                              text: "Email Address",
                              fontSize: labelSize,
                            ),
                            const SizedBox(height: 10),
                            _RoundedTextField(
                              controller: emailController,
                              hint: "jane@example.com",
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              isSmallPhone: isSmallPhone,
                            ),

                            SizedBox(height: sectionGapMedium),

                            //================ PASSWORD =================
                            _FieldLabel(text: "Password", fontSize: labelSize),
                            const SizedBox(height: 10),
                            _RoundedTextField(
                              controller: passwordController,
                              hint: "••••••••",
                              icon: Icons.lock_outline,
                              obscureText: obscurePassword,
                              textInputAction: TextInputAction.done,
                              isSmallPhone: isSmallPhone,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),

                            SizedBox(height: sectionGapLarge * 1.2),

                            //================ CONTINUE BUTTON =================
                            SizedBox(
                              width: double.infinity,
                              height: isSmallPhone ? 52 : 58,
                              child: ElevatedButton(
                                onPressed: isLoading
                                    ? null
                                    : () async {
                                        if (nameController.text.trim().isEmpty ||
                                            emailController.text
                                                .trim()
                                                .isEmpty ||
                                            passwordController.text
                                                .trim()
                                                .isEmpty) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text("Semua data wajib diisi"),
                                            ),
                                          );
                                          return;
                                        }

                                        setState(() => isLoading = true);

                                        final error = await _auth.register(
                                          name: nameController.text.trim(),
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                        );

                                        if (!mounted) return;
                                        setState(() => isLoading = false);

                                        if (error == null) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text("Register berhasil"),
                                            ),
                                          );

                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const LoginScreen(),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(content: Text(error)),
                                          );
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff4F7F5D),
                                  disabledBackgroundColor:
                                      const Color(0xff4F7F5D).withOpacity(.6),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: isLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Continue",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: buttonTextSize,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                              ),
                            ),

                            SizedBox(height: sectionGapLarge),

                            //================ LOGIN LINK =================
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: scale(15, min: 13, max: 17),
                                    color: Colors.black54,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Log in here",
                                    style: TextStyle(
                                      fontSize: scale(15, min: 13, max: 17),
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff2F5F3D),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

// ===================== REUSABLE WIDGETS =====================

class _FieldLabel extends StatelessWidget {
  final String text;
  final double fontSize;

  const _FieldLabel({required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isSmallPhone;

  const _RoundedTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.isSmallPhone,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: TextStyle(fontSize: isSmallPhone ? 15 : 16),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          vertical: isSmallPhone ? 16 : 20,
          horizontal: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xff4F7F5D),
            width: 2,
          ),
        ),
      ),
    );
  }
}