import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  static const routeName = '/';
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(children: <Widget>[
        Center(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  'Hello BookLib User',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Palatino',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Username',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/bookshelf');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow.shade900,
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}