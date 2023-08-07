import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SplashProvider>(context, listen: false).splashTimer(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(),
        child: const Center(child: Text('Loading ...')),
      ),
    );
  }
}
