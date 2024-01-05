import 'dart:convert';
GenerateAgoraTokenModel generateAgoraTokenModelFromJson(String str) => GenerateAgoraTokenModel.fromJson(json.decode(str));
String generateAgoraTokenModelToJson(GenerateAgoraTokenModel data) => json.encode(data.toJson());
class GenerateAgoraTokenModel {
  GenerateAgoraTokenModel({
      String? data, 
      bool? success, 
      String? message, 
      dynamic errors,}){
    _data = data;
    _success = success;
    _message = message;
    _errors = errors;
}

  GenerateAgoraTokenModel.fromJson(dynamic json) {
    _data = json['data'];
    _success = json['success'];
    _message = json['message'];
    _errors = json['errors'];
  }
  String? _data;
  bool? _success;
  String? _message;
  dynamic _errors;
GenerateAgoraTokenModel copyWith({  String? data,
  bool? success,
  String? message,
  dynamic errors,
}) => GenerateAgoraTokenModel(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
  errors: errors ?? _errors,
);
  String? get data => _data;
  bool? get success => _success;
  String? get message => _message;
  dynamic get errors => _errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    map['success'] = _success;
    map['message'] = _message;
    map['errors'] = _errors;
    return map;
  }

}