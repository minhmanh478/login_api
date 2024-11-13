import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_api/ForgotPassword/ScreenVerifyOtp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../common/AppStyle.dart';

class ScreenForgotPassword extends StatefulWidget {
  @override
  _ScreenForgotPasswordState createState() => _ScreenForgotPasswordState();
}

class _ScreenForgotPasswordState extends State<ScreenForgotPassword> {
  TextEditingController emailController = TextEditingController();

  Future<void> _requestOtp() async {
    final email = emailController.text.trim();
    final url = Uri.parse(
        'https://api-dev-photruyen.deepviet.com/api/auth/forgot_password/request');

    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(
          msg: "Hãy điền email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        return;
      }

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      print("Phản hồi từ API: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData != null && responseData['data'] != null && responseData['data']['transaction_id'] != null) {
          String transactionId = responseData['data']['transaction_id'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          bool isStored = await prefs.setString('transaction_id', transactionId);

          if (isStored) {
            print("transaction_id đã được lưu thành công.");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenVerifyOtp(transactionId: transactionId),
              ),
            );
          } else {
            print("Lỗi khi lưu transaction_id.");
          }
        } else {
          print("Lỗi: Không có `transaction_id` trong phản hồi từ API.");
        }
      } else {
        print("Lỗi từ server: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi gửi yêu cầu OTP: $e");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          _buildBack(),
          const SizedBox(height: 24),
          _buildHeader(),
          const SizedBox(height: 24),
          CustomTextField(
            controller: emailController,
            labelText: 'Email',
          ),
          const SizedBox(height: 20),
          _buildContinueButton(),
        ],
      ),
    );
  }



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
        Text("Forgot password", style: AppStyle.s32w700.copyWith(color: Colors.black,height: 16.8/12)),
        SizedBox(height: 8),
        Text(
          "Enter email",
          style: AppStyle.s12w500.copyWith(color: const Color (0xFF6C7278)),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return GestureDetector(
      onTap: _requestOtp,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF375DFB),
              Color(0x7A253EA7),
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
        child: const Text(
          'Continue',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildBody(),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Text(
            labelText ?? '',
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
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
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
            ),
          ),
        ),
      ],
    );
  }
}
