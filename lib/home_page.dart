import 'package:flutter/material.dart';
import 'package:mycashbook/database_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int totalPengeluaran = 0;
  int totalPemasukan = 0;
  int sisaUang = 0;

  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk mengambil total pengeluaran dan pemasukan
    _updateTotals();
  }

  Future<void> _updateTotals() async {
    int totalPengeluaranFromDB =
        await DatabaseHelper.instance.getTotalPengeluaran();
    int totalPemasukanFromDB =
        await DatabaseHelper.instance.getTotalPemasukan();

    // Perbarui state dengan total pengeluaran dan pemasukan dari database
    setState(() {
      totalPengeluaran = totalPengeluaranFromDB;
      totalPemasukan = totalPemasukanFromDB;
      sisaUang = totalPemasukan - totalPengeluaran;
    });
  }

  @override



  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Halaman Utama',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CATATAN KEUANGAN',
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ),
              SizedBox(height: 8),
            // Label untuk total pengeluaran
            Text(
              'Pengeluaran = Rp $totalPengeluaran',
               style: TextStyle(fontSize: 13, color: Colors.red,fontWeight: FontWeight.bold,),
            ),

            // Label untuk total pemasukan
            Text(
              'Pemasukan = Rp $totalPemasukan',
              style: TextStyle(fontSize: 13, color: Colors.green,fontWeight: FontWeight.bold,),
            ),

            Text(
              'Selisih = Rp $sisaUang',
              style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,),
            ),
            SizedBox(height: 20),
            // [BONUS] Placeholder untuk grafik atau gambar
            Container(
              
              width: 200,
              height: 200,
              
              child: Center(
                child: Image.asset(
                  'assets/grafik.png',
                  width: 200,
                  height: 150,
                  fit: BoxFit.cover, // Sesuaikan dengan kebutuhanmu
                ),
              ),
            ),

            SizedBox(height: 20),
            // 4 ImageButton untuk navigasi
            Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Button tambah pemasukan
                    Container(
                     
                      // color: Color.fromARGB(255, 24, 243, 39),
                      child: NavigationButton(
                        icon: Icons.login,
                        
                        label: '+ Pemasukan', 
                        onPressed: () {
                          Navigator.pushNamed(context, '/tambah_pemasukan');
                        },
                      ),
                    ),
                    SizedBox(width: 25), // Spasi antar tombol
                    Container(
                     
                      child: NavigationButton(
                        icon: Icons.logout ,
                        label: '- Pengeluaran',
                        onPressed: () {
                          Navigator.pushNamed(context, '/tambah_pengeluaran');
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15), // Spasi antara dua baris tombol
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Container(
                     
                      child: NavigationButton(
                        icon: Icons.view_list,
                        label: 'Cash Flow',
                        onPressed: () {
                          Navigator.pushNamed(context, '/detail_cash_flow');
                        },
                      ),
                    ),
                    SizedBox(width: 54), // Spasi antar tombol
                    Container(
                      
                      child: NavigationButton(
                        icon: Icons.settings,
                        label: 'Setting',
                        onPressed: () {
                          Navigator.pushNamed(context, '/setting');
                        },
                      ),
                    ),
                     
                  ],
                )
              ],
            ),SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// Widget untuk tombol navigasi
class NavigationButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onPressed;

  const NavigationButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: () {
            // Panggil fungsi onPressed ketika tombol ditekan
            onPressed();
          },
        ),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
