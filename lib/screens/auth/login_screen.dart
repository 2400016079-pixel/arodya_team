import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import '../dashboard/dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 60),

              Image.asset('assets/images/logo.png', width: 80),

              const SizedBox(height: 15),

              const Text(
                "ZenFit",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1F2940),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Healthy Body, Calm Mind",
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff6B7C99),
                ),
              ),

              const SizedBox(height: 55),

              _textField(hint: "Email", icon: Icons.email_outlined),

              const SizedBox(height: 22),

              _textField(
                hint: "Password",
                icon: Icons.lock_outline,
                obscure: true,
              ),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ForgotPasswordScreen(),
                      ),
                    );
                  },

                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Color(0xff0C9E6E), fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 60,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DashboardScreen(),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0C9E6E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),

                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 55),

              const Text(
                "Belum punya akun?",
                style: TextStyle(color: Color(0xff6B7C99), fontSize: 18),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 60,

                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },

                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xff0C9E6E), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),

                  child: const Text(
                    "Register",
                    style: TextStyle(color: Color(0xff0C9E6E), fontSize: 22),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xff93A4BF)),

        hintText: hint,

        hintStyle: const TextStyle(color: Color(0xff93A4BF)),

        filled: true,
        fillColor: const Color(0xffF7F9FC),

        contentPadding: const EdgeInsets.symmetric(vertical: 22),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: const BorderSide(color: Color(0xffDCE3EE)),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: const BorderSide(color: Color(0xff0C9E6E), width: 2),
        ),
      ),
    );
  }
}
