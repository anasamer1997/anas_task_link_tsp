import 'package:dio/dio.dart';
import 'package:rick_and_morty_explorer/core/helper/log_helper.dart';
import 'package:rick_and_morty_explorer/features/characters/data/model/character_model.dart';

import 'package:rick_and_morty_explorer/features/characters/data/data_source/remote/api.dart';
import 'package:rick_and_morty_explorer/features/characters/domain/repository/character_repository.dart';

import '../../../../core/dependency_injection/di.dart';
import '../../../../core/helper/connection_helper.dart';
import '../data_source/local/db_provider.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final Api _api;
  final DataBaseProvider _dbProvider;

  CharacterRepositoryImpl(this._api, this._dbProvider);

  @override
  Future<List<CharacterModel>> getCharacters({int page = 0}) async {
    final bool isInternetConnected =
        await di<InternetConnectionHelper>().checkInternetConnection();

    if (isInternetConnected) {
      try {
        final Response response = await _api.loadCharacters(page: page);
        logger.d(
            'Fetch [Characters] from the Server and cache it in the local DataBase');
        final charactersResponse = (response.data!['results'] as List<dynamic>)
            .map((e) => CharacterModel.fromJson(e))
            .toList();

        /// Success
        if (charactersResponse.isNotEmpty) {
          return charactersResponse;
        }
      } catch (e) {
        logger.e('Unexpected error happened!');
        return [];
      }
    } else {
      logger.e('No Network Connection!');
    }
    return [];
  }

  @override
  Future<void> addToFavorit(CharacterModel character) async {
    try {
      // Mark the character as favorite
      character.isFavorit = true;
      // Update the character in the local database
      await _dbProvider.insertCharacters(character: character);
      logger.d('Character added to favorites: ${character.name}');
    } catch (e) {
      logger.e('Error adding character to favorites: $e');
    }
  }

  @override
  Future<void> removeFromFavorit(CharacterModel character) async {
    try {
      // Mark the character as not favorite
      character.isFavorit = false;
      // Update the character in the local database
      await _dbProvider.removeCharacters(character: character);
      logger.d('Character removed from favorites: ${character.name}');
    } catch (e) {
      logger.e('Error removing character from favorites: $e');
    }
  }

  @override
  Future<List<CharacterModel>> getFavoriteCharactes() async {
    try {
      // Retrieve all characters from the local database
      final characters = await _dbProvider.getCharacters();
      if (characters != null) {
        // Filter characters to return only favorites
        return characters.where((character) => character.isFavorit).toList();
      }
    } catch (e) {
      logger.e('Error retrieving favorite characters: $e');
    }
    return [];
  }
}
