# dataconnect_generated SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
ExampleConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### ListCampusEvents
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listCampusEvents().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListCampusEventsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listCampusEvents();
ListCampusEventsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listCampusEvents().ref();
ref.execute();

ref.subscribe(...);
```


### ListMenuItemsForCafeteria
#### Required Arguments
```dart
String cafeteriaMenuId = ...;
ExampleConnector.instance.listMenuItemsForCafeteria(
  cafeteriaMenuId: cafeteriaMenuId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMenuItemsForCafeteriaData, ListMenuItemsForCafeteriaVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listMenuItemsForCafeteria(
  cafeteriaMenuId: cafeteriaMenuId,
);
ListMenuItemsForCafeteriaData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String cafeteriaMenuId = ...;

final ref = ExampleConnector.instance.listMenuItemsForCafeteria(
  cafeteriaMenuId: cafeteriaMenuId,
).ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### AddCampusEvent
#### Required Arguments
```dart
String title = ...;
String location = ...;
Timestamp eventDate = ...;
ExampleConnector.instance.addCampusEvent(
  title: title,
  location: location,
  eventDate: eventDate,
).execute();
```

#### Optional Arguments
We return a builder for each query. For AddCampusEvent, we created `AddCampusEventBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AddCampusEventVariablesBuilder {
  ...
   AddCampusEventVariablesBuilder description(String? t) {
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

  ...
}
ExampleConnector.instance.addCampusEvent(
  title: title,
  location: location,
  eventDate: eventDate,
)
.description(description)
.category(category)
.imageUrl(imageUrl)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<AddCampusEventData, AddCampusEventVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.addCampusEvent(
  title: title,
  location: location,
  eventDate: eventDate,
);
AddCampusEventData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String title = ...;
String location = ...;
Timestamp eventDate = ...;

final ref = ExampleConnector.instance.addCampusEvent(
  title: title,
  location: location,
  eventDate: eventDate,
).ref();
ref.execute();
```


### ReportLostAndFoundItem
#### Required Arguments
```dart
String itemType = ...;
String status = ...;
ExampleConnector.instance.reportLostAndFoundItem(
  itemType: itemType,
  status: status,
).execute();
```

#### Optional Arguments
We return a builder for each query. For ReportLostAndFoundItem, we created `ReportLostAndFoundItemBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ReportLostAndFoundItemVariablesBuilder {
  ...
   ReportLostAndFoundItemVariablesBuilder description(String? t) {
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

  ...
}
ExampleConnector.instance.reportLostAndFoundItem(
  itemType: itemType,
  status: status,
)
.description(description)
.locationLostFound(locationLostFound)
.contactInfo(contactInfo)
.imageUrl(imageUrl)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<ReportLostAndFoundItemData, ReportLostAndFoundItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.reportLostAndFoundItem(
  itemType: itemType,
  status: status,
);
ReportLostAndFoundItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String itemType = ...;
String status = ...;

final ref = ExampleConnector.instance.reportLostAndFoundItem(
  itemType: itemType,
  status: status,
).ref();
ref.execute();
```

