import 'package:flutter/material.dart';
import 'package:mycashbook/database_helper.dart';

class TambahPengeluaranPage extends StatefulWidget {
  @override
  _TambahPengeluaranPageState createState() => _TambahPengeluaranPageState();
}

class _TambahPengeluaranPageState extends State<TambahPengeluaranPage> {
  TextEditingController _tanggalController = TextEditingController();
  TextEditingController _jumlahController = TextEditingController();
  TextEditingController _keteranganController = TextEditingController();

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _tanggalController.text = pickedDate.toString();
      });
    }
  }

  void _resetFields() {
    _tanggalController.text = '01/01/2021';
    _jumlahController.text = '';
    _keteranganController.text = '';
  }

  void _saveDataToSQLite() async {
    String tanggal = _tanggalController.text;
    String jumlah = _jumlahController.text;
    String keterangan = _keteranganController.text;

    if (tanggal.isEmpty || jumlah.isEmpty || keterangan.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Isi semua field!'),
        ),
      );
      return;
    }

    Map<String, dynamic> pengeluaran = {
      'tanggal_pengeluaran': tanggal,
      'nominal_pengeluaran': int.parse(jumlah),
      'keterangan_pengeluaran': keterangan,
    };

    int result = await DatabaseHelper.instance.insertPengeluaran(pengeluaran);

    if (result != -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data Pengeluaran Berhasil Disimpan!'),
        ),
      );

      _resetFields();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi Kesalahan. Data Tidak Tersimpan!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pengeluaran',
        style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 237, 40, 26)
              ),
      ),),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tanggalController,
              decoration: InputDecoration(
                hintText: 'Tanggal',
                suffixIcon: IconButton(
                  onPressed: _showDatePicker,
                  icon: Icon(Icons.calendar_today),
                ),
              ),
              readOnly: true,
            ),
            TextField(
              controller: _jumlahController,
              decoration: InputDecoration(hintText: 'Jumlah (Nominal)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _keteranganController,
              decoration: InputDecoration(hintText: 'Keterangan'),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: _resetFields,
                  child: Text('Reset', style: TextStyle(color: const Color.fromARGB(252, 0, 0, 0), fontSize: 15)),
                ),
                SizedBox(height: 13),
                SizedBox(width: 8,),
                ElevatedButton(
                  onPressed: _saveDataToSQLite,
                 child: Text('Simpan', style: TextStyle(color: const Color.fromARGB(255, 2, 126, 66), fontSize: 15)),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                //   child: Text('<< Kembali'),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
