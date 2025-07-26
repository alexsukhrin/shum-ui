import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _currentLocale = const Locale('en');

  void _changeLanguage(Locale locale) {
    setState(() {
      _currentLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shum UI',
      locale: _currentLocale,
      // Enable localization
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('uk'), // Ukrainian
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(onLanguageChanged: _changeLanguage),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function(Locale) onLanguageChanged;

  const MyHomePage({super.key, required this.onLanguageChanged});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)?.counterTitle ?? 'Flutter Demo Home Page'),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            tooltip: AppLocalizations.of(context)?.languageSelector ?? 'Language',
            onSelected: widget.onLanguageChanged,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<Locale>(
                value: const Locale('en'),
                child: Text(AppLocalizations.of(context)?.english ?? 'English'),
              ),
              PopupMenuItem<Locale>(
                value: const Locale('uk'),
                child: Text(AppLocalizations.of(context)?.ukrainian ?? 'Українська'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)?.counterText ?? 'You have pushed the button this many times:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: AppLocalizations.of(context)?.incrementButton ?? 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
