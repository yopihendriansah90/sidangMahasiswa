import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class Formpengajuansidang extends StatefulWidget {
  const Formpengajuansidang({super.key});

  @override
  State<Formpengajuansidang> createState() => _FormpengajuansidangState();
}

class _FormpengajuansidangState extends State<Formpengajuansidang> {
  bool isVisible = false;
  String UkuranFile = "";
  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
  final List<String> items = ['Proposal', 'Hasil', 'Kompre'];

  final TextEditingController nameFileController = TextEditingController();
  final TextEditingController tipeFileController = TextEditingController();
  final TextEditingController ukuranFileController = TextEditingController();

  // void _submitForm() {
  //   if (_formKey.currentState.validate()) {
  //     final nameFile = nameFileController;
  //     final tipeFile = tipeFileController;
  //     final ukuranFile = int.tryParse(ukuranFileController.text) ?? 0;

  //     print('nama File : $nameFile');
  //     print('tipe File : $tipeFile');
  //     print('ukuran File : $ukuranFile');
  //     // Simpan ke database, kirim ke API, dll
  //   }
  // }

  File? selectedFile;
  Future<void> _pickPdfFile() async {
    FilePickerResult? reslut = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (reslut != null && reslut.files.single.path != null) {
      File file = File(reslut.files.single.path!);

      final fileName = path.basename(file.path);
      final fileExtension = path.extension(file.path).replaceAll('.', '');
      final fileSizeKb = file.lengthSync() ~/ 1024;

      setState(() {
        selectedFile = file;
        nameFileController.text = fileName;
        tipeFileController.text = fileExtension;
        ukuranFileController.text = fileSizeKb.toString();
        isVisible = true;
        UkuranFile = fileSizeKb.toString();
      });
    }
  }

  Future<void> _uploadFile() async {
    if (selectedFile == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Pilih file terlebih dahulu")));
      return;
    }
  }

  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse('https://your-server.com/upload'), // Ganti sesuai endpoint
  //   );
  // request.files.add(await http.http.MultipartFile.formPath(
  //   'file', // name sesuai filed backend
  //   selectedFile!.path,
  // ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Pengajuan Sidang"),
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
                Text("NIM", style: TextStyle(fontSize: 18, color: Colors.teal)),
                TextFormField(
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
                  "Judul Sripsi",
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                ),
                TextFormField(
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
                  "Dosen Pembimbing",
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                ),
                TextFormField(
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
                  "kategori Sidang",
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                ),
                DropdownButtonFormField(
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
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  hint: Text("Pilih kategori Sidang"),
                  value: selectedValue,
                  items: items.map((String value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  },
                ),

                SizedBox(height: 15),
                Text(
                  "Nama File",
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                ),
                TextField(
                  readOnly: true,
                  controller: nameFileController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        _pickPdfFile();
                        print("Get file");
                      },
                      icon: Icon(Icons.file_open),
                      color: Colors.teal,
                    ),
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
                Visibility(
                  visible: isVisible,
                  child: Row(
                    children: [
                      Text("Ukuran File:  ${(UkuranFile)} Kb"),
                      Spacer(),
                      Text("Extension : ${tipeFileController.text} "),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      print("Ok");
                    },

                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(5),
                      ),
                    ),
                    child: Text(
                      "Kirim Sekarang!",
                      style: TextStyle(fontSize: 20, color: Colors.white),
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
