import 'package:flutter/material.dart';
import 'package:flutter_sp_login_uygulamasi/Anasayfa.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> oturumKontrol() async {
    var sp = await SharedPreferences.getInstance();

    String spKullaniciAdi = sp.getString('kullaniciAdi') ?? 'Kullanıcı Adı Yok';
    String spSifre = sp.getString('sifre') ?? 'Şifre Yok';

    if (spKullaniciAdi == "admin" && spSifre == "123") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SP Login Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: oturumKontrol(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool? gecisIzni = snapshot.data;
            return gecisIzni! ? const Anasayfa() : const LoginEkrani();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class LoginEkrani extends StatefulWidget {
  const LoginEkrani({super.key});

  @override
  State<LoginEkrani> createState() => _LoginEkraniState();
}

class _LoginEkraniState extends State<LoginEkrani> {
  var tfKullaniciAdi = TextEditingController();
  var tfSifre = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> girisKontrol() async {
    var ka = tfKullaniciAdi.text;
    var s = tfSifre.text;

    if (ka == "admin" && s == "123") {
      var sp = await SharedPreferences.getInstance();
      sp.setString("kullaniciAdi", ka);
      sp.setString("sifre", s);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Anasayfa()));
    } else {
      final scaffoldMessenger =
          ScaffoldMessenger.of(scaffoldKey.currentContext!);
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: const Text("Giriş Hatalı"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          "Login Ekranı",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: tfKullaniciAdi,
                decoration: const InputDecoration(
                  hintText: "Kullanıcı Adı",
                ),
              ),
              TextField(
                obscureText: true,
                controller: tfSifre,
                decoration: const InputDecoration(
                  hintText: "Şifre",
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Giriş Yap"),
                onPressed: () {
                  girisKontrol();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
