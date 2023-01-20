import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maslindapp/src/pages/salon/categories/create/salon_categories_create_controller.dart';
import 'package:maslindapp/src/utils/my_colors.dart';
class SalonCategoriesCreatePage  extends StatefulWidget {
  const SalonCategoriesCreatePage ({Key key}) : super(key: key);

  @override
  _SalonCategoriesCreatePageState createState() => _SalonCategoriesCreatePageState();
}

class _SalonCategoriesCreatePageState extends State<SalonCategoriesCreatePage> {

  SalonCategoriesCreateController _con = new SalonCategoriesCreateController();
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
        title: Text('Nueva Categoria'),
      ),
      body: Column(
        children: [
          SizedBox( height: 30),
          _textfielnameCategorie(),
          _textfielDescripcion()
        ],
      ),
      bottomNavigationBar: _buttonCreate() ,
    );
  }

  Widget _textfielnameCategorie() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Categoria',
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

  Widget _textfielDescripcion() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      padding: EdgeInsets.all(10),
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

  Widget _buttonCreate() {
    return  Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.createCategoria,
        child: Text(
          'Registrar Categoria',
          style: TextStyle(
              fontSize: 15
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
