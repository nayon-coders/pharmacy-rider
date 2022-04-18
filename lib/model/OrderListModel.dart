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
/// status : "Processing"
/// date : "2022-04-18 12:36:16"
/// payment_status : "unpaid"
/// updated_at : "2022-04-18"
/// delivery_man : {"id":37,"name":"Del","email":"deliveryman@mail.com","phone":"01814-569747","image":null,"nid":"32123123"}

class OrderListModel {
  OrderListModel({
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
      String? updatedAt, 
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
    _updatedAt = updatedAt;
    _deliveryMan = deliveryMan;
}

  OrderListModel.fromJson(dynamic json) {
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
    _updatedAt = json['updated_at'];
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
  String? _updatedAt;
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
  String? get updatedAt => _updatedAt;
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
    map['updated_at'] = _updatedAt;
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