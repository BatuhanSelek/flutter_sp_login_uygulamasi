import 'package:flutter/material.dart';
import 'package:flutter_sp_login_uygulamasi/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  String? spKullaniciAdi;
  String? spSifre;

  Future<void> oturumBilgisiOku() async {
    var sp = await SharedPreferences.getInstance();
    setState(() {
      spKullaniciAdi = sp.getString('kullaniciAdi') ?? 'Kullanıcı Adı Yok';
      spSifre = sp.getString('sifre') ?? 'Şifre Yok';
    });
  }

  Future<void> cikisYap() async {
    var sp = await SharedPreferences.getInstance();
    sp.remove("kullaniciAdi");
    sp.remove("sifre");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginEkrani()));
  }

  @override
  void initState() {
    super.initState();
    oturumBilgisiOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          "Anasayfa",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              cikisYap();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Kullanıcı Adı : $spKullaniciAdi",
                style: const TextStyle(fontSize: 30),
              ),
              Text(
                "Şifre : $spSifre",
                style: const TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
