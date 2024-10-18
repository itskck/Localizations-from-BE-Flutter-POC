import 'package:arb_poc/cubit/locale_cubit.dart';
import 'package:arb_poc/cubit/locale_state.dart';
import 'package:arb_poc/i18n/localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const App());
}

extension BxE on BuildContext {
  String tr(String key) => LocalizationManager.of(this)?.getString(key) ?? key;
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleCubit>(
      create: (context) => LocaleCubit()..init(),
      child: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<int> list = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Arb Poc',
          supportedLocales: state.supportedLocales,
          locale: state.currentLocale,
          localizationsDelegates: [
            AppLocalizationDelegate(context),
            ...GlobalMaterialLocalizations.delegates,
          ],
          home: HomeBody(state: state),
        );
      },
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.state});

  final LocaleState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arb Poc'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.toString(),
              style: const TextStyle(fontSize: 18),
            ),
            PopupMenuButton(
              elevation: 4,
              onSelected: (e) => context.read<LocaleCubit>().switchLocale(e),
              itemBuilder: (context) => state.supportedLocales
                  .map(
                    (e) => PopupMenuItem(
                      value: e,
                      child: Text(
                        e.languageCode,
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  )
                  .toList(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.currentLocale.languageCode,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
            Text(
              context.tr('title'),
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
