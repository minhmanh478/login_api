import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:login_api/common/AppStyle.dart';

class ScreenSignUp extends StatefulWidget {
  @override
  _ScreenSignUpState createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    final url =
        Uri.parse('https://api-dev-photruyen.deepviet.com/api/auth/register');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "full_name": _fullNameController.text,
      "user_name": _userNameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print("Registration successful: ${response.body}");
      } else {
        print("Registration failed: ${response.body}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 137.5),
            _buildBack(),
            const SizedBox(height: 24),
            _buildHeader(),
            const SizedBox(height: 24),
            _buildInputFields(),
            const SizedBox(height: 24),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       leading: IconButton(
  //         icon: Icon(Icons.arrow_back),
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //       ),
  //       elevation: 0,
  //       backgroundColor: Colors.white,
  //     ),
  //     body: Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           _buildHeader(),
  //           SizedBox(height: 24),
  //           _buildInputFields(),
  //           SizedBox(height: 24),
  //           _buildRegisterButton(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildBack() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Image.asset('assets/images/back.png', width: 24, height: 24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Sign up", style: AppStyle.s32w700.copyWith(color: Colors.black)),
        SizedBox(height: 8),
        Text(
          "Create an account to continue!",
          style: AppStyle.s12w500.copyWith(color: const Color(0xFF6C7278)),
        ),
      ],
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        CustomTextField(
          controller: _fullNameController,
          labelText: "Full Name",
        ),
        SizedBox(height: 16),
        CustomTextField(
          controller: _userNameController,
          labelText: "Username",
        ),
        SizedBox(height: 16),
        CustomTextField(
          controller: _emailController,
          labelText: "Email",
        ),
        SizedBox(height: 16),
        CustomTextField(
          controller: _passwordController,
          labelText: "Set Password",
          obscureText: true,
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0x1FFFFFFF),
            Color(0x00FFFFFF),
          ],
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF375DFB),
            offset: Offset(0, 0),
            blurRadius: 0,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Color(0x7A253EA7),
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextButton(
        onPressed: _register,
        child: Text('Register',
            style: AppStyle.s14w500.copyWith(color: Colors.white)),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Text(
            widget.labelText ?? '',
            style: AppStyle.s12w500.copyWith(color: const Color(0xFF6C7278)),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0x3DE4E5E7),
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: _obscureText,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: const BorderSide(color: Color(0xFFEDF1F3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: const BorderSide(color: Color(0xFFEDF1F3)),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
              // Hiển thị icon chỉ khi obscureText là true
              suffixIcon: widget.obscureText
                  ? IconButton(
                onPressed: _toggleObscureText,
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  size: 16.0,
                  color: const Color(0xFF6C7278),
                ),
              )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}