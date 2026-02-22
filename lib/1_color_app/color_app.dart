import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum ColorType {
  red(color: Colors.red),
  green(color: Colors.green),
  yellow(color: Colors.yellow),
  blue(color: Colors.blue);

  const ColorType({required this.color});
  final Color color;
}

class ColorService extends ChangeNotifier {
  // One counter per ColorType – initialised to 0 for every value
  final Map<ColorType, int> _counts = {for (final c in ColorType.values) c: 0};

  int countOf(ColorType type) => _counts[type]!;

  Map<ColorType, int> get allCounts => Map.unmodifiable(_counts);

  void increment(ColorType type) {
    _counts[type] = (_counts[type] ?? 0) + 1;
    notifyListeners();
  }
}

final ColorService colorService = ColorService();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? ColorTapsScreen() : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: ColorType.values.map((type) => ColorTap(type: type)).toList(),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Center(
        child: ListenableBuilder(
          listenable: colorService,
          builder: (context, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: colorService.allCounts.entries
                  .map(
                    (e) => Text(
                      'Number of ${e.key} = ${e.value}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  const ColorTap({super.key, required this.type});

  final ColorType type;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: colorService,
      builder: (context, _) {
        return GestureDetector(
          onTap: () => colorService.increment(type),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: type.color,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: 100,
            child: Center(
              child: Text(
                'Taps: ${colorService.countOf(type)}',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
