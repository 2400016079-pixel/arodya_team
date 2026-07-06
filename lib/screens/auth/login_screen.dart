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

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

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

          child: SingleChildScrollView(

            padding: const EdgeInsets.symmetric(horizontal: 28),

            child: Column(

              children: [

                const SizedBox(height: 55),

                Container(
                  width: 95,
                  height: 95,

                  decoration: BoxDecoration(
                    color: const Color(0xff5A845F),
                    borderRadius: BorderRadius.circular(28),
                  ),

                  child: const Icon(
                    Icons.self_improvement,
                    color: Colors.white,
                    size: 50,
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2F5F3D),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Sign in to continue your journey.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff4E5652),
                  ),
                ),

                const SizedBox(height: 45),

                Container(

                  width: double.infinity,

                  padding: const EdgeInsets.all(28),

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius: BorderRadius.circular(35),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.08),
                        blurRadius: 35,
                        offset: const Offset(0,15),
                      )
                    ],
                  ),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      const Text(
                        "Email Address",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextField(

                        controller: emailController,

                        decoration: InputDecoration(

                          hintText: "hello@zenfit.com",

                          prefixIcon: const Icon(Icons.email_outlined),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),

                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 22,
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      Row(

                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                        children: [

                          const Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          GestureDetector(

                            onTap: (){

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_)=>const ForgotPasswordScreen(),
                                ),
                              );

                            },

                            child: const Text(

                              "Forgot Password?",

                              style: TextStyle(
                                color: Color(0xff39744C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height:16),

                      TextField(

                        controller: passwordController,

                        obscureText: obscure,
                                                decoration: InputDecoration(
                          hintText: "••••••••",

                          prefixIcon: const Icon(Icons.lock_outline),

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

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),

                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 22,
                          ),
                        ),
                      ),

                      const SizedBox(height: 35),

                      SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: ElevatedButton(
                          onPressed: () async {
  if (emailController.text.isEmpty ||
      passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Email dan password wajib diisi"),
      ),
    );
    return;
  }

  final error = await _auth.login(
    email: emailController.text.trim(),
    password: passwordController.text.trim(),
  );

  if (!mounted) return;

  if (error == null) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DashboardScreen(),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
      ),
    );
  }
},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff4D7C59),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 35),

                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "or continue with",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),

                      const SizedBox(height: 30),

                      Row(
                        children: [

                          Expanded(
  child: OutlinedButton.icon(
    onPressed: () async {
      final error = await _auth.signInWithGoogle();

      if (!mounted) return;

      if (error == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => DashboardScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
          ),
        );
      }
    },
    icon: const Icon(Icons.g_mobiledata, size: 32),
    label: const Text("Google"),
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(0, 58),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
    ),
  ),
),

                          const SizedBox(width: 18),

                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.apple),
                              label: const Text("Apple"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black87,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(0, 58),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 45),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 18,
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

                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff2F5F3D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
