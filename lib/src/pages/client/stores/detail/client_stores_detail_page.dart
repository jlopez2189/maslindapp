import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:maslindapp/src/models/services.dart';
import 'package:maslindapp/src/models/stores.dart';
import 'package:maslindapp/src/pages/client/appointment/create/client_appointment_create_controller.dart';
import 'package:maslindapp/src/pages/client/appointment/detail/client_appointment_detail_controller.dart';
import 'package:maslindapp/src/pages/client/stores/detail/client_stores_detail_controller.dart';
import 'package:maslindapp/src/utils/my_colors.dart';
import 'dart:async';


class ClientStoresDetailPage extends StatefulWidget {
  Stores stores;


  ClientStoresDetailPage({Key key, @required this.stores}) : super(key: key);

  @override
  _ClientStoresDetailPageState createState() => _ClientStoresDetailPageState();
}

class _ClientStoresDetailPageState extends State<ClientStoresDetailPage> {
 // DateTime _selectedDate;
  DateTime _selectedDate = DateTime.now();

  void _presentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
        context: context,
       /// initialDate: DateTime.now(),
        initialDate: _selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now())
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        // using state so that the UI will be rerendered when date is picked
        _selectedDate = pickedDate;
      });
    });
  }


  ///DateTime selectedDate = DateTime.now();

  ClientStoresDetailController _con =  new ClientStoresDetailController();
  ClientAppointmentCreateController _con2 = new ClientAppointmentCreateController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.stores);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          _imageSlideshow(),
          ElevatedButton(
              onPressed: _presentDatePicker,
              child: const Text('Seleccionar Fecha'),
          ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
              _selectedDate != null
                  ? _selectedDate.toString()
                  : 'Fecha no seleccionada!',
                   style: const TextStyle(fontSize: 14),
          ),
      ),

          _textName(),
          _textfielDescripcion(),
          _textfieltime(),
          SizedBox( height: 15),
          _dropDownServices(_con.services),
        ],
      ),
    );
  }

  Widget _imageSlideshow() {
    return Stack(
      children: [
        ImageSlideshow(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.25,
          initialPage: 0,
          indicatorColor: Colors.blue,
          indicatorBackgroundColor: Colors.grey,
          children: [
            FadeInImage(
              image: _con.stores?.image1 != null
                  ? NetworkImage(_con.stores.image1)
                  : AssetImage('assets/img/no-image.png'),
              fit: BoxFit.fill,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
            FadeInImage(
              image: _con.stores?.image2 != null
                  ? NetworkImage(_con.stores.image2)
                  : AssetImage('assets/img/no-image.png'),
              fit: BoxFit.fill,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
            FadeInImage(
              image: _con.stores?.image3 != null
                  ? NetworkImage(_con.stores.image3)
                  : AssetImage('assets/img/no-image.png'),
              fit: BoxFit.fill,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),

          ],
          onPageChanged: (value) {
            debugPrint('Page changed: $value');
          },
          autoPlayInterval: 20000,
        ),
        Positioned(
            left: 10,
            top: 4,
            child: IconButton(
              onPressed: _con.close,
              icon: Icon(Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )
        )
      ],
    );
  }





  Widget _textIdSalon() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 30, left: 30, top: 30),
      child: Text(
        _con.stores?.id ?? '',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _textName() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 30, left: 30, top: 2),
      child: Text(
        _con.stores?.shop ?? '',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Services> services){
    List<DropdownMenuItem<String>> list = [];
    services.forEach((services) {
      list.add(DropdownMenuItem(
        child: Text(services.services),
        value: services.id,
      ));
    });
    return list;
  }

  Widget _dropDownServices(List<Services> services) {
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
                    'Servicios',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
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
                    'Selecciona un servicio',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                    ),
                  ),
                  items: _dropDownItems(services),
                  value: _con.idServices,
                  onChanged: (opcion) {
                    setState(() {
                      print('Servicio seleccionada $opcion');
                      _con.idServices = opcion; // Estableciendo el valor seleccionado a la variable idcategory
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






  Widget _textfielDescripcion() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          ///color: Colors.orangeAccent[200],
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        maxLines: 2,
        maxLength: 255,
        controller: _con2.descripcionController,
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

  Widget _textfieltime() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        //color: MyColors.primaryOpacityColor,
          color:  MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con2.timeController,
        decoration: InputDecoration(
            hintText: 'Hora',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.black54
            ),
            suffixIcon: Icon(
              Icons.timer,
              color: Colors.amber,
            )
        ),
      ),
    );
  }






  void refresh() {
    setState(() {

    });
  }

}
