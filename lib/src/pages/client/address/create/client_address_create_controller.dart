import 'package:flutter/material.dart';
import 'package:maslindapp/src/pages/client/address/map/client_address_map_page.dart';
import 'package:maslindapp/src/provider/address_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientAddressCreateController {
 BuildContext context;
 Function refresh;

 TextEditingController refPointController =  new TextEditingController();
 TextEditingController addressController =  new TextEditingController();
 TextEditingController neighbordhoodController =  new TextEditingController();

 Map<String, dynamic> refPoint;
 AddressProvider _addressProvider =  new AddressProvider();

 Future init(BuildContext context, Function refresh){
   this.context = context;
   this.refresh =  refresh;
  /// _addressProvider.init(context, sessionUser);
 }

 void createAddress() {
   String address =  addressController.text;
   String neighbordhood = neighbordhoodController.text;
   double lat =  refPoint['lat'] ?? 0;
   double lng =  refPoint['lng'] ?? 0;



 }

 void openMap() {
   showMaterialModalBottomSheet(
     context: context,
     isDismissible: false,
     enableDrag: false,
     builder: (context) => ClientAddressMapPage()
   );

   if (refPoint != null) {
     refPointController.text =  refPoint['address'];
     refresh();
   }

 }

}