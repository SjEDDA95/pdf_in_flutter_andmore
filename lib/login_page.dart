// login_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf_gen/home_page.dart';
import 'package:pdf_gen/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'invoice_page.dart';
import 'main.dart'; // Assurez-vous que c'est le bon chemin

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/login'),
      headers: {'Content-Type': 'application/json'},
      body:
          '{"username": "${_usernameController.text}", "password": "${_passwordController.text}"}',
    );

    if (response.statusCode == 200) {
      // Connexion réussie
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', _usernameController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connexion réussie')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Erreur lors de la connexion
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${response.body}')),
      );
    }
  }

  void navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Connexion'),
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
                onPressed: login,
                child: const Text('Se connecter'),
              ),
              TextButton(
                onPressed: navigateToRegister,
                child: const Text('Créer un compte'),
              ),
            ],
          ),
        ));
  }
}
