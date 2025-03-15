import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_explorer/features/characters/data/model/character_model.dart';
import 'package:rick_and_morty_explorer/features/characters/presentation/details_page/view/character_details_page.dart';
import 'package:rick_and_morty_explorer/features/characters/presentation/favorite/cubit/favorit_cubit.dart';
import 'package:rick_and_morty_explorer/features/characters/presentation/shared/character_list_item.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritCubit>().fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocBuilder<FavoritCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavoriteError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content:
                      Text('Failed to load characters. Please try again.')),
            );
          } else if (state is FavoriteLoaded) {
            final list = state.favoriteCharacters;
            return ListView.builder(
              key: const ValueKey('character_page_list_key'),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return CharacterListItem(item: item, onTap: _goToDetails);
              },
            );
          }
          return const Placeholder();
        },
      ),
    );
  }

  void _goToDetails(CharacterModel character) {
    final route = CharacterDetailsPage.route(character: character);
    Navigator.of(context).push(route);
  }
}
