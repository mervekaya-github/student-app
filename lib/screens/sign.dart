import 'package:flutter/material.dart';
import 'package:student_app/screens/login.dart';

class SignScreen extends StatefulWidget {
  @override
  _SignScreenState createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _register() {
    // Kayıt işlemi tamamlandıktan sonra gösterilecek popup
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Kayıt Başarılı!'),
          content: Text('Kayıt işleminiz başarıyla tamamlandı.'),
          actions: [
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.pop(context); // Popup'ı kapat
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ); // Login ekranına yönlendirme
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50], // Pastel bir arka plan rengi
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hesap Oluştur',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800], // Pastel bir metin rengi
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(height: 32),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Ad-Soyad',
                    labelStyle: TextStyle(color: Colors.lightBlue[800]), // Pastel bir metin rengi
                    filled: true,
                    fillColor: Colors.lightBlue[100], // Pastel bir doldurma rengi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Bölüm',
                    labelStyle: TextStyle(color: Colors.lightBlue[800]), // Pastel bir metin rengi
                    filled: true,
                    fillColor: Colors.lightBlue[100], // Pastel bir doldurma rengi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Sınıf',
                    labelStyle: TextStyle(color: Colors.lightBlue[800]), // Pastel bir metin rengi
                    filled: true,
                    fillColor: Colors.lightBlue[100], // Pastel bir doldurma rengi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Telefon',
                    labelStyle: TextStyle(color: Colors.lightBlue[800]), // Pastel bir metin rengi
                    filled: true,
                    fillColor: Colors.lightBlue[100], // Pastel bir doldurma rengi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'E-posta',
                    labelStyle: TextStyle(color: Colors.lightBlue[800]), // Pastel bir metin rengi
                    filled: true,
                    fillColor: Colors.lightBlue[100], // Pastel bir doldurma rengi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.lightBlue[800]),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                TextField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    labelStyle: TextStyle(color: Colors.lightBlue[800]), // Pastel bir metin rengi
                    filled: true,
                    fillColor: Colors.lightBlue[100], // Pastel bir doldurma rengi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.lightBlue[800], // Pastel bir simge rengi
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _register,
                  child: Text(
                    'Kayıt Ol',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[800], // Pastel buton rengi
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Geri dönmek için
                  },
                  child: Text(
                    'Geri Dön',
                    style: TextStyle(
                      color: Colors.lightBlue[800],
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
