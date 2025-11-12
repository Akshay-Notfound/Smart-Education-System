library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'add_campus_event.dart';

part 'list_campus_events.dart';

part 'report_lost_and_found_item.dart';

part 'list_menu_items_for_cafeteria.dart';







class ExampleConnector {
  
  
  AddCampusEventVariablesBuilder addCampusEvent ({required String title, required String location, required Timestamp eventDate, }) {
    return AddCampusEventVariablesBuilder(dataConnect, title: title,location: location,eventDate: eventDate,);
  }
  
  
  ListCampusEventsVariablesBuilder listCampusEvents () {
    return ListCampusEventsVariablesBuilder(dataConnect, );
  }
  
  
  ReportLostAndFoundItemVariablesBuilder reportLostAndFoundItem ({required String itemType, required String status, }) {
    return ReportLostAndFoundItemVariablesBuilder(dataConnect, itemType: itemType,status: status,);
  }
  
  
  ListMenuItemsForCafeteriaVariablesBuilder listMenuItemsForCafeteria ({required String cafeteriaMenuId, }) {
    return ListMenuItemsForCafeteriaVariablesBuilder(dataConnect, cafeteriaMenuId: cafeteriaMenuId,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-central1',
    'example',
    'smarteducationsystem',
  );

  ExampleConnector({required this.dataConnect});
  static ExampleConnector get instance {
    return ExampleConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
