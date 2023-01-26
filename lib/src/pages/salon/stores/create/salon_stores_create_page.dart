import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maslindapp/src/pages/salon/stores/create/salon_stores_create_controller.dart';
import 'package:maslindapp/src/utils/my_colors.dart';
class SalonStoresCreatePage  extends StatefulWidget {
  const SalonStoresCreatePage ({Key key}) : super(key: key);

  @override
  _SalonStoresCreatePageState createState() => _SalonStoresCreatePageState();
}

class _SalonStoresCreatePageState extends State<SalonStoresCreatePage> {

  SalonStoresCreateController _con = new SalonStoresCreateController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.ini(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
            'Nueva Tienda',
             style: TextStyle(
               color: Colors.black,
               fontWeight: FontWeight.bold
             ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox( height: 30),
          _textfielnameStore(),
          _textfielDescripcion(),
          SingleChildScrollView(
            child: Container(
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _cardImage(_con.imageFile1, 1),
                  _cardImage(_con.imageFile2, 2),
                  _cardImage(_con.imageFile3, 3),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buttonCreate() ,
    );
  }

  Widget _textfielnameStore() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 45, vertical: 7),
      decoration: BoxDecoration(
          //color: MyColors.primaryOpacityColor,
          color: Colors.amber[100],
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.shopController,
        decoration: InputDecoration(
            hintText: 'Tienda',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.black54
            ),
            suffixIcon: Icon(
              Icons.store,
              color: Colors.black,
            )
        ),
      ),
    );
  }

  Widget _textfielDescripcion() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 45, vertical: 7),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          //color: MyColors.primaryOpacityColor,
          color: Colors.amber[100],
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        maxLines: 3,
        maxLength: 255,
        controller: _con.descripcionController,
        decoration: InputDecoration(
          hintText: 'Descripcion',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: Colors.black54
          ),
          suffixIcon: Icon(
            Icons.description,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _cardImage(File imageFile, int numberFile){
    return GestureDetector(
      onTap:(){
        _con.showAlertDialog(numberFile);
      },
      child: imageFile != null
          ? Card(
        elevation: 3.0,
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width * 0.20,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
          ),
        ),
      )
          : Card(
        elevation: 2.0,
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width * 0.20,
          child: Image(
            image: AssetImage('assets/img/add_image.png'),
          ),
        ),
      ),
    );
  }


  Widget _buttonCreate() {
    return  Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.createStore,
        child: Text(
          'Registrar Tienda',
          style: TextStyle(
              fontSize: 17
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.green[500],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(vertical: 15)
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

}
