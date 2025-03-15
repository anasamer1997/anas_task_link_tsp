import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_explorer/features/characters/data/model/character_model.dart';
import 'package:rick_and_morty_explorer/features/characters/data/repository/character_repository_impl.dart';

part 'character_page_state.dart';

class CharacterPageCubit extends Cubit<CharacterPageState> {
  // final GetAllCharactersUseCase _getAllCharacters;

  final CharacterRepositoryImpl _repository;
  CharacterPageCubit(this._repository) : super(const CharacterPageState());

  Future<void> fetchNextPage() async {
    emit(state.copyWith(status: CharacterPageStatus.loading));
    try {
      final charactersList =
          await _repository.getCharacters(page: state.currentPage);

      if (charactersList.isNotEmpty) {
        final updatedCharacters = List.of(state.characters)
          ..addAll(charactersList);
        if (state.isFilter) {
          final tempState = state.copyWith(characters: updatedCharacters);
          _applyFilters(tempState); // Apply current filters
        } else {
          emit(
            state.copyWith(
              status: CharacterPageStatus.success,
              currentPage: state.currentPage + 1,
              characters: updatedCharacters,
              isFilter: false,
            ),
          );
        }
      }
    } on DioException catch (e) {
      emit(
        state.copyWith(
            status: CharacterPageStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void filterByName(String name) {
    final newState = state.copyWith(searchText: name);
    emit(newState);
    _applyFilters(newState);
  }

  void filterByStatus(String status) {
    final newState = state.copyWith(selectedFilter: status);
    emit(newState);
    _applyFilters(newState);
  }

  void _applyFilters(CharacterPageState state) {
    List<CharacterModel> filteredCharacters = List.from(state.characters);

    if (state.searchText != null && state.searchText!.isNotEmpty) {
      filteredCharacters = filteredCharacters
          .where((character) => character.name
              .toLowerCase()
              .contains(state.searchText!.toLowerCase()))
          .toList();
    }

    if (state.selectedFilter != null && state.selectedFilter!.isNotEmpty) {
      filteredCharacters = filteredCharacters
          .where((character) =>
              character.status.toLowerCase() ==
              state.selectedFilter!.toLowerCase()) // Ensure case consistency
          .toList();
    }

    emit(
        state.copyWith(filteredCharacters: filteredCharacters, isFilter: true));
  }

  void resetFilter() {
    emit(state.copyWith(
        characters: state.characters,
        isFilter: false,
        searchText: null,
        selectedFilter: null));
  }
}
