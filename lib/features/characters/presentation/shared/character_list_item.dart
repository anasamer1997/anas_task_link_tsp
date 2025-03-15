import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_explorer/core/dependency_injection/di.dart';

import 'package:rick_and_morty_explorer/features/characters/data/model/character_model.dart';
import 'package:rick_and_morty_explorer/features/characters/presentation/favorite/cubit/favorit_cubit.dart';

typedef OnCharacterListItemTap = void Function(CharacterModel character);

class CharacterListItem extends StatelessWidget {
  const CharacterListItem({
    super.key,
    required this.item,
    this.onTap,
    // this.add_remove_favorit,
  });

  final CharacterModel item;
  final OnCharacterListItemTap? onTap;
  // final OnCharacterListItemTap? add_remove_favorit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritCubit, FavoriteState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => onTap?.call(item),
          child: Card(
            elevation: 0,
            color: Colors.transparent,
            child: SizedBox(
              height: 124,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _ItemPhoto(item: item),
                  _ItemDescription(item: item),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ItemDescription extends StatelessWidget {
  const _ItemDescription({super.key, required this.item});

  final CharacterModel item;
  // final OnCharacterListItemTap? add_remove_favorit;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            color: colorScheme.surfaceContainerHighest,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.name,
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          item.isFavorit
                              ? di<FavoritCubit>().removeFromFavorites(item)
                              : di<FavoritCubit>().addToFavorites(item);
                        },
                        icon: item.isFavorit
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_border))
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Status: ${item.status}',
                  style: textTheme.labelSmall!.copyWith(
                    color: item.status == 'Alive'
                        ? Colors.lightGreen
                        : Colors.redAccent,
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Text(
                    'Last location: ${item.location.name}',
                    style: textTheme.labelSmall!.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemPhoto extends StatelessWidget {
  const _ItemPhoto({super.key, required this.item});

  final CharacterModel item;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: SizedBox(
        height: 122,
        child: Hero(
          tag: item.id,
          child: CachedNetworkImage(
            height: 122,
            width: 122,
            imageUrl: item.image,
            fit: BoxFit.cover,
            errorWidget: (ctx, url, err) => const Icon(Icons.error),
            placeholder: (ctx, url) => const Icon(Icons.image),
          ),
        ),
      ),
    );
  }
}
