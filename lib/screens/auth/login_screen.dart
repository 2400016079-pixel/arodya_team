import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';
import '../dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscure = true;
  bool isLoading = false;
  bool isGoogleLoading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _auth = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    // ===== BREAKPOINT & SCALE HELPERS =====
    final bool isSmallPhone = width < 360;
    final bool isTablet = width >= 600;

    double scale(double base, {double min = 0, double max = 999}) {
      final value = base * (width / 375);
      return value.clamp(min, max);
    }

    final double horizontalPadding = isTablet ? 60 : scale(28, min: 18, max: 32);
    final double cardPadding = isTablet ? 40 : scale(28, min: 18, max: 30);

    final double logoSize = scale(90, min: 72, max: 105);
    final double logoIconSize = scale(46, min: 36, max: 52);

    final double titleSize = scale(34, min: 26, max: 40);
    final double subtitleSize = scale(16, min: 14, max: 18);
    final double labelSize = scale(17, min: 15, max: 18);
    final double buttonTextSize = scale(19, min: 17, max: 22);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffEAF6EF),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight -
                        MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      // Batasi lebar konten di tablet/desktop.
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: isSmallPhone ? 24 : 40),

                          //================ LOGO =================
                          Container(
                            width: logoSize,
                            height: logoSize,
                            decoration: BoxDecoration(
                              color: const Color(0xff5A845F),
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

                          SizedBox(height: scale(24, min: 18, max: 28)),

                          //================ TITLE =================
                          Text(
                            "Welcome Back",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff2F5F3D),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "Sign in to continue your journey.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: subtitleSize,
                              color: const Color(0xff4E5652),
                            ),
                          ),

                          SizedBox(height: scale(38, min: 28, max: 44)),

                          //================ CARD =================
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(cardPadding),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                isSmallPhone ? 26 : 32,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.08),
                                  blurRadius: 35,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _FieldLabel(
                                  text: "Email Address",
                                  fontSize: labelSize,
                                ),
                                const SizedBox(height: 12),
                                _RoundedTextField(
                                  controller: emailController,
                                  hint: "hello@zenfit.com",
                                  icon: Icons.email_outlined,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  isSmallPhone: isSmallPhone,
                                ),

                                SizedBox(height: scale(24, min: 18, max: 28)),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _FieldLabel(
                                      text: "Password",
                                      fontSize: labelSize,
                                    ),
                                    Flexible(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const ForgotPasswordScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Forgot Password?",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: scale(
                                              14,
                                              min: 12,
                                              max: 15,
                                            ),
                                            color: const Color(0xff39744C),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                _RoundedTextField(
                                  controller: passwordController,
                                  hint: "••••••••",
                                  icon: Icons.lock_outline,
                                  obscureText: obscure,
                                  textInputAction: TextInputAction.done,
                                  isSmallPhone: isSmallPhone,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscure = !obscure;
                                      });
                                    },
                                    icon: Icon(
                                      obscure
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                    ),
                                  ),
                                ),

                                SizedBox(height: scale(32, min: 24, max: 38)),

                                //================ SIGN IN BUTTON =================
                                SizedBox(
                                  width: double.infinity,
                                  height: isSmallPhone ? 54 : 62,
                                  child: ElevatedButton(
                                    onPressed: isLoading
                                        ? null
                                        : () async {
                                            if (emailController.text.isEmpty ||
                                                passwordController
                                                    .text.isEmpty) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Email dan password wajib diisi",
                                                  ),
                                                ),
                                              );
                                              return;
                                            }

                                            setState(() => isLoading = true);

                                            final error = await _auth.login(
                                              email:
                                                  emailController.text.trim(),
                                              password: passwordController
                                                  .text
                                                  .trim(),
                                            );

                                            if (!mounted) return;
                                            setState(() => isLoading = false);

                                            if (error == null) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      DashboardScreen(),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(error),
                                                ),
                                              );
                                            }
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color(0xff4D7C59),
                                      disabledBackgroundColor:
                                          const Color(0xff4D7C59)
                                              .withOpacity(.6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(28),
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
                                                "Sign In",
                                                style: TextStyle(
                                                  fontSize: buttonTextSize,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w600,
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

                                SizedBox(height: scale(32, min: 24, max: 38)),

                                Row(
                                  children: [
                                    const Expanded(child: Divider()),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Text(
                                        "or continue with",
                                        style: TextStyle(
                                          fontSize:
                                              scale(13, min: 11, max: 14),
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const Expanded(child: Divider()),
                                  ],
                                ),

                                SizedBox(height: scale(26, min: 18, max: 30)),

                                //================ SOCIAL BUTTONS =================
                                // Di layar sempit ditumpuk vertikal, di layar
                                // cukup lebar disejajarkan horizontal.
                                LayoutBuilder(
                                  builder: (context, cardConstraints) {
                                    final buttonWidth =
                                        cardConstraints.maxWidth;
                                    final bool stack = buttonWidth < 300;

                                    final googleButton = OutlinedButton.icon(
                                      onPressed: isGoogleLoading
                                          ? null
                                          : () async {
                                              setState(
                                                () => isGoogleLoading = true,
                                              );
                                              final error = await _auth
                                                  .signInWithGoogle();

                                              if (!mounted) return;
                                              setState(
                                                () => isGoogleLoading = false,
                                              );

                                              if (error == null) {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        DashboardScreen(),
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(error),
                                                  ),
                                                );
                                              }
                                            },
                                      icon: isGoogleLoading
                                          ? const SizedBox(
                                              width: 18,
                                              height: 18,
                                              child:
                                                  CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Icon(
                                              Icons.g_mobiledata,
                                              size: 30,
                                            ),
                                      label: const Text("Google"),
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: const Size(0, 54),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    );

                                    final appleButton = ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.apple),
                                      label: const Text("Apple"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black87,
                                        foregroundColor: Colors.white,
                                        minimumSize: const Size(0, 54),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    );

                                    if (stack) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: googleButton,
                                          ),
                                          const SizedBox(height: 14),
                                          SizedBox(
                                            width: double.infinity,
                                            child: appleButton,
                                          ),
                                        ],
                                      );
                                    }

                                    return Row(
                                      children: [
                                        Expanded(child: googleButton),
                                        const SizedBox(width: 16),
                                        Expanded(child: appleButton),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: scale(36, min: 26, max: 44)),

                          //================ SIGN UP LINK =================
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  fontSize: scale(16, min: 14, max: 18),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const RegisterScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: scale(16, min: 14, max: 18),
                                    color: const Color(0xff2F5F3D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: isSmallPhone ? 28 : 40),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ===================== REUSABLE WIDGETS =====================

class _FieldLabel extends StatelessWidget {
  final String text;
  final double fontSize;

  const _FieldLabel({required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: isSmallPhone ? 16 : 20,
          horizontal: 18,
        ),
      ),
    );
  }
}