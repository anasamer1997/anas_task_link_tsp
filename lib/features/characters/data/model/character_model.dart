import 'package:hive/hive.dart';
import 'package:rick_and_morty_explorer/features/characters/data/model/location_model.dart';

import 'hive_helper/hive_types.dart';

part 'character_model.g.dart';

// @HiveType(typeId: HiveTypes.characterResponse)
// class CharactersResponse extends HiveObject {
//   @HiveField(0)
//   final List<CharacterModel> results;

//   CharactersResponse({required this.results});

//   factory CharactersResponse.fromJson(Map<String, dynamic> json) =>
//       CharactersResponse(
//           results: List<CharacterModel>.from(
//               json['results']!.map((x) => CharacterModel.fromJson(x))));
// }

@HiveType(typeId: HiveTypes.characterModel)
class CharacterModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String status;
  @HiveField(3)
  final String species;
  @HiveField(4)
  final String? type;
  @HiveField(5)
  final String gender;
  @HiveField(6)
  final LocationModel origin;
  @HiveField(7)
  final LocationModel location;
  @HiveField(8)
  final String image;
  @HiveField(9)
  final List<String> episode;
  @HiveField(10)
  final String url;
  @HiveField(11)
  final DateTime created;
  @HiveField(12)
  bool isFavorit;

  CharacterModel(
      {required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.type,
      required this.gender,
      required this.origin,
      required this.location,
      required this.image,
      required this.episode,
      required this.url,
      required this.created,
      this.isFavorit = false});

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'] ?? "",
        gender: json['gender'],
        origin: LocationModel.fromJson(json['origin']),
        location: LocationModel.fromJson(json['location']),
        image: json['image'],
        episode: json['episode'] == null
            ? []
            : List<String>.from(json['episode']!.map((dynamic x) => x)),
        url: json['url'],
        created: DateTime.parse(json['created']),
      );
}
