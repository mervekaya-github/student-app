import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50], // Pastel bir arka plan rengi
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800], // Uyumlu renk
        title: Text('Bilgilerim'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField('Ad-Soyad', 'Ad-Soyad'),
              SizedBox(height: 16),
              buildTextField('Bölüm', 'Bölüm'),
              SizedBox(height: 16),
              buildTextField('Sınıf', 'Sınıf'),
              SizedBox(height: 16),
              buildTextField('Telefon', 'Telefon', keyboardType: TextInputType.phone),
              SizedBox(height: 32),
              buildButtonRow(context, 'Sınıf Arkadaşlarım', () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Sınıf Arkadaşlarım'),
                      content: Text('Bu bölüm henüz geliştirilmedi.'),
                      actions: [
                        TextButton(
                          child: Text('Tamam'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              }),
              SizedBox(height: 16),
              buildButtonRow(context, 'Mesajlarım', () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Mesajlarım'),
                      content: Text('Bu bölüm henüz geliştirilmedi.'),
                      actions: [
                        TextButton(
                          child: Text('Tamam'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue[800],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.lightBlue[100],
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.lightBlue[800]),
            ),
            keyboardType: keyboardType,
          ),
        ),
      ],
    );
  }

  Widget buildButtonRow(BuildContext context, String text, VoidCallback onPressed) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
      ),
    );
  }
}
