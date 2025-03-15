part of 'character_page_cubit.dart';

enum CharacterPageStatus { initial, loading, success, failure }

class CharacterPageState extends Equatable {
  const CharacterPageState({
    this.status = CharacterPageStatus.initial,
    this.characters = const [],
    this.filteredCharacters = const [],
    this.currentPage = 1,
    this.isFilter = false,
    this.selectedFilter = '',
    this.searchText = '',
    this.errorMessage = '',
  });

  final CharacterPageStatus status;
  final List<CharacterModel> characters;
  final List<CharacterModel> filteredCharacters;
  final bool isFilter;
  final int currentPage;
  final String? selectedFilter;
  final String? searchText;
  final String errorMessage;

  CharacterPageState copyWith({
    CharacterPageStatus? status,
    List<CharacterModel>? characters,
    List<CharacterModel>? filteredCharacters,
    bool? isFilter,
    int? currentPage,
    String? selectedFilter,
    String? searchText,
    String? errorMessage,
  }) {
    return CharacterPageState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      filteredCharacters: filteredCharacters ?? this.filteredCharacters,
      currentPage: currentPage ?? this.currentPage,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      searchText: searchText ?? this.searchText,
      errorMessage: errorMessage ?? this.errorMessage,
      isFilter: isFilter ?? this.isFilter,
    );
  }

  @override
  List<Object> get props => [
        status,
        characters,
        filteredCharacters,
        currentPage,
        errorMessage,
        isFilter
      ];
}
