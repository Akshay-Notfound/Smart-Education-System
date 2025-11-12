part of 'generated.dart';

class ListMenuItemsForCafeteriaVariablesBuilder {
  String cafeteriaMenuId;

  final FirebaseDataConnect _dataConnect;
  ListMenuItemsForCafeteriaVariablesBuilder(this._dataConnect, {required  this.cafeteriaMenuId,});
  Deserializer<ListMenuItemsForCafeteriaData> dataDeserializer = (dynamic json)  => ListMenuItemsForCafeteriaData.fromJson(jsonDecode(json));
  Serializer<ListMenuItemsForCafeteriaVariables> varsSerializer = (ListMenuItemsForCafeteriaVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListMenuItemsForCafeteriaData, ListMenuItemsForCafeteriaVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListMenuItemsForCafeteriaData, ListMenuItemsForCafeteriaVariables> ref() {
    ListMenuItemsForCafeteriaVariables vars= ListMenuItemsForCafeteriaVariables(cafeteriaMenuId: cafeteriaMenuId,);
    return _dataConnect.query("ListMenuItemsForCafeteria", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListMenuItemsForCafeteriaMenuItems {
  final String id;
  final String name;
  final String? description;
  final double price;
  final List<String>? allergens;
  final String? nutritionalInfo;
  ListMenuItemsForCafeteriaMenuItems.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']),
  price = nativeFromJson<double>(json['price']),
  allergens = json['allergens'] == null ? null : (json['allergens'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),
  nutritionalInfo = json['nutritionalInfo'] == null ? null : nativeFromJson<String>(json['nutritionalInfo']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMenuItemsForCafeteriaMenuItems otherTyped = other as ListMenuItemsForCafeteriaMenuItems;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    description == otherTyped.description && 
    price == otherTyped.price && 
    allergens == otherTyped.allergens && 
    nutritionalInfo == otherTyped.nutritionalInfo;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, description.hashCode, price.hashCode, allergens.hashCode, nutritionalInfo.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    json['price'] = nativeToJson<double>(price);
    if (allergens != null) {
      json['allergens'] = allergens?.map((e) => nativeToJson<String>(e)).toList();
    }
    if (nutritionalInfo != null) {
      json['nutritionalInfo'] = nativeToJson<String?>(nutritionalInfo);
    }
    return json;
  }

  ListMenuItemsForCafeteriaMenuItems({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.allergens,
    this.nutritionalInfo,
  });
}

@immutable
class ListMenuItemsForCafeteriaData {
  final List<ListMenuItemsForCafeteriaMenuItems> menuItems;
  ListMenuItemsForCafeteriaData.fromJson(dynamic json):
  
  menuItems = (json['menuItems'] as List<dynamic>)
        .map((e) => ListMenuItemsForCafeteriaMenuItems.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMenuItemsForCafeteriaData otherTyped = other as ListMenuItemsForCafeteriaData;
    return menuItems == otherTyped.menuItems;
    
  }
  @override
  int get hashCode => menuItems.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['menuItems'] = menuItems.map((e) => e.toJson()).toList();
    return json;
  }

  ListMenuItemsForCafeteriaData({
    required this.menuItems,
  });
}

@immutable
class ListMenuItemsForCafeteriaVariables {
  final String cafeteriaMenuId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListMenuItemsForCafeteriaVariables.fromJson(Map<String, dynamic> json):
  
  cafeteriaMenuId = nativeFromJson<String>(json['cafeteriaMenuId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMenuItemsForCafeteriaVariables otherTyped = other as ListMenuItemsForCafeteriaVariables;
    return cafeteriaMenuId == otherTyped.cafeteriaMenuId;
    
  }
  @override
  int get hashCode => cafeteriaMenuId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cafeteriaMenuId'] = nativeToJson<String>(cafeteriaMenuId);
    return json;
  }

  ListMenuItemsForCafeteriaVariables({
    required this.cafeteriaMenuId,
  });
}

