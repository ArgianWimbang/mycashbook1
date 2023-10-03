import 'package:flutter/material.dart';
import 'package:mycashbook/database_helper.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();

  String _message = '';

  void _clearFields() {
    setState(() {
      _currentPasswordController.clear();
      _newPasswordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan',
        style: TextStyle(
                // height: 10,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 2, 33, 125)
              ),
      ),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ubah Password',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SizedBox(
              // <-- SEE HERE
              // width: 270,
              height: 43,
              child: TextField(
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  labelText: 'Password Saat Ini',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              // <-- SEE HERE
              // width: 270,
              height: 43,
              child: TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password Baru',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
           
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final oldPassword = _currentPasswordController.text;
                final newPassword = _newPasswordController.text;

                final user =
                    await DatabaseHelper.instance.getUser('user', oldPassword);

                if (user != null) {
                  // Kata sandi lama benar
                  final rowsAffected = await DatabaseHelper.instance
                      .updatePassword('user', newPassword);

                  if (rowsAffected > 0) {
                    // Kata sandi berhasil diperbarui
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Kata Sandi Berhasil Diperbarui'),
                      ),
                    );

                    // Clear the password fields after successful update
                    _clearFields();
                  } else {
                    // Terjadi kesalahan
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Terjadi Kesalahan. Silakan Coba Lagi.'),
                      ),
                    );
                  }
                } else {
                  // Kata sandi lama salah
                  setState(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Kata sandi lama salah!'),
                      ),
                    );
                  });
                }
              },
              child: Text('Simpan', style: TextStyle(color: const Color.fromARGB(255, 2, 126, 66), fontSize: 15)),
            ),
            SizedBox(height: 33),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Developer Mobile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 3),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/foto.jpg'),
              ),
              title: Text('Argian Wimbang Ekivarel'),
              subtitle: Text('1941720113'),
            ),
            SizedBox(height: 3),
            Text(_message), // Display the message here
          ],
        ),
      ),
    );
  }
}
