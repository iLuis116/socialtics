import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instoo/resources/auth_methods.dart';
import 'package:instoo/utils/colors.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';
import '../widgets/text_field.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _profileImage;
  AssetImage defaultProfile = AssetImage('assets/defaultUserimage.png');
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _profileImage = im;
    });
  }

  void signUpUser() async {
    // Validar que todos los campos estén llenos
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _bioController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _profileImage == null) {
      _showAlert(
          "Por favor llena todos los campos y selecciona una foto de perfil.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _profileImage!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
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
                .height, // Gradiente abarca toda la pantalla
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 39, 144, 134),
                  Color.fromARGB(255, 42, 52, 69),
                  Colors.blue,
                ],
                stops: [0.0, 0.5, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth > 600 ? screenWidth * 0.2 : 32,
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Hero(
                  tag: 1,
                  child: SvgPicture.asset(
                    'assets/instoo logo.svg',
                    height: screenWidth > 600 ? 120 : 64,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: textPrimaryColor,
                      radius: 64,
                      backgroundImage: _profileImage != null
                          ? MemoryImage(
                              _profileImage!) // Usa MemoryImage si hay una imagen
                          : AssetImage('assets/defaultUserimage.png')
                              as ImageProvider, // Convierte AssetImage a ImageProvider
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFieldInput(
                  textEditingController: _usernameController,
                  hintText: "Ingresa tu usuario",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                TextFieldInput(
                  textEditingController: _emailController,
                  hintText: "Ingresa tu correo",
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: "Ingresa tu contraseña",
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(height: 20),
                TextFieldInput(
                  textEditingController: _bioController,
                  hintText: "Has descripción de ti ",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: signUpUser,
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
                            'Registrarse',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿Ya tienes una cuenta? ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        ' Iniciar Sesión',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
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
    );
  }
}
