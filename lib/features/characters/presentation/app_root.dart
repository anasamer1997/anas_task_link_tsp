import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_explorer/core/dependency_injection/di.dart';
import 'package:rick_and_morty_explorer/features/characters/presentation/favorite/view/favorite_screen.dart';
import 'package:rick_and_morty_explorer/features/characters/presentation/list_page/cubit/character_page_cubit.dart';
import 'package:rick_and_morty_explorer/features/characters/presentation/favorite/cubit/favorit_cubit.dart';
import 'package:rick_and_morty_explorer/features/characters/presentation/list_page/view/character_page.dart';
import 'package:rick_and_morty_explorer/features/characters/presentation/theme.dart';

import 'package:rick_and_morty_explorer/features/characters/presentation/widgets/filterButton.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  var themeMode = ThemeMode.dark;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const theme = CustomTheme();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di<CharacterPageCubit>()),
        BlocProvider(create: (_) => di<FavoritCubit>()),
      ],
      child: MaterialApp(
        themeMode: themeMode,
        theme: theme.toThemeData(),
        darkTheme: theme.toThemeDataDark(),
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) {
            final tt = Theme.of(context).textTheme;
            final cs = Theme.of(context).colorScheme;
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 50,
                title: Transform.translate(
                  offset: const Offset(15, 0),
                  child: Text(
                    'Rick & Morty',
                    style: tt.headlineLarge!.copyWith(
                      color: cs.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ).animate().fadeIn(delay: .8.seconds, duration: .7.seconds),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const FavoriteScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.favorite)),
                  const FilterStatusBTN(),
                  IconButton(
                    onPressed: () {
                      final useLight =
                          themeMode == ThemeMode.dark ? true : false;
                      handleBrightnessChange(useLight);
                    },
                    icon: const Icon(Icons.light_mode),
                  ),
                ],
              ),
              body: const CharacterPage()
                  .animate()
                  .fadeIn(delay: 1.2.seconds, duration: .7.seconds),
            );
          },
        ),
      ),
    );
  }

  bool get useLightMode {
    switch (themeMode) {
      case ThemeMode.system:
        return View.of(context).platformDispatcher.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }
}
