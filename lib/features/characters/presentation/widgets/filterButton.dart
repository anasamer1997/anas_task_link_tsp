import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../list_page/cubit/character_page_cubit.dart';

class FilterStatusBTN extends StatelessWidget {
  const FilterStatusBTN({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterPageCubit, CharacterPageState>(
      builder: (context, state) {
        return PopupMenuButton<String>(
          icon: const Icon(Icons.filter_list),
          onSelected: (filter) {
            if (filter == "Reset") {
              context.read<CharacterPageCubit>().resetFilter();
            } else {
              context.read<CharacterPageCubit>().filterByStatus(filter);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: "Alive", child: Text("Alive")),
            const PopupMenuItem(value: "Dead", child: Text("Dead")),
            const PopupMenuItem(value: "Unknown", child: Text("Unknown")),
            const PopupMenuItem(value: "Reset", child: Text("Reset Filter")),
          ],
        );
      },
    );
  }
}

class FilterSpeciesBTN extends StatelessWidget {
  const FilterSpeciesBTN({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterPageCubit, CharacterPageState>(
      builder: (context, state) {
        return PopupMenuButton<String>(
          child: const Text('Select Species'),
          onSelected: (filter) {
            if (filter == "etc") {
              // context.read<CharacterPageCubit>().resetFilter();
            } else {
              // context.read<CharacterPageCubit>().filterByStatus(filter);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: "Human", child: Text("Human")),
            const PopupMenuItem(value: "Alien", child: Text("Alien")),
            const PopupMenuItem(value: "etc", child: Text("etc")),
          ],
        );
      },
    );
  }
}
