import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:maslindapp/src/models/services.dart';
import 'package:maslindapp/src/models/stores.dart';
import 'package:maslindapp/src/models/appointment.dart';
import 'package:maslindapp/src/pages/client/appointment/detail/client_appointment_detail_controller.dart';
import 'package:maslindapp/src/utils/my_colors.dart';

class ClientAppointmentDetailPage extends StatefulWidget {

  Stores stores;
  Appointment appointment;

  ClientAppointmentDetailPage ({Key key, @required this.stores}) : super(key: key);

  @override
  _ClientAppointmentDetailPageState createState() => _ClientAppointmentDetailPageState();
}

class _ClientAppointmentDetailPageState extends State<ClientAppointmentDetailPage> {

  ClientAppointmentDetailController _con =  new ClientAppointmentDetailController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.stores, widget.appointment);
    });
  }

  Widget _textDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 30, left: 30, top: 15),
      child: Text(
        _con.stores?.description ?? '',
        style: TextStyle(
            fontSize: 13,
            color: Colors.grey
        ),
      ),
    );
  }

  Widget _textShop() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 30, left: 30, top: 30),
      child: Text(
        _con.stores?.shop ?? '',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
    );
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
                    'Selecciona el servicio',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                    ),
                  ),
                  items: _dropDownItems(services),
                  value: _con.idServices,
                  onChanged: (opcion) {
                    setState(() {
                      print('Tienda seleccionada $opcion');
                      _con.stores = opcion; // Estableciendo el valor seleccionado a la variable idcategory
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


  Widget _buttonAddAppointment() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
      child: ElevatedButton(
      //  onPressed: _con.addToBag,
        style: ElevatedButton.styleFrom(
            primary: Colors.redAccent,
            padding: EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'Agregar Cita',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 15, top: 6),
                height: 30,
                child: Image.asset('assets/img/bag.png'),
              ),
            )
          ],
        ),
      ) ,
    );
  }

  Widget _standartDelivery() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10) ,
      child: Row(
        children: [
          Image.asset(
            'assets/img/delivery.png',
            height: 17,
          ),
          SizedBox(width: 7),
          Text(
            'Envio estandar',
            style: TextStyle(
                fontSize: 12,
                color: Colors.green
            ),
          )
        ],
      ),
    );
  }

  Widget _imageSlideshow() {
    return Stack(
      children: [
        ImageSlideshow(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
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
            top: 5,
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

  @override
  Widget build(BuildContext context) {
    return Container(
         height: MediaQuery.of(context).size.height * 0.9,
    child: Column(
        children: [
          _imageSlideshow(),
          _textShop(),
          _textDescription(),
          _dropDownServices(_con.services),
          Spacer(),
          _buttonAddAppointment()
      ]
    )

    );
  }


  void refresh() {
    setState(() {

    });
  }

}
