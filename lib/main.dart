import 'package:flutter/material.dart';
import 'package:stringencryptiondecryptionusingaes/tic_tac_toe.dart';
import 'package:stringencryptiondecryptionusingaes/crypto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'String Encryption & Decryption using AES'),
      //home: const TicTacToe(),//game for to handle when internet goes off.
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var enteredText = TextEditingController();
  String encryptedString = "";
  String decryptedString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: TextField(
                        onChanged: (text) {
                          setState(() {
                            if (enteredText.text == null ||
                                enteredText.text.isEmpty) {
                              encryptedString = "";
                              decryptedString = "";
                            }
                          });
                        },
                        controller: enteredText,
                        textAlign: TextAlign.start,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: "Enter String to encrypt",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        color: Colors.white,
                        child: const Text('Before Encryption'),
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible:
                      enteredText.text != null && enteredText.text.isNotEmpty,
                  child: GestureDetector(
                    onTap: () {
                      encryptString(enteredText.text);
                    },
                    onDoubleTap: () {},
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 22, right: 22),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: 40,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.amber,
                                  Colors.red,
                                ],
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Encrypt",
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible:
                      encryptedString != null && encryptedString.isNotEmpty,
                  child: GestureDetector(
                    onTap: () {
                      //encryptString(enteredText.text);
                    },
                    onDoubleTap: () {},
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 22, right: 22),
                        child: Center(
                          child: Text(
                            encryptedString,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible:
                      encryptedString != null && encryptedString.isNotEmpty,
                  child: GestureDetector(
                    onTap: () {
                      decryptString(encryptedString);
                    },
                    onDoubleTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.amber,
                            Colors.red,
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, left: 22, right: 22),
                          child: Center(
                            child: Text(
                              "Decrypt the encrypted string",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: decryptedString != null,
                  child: GestureDetector(
                    onTap: () {
                      //encryptString(enteredText.text);
                    },
                    onDoubleTap: () {},
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 22, right: 22),
                        child: Center(
                          child: Text(
                            decryptedString,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void encryptString(String enteredText) {
    encryptedString = Crypto.encrypt(enteredText);
    setState(() {});
  }

  void decryptString(String enteredText) {
    decryptedString = Crypto.decrypt(enteredText);
    setState(() {});
  }
}
