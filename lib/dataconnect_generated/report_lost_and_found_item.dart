part of 'generated.dart';

class ReportLostAndFoundItemVariablesBuilder {
  String itemType;
  Optional<String> _description = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _locationLostFound = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _contactInfo = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _imageUrl = Optional.optional(nativeFromJson, nativeToJson);
  String status;

  final FirebaseDataConnect _dataConnect;  ReportLostAndFoundItemVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }
  ReportLostAndFoundItemVariablesBuilder locationLostFound(String? t) {
   _locationLostFound.value = t;
   return this;
  }
  ReportLostAndFoundItemVariablesBuilder contactInfo(String? t) {
   _contactInfo.value = t;
   return this;
  }
  ReportLostAndFoundItemVariablesBuilder imageUrl(String? t) {
   _imageUrl.value = t;
   return this;
  }

  ReportLostAndFoundItemVariablesBuilder(this._dataConnect, {required  this.itemType,required  this.status,});
  Deserializer<ReportLostAndFoundItemData> dataDeserializer = (dynamic json)  => ReportLostAndFoundItemData.fromJson(jsonDecode(json));
  Serializer<ReportLostAndFoundItemVariables> varsSerializer = (ReportLostAndFoundItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<ReportLostAndFoundItemData, ReportLostAndFoundItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<ReportLostAndFoundItemData, ReportLostAndFoundItemVariables> ref() {
    ReportLostAndFoundItemVariables vars= ReportLostAndFoundItemVariables(itemType: itemType,description: _description,locationLostFound: _locationLostFound,contactInfo: _contactInfo,imageUrl: _imageUrl,status: status,);
    return _dataConnect.mutation("ReportLostAndFoundItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ReportLostAndFoundItemLostAndFoundItemInsert {
  final String id;
  ReportLostAndFoundItemLostAndFoundItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReportLostAndFoundItemLostAndFoundItemInsert otherTyped = other as ReportLostAndFoundItemLostAndFoundItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ReportLostAndFoundItemLostAndFoundItemInsert({
    required this.id,
  });
}

@immutable
class ReportLostAndFoundItemData {
  final ReportLostAndFoundItemLostAndFoundItemInsert lostAndFoundItem_insert;
  ReportLostAndFoundItemData.fromJson(dynamic json):
  
  lostAndFoundItem_insert = ReportLostAndFoundItemLostAndFoundItemInsert.fromJson(json['lostAndFoundItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReportLostAndFoundItemData otherTyped = other as ReportLostAndFoundItemData;
    return lostAndFoundItem_insert == otherTyped.lostAndFoundItem_insert;
    
  }
  @override
  int get hashCode => lostAndFoundItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['lostAndFoundItem_insert'] = lostAndFoundItem_insert.toJson();
    return json;
  }

  ReportLostAndFoundItemData({
    required this.lostAndFoundItem_insert,
  });
}

@immutable
class ReportLostAndFoundItemVariables {
  final String itemType;
  late final Optional<String>description;
  late final Optional<String>locationLostFound;
  late final Optional<String>contactInfo;
  late final Optional<String>imageUrl;
  final String status;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ReportLostAndFoundItemVariables.fromJson(Map<String, dynamic> json):
  
  itemType = nativeFromJson<String>(json['itemType']),
  status = nativeFromJson<String>(json['status']) {
  
  
  
    description = Optional.optional(nativeFromJson, nativeToJson);
    description.value = json['description'] == null ? null : nativeFromJson<String>(json['description']);
  
  
    locationLostFound = Optional.optional(nativeFromJson, nativeToJson);
    locationLostFound.value = json['locationLostFound'] == null ? null : nativeFromJson<String>(json['locationLostFound']);
  
  
    contactInfo = Optional.optional(nativeFromJson, nativeToJson);
    contactInfo.value = json['contactInfo'] == null ? null : nativeFromJson<String>(json['contactInfo']);
  
  
    imageUrl = Optional.optional(nativeFromJson, nativeToJson);
    imageUrl.value = json['imageUrl'] == null ? null : nativeFromJson<String>(json['imageUrl']);
  
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReportLostAndFoundItemVariables otherTyped = other as ReportLostAndFoundItemVariables;
    return itemType == otherTyped.itemType && 
    description == otherTyped.description && 
    locationLostFound == otherTyped.locationLostFound && 
    contactInfo == otherTyped.contactInfo && 
    imageUrl == otherTyped.imageUrl && 
    status == otherTyped.status;
    
  }
  @override
  int get hashCode => Object.hashAll([itemType.hashCode, description.hashCode, locationLostFound.hashCode, contactInfo.hashCode, imageUrl.hashCode, status.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['itemType'] = nativeToJson<String>(itemType);
    if(description.state == OptionalState.set) {
      json['description'] = description.toJson();
    }
    if(locationLostFound.state == OptionalState.set) {
      json['locationLostFound'] = locationLostFound.toJson();
    }
    if(contactInfo.state == OptionalState.set) {
      json['contactInfo'] = contactInfo.toJson();
    }
    if(imageUrl.state == OptionalState.set) {
      json['imageUrl'] = imageUrl.toJson();
    }
    json['status'] = nativeToJson<String>(status);
    return json;
  }

  ReportLostAndFoundItemVariables({
    required this.itemType,
    required this.description,
    required this.locationLostFound,
    required this.contactInfo,
    required this.imageUrl,
    required this.status,
  });
}

