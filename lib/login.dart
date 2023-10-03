import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance;
  }

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final context = this.context; // Assign the context to a local variable

    final user = await DatabaseHelper.instance.getUser(username, password);

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Page',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 5),
            Container(
              width: 200,
              height: 200,
              child: Center(
                child: Image.asset(
                  'assets/login.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'MyCashBook v.1',
              style: TextStyle(
                // height: 10,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              // <-- SEE HERE
              width: 230,
              height: 43,
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 9.0),
            SizedBox(
              // <-- SEE HERE
              width: 230,
              height: 43,
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _login,
              
              child: Text('  Login  ',style: TextStyle(color: Color.fromARGB(255, 2, 14, 126), fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
