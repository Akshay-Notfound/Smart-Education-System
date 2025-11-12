part of 'generated.dart';

class ListCampusEventsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListCampusEventsVariablesBuilder(this._dataConnect, );
  Deserializer<ListCampusEventsData> dataDeserializer = (dynamic json)  => ListCampusEventsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListCampusEventsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListCampusEventsData, void> ref() {
    
    return _dataConnect.query("ListCampusEvents", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListCampusEventsCampusEvents {
  final String id;
  final String title;
  final String location;
  final Timestamp eventDate;
  final String? description;
  final String? category;
  final String? imageUrl;
  ListCampusEventsCampusEvents.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  title = nativeFromJson<String>(json['title']),
  location = nativeFromJson<String>(json['location']),
  eventDate = Timestamp.fromJson(json['eventDate']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']),
  category = json['category'] == null ? null : nativeFromJson<String>(json['category']),
  imageUrl = json['imageUrl'] == null ? null : nativeFromJson<String>(json['imageUrl']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListCampusEventsCampusEvents otherTyped = other as ListCampusEventsCampusEvents;
    return id == otherTyped.id && 
    title == otherTyped.title && 
    location == otherTyped.location && 
    eventDate == otherTyped.eventDate && 
    description == otherTyped.description && 
    category == otherTyped.category && 
    imageUrl == otherTyped.imageUrl;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, title.hashCode, location.hashCode, eventDate.hashCode, description.hashCode, category.hashCode, imageUrl.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['title'] = nativeToJson<String>(title);
    json['location'] = nativeToJson<String>(location);
    json['eventDate'] = eventDate.toJson();
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    if (category != null) {
      json['category'] = nativeToJson<String?>(category);
    }
    if (imageUrl != null) {
      json['imageUrl'] = nativeToJson<String?>(imageUrl);
    }
    return json;
  }

  ListCampusEventsCampusEvents({
    required this.id,
    required this.title,
    required this.location,
    required this.eventDate,
    this.description,
    this.category,
    this.imageUrl,
  });
}

@immutable
class ListCampusEventsData {
  final List<ListCampusEventsCampusEvents> campusEvents;
  ListCampusEventsData.fromJson(dynamic json):
  
  campusEvents = (json['campusEvents'] as List<dynamic>)
        .map((e) => ListCampusEventsCampusEvents.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListCampusEventsData otherTyped = other as ListCampusEventsData;
    return campusEvents == otherTyped.campusEvents;
    
  }
  @override
  int get hashCode => campusEvents.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['campusEvents'] = campusEvents.map((e) => e.toJson()).toList();
    return json;
  }

  ListCampusEventsData({
    required this.campusEvents,
  });
}

