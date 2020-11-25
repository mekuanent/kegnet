import 'package:BegenaTuner/util/FrequencyToNote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fft/flutter_fft.dart';

class FFT extends StatefulWidget {
  FFTState fftState = FFTState();

  @override
  FFTState createState() => fftState;

  void setCurrentString(Map<String, Object> map) =>
      fftState.setCurrentString(map);
}

class FFTState extends State<FFT> {
  double frequency;
  String note;
  String desc = '';
  String dir = '';
  Color dirColor = Colors.grey.shade800;
  bool isRecording;

  FlutterFft flutterFft = new FlutterFft();
  FrequencyToNote frequencyToNote = FrequencyToNote();

  List<ListTile> strings = [];

  Map string = {
    "name": "String 3",
    "minFreq": 100.00,
    "maxFreq": 120.00,
    "note": "A#",
    "enabled": false
  };

  void setCurrentString(Map nString) {
    this.string = nString;
    print(this.string);
  }

  FFTState() {
    frequencyToNote.calibrate(FrequencyToNote.DEFAULT_A4);
  }

  @override
  void initState() {
    isRecording = flutterFft.getIsRecording;
    frequency = flutterFft.getFrequency;
    note = flutterFft.getNote;
    super.initState();
    _async();
  }

  @override
  void dispose() {
    flutterFft?.stopRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30.0),
        Container(
          padding: EdgeInsets.all(20.0),
          alignment: Alignment.topRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: dirColor,
                  child: Text(dir),
                ),
                label: Text(desc),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: Text(string['note']),
                ),
                label: Text('Target Note'),
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                "${frequency.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
              Text(
                "$note",
                style: TextStyle(
                  fontSize: 25,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  redirect(double freq) {
    if (freq < string['minFreq']) {
      dir = '+';
      desc = 'Tighten';
      dirColor = Colors.redAccent;
    } else if (freq > string['maxFreq']) {
      dir = '-';
      desc = 'Loosen';
      dirColor = Colors.red;
    } else {
      dir = '✓';
      desc = 'correct';
      dirColor = Colors.green;
    }
  }

  _async() async {
    print("starting...");
    await flutterFft.startRecorder();
    setState(() => isRecording = flutterFft.getIsRecording);
    flutterFft.onRecorderStateChanged.listen(
      (data) => {
        setState(
          () {
            frequency = data[1];
            note = frequencyToNote.findInterval(data[1])?.note;
            if (note == null) note = '';
            redirect(data[1]);
          },
        ),
        // flutterFft.setNote = note,
        // flutterFft.setFrequency = frequency,
      },
    );
  }
}
