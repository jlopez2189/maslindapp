import 'dart:io';
import 'package:maslindapp/src/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maslindapp/src/pages/salon/products/create/salon_products_create_controller.dart';
import 'package:maslindapp/src/utils/my_colors.dart';

class SalonProductsCreatePage  extends StatefulWidget {
  const SalonProductsCreatePage ({Key key}) : super(key: key);

  @override
  _SalonProductsCreatePageState createState() => _SalonProductsCreatePageState();
}

class _SalonProductsCreatePageState extends State<SalonProductsCreatePage> {

  SalonProductsCreateController _con = new SalonProductsCreateController();

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
        title: Text('Nuevo Producto'),
      ),
      body: ListView( // es para scroll view en la pantalla
        children: [
          SizedBox( height: 20),
          _textfielnameProduct(),
          _textfielDescripcion(),
          _textfielPrecio(),
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
         _dropDownCategorias(_con.categories),
        ],
      ),
      bottomNavigationBar: _buttonCreate() ,
    );
  }

  Widget _textfielnameProduct() {
    return  Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        maxLines: 1,
        maxLength: 180,
        decoration: InputDecoration(
            hintText: 'Nombre',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.black54
            ),
            suffixIcon: Icon(
              Icons.list_alt,
              color: Colors.amber,
            )
        ),
      ),
    );
  }

  Widget _textfielPrecio() {
    return  Container(
      //padding: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.precioController,
        keyboardType: TextInputType.phone,
        maxLines: 1,
        decoration: InputDecoration(
            hintText: 'Precio',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.black54
            ),
            suffixIcon: Icon(
              Icons.monetization_on,
              color: Colors.amber,
            )
        ),
      ),
    );
  }

  Widget _textfielDescripcion() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
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
            color: Colors.amber,
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

  Widget _dropDownCategorias(List<Category> categories) {
   return Container(
     margin: EdgeInsets.symmetric(horizontal: 33),
     child: Material(
       elevation: 2.0,
       color: Colors.white,
       borderRadius: BorderRadius.all(Radius.circular(5)),
       child: Container(
          padding: EdgeInsets.all(3),
           child: Column(
           children: [
                Row(
                children: [
                Icon(
                  Icons.search,
                  color: MyColors.primaryColor,
                ),
                  SizedBox(width: 15),
                  Text(
                    'Categorias',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                    ),
                  )
                ],
              ),
             Container(
               padding: EdgeInsets.symmetric(horizontal: 20),
               child: DropdownButton(
                 underline: Container(
                   alignment: Alignment.centerRight,
                   child: Icon(
                     Icons.arrow_drop_down_circle,
                     color: MyColors.primaryColor,
                   ),
                 ),
                 elevation: 3 ,
                 isExpanded: true,
                 hint: Text(
                     'Selecciona Categoria',
                   style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16
                   ),
                 ),
                 items: _dropDownItems(categories),
                 value: _con.idCategory,
                 onChanged: (opcion) {
                   setState(() {
                     print('Categoria seleccionada $opcion');
                     _con.idCategory = opcion; // Estableciendo el valor seleccionado a la variable idcategory
                   });
                 },
               ),

               ),


           ],
         ),
       ),
     ),
   );
  }
  List<DropdownMenuItem<String>> _dropDownItems(List<Category> categories){
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) { 
      list.add(DropdownMenuItem(
        child: Text(category.name),
        value: category.id,
       ));
    });
    return list;
  }

  Widget _buttonCreate() {
    return  Container(
      height: 42,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'Registrar Producto',
          style: TextStyle(
              fontSize: 13
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.black,
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
