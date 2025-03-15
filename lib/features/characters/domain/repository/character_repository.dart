import 'package:rick_and_morty_explorer/features/characters/data/model/character_model.dart';

abstract class CharacterRepository {
  Future<List<CharacterModel>> getCharacters({int page = 0});
  Future<void> addToFavorit(CharacterModel character);
  Future<void> removeFromFavorit(CharacterModel character);
  Future<List<CharacterModel>> getFavoriteCharactes();
}
