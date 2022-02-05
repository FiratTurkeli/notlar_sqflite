import 'package:flutter/material.dart';
import 'package:notlar_uygulamasi/notlardao.dart';

import 'main.dart';
import 'notlar.dart';

class NotDetaySayfa extends StatefulWidget {
  late Notlar not;


  NotDetaySayfa({required this.not});

  @override
  _NotDetaySayfaState createState() => _NotDetaySayfaState();
}

class _NotDetaySayfaState extends State<NotDetaySayfa> {


  var tfdersAdi = TextEditingController();
  var tfNot1 = TextEditingController();
  var tfNot2 = TextEditingController();

  Future<void> sil(int not_id)   async {

    await Notlardao().notSil(not_id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  Future<void> guncelle(int not_id, String ders_adi, int not1, int not2) async {

    await Notlardao().notGuncelle(not_id, ders_adi, not1, not2);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  void initState() {

    super.initState();
    var not = widget.not;
    tfdersAdi.text = not.ders_adi.toString() ;
    tfNot1.text = not.not1.toString()  ;
    tfNot2.text = not.not2.toString()  ;


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Detay Sayfa"),
        actions: [
          TextButton(onPressed:(){
            sil(widget.not.not_id);
          }, child: Text("Sil", style: TextStyle(color: Colors.white),)),
          TextButton(onPressed:(){
           guncelle(widget.not.not_id, tfdersAdi.text, int.parse(tfNot1.text), int.parse(tfNot2.text));

          }, child: Text("Güncelle", style: TextStyle(color: Colors.white),)),
        ],
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 50.0, left: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  decoration: InputDecoration(hintText: "Derd adi"),
                  controller: tfdersAdi ,
                ),
                TextField(
                  decoration: InputDecoration( hintText: "ders not1"),
                  controller: tfNot1,
                ),
                TextField(
                  decoration: InputDecoration(hintText: " ders not2"),
                  controller: tfNot2,
                ),

              ],
            ),
          )
      ),
    );
  }
}
