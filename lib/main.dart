import 'package:flutter/material.dart';
import 'package:flutter_bible_new/reading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _bibleVersion = 'ESV';

  List versions = ['ESV', 'KJV', 'NIV', 'NLT'];

  @override
  void initState() {
    super.initState();
    _bibleVersion = versions.first;
  }

  List<DropdownMenuItem<String>> _getBibleVersions() {
    List<DropdownMenuItem<String>> bibleVersions = [];
    for (String version in versions) {
      bibleVersions.add(
        DropdownMenuItem<String>(
          value: version,
          child: Text(
            version,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      );
    }
    return bibleVersions;
  }

  final Map _bibleStructure = {
    0: {
      "Genesis": 50,
      "Exodus": 40,
      "Leviticus": 27,
      "Numbers": 36,
      "Deuteronomy": 34,
      "Joshua": 24,
      "Judges": 21,
      "Ruth": 4,
      "1 Samuel": 31,
      "2 Samuel": 24,
      "1 Kings": 22,
      "2 Kings": 25,
      "1 Chronicles": 29,
      "2 Chronicles": 36,
      "Ezra": 10,
      "Nehemiah": 13,
      "Esther": 10,
      "Job": 42,
      "Psalms": 150,
      "Proverbs": 31,
      "Ecclesiastes": 12,
      "Song of Songs": 8,
      "Isaiah": 66,
      "Jeremiah": 52,
      "Lamentations": 5,
      "Ezekiel": 48,
      "Daniel": 12,
      "Hosea": 14,
      "Joel": 3,
      "Amos": 9,
      "Obadiah": 1,
      "Jonah": 4,
      "Micah": 7,
      "Nahum": 3,
      "Habakkuk": 3,
      "Zephaniah": 3,
      "Haggai": 2,
      "Zechariah": 14,
      "Malachi": 4
    },
    1: {
      "Matthew": 28,
      "Mark": 16,
      "Luke": 24,
      "John": 21,
      "Acts": 28,
      "Romans": 16,
      "1 Corinthians": 16,
      "2 Corinthians": 13,
      "Galatians": 6,
      "Ephesians": 6,
      "Philippians": 4,
      "Colossians": 4,
      "1 Thessalonians": 5,
      "2 Thessalonians": 3,
      "1 Timothy": 6,
      "2 Timothy": 4,
      "Titus": 3,
      "Philemon": 1,
      "Hebrews": 13,
      "James": 5,
      "1 Peter": 5,
      "2 Peter": 3,
      "1 John": 5,
      "2 John": 1,
      "3 John": 1,
      "Jude": 1,
      "Revelation": 22
    }
  };

  List<Widget> _showBibleStructure() {
    List<Widget> bibleStructure = [];
    int test = 0;
    bibleStructure.add(
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              child: Text(
                'Old Testament',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: DropdownButton<String>(
                value: _bibleVersion,
                items: _getBibleVersions(),
                onChanged: (String? value) {
                  _bibleVersion = value!;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
    for (Map testament in _bibleStructure.values) {
      int bk = 0;
      for (String book in testament.keys) {
        bibleStructure.add(
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Colors.grey,
                ),
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showVersesFor = _showVersesFor == book ? '' : book;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            book,
                            style: const TextStyle(fontSize: 16),
                          ),
                          _showVersesFor == book
                              ? const Icon(
                                  Icons.keyboard_arrow_up,
                                )
                              : const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                _showVersesFor == book
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: [
                            for (int i = 0; i < testament[book]; i++)
                              VerseButton(
                                testament: test,
                                book: bk,
                                chapter: i,
                                version: _bibleVersion,
                              ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
        bk += 1;
      }
      test += 1;
      if (test == 1) {
        bibleStructure.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 25),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Text(
                'New Testament',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }
    }
    return bibleStructure;
  }

  String _showVersesFor = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: _showBibleStructure(),
            ),
          ],
        ),
      ),
    );
  }
}

class VerseButton extends StatelessWidget {
  const VerseButton({
    super.key,
    required this.testament,
    required this.book,
    required this.chapter,
    required this.version,
  });

  final int testament;
  final int book;
  final int chapter;
  final String version;

  void showChapter(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BibleReading(
          testament: testament,
          book: book,
          chapter: chapter,
          version: version,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showChapter(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 45,
          height: 45,
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${chapter + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
