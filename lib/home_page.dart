import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'invoice_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Welcome to the Mecafinder App'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Since there's only one item, no navigation is needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MECAFINDER'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('username');

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 56, // Standard height for bottom navigation
          child: InkWell(
            onTap: () => _navigateToInvoices(context),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt),
                const SizedBox(width: 8),
                const Text('Invoices'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToInvoices(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InvoicePage()),
    );
  }
}
