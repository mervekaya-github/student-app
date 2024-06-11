import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app/screens/login_screen.dart';
import 'package:student_app/services/auth_service.dart';
import 'package:student_app/services/firebase_service.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  _SignScreenState createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _classController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedDepartment;

  late final AuthService _authService;

  final List<String> _departments = [
    'Tıp',
    'Diş Hekimliği',
    'Bilgisayar Mühendisliği',
    'Makine Mühendisliği'
  ];

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    final firebaseService = FirebaseService();
    _authService = AuthService(firebaseService);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate() && _selectedDepartment != null) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        User? user = await _authService.registerWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        if (user != null) {
          await _authService.registerStudent(
            user.uid,
            _nameController.text.trim(),
            _selectedDepartment!,
            int.parse(_classController.text.trim()),
            _phoneController.text.trim(),
          );

          showDialog(
              context: context,
              builder: (context) {
            return AlertDialog(
                title: const Text('Kayıt Başarılı!'),
                content: const Text('Kayıt işleminiz başarıyla tamamlandı.'),
                actions: [
            TextButton(
            child: const Text('Tamam'),
    onPressed: () {
    Navigator.pop(context); // Popup'ı kap
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    ); // Login ekranına yönlendirme
    },
            ),
                ],
            );
              },
          );
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Kayıt işlemi başarısız oldu: ${e.toString()}';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen adınızı ve soyadınızı girin';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedDepartment,
                        hint: Text(
                          'Bölüm Seçin',
                          style: TextStyle(color: Colors.lightBlue[800]), // Pastel bir metin rengi
                        ),
                        items: _departments.map((String department) {
                          return DropdownMenuItem<String>(
                            value: department,
                            child: Text(department),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedDepartment = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.lightBlue[100], // Pastel bir doldurma rengi
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) => value == null ? 'Lütfen bir bölüm seçin' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _classController,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen sınıfınızı girin';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen telefon numaranızı girin';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen e-posta adresinizi girin';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen şifrenizi girin';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      const SizedBox(height: 16),
                      _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue[800], // Pastel buton rengi
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        child: const Text(
                          'Kayıt Ol',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 16),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
