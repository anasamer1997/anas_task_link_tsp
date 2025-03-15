import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_explorer/features/characters/data/model/character_model.dart';

import 'package:rick_and_morty_explorer/features/characters/presentation/shared/character_list_item.dart';

import 'package:rick_and_morty_explorer/features/characters/presentation/details_page/view/character_details_page.dart';
import 'package:rick_and_morty_explorer/features/characters/presentation/list_page/cubit/character_page_cubit.dart';
import 'package:rick_and_morty_explorer/features/characters/presentation/widgets/errorWidget.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterPageCubit, CharacterPageState>(
      listener: (context, state) {
        if (state.status == CharacterPageStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to load characters. Please try again.')),
          );
        } else if (state.status == CharacterPageStatus.loading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      builder: (context, state) {
        return state.status == CharacterPageStatus.failure
            ? CustomErrorWidget(
                onRetry: () =>
                    context.read<CharacterPageCubit>().fetchNextPage())
            : const _Content();
      },
    );
  }
}

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  final _searchController = TextEditingController();

  CharacterPageCubit get pageCubit => context.read<CharacterPageCubit>();

  @override
  void initState() {
    super.initState();
    context.read<CharacterPageCubit>().fetchNextPage();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext ctx) {
    return BlocBuilder<CharacterPageCubit, CharacterPageState>(
      builder: (context, state) {
        final list =
            state.isFilter ? state.filteredCharacters : state.characters;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by name...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels ==
                          notification.metrics.maxScrollExtent &&
                      notification is ScrollUpdateNotification) {
                    pageCubit.fetchNextPage();
                  }
                  return true;
                },
                child: ListView.builder(
                  key: const ValueKey('character_page_list_key'),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return CharacterListItem(item: item, onTap: _goToDetails);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _goToDetails(CharacterModel character) {
    final route = CharacterDetailsPage.route(character: character);
    Navigator.of(context).push(route);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();

    super.dispose();
  }

  void _onSearchChanged() {
    pageCubit.filterByName(_searchController.text); // Update search filter
  }
}
