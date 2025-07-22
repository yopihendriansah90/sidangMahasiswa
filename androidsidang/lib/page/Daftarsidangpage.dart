import 'package:flutter/material.dart';

class Daftarsidangpage extends StatefulWidget {
  const Daftarsidangpage({super.key});

  @override
  State<Daftarsidangpage> createState() => _DaftarsidangpageState();
}

class _DaftarsidangpageState extends State<Daftarsidangpage> {
  List<Map<String, dynamic>> DataSidang = [
    {
      "nama": "yopi",
      "ruangan": "Ruangan A80",
      "dosen": "Drs. Doni Setiawan. SH .MM",
      "tanggal": "01 Agustus 2025",
      "jam": "08:00 WIB",
    },
    {
      "nama": "test",
      "ruangan": "Ruangan A82",
      "dosen": "Budi Wahyudi. S.Kom",
      "tanggal": "01 Agustus 2025",
      "jam": "08:00 WIB",
    },
    {
      "nama": "Tes lagi",
      "ruangan": "Ruangan A80",
      "dosen": "Rini Anggraeni S.Kom",
      "tanggal": "01 Agustus 2025",
      "jam": "08:00 WIB",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Home"),
      //   backgroundColor: Colors.teal,
      //   foregroundColor: Colors.white,
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color.fromARGB(111, 0, 150, 135),
        child: ListView.builder(
          itemCount: DataSidang.length,
          itemBuilder: (context, i) {
            return Container(
              padding: EdgeInsets.all(1),
              child: GestureDetector(
                onTap: () {
                  print(
                    DataSidang[i]['nama']
                  );
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "#${i + 1} ${DataSidang[i]['nama'].toString().toUpperCase()}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        Text(
                          "Sitem Informasi Sidang Skripsi",
                          style: TextStyle(color: Colors.black87),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Icon(
                                    Icons.calendar_month,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${DataSidang[i]['tanggal']}, ${DataSidang[i]['jam']}",
                                    ),
                                    Text(DataSidang[i]['ruangan']),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Icon(
                                    Icons.account_circle_sharp,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(DataSidang[i]['dosen'])],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
