import 'package:BegenaTuner/screen/About.dart';
import 'package:BegenaTuner/screen/Settings.dart';
import 'package:BegenaTuner/screen/Tuner.dart';
import 'package:flutter/material.dart';

class EntryPoint extends StatefulWidget {
  @override
  EntryPointState createState() => EntryPointState();
}

class EntryPointState extends State<EntryPoint> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) => setState(() => _currentIndex = value),
        children: <Widget>[Tuner(), About(), Settings()],
      ),
      bottomNavigationBar: FlatButton(
          onPressed: () =>
              showAboutDialog(context: context, children: [Text("hello")]),
          child: Text("(ℹ) Open Source project")),

      // BottomNavyBar(
      //   selectedIndex: _currentIndex,
      //   onItemSelected: (index) {
      //     setState(() => _currentIndex = index);
      //     _pageController.jumpToPage(index);
      //   },
      //   items: <BottomNavyBarItem>[
      //     BottomNavyBarItem(
      //         title: Text('Fourier Transform'), icon: Icon(Icons.home)),
      //     BottomNavyBarItem(title: Text('About'), icon: Icon(Icons.apps)),
      //     BottomNavyBarItem(
      //         title: Text('Settings'), icon: Icon(Icons.settings)),
      //   ],
      // ),
    );
  }
}
