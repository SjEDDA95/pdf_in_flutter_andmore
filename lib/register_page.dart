// register_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> register() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/register'),
      headers: {'Content-Type': 'application/json'},
      body:
          '{"username": "${_usernameController.text}", "password": "${_passwordController.text}"}',
    );

    if (response.statusCode == 200) {
      // Inscription réussie
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inscription réussie')),
      );
      Navigator.pop(context);
    } else {
      // Erreur lors de l'inscription
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Inscription'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                decoration:
                    const InputDecoration(labelText: 'Nom d\'utilisateur'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: register,
                child: const Text('S\'inscrire'),
              ),
            ],
          ),
        ));
  }
}
