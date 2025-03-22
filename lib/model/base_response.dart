import 'dart:convert';

class BaseResponse<T> {
  num? code;
  String? message;
  T? data;
  num? total;

  BaseResponse({
    this.code,
    this.message,
    this.data,
    this.total,
  });

  BaseResponse copyWith({
    num? code,
    String? message,
    T? data,
    num? total,
  }) =>
      BaseResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data,
        total: total ?? this.total,
      );

  factory BaseResponse.fromRawJson(
    String str,
    T Function(Object? json) fromJsonT,
  ) =>
      BaseResponse.fromJson(json.decode(str), fromJsonT);

  String toRawJson(
    Object? Function(T value) toJsonT,
  ) =>
      json.encode(toJson(toJsonT));

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      BaseResponse(
        code: json["Code"],
        message: json["Message"],
        data: json["Data"] == null ? null : fromJsonT(json["Data"]),
        total: json["Total"],
      );

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      {
        "Code": code,
        "Message": message,
        "Data": data == null ? null : toJsonT(data as T),
        "Total": total,
      };
}

class BaseResponseList<T> {
  num? code;
  String? message;
  List<T>? data;
  num? total;

  BaseResponseList({
    this.code,
    this.message,
    this.data,
    this.total,
  });

  BaseResponseList copyWith({
    num? code,
    String? message,
    List<T>? data,
    num? total,
  }) =>
      BaseResponseList(
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data,
        total: total ?? this.total,
      );

  factory BaseResponseList.fromRawJson(
    String str,
    T Function(Object? json) fromJsonT,
  ) =>
      BaseResponseList.fromJson(json.decode(str), fromJsonT);

  String toRawJson(
    Object? Function(T value) toJsonT,
  ) =>
      json.encode(toJson(toJsonT));

  factory BaseResponseList.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      BaseResponseList(
        code: json["Code"],
        message: json["Message"],
        data: json["Data"] == null
            ? []
            : List<T>.from(json["Data"]!.map((x) => fromJsonT(x))),
        total: json["Total"],
      );

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      {
        "Code": code,
        "Message": message,
        "Data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => toJsonT(x))),
        "Total": total,
      };
}
