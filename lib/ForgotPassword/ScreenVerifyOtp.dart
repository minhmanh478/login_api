import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../common/AppStyle.dart';
import 'ScreenResetPassword.dart';

class ScreenVerifyOtp extends StatefulWidget {
  final String transactionId;

  ScreenVerifyOtp({required this.transactionId});

  @override
  _ScreenVerifyOtpState createState() => _ScreenVerifyOtpState();
}

class _ScreenVerifyOtpState extends State<ScreenVerifyOtp> {
  TextEditingController otpController = TextEditingController();

  Future<void> _verifyOtp() async {
    final otp = otpController.text.trim();
    final transactionId = widget.transactionId;

    if (otp.isEmpty) {
      print("OTP không được để trống.");
      return;
    }

    final url = Uri.parse(
        'https://api-dev-photruyen.deepviet.com/api/auth/forgot_password/verify_otp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'transaction_id': transactionId,
          'otp': otp, // OTP nhập vào
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("API Response: $responseData");

        if (responseData['message'] == "Thành công") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ScreenResetPassword(transactionId: transactionId),
            ),
          );
        } else {
          print("OTP không hợp lệ: ${responseData['message']}");
        }
      } else {
        print("Lỗi từ server: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Lỗi khi xác thực OTP: $e");
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
            const SizedBox(height: 24),
            _buildBack(),
            const SizedBox(height: 24),
            _buildHeader(),
            const SizedBox(height: 24),
            CustomTextField(
              controller: otpController,
              labelText: 'OTP',
            ),
            const SizedBox(height: 20),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  // Widget back button
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

  // Widget header
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Forgot password", style: AppStyle.s32w700.copyWith(color: Colors.black)),
        const SizedBox(height: 8),
        Text(
          "Enter OTP",
          style: AppStyle.s12w500.copyWith(color: Color(0xFF6C7278)),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return GestureDetector(
      onTap: _verifyOtp,
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
