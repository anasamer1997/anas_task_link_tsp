part of 'favorit_cubit.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<CharacterModel> favoriteCharacters;

  FavoriteLoaded(this.favoriteCharacters);
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}
