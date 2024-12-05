import 'package:flutter/material.dart';
import 'package:instoo/resources/auth_methods.dart';
import 'package:instoo/responsive/mobile_screen_layout.dart';
import 'package:instoo/screens/signup_screen.dart';
import 'package:instoo/utils/colors.dart';
import 'package:instoo/utils/utils.dart';
import 'package:instoo/widgets/text_field.dart';

import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (result == 'success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(result, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context)
                .size
                .height, // Asegura que el gradiente cubra toda la pantalla
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 39, 144, 134),
                  Color.fromARGB(255, 42, 52, 69),
                  Colors.blue,
                ],
                stops: [0.0, 0.5, 1.0], // Controla la posición de los colores
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth > 600 ? screenWidth * 0.2 : 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Hero(
                  tag: 1,
                  child: Image.asset(
                    'assets/Logo.gif',
                    height: screenWidth > 600 ? 300 : 250,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 32),
                TextFieldInput(
                  textEditingController: _emailController,
                  hintText: "Ingresa tu Correo",
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: "Ingresa tu Contraseña",
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: loginUser,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.blueGrey,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿No tienes una cuenta? ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Regístrate!',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
