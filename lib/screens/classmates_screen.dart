import 'package:flutter/material.dart';

import '../models/User.dart';

class ClassmatesScreen extends StatelessWidget {
  const ClassmatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<User> classmates = const [
      User(name: 'Ahmet Yılmaz', department: 'Bilgisayar Mühendisliği', studentClass: 3, phone: '123-456-7890'),
      User(name: 'Mehmet Kaya', department: 'Makine Mühendisliği', studentClass: 2, phone: '098-765-4321'),
      User(name: 'Ayşe Demir', department: 'Elektrik-Elektronik Mühendisliği', studentClass: 1, phone: '567-890-1234'),
      User(name: 'Fatma Şahin', department: 'İnşaat Mühendisliği', studentClass: 4, phone: '345-678-9012'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sınıf Arkadaşlarım'),
      ),
      body: ListView.builder(
        itemCount: classmates.length,
        itemBuilder: (context, index) {
          final classmate = classmates[index];
          return ListTile(
            title: Text(classmate.name),
            subtitle: Text('${classmate.department} - Sınıf: ${classmate.studentClass}'),
            trailing: IconButton(
              icon: const Icon(Icons.message),
              onPressed: () {
                // Mesaj gönderme işlemi
              },
            ),
          );
        },
      ),
    );
  }
}
