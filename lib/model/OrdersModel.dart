/// data : [{"id":60,"order_number ":"MPBP-91648532547","user_id":"29","name":"Nayon Talukder","email":"nayon.coders@gmail.com","phone":"01814569747","amount":"140","shipping":"20.00","discount":null,"address":"Nadmulla, Bhandaria, Pirojpur 8550, ","division":{"id":1,"name":"Chattagram"},"district":{"id":1,"name":"Comilla","division_id":"1"},"upazila":{"id":1,"name":"Debidwar","district_id":"1"},"zip":"8550","status":"Confirmed","date":"2022-04-10 14:21:16","payment_status":"unpaid","delivery_man":{"id":37,"name":"Del","email":"deliveryman@mail.com","phone":"01814-569747","image":null,"nid":"32123123"}},{"id":61,"order_number ":"MPBP-91648532548","user_id":"29","name":"Nayon Talukder","email":"nayon.coders@gmail.com","phone":"01814569747","amount":"357","shipping":"15.00","discount":null,"address":"Nadmulla, Bhandaria, Pirojpur 8550, ","division":{"id":1,"name":"Chattagram"},"district":{"id":1,"name":"Comilla","division_id":"1"},"upazila":{"id":1,"name":"Debidwar","district_id":"1"},"zip":"8550","status":"Processing","date":"2022-04-10 14:33:08","payment_status":"unpaid","delivery_man":{"id":37,"name":"Del","email":"deliveryman@mail.com","phone":"01814-569747","image":null,"nid":"32123123"}},{"id":62,"order_number ":"MPBP-91648532549","user_id":"29","name":"Nayon Talukder","email":"nayon.coders@gmail.com","phone":"01814569747","amount":"568.4","shipping":null,"discount":null,"address":"Nadmulla, Bhandaria, Pirojpur 8550, ","division":{"id":1,"name":"Chattagram"},"district":{"id":1,"name":"Comilla","division_id":"1"},"upazila":{"id":1,"name":"Debidwar","district_id":"1"},"zip":"8550","status":"Processing","date":"2022-04-13 12:34:59","payment_status":"unpaid","delivery_man":{"id":37,"name":"Del","email":"deliveryman@mail.com","phone":"01814-569747","image":null,"nid":"32123123"}},{"id":63,"order_number ":"MPBP-91648532550","user_id":"29","name":"Nayon Talukder","email":"nayon.coders@gmail.com","phone":"01814569747","amount":"314.5","shipping":"20.00","discount":null,"address":"Nadmulla, Bhandaria, Pirojpur 8550, ","division":{"id":1,"name":"Chattagram"},"district":{"id":1,"name":"Comilla","division_id":"1"},"upazila":{"id":1,"name":"Debidwar","district_id":"1"},"zip":"8550","status":"Delivered","date":"2022-04-13 15:24:05","payment_status":"paid","delivery_man":{"id":37,"name":"Del","email":"deliveryman@mail.com","phone":"01814-569747","image":null,"nid":"32123123"}},{"id":64,"order_number ":"MPBP-91648532551","user_id":"29","name":"Nayon Talukder","email":"nayon.coders@gmail.com","phone":"01814569747","amount":"312.9","shipping":"20.00","discount":null,"address":"Nadmulla, Bhandaria, Pirojpur 8550, ","division":{"id":1,"name":"Chattagram"},"district":{"id":1,"name":"Comilla","division_id":"1"},"upazila":{"id":1,"name":"Debidwar","district_id":"1"},"zip":"8550","status":"Delivered","date":"2022-04-13 14:22:10","payment_status":"paid","delivery_man":{"id":37,"name":"Del","email":"deliveryman@mail.com","phone":"01814-569747","image":null,"nid":"32123123"}},{"id":65,"order_number ":"MPBP-91648532552","user_id":"29","name":"Nayon Talukder","email":"nayon.coders@gmail.com","phone":"01814569747","amount":"296.75","shipping":"20.00","discount":null,"address":"Nadmulla, Bhandaria, Pirojpur 8550, ","division":{"id":1,"name":"Chattagram"},"district":{"id":1,"name":"Comilla","division_id":"1"},"upazila":{"id":1,"name":"Debidwar","district_id":"1"},"zip":"8550","status":"Delivered","date":"2022-04-13 14:33:00","payment_status":"paid","delivery_man":{"id":37,"name":"Del","email":"deliveryman@mail.com","phone":"01814-569747","image":null,"nid":"32123123"}},{"id":66,"order_number ":"MPBP-91648532553","user_id":"29","name":"Nayon Talukder","email":"nayon.coders@gmail.com","phone":"01814569747","amount":"330.4","shipping":"15.00","discount":null,"address":"Nadmulla, Bhandaria, Pirojpur 8550, ","division":{"id":1,"name":"Chattagram"},"district":{"id":1,"name":"Comilla","division_id":"1"},"upazila":{"id":1,"name":"Debidwar","district_id":"1"},"zip":"8550","status":"Delivered","date":"2022-04-13 15:56:15","payment_status":"paid","delivery_man":{"id":37,"name":"Del","email":"deliveryman@mail.com","phone":"01814-569747","image":null,"nid":"32123123"}}]
/// links : {"first":"https://apps.piit.us/my-pharmacy/api/v1/admin/orders?page=1","last":"https://apps.piit.us/my-pharmacy/api/v1/admin/orders?page=1","prev":null,"next":null}
/// meta : {"current_page":1,"from":1,"last_page":1,"links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://apps.piit.us/my-pharmacy/api/v1/admin/orders?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"path":"https://apps.piit.us/my-pharmacy/api/v1/admin/orders","per_page":20,"to":7,"total":7}

class OrdersModel {
  OrdersModel({
      List<Data>? data, 
      Links? links, 
      Meta? meta,}){
    _data = data;
    _links = links;
    _meta = meta;
}

  OrdersModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _links = json['links'] != null ? Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  List<Data>? _data;
  Links? _links;
  Meta? _meta;

  List<Data>? get data => _data;
  Links? get links => _links;
  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_links != null) {
      map['links'] = _links?.toJson();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }


}

/// current_page : 1
/// from : 1
/// last_page : 1
/// links : [{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://apps.piit.us/my-pharmacy/api/v1/admin/orders?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}]
/// path : "https://apps.piit.us/my-pharmacy/api/v1/admin/orders"
/// per_page : 20
/// to : 7
/// total : 7

class Meta {
  Meta({
      int? currentPage, 
      int? from, 
      int? lastPage, 
      List<Links>? links, 
      String? path, 
      int? perPage, 
      int? to, 
      int? total,}){
    _currentPage = currentPage;
    _from = from;
    _lastPage = lastPage;
    _links = links;
    _path = path;
    _perPage = perPage;
    _to = to;
    _total = total;
}

  Meta.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    _from = json['from'];
    _lastPage = json['last_page'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _path = json['path'];
    _perPage = json['per_page'];
    _to = json['to'];
    _total = json['total'];
  }
  int? _currentPage;
  int? _from;
  int? _lastPage;
  List<Links>? _links;
  String? _path;
  int? _perPage;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;
  int? get from => _from;
  int? get lastPage => _lastPage;
  List<Links>? get links => _links;
  String? get path => _path;
  int? get perPage => _perPage;
  int? get to => _to;
  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

/// url : null
/// label : "&laquo; Previous"
/// active : false

class Links {
  Links({
      dynamic url, 
      String? label, 
      bool? active,}){
    _url = url;
    _label = label;
    _active = active;
}

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;

  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }

}

/// first : "https://apps.piit.us/my-pharmacy/api/v1/admin/orders?page=1"
/// last : "https://apps.piit.us/my-pharmacy/api/v1/admin/orders?page=1"
/// prev : null
/// next : null

/// id : 60
/// order_number  : "MPBP-91648532547"
/// user_id : "29"
/// name : "Nayon Talukder"
/// email : "nayon.coders@gmail.com"
/// phone : "01814569747"
/// amount : "140"
/// shipping : "20.00"
/// discount : null
/// address : "Nadmulla, Bhandaria, Pirojpur 8550, "
/// division : {"id":1,"name":"Chattagram"}
/// district : {"id":1,"name":"Comilla","division_id":"1"}
/// upazila : {"id":1,"name":"Debidwar","district_id":"1"}
/// zip : "8550"
/// status : "Confirmed"
/// date : "2022-04-10 14:21:16"
/// payment_status : "unpaid"
/// delivery_man : {"id":37,"name":"Del","email":"deliveryman@mail.com","phone":"01814-569747","image":null,"nid":"32123123"}

class Data {
  Data({
      int? id, 
      String? orderNumber, 
      String? userId, 
      String? name, 
      String? email, 
      String? phone, 
      String? amount, 
      String? shipping, 
      dynamic discount, 
      String? address, 
      Division? division, 
      District? district, 
      Upazila? upazila, 
      String? zip, 
      String? status, 
      String? date, 
      String? paymentStatus, 
      DeliveryMan? deliveryMan,}){
    _id = id;
    _orderNumber = orderNumber;
    _userId = userId;
    _name = name;
    _email = email;
    _phone = phone;
    _amount = amount;
    _shipping = shipping;
    _discount = discount;
    _address = address;
    _division = division;
    _district = district;
    _upazila = upazila;
    _zip = zip;
    _status = status;
    _date = date;
    _paymentStatus = paymentStatus;
    _deliveryMan = deliveryMan;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _orderNumber = json['order_number '];
    _userId = json['user_id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _amount = json['amount'];
    _shipping = json['shipping'];
    _discount = json['discount'];
    _address = json['address'];
    _division = json['division'] != null ? Division.fromJson(json['division']) : null;
    _district = json['district'] != null ? District.fromJson(json['district']) : null;
    _upazila = json['upazila'] != null ? Upazila.fromJson(json['upazila']) : null;
    _zip = json['zip'];
    _status = json['status'];
    _date = json['date'];
    _paymentStatus = json['payment_status'];
    _deliveryMan = json['delivery_man'] != null ? DeliveryMan.fromJson(json['delivery_man']) : null;
  }
  int? _id;
  String? _orderNumber;
  String? _userId;
  String? _name;
  String? _email;
  String? _phone;
  String? _amount;
  String? _shipping;
  dynamic _discount;
  String? _address;
  Division? _division;
  District? _district;
  Upazila? _upazila;
  String? _zip;
  String? _status;
  String? _date;
  String? _paymentStatus;
  DeliveryMan? _deliveryMan;

  int? get id => _id;
  String? get orderNumber => _orderNumber;
  String? get userId => _userId;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get amount => _amount;
  String? get shipping => _shipping;
  dynamic get discount => _discount;
  String? get address => _address;
  Division? get division => _division;
  District? get district => _district;
  Upazila? get upazila => _upazila;
  String? get zip => _zip;
  String? get status => _status;
  String? get date => _date;
  String? get paymentStatus => _paymentStatus;
  DeliveryMan? get deliveryMan => _deliveryMan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['order_number '] = _orderNumber;
    map['user_id'] = _userId;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['amount'] = _amount;
    map['shipping'] = _shipping;
    map['discount'] = _discount;
    map['address'] = _address;
    if (_division != null) {
      map['division'] = _division?.toJson();
    }
    if (_district != null) {
      map['district'] = _district?.toJson();
    }
    if (_upazila != null) {
      map['upazila'] = _upazila?.toJson();
    }
    map['zip'] = _zip;
    map['status'] = _status;
    map['date'] = _date;
    map['payment_status'] = _paymentStatus;
    if (_deliveryMan != null) {
      map['delivery_man'] = _deliveryMan?.toJson();
    }
    return map;
  }

}

/// id : 37
/// name : "Del"
/// email : "deliveryman@mail.com"
/// phone : "01814-569747"
/// image : null
/// nid : "32123123"

class DeliveryMan {
  DeliveryMan({
      int? id, 
      String? name, 
      String? email, 
      String? phone, 
      dynamic image, 
      String? nid,}){
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _image = image;
    _nid = nid;
}

  DeliveryMan.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _image = json['image'];
    _nid = json['nid'];
  }
  int? _id;
  String? _name;
  String? _email;
  String? _phone;
  dynamic _image;
  String? _nid;

  int? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  dynamic get image => _image;
  String? get nid => _nid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['image'] = _image;
    map['nid'] = _nid;
    return map;
  }

}

/// id : 1
/// name : "Debidwar"
/// district_id : "1"

class Upazila {
  Upazila({
      int? id, 
      String? name, 
      String? districtId,}){
    _id = id;
    _name = name;
    _districtId = districtId;
}

  Upazila.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _districtId = json['district_id'];
  }
  int? _id;
  String? _name;
  String? _districtId;

  int? get id => _id;
  String? get name => _name;
  String? get districtId => _districtId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['district_id'] = _districtId;
    return map;
  }

}

/// id : 1
/// name : "Comilla"
/// division_id : "1"

class District {
  District({
      int? id, 
      String? name, 
      String? divisionId,}){
    _id = id;
    _name = name;
    _divisionId = divisionId;
}

  District.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _divisionId = json['division_id'];
  }
  int? _id;
  String? _name;
  String? _divisionId;

  int? get id => _id;
  String? get name => _name;
  String? get divisionId => _divisionId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['division_id'] = _divisionId;
    return map;
  }

}

/// id : 1
/// name : "Chattagram"

class Division {
  Division({
      int? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Division.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}