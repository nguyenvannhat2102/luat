import 'dart:convert';

GetLawyerAppointmentScheduleModel getLawyerAppointmentScheduleModelFromJson(
        String str) =>
    GetLawyerAppointmentScheduleModel.fromJson(json.decode(str));
String getLawyerAppointmentScheduleModelToJson(
        GetLawyerAppointmentScheduleModel data) =>
    json.encode(data.toJson());

class GetLawyerAppointmentScheduleModel {
  GetLawyerAppointmentScheduleModel({
    GetLawyerBookAppointmentDataModel? data,
    bool? success,
    String? message,
    dynamic errors,
  }) {
    _data = data;
    _success = success;
    _message = message;
    _errors = errors;
  }

  GetLawyerAppointmentScheduleModel.fromJson(dynamic json) {
    _data = json['data'] != null
        ? GetLawyerBookAppointmentDataModel.fromJson(json['data'])
        : null;
    _success = json['success'];
    _message = json['message'];
    _errors = json['errors'];
  }
  GetLawyerBookAppointmentDataModel? _data;
  bool? _success;
  String? _message;
  dynamic _errors;
  GetLawyerAppointmentScheduleModel copyWith({
    GetLawyerBookAppointmentDataModel? data,
    bool? success,
    String? message,
    dynamic errors,
  }) =>
      GetLawyerAppointmentScheduleModel(
        data: data ?? _data,
        success: success ?? _success,
        message: message ?? _message,
        errors: errors ?? _errors,
      );
  GetLawyerBookAppointmentDataModel? get data => _data;
  bool? get success => _success;
  String? get message => _message;
  dynamic get errors => _errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['success'] = _success;
    map['message'] = _message;
    map['errors'] = _errors;
    return map;
  }
}

GetLawyerBookAppointmentDataModel dataFromJson(String str) =>
    GetLawyerBookAppointmentDataModel.fromJson(json.decode(str));
String dataToJson(GetLawyerBookAppointmentDataModel data) =>
    json.encode(data.toJson());

class GetLawyerBookAppointmentDataModel {
  GetLawyerBookAppointmentDataModel({
    Schedule? schedule,
  }) {
    _schedule = schedule;
  }

  GetLawyerBookAppointmentDataModel.fromJson(dynamic json) {
    _schedule =
        json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null;
  }
  Schedule? _schedule;
  GetLawyerBookAppointmentDataModel copyWith({
    Schedule? schedule,
  }) =>
      GetLawyerBookAppointmentDataModel(
        schedule: schedule ?? _schedule,
      );
  Schedule? get schedule => _schedule;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_schedule != null) {
      map['schedule'] = _schedule?.toJson();
    }
    return map;
  }
}

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));
String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  Schedule({
    num? id,
    num? lawyerId,
    dynamic lawFirmId,
    num? appointmentTypeId,
    num? fee,
    String? day,
    num? isHoliday,
    String? startTime,
    String? endTime,
    num? slotDuration,
    String? type,
    AppointmentType? appointmentType,
    List<ScheduleSlots>? scheduleSlots,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _lawyerId = lawyerId;
    _lawFirmId = lawFirmId;
    _appointmentTypeId = appointmentTypeId;
    _fee = fee;
    _day = day;
    _isHoliday = isHoliday;
    _startTime = startTime;
    _endTime = endTime;
    _slotDuration = slotDuration;
    _type = type;
    _appointmentType = appointmentType;
    _scheduleSlots = scheduleSlots;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Schedule.fromJson(dynamic json) {
    _id = json['id'];
    _lawyerId = json['lawyer_id'];
    _lawFirmId = json['law_firm_id'];
    _appointmentTypeId = json['appointment_type_id'];
    _fee = json['fee'];
    _day = json['day'];
    _isHoliday = json['is_holiday'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _slotDuration = json['slot_duration'];
    _type = json['type'];
    _appointmentType = json['appointment_type'] != null
        ? AppointmentType.fromJson(json['appointment_type'])
        : null;
    if (json['schedule_slots'] != null) {
      _scheduleSlots = [];
      json['schedule_slots'].forEach((v) {
        _scheduleSlots?.add(ScheduleSlots.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _lawyerId;
  dynamic _lawFirmId;
  num? _appointmentTypeId;
  num? _fee;
  String? _day;
  num? _isHoliday;
  String? _startTime;
  String? _endTime;
  num? _slotDuration;
  String? _type;
  AppointmentType? _appointmentType;
  List<ScheduleSlots>? _scheduleSlots;
  String? _createdAt;
  String? _updatedAt;
  Schedule copyWith({
    num? id,
    num? lawyerId,
    dynamic lawFirmId,
    num? appointmentTypeId,
    num? fee,
    String? day,
    num? isHoliday,
    String? startTime,
    String? endTime,
    num? slotDuration,
    String? type,
    AppointmentType? appointmentType,
    List<ScheduleSlots>? scheduleSlots,
    String? createdAt,
    String? updatedAt,
  }) =>
      Schedule(
        id: id ?? _id,
        lawyerId: lawyerId ?? _lawyerId,
        lawFirmId: lawFirmId ?? _lawFirmId,
        appointmentTypeId: appointmentTypeId ?? _appointmentTypeId,
        fee: fee ?? _fee,
        day: day ?? _day,
        isHoliday: isHoliday ?? _isHoliday,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        slotDuration: slotDuration ?? _slotDuration,
        type: type ?? _type,
        appointmentType: appointmentType ?? _appointmentType,
        scheduleSlots: scheduleSlots ?? _scheduleSlots,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  num? get lawyerId => _lawyerId;
  dynamic get lawFirmId => _lawFirmId;
  num? get appointmentTypeId => _appointmentTypeId;
  num? get fee => _fee;
  String? get day => _day;
  num? get isHoliday => _isHoliday;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  num? get slotDuration => _slotDuration;
  String? get type => _type;
  AppointmentType? get appointmentType => _appointmentType;
  List<ScheduleSlots>? get scheduleSlots => _scheduleSlots;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['lawyer_id'] = _lawyerId;
    map['law_firm_id'] = _lawFirmId;
    map['appointment_type_id'] = _appointmentTypeId;
    map['fee'] = _fee;
    map['day'] = _day;
    map['is_holiday'] = _isHoliday;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['slot_duration'] = _slotDuration;
    map['type'] = _type;
    if (_appointmentType != null) {
      map['appointment_type'] = _appointmentType?.toJson();
    }
    if (_scheduleSlots != null) {
      map['schedule_slots'] = _scheduleSlots?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

ScheduleSlots scheduleSlotsFromJson(String str) =>
    ScheduleSlots.fromJson(json.decode(str));
String scheduleSlotsToJson(ScheduleSlots data) => json.encode(data.toJson());

class ScheduleSlots {
  ScheduleSlots({
    num? id,
    num? scheduleId,
    String? startTime,
    String? endTime,
    num? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _scheduleId = scheduleId;
    _startTime = startTime;
    _endTime = endTime;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  ScheduleSlots.fromJson(dynamic json) {
    _id = json['id'];
    _scheduleId = json['schedule_id'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _scheduleId;
  String? _startTime;
  String? _endTime;
  num? _isActive;
  String? _createdAt;
  String? _updatedAt;
  ScheduleSlots copyWith({
    num? id,
    num? scheduleId,
    String? startTime,
    String? endTime,
    num? isActive,
    String? createdAt,
    String? updatedAt,
  }) =>
      ScheduleSlots(
        id: id ?? _id,
        scheduleId: scheduleId ?? _scheduleId,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        isActive: isActive ?? _isActive,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  num? get scheduleId => _scheduleId;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  num? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['schedule_id'] = _scheduleId;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

AppointmentType appointmentTypeFromJson(String str) =>
    AppointmentType.fromJson(json.decode(str));
String appointmentTypeToJson(AppointmentType data) =>
    json.encode(data.toJson());

class AppointmentType {
  AppointmentType({
    num? id,
    String? displayName,
    String? description,
    String? type,
    num? isScheduleRequired,
    num? isPaid,
    num? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _displayName = displayName;
    _description = description;
    _type = type;
    _isScheduleRequired = isScheduleRequired;
    _isPaid = isPaid;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  AppointmentType.fromJson(dynamic json) {
    _id = json['id'];
    _displayName = json['display_name'];
    _description = json['description'];
    _type = json['type'];
    _isScheduleRequired = json['is_schedule_required'];
    _isPaid = json['is_paid'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _displayName;
  String? _description;
  String? _type;
  num? _isScheduleRequired;
  num? _isPaid;
  num? _isActive;
  String? _createdAt;
  String? _updatedAt;
  AppointmentType copyWith({
    num? id,
    String? displayName,
    String? description,
    String? type,
    num? isScheduleRequired,
    num? isPaid,
    num? isActive,
    String? createdAt,
    String? updatedAt,
  }) =>
      AppointmentType(
        id: id ?? _id,
        displayName: displayName ?? _displayName,
        description: description ?? _description,
        type: type ?? _type,
        isScheduleRequired: isScheduleRequired ?? _isScheduleRequired,
        isPaid: isPaid ?? _isPaid,
        isActive: isActive ?? _isActive,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get displayName => _displayName;
  String? get description => _description;
  String? get type => _type;
  num? get isScheduleRequired => _isScheduleRequired;
  num? get isPaid => _isPaid;
  num? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['display_name'] = _displayName;
    map['description'] = _description;
    map['type'] = _type;
    map['is_schedule_required'] = _isScheduleRequired;
    map['is_paid'] = _isPaid;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
