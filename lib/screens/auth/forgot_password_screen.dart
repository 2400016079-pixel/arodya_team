import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final AuthService _auth = AuthService();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
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

    final double horizontalPadding = isTablet
        ? 60
        : scale(24, min: 16, max: 28);
    final double cardPadding = isTablet ? 40 : scale(28, min: 18, max: 30);

    final double iconBoxSize = scale(100, min: 80, max: 110);
    final double iconSize = scale(52, min: 42, max: 60);
    final double titleSize = scale(28, min: 22, max: 33);
    final double bodySize = scale(15, min: 13, max: 16);
    final double buttonTextSize = scale(17, min: 15, max: 18);

    return Scaffold(
      backgroundColor: const Color(0xffF8FAF9),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isSmallPhone ? 16 : 24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      constraints.maxHeight -
                      (isSmallPhone ? 32 : 48) -
                      MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: isSmallPhone ? 4 : 10),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Color(0xff3E7650),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),

                        SizedBox(height: scale(32, min: 20, max: 40)),

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
                                color: Colors.green.withOpacity(.08),
                                blurRadius: 35,
                                offset: const Offset(0, 15),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: isSmallPhone ? 8 : 15),

                              //================ ICON =================
                              Container(
                                width: iconBoxSize,
                                height: iconBoxSize,
                                decoration: BoxDecoration(
                                  color: const Color(0xff4F875D),
                                  borderRadius: BorderRadius.circular(
                                    iconBoxSize * 0.26,
                                  ),
                                ),
                                child: Icon(
                                  Icons.lock_reset,
                                  color: Colors.white,
                                  size: iconSize,
                                ),
                              ),

                              SizedBox(height: scale(26, min: 18, max: 30)),

                              //================ TITLE =================
                              Text(
                                "Reset Kata Sandi",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: titleSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),

                              SizedBox(height: scale(16, min: 12, max: 18)),

                              Text(
                                "Masukkan email Anda untuk menerima tautan pemulihan kata sandi.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: bodySize,
                                  color: Colors.black54,
                                  height: 1.6,
                                ),
                              ),

                              SizedBox(height: scale(34, min: 24, max: 40)),

                              //================ EMAIL FIELD =================
                              TextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(
                                  fontSize: isSmallPhone ? 15 : 16,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Alamat Email",
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: isSmallPhone ? 16 : 20,
                                    horizontal: 20,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: const BorderSide(
                                      color: Color(0xff4F875D),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: scale(30, min: 22, max: 36)),

                              //================ SUBMIT BUTTON =================
                              SizedBox(
                                width: double.infinity,
                                height: isSmallPhone ? 54 : 60,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff4F875D),
                                    disabledBackgroundColor: const Color(
                                      0xff4F875D,
                                    ).withOpacity(.6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: isLoading
                                      ? null
                                      : () async {
                                          if (emailController.text
                                              .trim()
                                              .isEmpty) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Masukkan alamat email",
                                                ),
                                              ),
                                            );
                                            return;
                                          }

                                          setState(() => isLoading = true);

                                          final error = await _auth
                                              .resetPassword(
                                                email: emailController.text
                                                    .trim(),
                                              );

                                          if (!mounted) return;
                                          setState(() => isLoading = false);

                                          if (error == null) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Tautan reset password telah dikirim ke email.",
                                                ),
                                              ),
                                            );

                                            Navigator.pop(context);
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(content: Text(error)),
                                            );
                                          }
                                        },
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                      : Text(
                                          "Kirim Tautan Pemulihan",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: buttonTextSize,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: isSmallPhone ? 20 : 30),
                      ],
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
}
