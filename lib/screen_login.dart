import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_api/ForgotPassword/ScreenForgotPassword.dart';
import 'dart:convert';
import 'package:login_api/common/AppColor.dart';
import 'package:login_api/common/AppStyle.dart';
import 'screen_SignUp.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScreenLogin extends StatefulWidget {
  @override
  _ScreenLoginState createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    final url =
    Uri.parse('https://api-dev-photruyen.deepviet.com/api/auth/login');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_name": _usernameController.text,
        "password": _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Login thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Sai tên đăng nhập",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              _buildLogo(),
              const SizedBox(height: 32),
              _buildTitle(),
              const SizedBox(height: 32),
              _buildUsernameField(),
              const SizedBox(height: 16),
              _buildPasswordField(),
              const SizedBox(height: 0),
              _buildButtonForgot(),
              const SizedBox(height: 4),
              _buildLoginButton(),
              const SizedBox(height: 24),
              _buildDivider(),
              const SizedBox(height: 16),
              _buildGoogleButton(),
              const SizedBox(height: 15),
              _buildFacebookButton(),
              const SizedBox(height: 53.64),
              _buildSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 18.36,
          width: 18.36,
        ),
        const SizedBox(width: 8),
        Image.asset(
          'assets/images/text_logo.png',
          width: 76.67,
          height: 15.15,
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sign in to your   Account',
          textAlign: TextAlign.start,
          style: AppStyle.s32w700,
        ),
        SizedBox(height: 12),
        Text(
          'Enter your email and password to log in',
          textAlign: TextAlign.start,
          style: AppStyle.s12w500.copyWith(
            color: AppColor.blackSecondary
          )
        ),
      ],
    );
  }


  Widget _buildUsernameField() {
    return CustomTextField(
      controller: _usernameController,
      labelText: 'User name',
      obscureText: false,
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: _passwordController,
      labelText: 'Password',
      obscureText: true,
    );
  }

  Widget _buildButtonForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenForgotPassword()),
            );
          },
          child: Text(
            'Forgot password?',
            style: AppStyle.s12w600.copyWith(color: const Color(0xFF4D81E7)),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: login,
      child: Container(
        height: 48,
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
        child: Text(
          'Log In',
          style: AppStyle.s14w500.copyWith(color: Colors.white),
        ),
      ),
    );
  }




  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(
          color: Color(0xFFEDF1F3),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Or',
          style: AppStyle.s12w400.copyWith(color: Colors.grey)
          ),
        ),
        const Expanded(child: Divider(
          color: Color(0xFFEDF1F3),
        )),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEFF0F6), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x99F4F5FA),
            offset: Offset(0, -3),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          print('Google button tapped!');
        },
        borderRadius: BorderRadius.circular(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/google.png",
              width: 18,
              height: 18,
            ),
            const SizedBox(width: 10),
            Text(
              'Continue with Google',
              style: AppStyle.s14w600,
            ),
          ],
        ),
      ),
    );
  }





  Widget _buildFacebookButton() {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFEFF0F6),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/facebook.png",
              width: 18,
              height: 18,
            ),
            const SizedBox(width: 8),
            const Text(
              'Continue with Facebook',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSignUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: AppStyle.s12w500.copyWith(color: Colors.grey),
        ),
        TextButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScreenSignUp()),
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
            ),
            child:
            Text('Sign Up',style: AppStyle.s12w600.copyWith(color: const Color(0xFF4D81E7),)
            )
        )
      ],
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
                  : null,  // Không hiển thị icon khi obscureText là false
            ),
          ),
        ),
      ],
    );
  }
}





