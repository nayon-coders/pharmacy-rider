/// data : {"id":5,"order_number ":"#241644323903","order_products ":[{"id":5,"order_id":"5","product_id":"873","shop_id":null,"product_name":"Ambrox 15ml","price":"33","quantity":"1","total":"33","point":null,"status":"Pending","deleted_at":null,"created_at":"2022-02-08T12:38:23.000000Z","updated_at":"2022-02-08T12:38:23.000000Z"},{"id":6,"order_id":"5","product_id":"895","shop_id":null,"product_name":"Antazol0.05%","price":"11","quantity":"4","total":"44","point":null,"status":"Pending","deleted_at":null,"created_at":"2022-02-08T12:38:23.000000Z","updated_at":"2022-02-08T12:38:23.000000Z"}],"user_id":"24","name":"Shawon","email":"shawon@mail.com","phone":"+8801111111112","amount":"97","shipping":"20.00","discount":null,"address":"asdfas hibib, ","division":{"id":6,"name":"Dhaka"},"district":{"id":52,"name":"Faridpur","division_id":"6"},"upazila":{"id":395,"name":"Bhanga","district_id":"52"},"zip":"1205","status":"Pending","date":"2022-04-09 15:02:53","payment_status":"unpaid"}

class PendingOrderDetailsModel {
  PendingOrderDetailsModel({
      Data? data,}){
    _data = data;
}

  PendingOrderDetailsModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 5
/// order_number  : "#241644323903"
/// order_products  : [{"id":5,"order_id":"5","product_id":"873","shop_id":null,"product_name":"Ambrox 15ml","price":"33","quantity":"1","total":"33","point":null,"status":"Pending","deleted_at":null,"created_at":"2022-02-08T12:38:23.000000Z","updated_at":"2022-02-08T12:38:23.000000Z"},{"id":6,"order_id":"5","product_id":"895","shop_id":null,"product_name":"Antazol0.05%","price":"11","quantity":"4","total":"44","point":null,"status":"Pending","deleted_at":null,"created_at":"2022-02-08T12:38:23.000000Z","updated_at":"2022-02-08T12:38:23.000000Z"}]
/// user_id : "24"
/// name : "Shawon"
/// email : "shawon@mail.com"
/// phone : "+8801111111112"
/// amount : "97"
/// shipping : "20.00"
/// discount : null
/// address : "asdfas hibib, "
/// division : {"id":6,"name":"Dhaka"}
/// district : {"id":52,"name":"Faridpur","division_id":"6"}
/// upazila : {"id":395,"name":"Bhanga","district_id":"52"}
/// zip : "1205"
/// status : "Pending"
/// date : "2022-04-09 15:02:53"
/// payment_status : "unpaid"

class Data {
  Data({
      int? id, 
      String? orderNumber, 
      List<OrderProducts>? orderProducts, 
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
      String? paymentStatus,}){
    _id = id;
    _orderNumber = orderNumber;
    _orderProducts = orderProducts;
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
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _orderNumber = json['order_number '];
    if (json['order_products '] != null) {
      _orderProducts = [];
      json['order_products '].forEach((v) {
        _orderProducts?.add(OrderProducts.fromJson(v));
      });
    }
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
  }
  int? _id;
  String? _orderNumber;
  List<OrderProducts>? _orderProducts;
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

  int? get id => _id;
  String? get orderNumber => _orderNumber;
  List<OrderProducts>? get orderProducts => _orderProducts;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['order_number '] = _orderNumber;
    if (_orderProducts != null) {
      map['order_products '] = _orderProducts?.map((v) => v.toJson()).toList();
    }
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
    return map;
  }

}

/// id : 395
/// name : "Bhanga"
/// district_id : "52"

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

/// id : 52
/// name : "Faridpur"
/// division_id : "6"

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

/// id : 6
/// name : "Dhaka"

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

/// id : 5
/// order_id : "5"
/// product_id : "873"
/// shop_id : null
/// product_name : "Ambrox 15ml"
/// price : "33"
/// quantity : "1"
/// total : "33"
/// point : null
/// status : "Pending"
/// deleted_at : null
/// created_at : "2022-02-08T12:38:23.000000Z"
/// updated_at : "2022-02-08T12:38:23.000000Z"

class OrderProducts {
  OrderProducts({
      int? id, 
      String? orderId, 
      String? productId, 
      dynamic shopId, 
      String? productName, 
      String? price, 
      String? quantity, 
      String? total, 
      dynamic point, 
      String? status, 
      dynamic deletedAt, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _orderId = orderId;
    _productId = productId;
    _shopId = shopId;
    _productName = productName;
    _price = price;
    _quantity = quantity;
    _total = total;
    _point = point;
    _status = status;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  OrderProducts.fromJson(dynamic json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _productId = json['product_id'];
    _shopId = json['shop_id'];
    _productName = json['product_name'];
    _price = json['price'];
    _quantity = json['quantity'];
    _total = json['total'];
    _point = json['point'];
    _status = json['status'];
    _deletedAt = json['deleted_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _orderId;
  String? _productId;
  dynamic _shopId;
  String? _productName;
  String? _price;
  String? _quantity;
  String? _total;
  dynamic _point;
  String? _status;
  dynamic _deletedAt;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get orderId => _orderId;
  String? get productId => _productId;
  dynamic get shopId => _shopId;
  String? get productName => _productName;
  String? get price => _price;
  String? get quantity => _quantity;
  String? get total => _total;
  dynamic get point => _point;
  String? get status => _status;
  dynamic get deletedAt => _deletedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['order_id'] = _orderId;
    map['product_id'] = _productId;
    map['shop_id'] = _shopId;
    map['product_name'] = _productName;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['total'] = _total;
    map['point'] = _point;
    map['status'] = _status;
    map['deleted_at'] = _deletedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}