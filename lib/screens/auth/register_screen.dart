import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool obscure = true;

  final nameController = TextEditingController();
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

            padding: const EdgeInsets.all(26),

            child: Container(

              padding: const EdgeInsets.all(28),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius: BorderRadius.circular(35),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.08),
                    blurRadius: 35,
                    offset: const Offset(0,18),
                  )
                ],
              ),

              child: Column(

                children: [

                  Container(
                    width: 110,
                    height: 110,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.08),
                          blurRadius: 15,
                        )
                      ],
                    ),

                    child: Container(
                      margin: const EdgeInsets.all(14),

                      decoration: BoxDecoration(
                        color: const Color(0xff5A845F),
                        borderRadius: BorderRadius.circular(28),
                      ),

                      child: const Icon(
                        Icons.self_improvement,
                        color: Colors.white,
                        size: 55,
                      ),
                    ),
                  ),

                  const SizedBox(height:30),

                  const Text(
                    "Join ZenFit",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2F5F3D),
                    ),
                  ),

                  const SizedBox(height:10),

                  const Text(
                    "Begin your journey to a balanced life.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height:28),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        width:60,
                        height:8,
                        decoration: BoxDecoration(
                          color: const Color(0xff2F5F3D),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      const SizedBox(width:10),

                      Container(
                        width:34,
                        height:8,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      const SizedBox(width:10),

                      Container(
                        width:34,
                        height:8,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height:40),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Full Name",
                      style: TextStyle(
                        fontSize:18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height:12),

                  TextField(
                    controller: nameController,

                    decoration: InputDecoration(
                      hintText: "Jane Doe",

                      prefixIcon: const Icon(Icons.person_outline),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),

                      contentPadding: const EdgeInsets.symmetric(
                        vertical:22,
                      ),
                    ),
                  ),

                  const SizedBox(height:25),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email Address",
                      style: TextStyle(
                        fontSize:18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height:12),

                  TextField(
                    controller: emailController,

                    decoration: InputDecoration(
                      hintText: "jane@example.com",

                      prefixIcon: const Icon(Icons.email_outlined),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),

                      contentPadding: const EdgeInsets.symmetric(
                        vertical:22,
                      ),
                    ),
                  ),

                  const SizedBox(height:25),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontSize:18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height:12),

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
                        borderRadius: BorderRadius.circular(22),
                      ),

                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 22,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 65,

                    child: ElevatedButton(
                     onPressed: () async {
  if (nameController.text.isEmpty ||
      emailController.text.isEmpty ||
      passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Semua data wajib diisi"),
      ),
    );
    return;
  }

  final error = await _auth.register(
    name: nameController.text.trim(),
    email: emailController.text.trim(),
    password: passwordController.text.trim(),
  );

  if (!mounted) return;

  if (error == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Register berhasil"),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error)),
    );
  }
},

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4D7C59),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),

                          SizedBox(width: 12),

                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),

                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 45),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: 18,
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

                        child: const Text(
                          "Log in here",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2F5F3D),
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
    );
  }
}