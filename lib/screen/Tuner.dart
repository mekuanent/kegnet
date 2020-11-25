import 'package:BegenaTuner/screen/FFT.dart';
import 'package:flutter/material.dart';

class Tuner extends StatefulWidget {
  @override
  _TunerState createState() => _TunerState();
}

class _TunerState extends State<Tuner> {
  PopupMenuButton popupMenuButton;
  FFT fft;

  String type = "begena";

  var data = {
    "begena": {
      "strings": [
        {
          "name": "String 1",
          "minFreq": 100.00,
          "maxFreq": 120.00,
          "note": "A",
          "enabled": true
        },
        {
          "name": "String 2",
          "minFreq": 100.00,
          "maxFreq": 120.00,
          "note": "A",
          "enabled": true
        },
        {
          "name": "String 3",
          "minFreq": 100.00,
          "maxFreq": 120.00,
          "note": "A",
          "enabled": false
        },
        {
          "name": "String 4",
          "minFreq": 100.00,
          "maxFreq": 120.00,
          "note": "A",
          "enabled": true
        },
        {
          "name": "String 5",
          "minFreq": 100.00,
          "maxFreq": 120.00,
          "note": "A",
          "enabled": true
        },
        {
          "name": "String 6",
          "minFreq": 100.00,
          "maxFreq": 120.00,
          "note": "A",
          "enabled": true
        },
        {
          "name": "String 7",
          "minFreq": 100.00,
          "maxFreq": 120.00,
          "note": "A",
          "enabled": false
        },
        {
          "name": "String 8",
          "minFreq": 100.00,
          "maxFreq": 120.00,
          "note": "A",
          "enabled": true
        },
        {
          "name": "String 9",
          "minFreq": 100.00,
          "maxFreq": 120.00,
          "note": "A",
          "enabled": true
        },
        {
          "name": "String 10",
          "minFreq": 100.00,
          "maxFreq": 120.00,
          "note": "A",
          "enabled": true
        },
      ]
    },
    "kerar": {
      "strings": [
        {
          "name": "String 1",
          "minFreq": 100.00,
          "maxFreq": 120.00,
          "note": "A",
          "enabled": true
        },
        {
          "name": "String 2",
          "minFreq": 100.00,
          "maxFreq": 120.00,
          "note": "A",
          "enabled": true
        },
        {
          "name": "String 3",
          "minFreq": 100.00,
          "maxFreq": 120.00,
          "note": "A",
          "enabled": false
        },
        {
          "name": "String 4",
          "minFreq": 100.00,
          "maxFreq": 120.00,
          "note": "A",
          "enabled": true
        },
        {
          "name": "String 5",
          "minFreq": 100.00,
          "maxFreq": 120.00,
          "note": "A",
          "enabled": true
        },
      ]
    }
  };

  List<ListTile> strings = [];

  int _selectedString;
  String previousSelect;

  void generateList() {
    strings.clear();
    int i = 0;
    for (var obj in data[type]["strings"]) {
      strings.add(
        ListTile(
          title: Text(obj['name']),
          leading: Icon(Icons.label),
          trailing: Radio(
            value: i,
            groupValue: _selectedString,
            onChanged: (value) {
              print(data[type]['strings'][i % data[type]['strings'].length]);
              fft.setCurrentString(
                  data[type]['strings'][i % data[type]['strings'].length]);
              setState(() => _selectedString = value);
            },
          ),
        ),
      );
      i++;
    }
  }

  var typeToDisplay = {
    "begena": {"name": "Begena", "short": 'B'},
    "kerar": {"name": "Kerar", 'short': 'K'}
  };

  @override
  void initState() {
    fft = FFT();
    generateList();
    popupMenuButton = PopupMenuButton(
        child: Chip(
          avatar: CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            child: Text(typeToDisplay[type]['short']),
          ),
          label: Text(typeToDisplay[type]['name']),
        ),
        onSelected: (value) => setState(() => type = value),
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: "begena",
                child: Text('Begena'),
              ),
              PopupMenuItem(
                value: "kerar",
                child: Text('Kerar'),
              )
            ]);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (previousSelect != _selectedString) generateList();
    // previousSelect = _selectedString;
    generateList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        fft,
        popupMenuButton,
        Expanded(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Select a String",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              for (var string in strings) string
            ],
          ),
        ),
      ],
    );
  }
}
