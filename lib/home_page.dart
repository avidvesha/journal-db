import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:journal_coffee/choco.dart';
import 'package:journal_coffee/tea.dart';
import 'package:journal_coffee/widget/category.dart';
import 'package:journal_coffee/widget/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'beverage.dart';
import 'coffee.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final userId = FirebaseAuth.instance.currentUser!.uid;

  List KategoriLis = [
    "Semua",
    "Coffee",
    "Chocolate",
    "Tea",
    "Pastry",
    "Beverage",
  ];

  int IndexKategori = 0;
  String searchText = "";
  
  List<dynamic> produkList = [];
  List<dynamic> produkKeys = [];
  List<dynamic> filterProdukList = [];
  List<dynamic> filterProdukKeys = [];
  List<dynamic> searchProdukList = [];
  List<dynamic> searchProdukKeys = [];

  Future<void> getData() async {
    FirebaseDatabase.instance.ref().child("produk").onValue.listen((event) {
      produkList.clear();
      produkKeys.clear();
      setState(() {
        List<dynamic>? _foodMap = event.snapshot.value as List?;
        if (_foodMap != null) {
          _foodMap.asMap().forEach((index, value) {
            if(value != null) {
              produkKeys.add(index.toString());
              produkList.add(value);
            }
          });
        }
      });
    });
  }
  
  Future<void> saveCart(keys, nama_produk, image, harga) async {
    await FirebaseDatabase.instance.ref().child('user').child(userId).child('cart').child(keys).set({
      "nama_produk":nama_produk,
      "image":image,
      "jumlah":1,
      "harga":harga,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                    height: 270, width: double.infinity, color: Color.fromRGBO(29, 29, 29, 1),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://studiolorier.com/wp-content/uploads/2018/10/Profile-Round-Sander-Lorier.jpg")),
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                          width: 2))),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Selamat Datang di Journal Coffee !",
                                style:
                                    GoogleFonts.montserrat(color: Colors.white),
                              )
                            ],
                          ),
                          Container(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                                size: 30,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFF5F5F7),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextField(
                          cursorHeight: 20,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {
                              searchText = value.toLowerCase();
                              searchProdukList = produkList.where((produk) =>
                                  produk['nama_produk'].toLowerCase().contains(searchText)).toList();
                              searchProdukKeys = produkList.map((e)  {
                                int originalIndex = produkList.indexOf(e);
                                return produkKeys[originalIndex];
                              }).toList();
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        width: 270,
                        height: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                image: AssetImage("assets/coffee_1.jpg"),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Center(
              child: Container(
                width: double.infinity,
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  // physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemCount: KategoriLis.length,
                    itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      setState(() {
                        IndexKategori = index;
                        filterProdukList = produkList.where((produk) =>
                        produk['kategori'].contains(KategoriLis[index])).toList();
                        filterProdukKeys = produkList.map((e)  {
                          int originalIndex = produkList.indexOf(e);
                          return produkKeys[originalIndex];
                        }).toList();
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            color: IndexKategori == index ? Color.fromRGBO(198, 124, 78, 1) : Color.fromRGBO(235, 235, 235, 0.5)

                          ),
                          width: 70,
                          child: Text(KategoriLis[index], style: TextStyle(color: IndexKategori == index ? Colors.white : Colors.black),),
                        ),
                        SizedBox(width: 5,)
                      ],
                    ),
                  );
                })
              ),
            ),
            if(IndexKategori != 0)Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              height: 500,
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 250,
                  ),
                  itemCount: filterProdukList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        filterProdukList[index]['image']
                                    ),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            filterProdukList[index]['nama_produk'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                filterProdukList[index]['harga'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              IconButton(onPressed: () {
                                saveCart(
                                    filterProdukKeys[index],
                                    filterProdukList[index]['nama_produk'],
                                    filterProdukList[index]['image'],
                                    filterProdukList[index]['harga']);
                              }, icon: Icon(Icons.add))
                            ],
                          )
                        ],
                      ),
                    );
                  }
              ),
            ),
            if(searchText != "")Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              height: 500,
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 250,
                  ),
                  itemCount: searchProdukList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        searchProdukList[index]['image']
                                    ),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            searchProdukList[index]['nama_produk'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                searchProdukList[index]['harga'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              IconButton(onPressed: () {
                                saveCart(
                                    searchProdukKeys[index],
                                    searchProdukList[index]['nama_produk'],
                                    searchProdukList[index]['image'],
                                    searchProdukList[index]['harga']);
                              }, icon: Icon(Icons.add))
                            ],
                          )
                        ],
                      ),
                    );
                  }
              ),
            ),
            if(IndexKategori == 0)Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              height: 2650,
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 250,
                  ),
                  itemCount: produkList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        produkList[index]['image']
                                    ),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            produkList[index]['nama_produk'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                produkList[index]['harga'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              IconButton(onPressed: () {
                                saveCart(
                                    produkKeys[index],
                                    produkList[index]['nama_produk'],
                                    produkList[index]['image'],
                                    produkList[index]['harga']);
                              }, icon: Icon(Icons.add))
                            ],
                          )
                        ],
                      ),
                    );
                  }
              ),
            )
            ],
          )
        ),
      ),
    );
  }
}
