import 'package:hive/hive.dart';
import 'package:rick_and_morty_explorer/config/constants/db_keys.dart';
import 'package:rick_and_morty_explorer/core/helper/log_helper.dart';
import 'package:rick_and_morty_explorer/features/characters/data/model/character_model.dart';
import 'package:rick_and_morty_explorer/features/characters/data/model/location_model.dart';

class DataBaseService {
  /// Box Key
  static const String _key = DbKeys.dbFavoritCharacters;

  DataBaseService();

  /// init DB
  Future<void> initDataBase() async {
    try {
      Hive.registerAdapter(CharacterModelAdapter());
      Hive.registerAdapter(LocationModelAdapter());
      await Hive.openBox<CharacterModel>(_key);
      logger.d('Success on initializing database For *CharacterModel*');
    } catch (e) {
      // Handle initialization errors
      logger.e('Error initializing database For *CharacterModel*');
    }
  }

  Future<List<CharacterModel>?> getCharacters() async {
    try {
      final box = Hive.box<CharacterModel>(_key);
      return box.values.toList();
    } catch (e) {
      logger.e('Error retrieving characters: $e');
      return null;
    }
  }

  Future<void> insertItem({required CharacterModel object}) async {
    try {
      final box = Hive.box<CharacterModel>(_key);
      await box.put(object.id, object);
    } catch (e) {
      logger.e('Error inserting character: $e');
    }
  }

  /// Remove Character from DB
  Future<void> removeItem({required CharacterModel object}) async {
    try {
      final box = Hive.box<CharacterModel>(_key);
      await box.delete(object.id);
    } catch (e) {
      logger.e('Error removing character: $e');
    }
  }

  /// Check if Data is Available in DB
  Future<bool> isDataAvailable() async {
    try {
      final box = Hive.box<CharacterModel>(_key);
      return box.isNotEmpty;
    } catch (e) {
      logger.e('Error checking data availability: $e');
      return false;
    }
  }
}
/*


class DataBaseService {
  /// Box Key
  static const String _key = DbKeys.dbFavoritCharacters;

  late final Box<List<CharacterModel>> _favoritesBox;
  DataBaseService();

  /// init DB
  Future<void> initDataBase() async {
    try {
      Hive.registerAdapter(CharacterModelAdapter());
      Hive.registerAdapter(CharactersResponseAdapter());
      Hive.registerAdapter(LocationModelAdapter());
      _favoritesBox = await Hive.openBox(_key);
      logger.d('Success on initializing database For *CharacterModel*');
    } catch (e) {
      // Handle initialization errors
      logger.e('Error initializing database For *CharacterModel*');
    }
  }

  Future<List<CharacterModel>?> getCharacters() async {
    try {
      if (_favoritesBox.isOpen && _favoritesBox.isNotEmpty) {
        return _favoritesBox.get(_key);
      } else {
        return null;
      }
    } catch (e) {
      // Handle read errors
      logger.e('Error reading from database: $e');
    }

    return null;
  }

  Future<void> insertItem({required CharacterModel object}) async {
    try {
      await _favoritesBox.put(_key, object);
    } catch (e) {
      // Handle insertion errors
      logger.e('Error inserting into database: $e');
    }
  }

  Future<bool> isDataAvailable() async {
    try {
      return _favoritesBox.isEmpty;
    } catch (e) {
      // Handle error checking box emptiness
      logger.e('Error checking if box is empty: $e');
      return true; // Return true assuming it's empty on error
    }
  }
}

*/