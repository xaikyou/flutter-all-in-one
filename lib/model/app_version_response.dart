import 'dart:convert';

class AppVersionResponse {
  String? version;
  String? url;

  AppVersionResponse({
    this.version,
    this.url,
  });

  AppVersionResponse copyWith({
    String? version,
    String? url,
  }) =>
      AppVersionResponse(
        version: version ?? this.version,
        url: url ?? this.url,
      );

  factory AppVersionResponse.fromRawJson(String str) =>
      AppVersionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AppVersionResponse.fromJson(Map<String, dynamic> json) =>
      AppVersionResponse(
        version: json["version"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "url": url,
      };
}
