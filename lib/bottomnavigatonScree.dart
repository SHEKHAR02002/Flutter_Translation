import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translation/controller/language_change_controller.dart';
import 'package:translation/screen/eventscreen.dart';
import 'package:translation/screen/favouritscreen.dart';
import 'package:translation/screen/homepage.dart';
import 'package:translation/screen/profile.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

enum Language { english, spanish }

class _BottomNavigationScreenState extends State<BottomNavigationScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavouritePage(),
    EventPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              'Translation App',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  letterSpacing: 1),
            )),
        actions: [
          Consumer<LanguageChangeController>(
            builder: (context, provider, child) {
              return PopupMenuButton(
                  onSelected: (Language item) {
                    if (Language.english.name == item.name) {
                      provider
                          .changeLanguage(const Locale('en'))
                          .whenComplete(() => setState(() {}));
                    } else {
                      provider
                          .changeLanguage(const Locale('es'))
                          .whenComplete(() => setState(() {}));
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<Language>>[
                        const PopupMenuItem(
                            value: Language.english, child: Text('English')),
                        const PopupMenuItem(
                            value: Language.spanish, child: Text('Arabic'))
                      ]);
            },
          )
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.white),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.heart),
                label: AppLocalizations.of(context)!.favourite,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.event),
                label: AppLocalizations.of(context)!.event,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: AppLocalizations.of(context)!.profile,
              ),
            ],
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.blue,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
