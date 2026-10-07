import 'package:flutter/material.dart';

class AuthenticationInterceptorDemoPage extends StatefulWidget {
  const AuthenticationInterceptorDemoPage({super.key});

  @override
  State<AuthenticationInterceptorDemoPage> createState() {
    return _AuthenticationInterceptorDemoPageState();
  }
}

class _AuthenticationInterceptorDemoPageState
    extends State<AuthenticationInterceptorDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Authentication Interceptor',
        ),
      ),
    );
  }
}
