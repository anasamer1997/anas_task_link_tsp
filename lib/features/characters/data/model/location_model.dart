import 'package:hive/hive.dart';

import 'hive_helper/hive_types.dart';

part 'location_model.g.dart';

@HiveType(typeId: HiveTypes.location)
class LocationModel extends HiveObject {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? url;

  LocationModel({required this.name, required this.url});
  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        name: json["name"] ?? "",
        url: json["name"] ?? "",
      );
}
