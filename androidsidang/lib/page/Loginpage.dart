import 'dart:convert';
import 'package:androidsidang/page/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool _obscureText = true;
  final String _username = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordControllers = TextEditingController();

  Future<void> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    final url = Uri.parse('http://192.168.122.1:8000/api/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final contentType = response.headers['content-type'];
          if (contentType != null && contentType.contains('application/json')) {
            final data = jsonDecode(response.body);
            print("Login success!");
            print("User: ${data['user']}");
            print("Token: ${data['token']}");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Login berhasil"),
                duration: Duration(seconds: 1),
              ),
            );
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Homepage()),
              (route) => false,
            );
          } else {
            print("Bukan response JSON, ini isi body:");
            print(response.body); // ini biasanya halaman HTML
          }
        } catch (e) {
          final data = jsonDecode(response.body);
          print("Gagal parsing JSON: $e");
          print("Isi response: ${response.body}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${data['message']}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        final data = jsonDecode(response.body);
        print("Status gagal: ${response.statusCode}");
        print("Isi response: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${data['message']}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            // Padding(padding: EdgeInsetsGeometry.all(10)),
            SizedBox(height: 70),
            Image(
              image: NetworkImage(
                "https://mayasaribakti.ac.id/wp-content/uploads/2024/12/cropped-LOGO-UNIVERSITAS-MAYASARI-BAKTI-png.png",
              ),
              width: MediaQuery.of(context).size.width / 3,
            ),
            SizedBox(height: 10),
            Text(
              "Welcome back!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            Text(
              "Login to continue",
              style: TextStyle(
                fontSize: 18,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                ),
                TextFormField(
                  controller: emailController,

                  decoration: InputDecoration(
                    // labelText: 'Email',
                    isDense: true, // Biar lebih kompak
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                      borderRadius: BorderRadius.circular(8),
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
                SizedBox(height: 30),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                ),
                TextFormField(
                  controller: passwordControllers,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    // labelText: 'Password',
                    isDense: true, // Biar lebih kompak
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                      borderRadius: BorderRadius.circular(8),
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
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  print("ok");
                },
                child: Text(
                  "Forget Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  final email = emailController.text.trim();
                  final password = passwordControllers.text.trim();
                  loginUser(context, email, password);
                },

                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(5),
                  ),
                ),
                child: Text(
                  "Log In",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an accout? ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    print("test aman");
                  },
                  child: Text(
                    "Sign up now!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
