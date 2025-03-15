import 'package:rick_and_morty_explorer/core/helper/log_helper.dart';
import 'package:rick_and_morty_explorer/features/characters/data/data_source/local/db_service.dart';
import 'package:rick_and_morty_explorer/features/characters/data/model/character_model.dart';

class DataBaseProvider {
  // Local Source For Home
  final DataBaseService _characterDBService;

  DataBaseProvider({
    required DataBaseService dataBaseService,
  }) : _characterDBService = dataBaseService;

  /// Read From DB
  Future<List<CharacterModel>?> getCharacters() async {
    try {
      return await _characterDBService.getCharacters();
    } catch (e) {
      // Log or handle the error appropriately
      logger.e('Error retrieving characters: $e');
      return null;
    }
  }

  /// Insert To DB
  Future<void> insertCharacters({required CharacterModel character}) async {
    try {
      await _characterDBService.insertItem(object: character);
    } catch (e) {
      // Handle insertion errors
      logger.e('Error inserting characters: $e');
    }
  }

  Future<void> removeCharacters({required CharacterModel character}) async {
    try {
      await _characterDBService.removeItem(object: character);
    } catch (e) {
      // Handle insertion errors
      logger.e('Error inserting characters: $e');
    }
  }

  /// Is Data Available
  Future<bool> isPostDataAvailable() async {
    return await _characterDBService.isDataAvailable();
  }
}
