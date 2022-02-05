import 'package:flutter/material.dart';
import 'package:notlar_uygulamasi/main.dart';
import 'package:notlar_uygulamasi/notlardao.dart';

class DetayKayitSayfa extends StatefulWidget {
  const DetayKayitSayfa({Key? key}) : super(key: key);

  @override
  _DetayKayitSayfaState createState() => _DetayKayitSayfaState();
}

class _DetayKayitSayfaState extends State<DetayKayitSayfa> {

  var tfdersAdi = TextEditingController();
  var tfNot1 = TextEditingController();
  var tfNot2 = TextEditingController();

  Future<void> kayit(String ders_adi, int not1, int not2) async {

    await Notlardao().notEkle(ders_adi, not1, not2);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detay Kayıt Sayfa"),
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
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        kayit(tfdersAdi.text, int.parse(tfNot1.text), int.parse(tfNot2.text));


      },
          icon: Icon(Icons.save),
          label: Text("Kaydet"),

      ),
    );
  }
}
