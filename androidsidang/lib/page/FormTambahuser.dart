import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class Formtambahuser extends StatefulWidget {
  const Formtambahuser({super.key});

  @override
  State<Formtambahuser> createState() => _FormtambahuserState();
}

class _FormtambahuserState extends State<Formtambahuser> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool isVisible = false;

  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
  final List<String> items = ['Proposal', 'Hasil', 'Kompre'];

  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController password1Controller = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();

  Future<void> createUser() async {
    final url = Uri.parse(
      "http://192.168.122.1:8000/api/users",
    ); //alamat userl api
    final response = await http.post(
      //coding untuk  mengirim data
      url,
      headers: {
        "Content-Type": "aplication/json",
        "Accept": "aplicatioin/json",
      },
      body: jsonEncode({
        "name": namaController.text,
        "email": emailController.text,
        "password": password1Controller.text,
      }),
    );

    // pengeceakan respon
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print("User created: ${data['data']}");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("User berhasil dibuat"),backgroundColor: Colors.teal,));
    } else {
      final Map<String, dynamic> errorData = jsonDecode(response.body);

      // Ambil error detail Laravel
      String errorMessage = "";

      if (errorData.containsKey('errors')) {
        errorData['errors'].forEach((key, value) {
          if (value is List && value.isNotEmpty) {
            errorMessage +=
                "- ${value[0]}\n"; // ambil pesan pertama dari setiap field
          }
        });
      } else if (errorData.containsKey('message')) {
        errorMessage = errorData['message'];
      } else {
        errorMessage = "Terjadi kesalahan tak dikenal.";
      }

      print("Gagal: $errorMessage");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage),backgroundColor: Colors.red[800],));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Tambah User"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // color: Colors.amber,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Lengkap",
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                ),
                TextFormField(
                  controller: namaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Email",
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                ),
                TextFormField(
                  controller: password1Controller,
                  obscureText: _obscureText1,
                  decoration: InputDecoration(
                    isDense: true, // Biar lebih kompak
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText1 ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText1 = !_obscureText1;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                SizedBox(height: 15),
                Text(
                  "Ketik Ulang Password",
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                ),
                TextFormField(
                  controller: password2Controller,
                  obscureText: _obscureText2,
                  decoration: InputDecoration(
                    isDense: true, // Biar lebih kompak
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText2 ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText2 = !_obscureText2;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (password1Controller.text ==
                          password2Controller.text) {
                        createUser();
                      } else {
                        print("tidak ok");
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(5),
                      ),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 20),
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
