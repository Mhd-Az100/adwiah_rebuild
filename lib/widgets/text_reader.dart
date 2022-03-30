// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// // class AudioPlayer extends StatefulWidget {
// //   final text,lang;
// //   Function callback;
// //   AudioPlayer(this.text,{this.lang='en-US',this.callback});
// //   @override
// //   _AudioPlayerState createState() => _AudioPlayerState();
// // }
// //
// // class _AudioPlayerState extends State<AudioPlayer> with WidgetsBindingObserver,ChangeNotifier{
// //   FlutterTts flutterTts;
// //   String language;
// //   String engine;
// //   double volume = 0.5;
// //   double pitch = 1.0;
// //   bool isCurrentLanguageInstalled = false;
// //   bool isplaying=false;
// //   String _newVoiceText;
// //   bool get isIOS => !kIsWeb && Platform.isIOS;
// //   bool get isAndroid => !kIsWeb && Platform.isAndroid;
// //   bool get isWeb => kIsWeb;
// // @override
// //   void didChangeAppLifecycleState(AppLifecycleState state) {
// //     // TODO: implement didChangeAppLifecycleState
// //   _stop();
// //     super.didChangeAppLifecycleState(state);
// //
// //
// // }
// // @override
// //   void didUpdateWidget(covariant AudioPlayer oldWidget) {
// //     // TODO: implement didUpdateWidget
// //   _stop();
// //
// //     super.didUpdateWidget(oldWidget);
// //   }
// //   @override
// //   initState() {
// //     _newVoiceText=widget.text;
// //     super.initState();
// //     flutterTts = FlutterTts();
// //     flutterTts.setLanguage(this.widget.lang);
// //     flutterTts.setSpeechRate(Platform.isAndroid ? 0.5 : 0.4);
// //     WidgetsBinding.instance.addObserver(this);
// //     initTts();
// //   }
// //   initTts()async {
// //
// //     var a= await _getLanguages();
// //     var b= await _getEngines();
// //     print(b);
// //     print(a);
// //
// //   }
// //
// //     Future<dynamic> _getLanguages() => flutterTts.getLanguages;
// //
// //     Future<dynamic> _getEngines() => flutterTts.getEngines;
// //
// //     Future _getDefaultEngine() async {
// //       var engine = await flutterTts.getDefaultEngine;
// //       if (engine != null) {
// //         print(engine);
// //       }
// //     }
// //
// //     Future _speak() async {
// //       // if(widget.callback!=null)widget.callback();
// //
// //       setState(() {
// //         isplaying=true;
// //       });
// //       await flutterTts.setVolume(volume);
// //       await flutterTts.setPitch(pitch);
// //
// //       if (_newVoiceText != null) {
// //         if (_newVoiceText.isNotEmpty) {
// //           await flutterTts.stop();
// //
// //
// //           var result = await flutterTts.speak(_newVoiceText);
// //           print(result);
// //           if(result==1){
// //             setState(() {
// //               isplaying=false;
// //             });
// //           }
// //         }
// //       }
// //     }
// //
// //     Future _stop() async {
// //       var result = await flutterTts.stop();
// //       setState(() {
// //         isplaying=false;
// //       });
// //     }
// //
// //     Future _pause() async {
// //       var result = await flutterTts.pause();
// //     }
// //
// //     @override
// //     void dispose() {
// //       flutterTts.stop();
// //       WidgetsBinding.instance.removeObserver(this);
// //     }
// //
// //
// //
// //     void changedEnginesDropDownItem(String selectedEngine) {
// //       flutterTts.setEngine(selectedEngine);
// //       language = null;
// //       setState(() {
// //         engine = selectedEngine;
// //       });
// //     }
// //
// //
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: IconButton(icon: Icon(!isplaying?Icons.volume_off:Icons.volume_up),onPressed: (){
// //
// //         if(!isplaying){
// //           _speak();
// //
// //         }else{
// //           _stop();
// //
// //         }
// //       },),
// //     );
// //   }
// //   }
// class AudioPlayer {
//   FlutterTts? flutterTts;
//   String? language;
//   String? engine;
//   double? volume = 0.5;
//   double? pitch = 1.0;
//   bool? isCurrentLanguageInstalled = false;
//   bool? isSpeaking = false;

//   AudioPlayer() {
//     flutterTts = FlutterTts();
//     flutterTts!.setSpeechRate(Platform.isAndroid ? 0.5 : 0.4);
//   }

//   Future speak(String _newVoiceText, {String lang = 'en-US'}) async {
//     if (isSpeaking!) await flutterTts!.stop();
//     isSpeaking = true;
//     await flutterTts!.setVolume(volume!);
//     await flutterTts!.setPitch(pitch!);
//     await flutterTts!.setLanguage(lang);
//     if (_newVoiceText != null) {
//       if (_newVoiceText.isNotEmpty) {
//         await flutterTts!.stop();

//         var result = await flutterTts!.speak(_newVoiceText);
//         if (result == 1) isSpeaking = false;
//         return result;
//       }
//     }
//   }

//   Future stop() async {
//     var result = await flutterTts!.stop();
//     isSpeaking = false;
//   }

//   Future pause() async {
//     var result = await flutterTts!.pause();
//   }
// }
