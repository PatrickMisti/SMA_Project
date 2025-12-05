import 'package:flutter/material.dart';
import 'package:sma_project/netflix-card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          children: [
            NetflixCard(
              imageUrl:
                  "https://static.vecteezy.com/system/resources/previews/036/324/708/non_2x/ai-generated-picture-of-a-tiger-walking-in-the-forest-photo.jpg",
              title: "Interstellar",
            ),
            NetflixCard(
              imageUrl:
                  "https://occ-0-1489-1490.1.nflxso.net/dnm/api/v6/Qs00mKCpRvrkl3HZAN5KwEL1kpE/AAAABWCzOdZCGvTz071IFxadMmD99xTn3ofEZC6DpaIUmSQSgW8x0_kqsH3qkGwrY-PB1n9wnGimSynVYjYJ69WOpGMpsRyg0hZ1BgY.jpg?r=9b9",
              title: "Interstellar",
            ),
          ],
        ),
      ),
    );
  }
}
