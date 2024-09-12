// To parse this JSON data, do
//
//     final categoriModel = categoriModelFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

CategoriModel categoriModelFromJson(String str) => CategoriModel.fromJson(json.decode(str));

String categoriModelToJson(CategoriModel data) => json.encode(data.toJson());

class CategoriModel {
    List<Category> categories;

    CategoriModel({
        required this.categories,
    });

    factory CategoriModel.fromJson(Map<String, dynamic> json) => CategoriModel(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}

class Category {
    String name;
    List<String> subcategory;

    Category({
        required this.name,
        required this.subcategory,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcategory: List<String>.from(json["Subcategory"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "Subcategory": List<dynamic>.from(subcategory.map((x) => x)),
    };
}
