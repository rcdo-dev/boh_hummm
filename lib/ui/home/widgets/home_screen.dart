import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Logo\nBoh Hummm',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ElevatedButton.icon(
                label: const Text(
                  'Login com Google',
                ),
                icon: const Icon(
                  Icons.g_mobiledata,
                  size: 25,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
