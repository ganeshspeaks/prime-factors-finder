import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prime Factors Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PrimeFactorsScreen(),
    );
  }
}

// Logic
List<dynamic> primeFactors(int n) {
  List<int> factors = [];
  int divisor = 2;

  while (n > 1) {
    while (n % divisor == 0) {
      factors.add(divisor);
      n ~/= divisor;
    }
    divisor++;
  }
  
  int sum = factors.fold(0, (prev, element) => prev + element);
  int multi = factors.fold(1, (prev, element) => prev * element);

  // factors
  return [factors, sum, multi];
}

// PrimeFactorsScreen

class PrimeFactorsScreen extends StatefulWidget {
  const PrimeFactorsScreen({Key? key}) : super(key: key);

  @override
  State<PrimeFactorsScreen> createState() => _PrimeFactorsScreenState();
}

class _PrimeFactorsScreenState extends State<PrimeFactorsScreen> {
  final TextEditingController _controller = TextEditingController();
  List<int> _factors = [];
  int _sum = 0;
  int _multi =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prime Factors Finder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter a number',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  int num = int.tryParse(_controller.text) ?? 0;
                  List<dynamic> result = primeFactors(num);
                  List<int> factors = result[0];
                  int sum = result[1];
                  int multi = result[2];
                  if (num < 2) {
                    _factors = [];
                    _sum = 0;
                    _multi =0;
                  } else {
                    _factors = factors;
                    _sum = sum;
                    _multi = multi;
                  }
                });
              },
              child: const Text('Find Prime Factors'),
            ),
            const SizedBox(height: 20),
            Text(
              _factors.isEmpty
                  ? 'Prime factors will be displayed here'
                  : 'Prime factors: ${_factors.join(', ')}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10,),
            Text(
              'Sum of factors: $_sum',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10,),
            Text(
              'Multiplication of factors: $_multi',
              style: const TextStyle(fontSize: 16),
            ),

            const Spacer(),
            const Text('For the ❤️ of Maths'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
