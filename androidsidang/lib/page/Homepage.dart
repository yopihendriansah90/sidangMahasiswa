import 'package:androidsidang/page/Daftarsidangpage.dart';
import 'package:androidsidang/page/FormPengajuan.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Beranda(),
    Daftarsidangpage(),
    Center(child: Text("Profile")),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Beranda'),
        // backgroundColor: Colors.teal,
        // foregroundColor: Colors.white,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.person_3),)
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_rounded),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class Beranda extends StatefulWidget {
   Beranda({super.key});
  final List<MenuItemData> menuItems = [
    MenuItemData(icon: Icons.upload_file, title: "Pengajuan Jadwal", subtitle: "Ajukan Sidang"),
    MenuItemData(icon: Icons.info_outline, title: "Informasi Sidang", subtitle: "Cek Jadwal dan Status"),
  ];


  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {

  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      // color: Colors.amber,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Halo, Yopi",
            style: TextStyle(
              fontSize: 30,
              color: Colors.teal,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            width: MediaQuery.of(context).size.width,

            decoration: BoxDecoration(
              color: Colors.teal[300],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.tealAccent,
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat datang",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Ini adalah jumbotron",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Expanded(child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4/3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10
          ),
          itemCount: widget.menuItems.length,
          itemBuilder: (context, index){
            final item = widget.menuItems[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                
              ),
              child: InkWell(
                onTap: () {
                  if(item.title=='Pengajuan Jadwal'){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Formpengajuansidang()));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item.icon,size: 40,color: Colors.teal,),
                      SizedBox(height: 10,),
                      Text(item.title,style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text(item.subtitle,style: TextStyle(fontSize: 12,color: Colors.grey[600]),)
                      
                    ],
                  ),

                  ),
              ),
            );
          },),)
         
        ],
      ),
    );
  }
}

class MenuItemData {
  final IconData icon;
  final String title;
  final String subtitle;

  MenuItemData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
