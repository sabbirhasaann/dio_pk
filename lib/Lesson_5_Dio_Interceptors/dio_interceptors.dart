import 'package:flutter/material.dart';

class DioInterceptors extends StatefulWidget {
  const DioInterceptors({super.key});

  @override
  State<DioInterceptors> createState() {
    return _DioInterceptorsState();
  }
}

class _DioInterceptorsState extends State<DioInterceptors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Dio Interceptors',
        ),
      ),
    );
  }
}
