import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notlar_uygulamasi/detaykayitsayfa.dart';
import 'package:notlar_uygulamasi/notdetaysayfa.dart';
import 'package:notlar_uygulamasi/notlardao.dart';

import 'notlar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {




  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<Notlar>> tumNotlariGoster() async {

    var notlarListesi = await Notlardao().tumNotlar();


    return notlarListesi;

  }
  Future<bool> uygulamayiKapat() async {

    await exit(0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed:(){
          uygulamayiKapat();
        }, icon: Icon(Icons.arrow_back_ios)),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center ,
            children:
            [
              Text("Notlar Uygulaması"),

               WillPopScope(
                 onWillPop: uygulamayiKapat,
                 child: FutureBuilder<List<Notlar>>(
                  future: tumNotlariGoster(),
                    builder: (context,snapshot){
                    if (snapshot.hasData) {
                      var notlarListesi = snapshot.data;

                      double ortalama = 0.0;

                      if (!notlarListesi!.isEmpty) {
                        double toplam = 0.0;

                        for (var n in notlarListesi) {
                          toplam = toplam + (n.not1 + n.not2) / 2;
                        }
                        ortalama = toplam / notlarListesi.length;
                      }

                      return Text("Ortalama: ${ortalama.toInt()}");
                    }else{
                      return Text("Ortalama: 0" , style: TextStyle(color: Colors.white, fontSize: 14),);
                    }
                    }
              ),
               )
            ]
        ),
      ),
      body:FutureBuilder<List<Notlar>>(
        future: tumNotlariGoster(),
          builder: (context, snapshot){
          if (snapshot.hasData) {
            var notlarListesi = snapshot.data;
            return ListView.builder(
                itemCount: notlarListesi!.length,
                itemBuilder:(context, indeks){

                  var not= notlarListesi[indeks];
                  return GestureDetector(
                    onTap: (){
                      
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NotDetaySayfa(not: not)));
                    },
                    
                    
                    child: Card(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                width: 80,
                                child:

                            Text(not.ders_adi, style: TextStyle(fontWeight: FontWeight.bold),)),

                            Text(not.not1.toString()),

                            Text(not.not2.toString())


                          ],
                        ),
                      ),
                    ),
                  );


                }
            );

          } else {
            return Center();

            }
          }

      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){

          Navigator.push(context, MaterialPageRoute(builder: (context) => DetayKayitSayfa()));

        },
        tooltip: 'Not Ekle',
        child: const Icon(Icons.add),
      ),
    );
  }
}
