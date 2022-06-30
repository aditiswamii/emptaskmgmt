import 'dart:convert';
/// id : 1
/// emp_name : "Bill Shanahan"
/// department_id : 4
/// created_at : "2022-06-30T09:16:05.000000Z"
/// updated_at : "2022-06-30T09:16:05.000000Z"
/// department_name : "B.A"
/// department : {"id":4,"department_name":"B.A","created_at":null,"updated_at":null}

GetEmployeeList getEmployeeListFromJson(String str) => GetEmployeeList.fromJson(json.decode(str));
String getEmployeeListToJson(GetEmployeeList data) => json.encode(data.toJson());
class GetEmployeeList {
  GetEmployeeList({
      int? id, 
      String? empName, 
      int? departmentId, 
      String? createdAt, 
      String? updatedAt, 
      String? departmentName, 
      Department? department,}){
    _id = id;
    _empName = empName;
    _departmentId = departmentId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _departmentName = departmentName;
    _department = department;
}

  GetEmployeeList.fromJson(dynamic json) {
    _id = json['id'];
    _empName = json['emp_name'];
    _departmentId = json['department_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _departmentName = json['department_name'];
    _department = json['department'] != null ? Department.fromJson(json['department']) : null;
  }
  int? _id;
  String? _empName;
  int? _departmentId;
  String? _createdAt;
  String? _updatedAt;
  String? _departmentName;
  Department? _department;
GetEmployeeList copyWith({  int? id,
  String? empName,
  int? departmentId,
  String? createdAt,
  String? updatedAt,
  String? departmentName,
  Department? department,
}) => GetEmployeeList(  id: id ?? _id,
  empName: empName ?? _empName,
  departmentId: departmentId ?? _departmentId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  departmentName: departmentName ?? _departmentName,
  department: department ?? _department,
);
  int? get id => _id;
  String? get empName => _empName;
  int? get departmentId => _departmentId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get departmentName => _departmentName;
  Department? get department => _department;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['emp_name'] = _empName;
    map['department_id'] = _departmentId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['department_name'] = _departmentName;
    if (_department != null) {
      map['department'] = _department?.toJson();
    }
    return map;
  }

}

/// id : 4
/// department_name : "B.A"
/// created_at : null
/// updated_at : null

Department departmentFromJson(String str) => Department.fromJson(json.decode(str));
String departmentToJson(Department data) => json.encode(data.toJson());
class Department {
  Department({
      int? id, 
      String? departmentName, 
      dynamic createdAt, 
      dynamic updatedAt,}){
    _id = id;
    _departmentName = departmentName;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Department.fromJson(dynamic json) {
    _id = json['id'];
    _departmentName = json['department_name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _departmentName;
  dynamic _createdAt;
  dynamic _updatedAt;
Department copyWith({  int? id,
  String? departmentName,
  dynamic createdAt,
  dynamic updatedAt,
}) => Department(  id: id ?? _id,
  departmentName: departmentName ?? _departmentName,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  int? get id => _id;
  String? get departmentName => _departmentName;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['department_name'] = _departmentName;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}