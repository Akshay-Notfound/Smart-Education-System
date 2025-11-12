part of 'generated.dart';

class AddCampusEventVariablesBuilder {
  String title;
  String location;
  Timestamp eventDate;
  Optional<String> _description = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _category = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _imageUrl = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  AddCampusEventVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }
  AddCampusEventVariablesBuilder category(String? t) {
   _category.value = t;
   return this;
  }
  AddCampusEventVariablesBuilder imageUrl(String? t) {
   _imageUrl.value = t;
   return this;
  }

  AddCampusEventVariablesBuilder(this._dataConnect, {required  this.title,required  this.location,required  this.eventDate,});
  Deserializer<AddCampusEventData> dataDeserializer = (dynamic json)  => AddCampusEventData.fromJson(jsonDecode(json));
  Serializer<AddCampusEventVariables> varsSerializer = (AddCampusEventVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddCampusEventData, AddCampusEventVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddCampusEventData, AddCampusEventVariables> ref() {
    AddCampusEventVariables vars= AddCampusEventVariables(title: title,location: location,eventDate: eventDate,description: _description,category: _category,imageUrl: _imageUrl,);
    return _dataConnect.mutation("AddCampusEvent", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AddCampusEventCampusEventInsert {
  final String id;
  AddCampusEventCampusEventInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddCampusEventCampusEventInsert otherTyped = other as AddCampusEventCampusEventInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AddCampusEventCampusEventInsert({
    required this.id,
  });
}

@immutable
class AddCampusEventData {
  final AddCampusEventCampusEventInsert campusEvent_insert;
  AddCampusEventData.fromJson(dynamic json):
  
  campusEvent_insert = AddCampusEventCampusEventInsert.fromJson(json['campusEvent_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddCampusEventData otherTyped = other as AddCampusEventData;
    return campusEvent_insert == otherTyped.campusEvent_insert;
    
  }
  @override
  int get hashCode => campusEvent_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['campusEvent_insert'] = campusEvent_insert.toJson();
    return json;
  }

  AddCampusEventData({
    required this.campusEvent_insert,
  });
}

@immutable
class AddCampusEventVariables {
  final String title;
  final String location;
  final Timestamp eventDate;
  late final Optional<String>description;
  late final Optional<String>category;
  late final Optional<String>imageUrl;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AddCampusEventVariables.fromJson(Map<String, dynamic> json):
  
  title = nativeFromJson<String>(json['title']),
  location = nativeFromJson<String>(json['location']),
  eventDate = Timestamp.fromJson(json['eventDate']) {
  
  
  
  
  
    description = Optional.optional(nativeFromJson, nativeToJson);
    description.value = json['description'] == null ? null : nativeFromJson<String>(json['description']);
  
  
    category = Optional.optional(nativeFromJson, nativeToJson);
    category.value = json['category'] == null ? null : nativeFromJson<String>(json['category']);
  
  
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

    final AddCampusEventVariables otherTyped = other as AddCampusEventVariables;
    return title == otherTyped.title && 
    location == otherTyped.location && 
    eventDate == otherTyped.eventDate && 
    description == otherTyped.description && 
    category == otherTyped.category && 
    imageUrl == otherTyped.imageUrl;
    
  }
  @override
  int get hashCode => Object.hashAll([title.hashCode, location.hashCode, eventDate.hashCode, description.hashCode, category.hashCode, imageUrl.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['title'] = nativeToJson<String>(title);
    json['location'] = nativeToJson<String>(location);
    json['eventDate'] = eventDate.toJson();
    if(description.state == OptionalState.set) {
      json['description'] = description.toJson();
    }
    if(category.state == OptionalState.set) {
      json['category'] = category.toJson();
    }
    if(imageUrl.state == OptionalState.set) {
      json['imageUrl'] = imageUrl.toJson();
    }
    return json;
  }

  AddCampusEventVariables({
    required this.title,
    required this.location,
    required this.eventDate,
    required this.description,
    required this.category,
    required this.imageUrl,
  });
}

