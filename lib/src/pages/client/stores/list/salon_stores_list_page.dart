import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maslindapp/src/models/category.dart';
import 'package:maslindapp/src/models/stores.dart';
import 'package:maslindapp/src/pages/client/stores/list/salon_stores_list_controller.dart';
import 'package:maslindapp/src/pages/salon/stores/create/salon_stores_create_controller.dart';
import 'package:maslindapp/src/widgets/no_data_widgets.dart';

class SalonStoresListPage extends StatefulWidget {
  const SalonStoresListPage ({Key key}) : super(key: key);

  @override
  _SalonStoresListPageState createState() => _SalonStoresListPageState();
}

class _SalonStoresListPageState extends State<SalonStoresListPage> {

  SalonStoresListController _con =  new SalonStoresListController();
  SalonStoresCreateController _con2 = new SalonStoresCreateController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _con.categories?.length,
      child: Scaffold(
        key: _con.key,
        appBar:PreferredSize(
          preferredSize: Size.fromHeight(170),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff900659),
            actions: [
              _shoppingBag()
            ],
            flexibleSpace: Column(
              children: [
                SizedBox(height: 40),
                _menudrawer(),
                SizedBox(height: 20),
                _textFlieldSearch()
              ],
            ),
            bottom: TabBar(
              indicatorColor: Colors.yellowAccent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[400],
              isScrollable: true,
              tabs: List<Widget>.generate(_con.categories.length, (index) {
                return Tab(
                  child: Text(_con.categories[index].name ?? ''),
                );
              }),
            ),
          ),
        ),

        drawer: _drawer(),
        body: TabBarView(
          children: _con.categories.map((Category category) {
            return FutureBuilder(
                future: _con.getStores(category.id),
                builder: (context, AsyncSnapshot<List<Stores>> snapshot){
                  if (snapshot.hasData) {
                    if(snapshot.data.length > 0) {
                      return GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.6
                          ),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                            return _cardProduct(snapshot.data[index]);
                          }
                      );
                    }
                    else
                    {
                      return NoDataWidget(text: 'No hay Tiendas registradas');
                    }
                  }
                  else
                  {
                    return NoDataWidget(text: 'No hay Tiendas registradas');
                  }
                }
            );
          }).toList(),
        ),

      ),
    );

  }

  Widget _cardProduct(Stores stores) {
    return GestureDetector(
      onTap: () {
       _con.openBottonSheet(stores);
      } ,
      child: Container(
        height: 250,
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ) ,
          child: Stack(
            children: [
              Positioned(
                  top: -1.0,
                  right: -1.0,
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color:  Color(0xff6E0643),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topRight: Radius.circular(20),
                        )
                    ),
                    child: Icon(Icons.add, color: Colors.white,),
                  )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 175,
                    margin: EdgeInsets.only(top: 15),
                    width: MediaQuery.of(context).size.width * 0.50,
                    padding: EdgeInsets.all(20),
                    child: FadeInImage(
                      image: stores.image1 != null
                          ? NetworkImage(stores.image1)
                          : AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      stores.shop ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'NimbusSans',
                          color: Color(0xff6E0643),

                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),

                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _shoppingBag() {
    return GestureDetector(
      ///onTap: _con.goToOrderCreatePage,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15, top: 13),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
          ),
          Positioned(
              right: 16,
              top: 15,
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
              )
          )
        ],
      ),
    );
  }

  Widget _textFlieldSearch() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Buscar Salones',
            suffixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintStyle: TextStyle(
                fontSize: 17,
                color: Colors.white
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                    color: Colors.white
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                    color: Colors.white
                )
            ),
            contentPadding: EdgeInsets.all(15)
        ) ,
      ) ,
    );
  }

  Widget _menudrawer() {
       return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20) ,
        alignment: Alignment.centerLeft,
         child: Image.asset('assets/img/menuredondeado.png', width: 20, height: 20,color: Colors.white,),
      ),
    );
  }
  Widget _drawer() {
    return Drawer(
      backgroundColor: Color(0xff6E0643),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(

              decoration: BoxDecoration(
                  color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.email ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.phone ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                       fontFamily: "NimbusSans"
                    ),
                    maxLines: 1,
                  ),
                  Container(
                    height: 70,
                    margin: EdgeInsets.only(top: 5),
                    child: FadeInImage(
                      image: _con.user?.image != null
                          ? NetworkImage(_con.user?.image)
                          :AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  )
                ],
              )
          ),
          ListTile(
        ///    onTap: _con.goToUpdatePage,
            title: Text(
                'Editar Perfil',
              style: TextStyle(
                 color: Colors.white,
                  fontFamily: "NimbusSans"
              ),
            ),
            trailing: Icon(Icons.edit_outlined, color: Colors.white,),

          ),

          ListTile(
            onTap: _con.goToCreateStores,
            title: Text(
              'Registrar Tiendas',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "NimbusSans"
              ),
            ),
            trailing: Icon(Icons.store_mall_directory, color: Colors.white,),

            //onTap: _con.goToStores,
            //title: Text('Tiendas'),
            //trailing: Icon(Icons.store_mall_directory),
          ),


          ListTile(
            title: Text(
                'Mis pedidos',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "NimbusSans"
              ),
            ),
            trailing: Icon(Icons.shopping_cart_outlined, color: Colors.white,),
          ),
         /// _con.user != Null ?
         /// _con.user.roles.length > 1 ?
        ///  ListTile(
        ///    onTap: _con.gotoRoles,
        ///    title: Text(
        ///        'Seleccionar rol',
        ///      style: TextStyle(
        ///          color: Colors.white
       ///       ),
       ///     ),
       ///     trailing: Icon(Icons.person_outline, color: Colors.white,),
        ///  ) : Container() :Container(),
          ListTile(
            onTap: _con.logout,
            title: Text(
                'Cerrar session',
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            trailing: Icon(Icons.power_settings_new, color: Colors.white,),
          ),

        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

}
