import 'package:flutter/material.dart';


class ErrorPage extends StatelessWidget {
  final String? error;

  const ErrorPage({
    Key? key,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APP_PAGE.error.toTitle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error ?? ""),
            TextButton(
              onPressed: () {},
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
