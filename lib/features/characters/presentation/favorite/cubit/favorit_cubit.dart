import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:rick_and_morty_explorer/features/characters/data/model/character_model.dart';
import 'package:rick_and_morty_explorer/features/characters/data/repository/character_repository_impl.dart';

part 'favorit_state.dart';

class FavoritCubit extends Cubit<FavoriteState> {
  final CharacterRepositoryImpl _characterRepository;
  FavoritCubit(this._characterRepository) : super(FavoriteInitial());

  Future<void> fetchFavorites() async {
    emit(FavoriteLoading());
    try {
      final favorites = await _characterRepository.getFavoriteCharactes();
      emit(FavoriteLoaded(favorites));
    } catch (e) {
      emit(FavoriteError('Failed to fetch favorites: $e'));
    }
  }

  /// Add a character to favorites
  Future<void> addToFavorites(CharacterModel character) async {
    try {
      await _characterRepository.addToFavorit(character);
      // Fetch updated list of favorites
      await fetchFavorites();
    } catch (e) {
      emit(FavoriteError('Failed to add to favorites: $e'));
    }
  }

  /// Remove a character from favorites
  Future<void> removeFromFavorites(CharacterModel character) async {
    try {
      await _characterRepository.removeFromFavorit(character);
      // Fetch updated list of favorites
      await fetchFavorites();
    } catch (e) {
      emit(FavoriteError('Failed to remove from favorites: $e'));
    }
  }
}
