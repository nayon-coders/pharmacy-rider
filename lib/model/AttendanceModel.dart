/// data : {"id":37,"user_id":"37","date":"2022-04-19","time":"14:04:32","attendance":"l","deleted_at":null,"created_at":"2022-04-19T08:32:14.000000Z","updated_at":"2022-04-19T08:37:49.000000Z","time_out":"14:04:37"}

class AttendanceModel {
  AttendanceModel({
      Data? data,}){
    _data = data;
}

  AttendanceModel.fromJson(dynamic json) {
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

/// id : 37
/// user_id : "37"
/// date : "2022-04-19"
/// time : "14:04:32"
/// attendance : "l"
/// deleted_at : null
/// created_at : "2022-04-19T08:32:14.000000Z"
/// updated_at : "2022-04-19T08:37:49.000000Z"
/// time_out : "14:04:37"

class Data {
  Data({
      int? id, 
      String? userId, 
      String? date, 
      String? time, 
      String? attendance, 
      dynamic deletedAt, 
      String? createdAt, 
      String? updatedAt, 
      String? timeOut,}){
    _id = id;
    _userId = userId;
    _date = date;
    _time = time;
    _attendance = attendance;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _timeOut = timeOut;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _date = json['date'];
    _time = json['time'];
    _attendance = json['attendance'];
    _deletedAt = json['deleted_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _timeOut = json['time_out'];
  }
  int? _id;
  String? _userId;
  String? _date;
  String? _time;
  String? _attendance;
  dynamic _deletedAt;
  String? _createdAt;
  String? _updatedAt;
  String? _timeOut;

  int? get id => _id;
  String? get userId => _userId;
  String? get date => _date;
  String? get time => _time;
  String? get attendance => _attendance;
  dynamic get deletedAt => _deletedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get timeOut => _timeOut;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['date'] = _date;
    map['time'] = _time;
    map['attendance'] = _attendance;
    map['deleted_at'] = _deletedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['time_out'] = _timeOut;
    return map;
  }

}