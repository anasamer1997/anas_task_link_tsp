import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_explorer/features/characters/data/model/character_model.dart';
// import 'package:rick_and_morty_explorer/features/characters/domain/entities/character_entity.dart';

part 'character_details_state.dart';

class CharacterDetailsCubit extends Cubit<CharacterDetailsState> {
  CharacterDetailsCubit({
    required CharacterModel character,
  }) : super(CharacterDetailsState(character));
}
