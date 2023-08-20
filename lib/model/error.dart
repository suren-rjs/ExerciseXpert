import 'dart:convert';

class CustomError {
    String message;

    CustomError({
        required this.message,
    });

    factory CustomError.fromRawJson(String str) => CustomError.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CustomError.fromJson(Map<String, dynamic> json) => CustomError(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
