import 'package:flutter/material.dart';

void main() {
  runApp(const RideApp());
}

class RideApp extends StatelessWidget {
  const RideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dombivali-Kalyan Rides',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB8860B),
          brightness: Brightness.dark,
        ).copyWith(
          primary: const Color(0xFFD4AF37),
          surface: const Color(0xFF2E1F17),
          background: const Color(0xFF1B120D),
        ),
        scaffoldBackgroundColor: const Color(0xFF1B120D),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E1F17),
          foregroundColor: Color(0xFFD4AF37),
          centerTitle: true,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF3A271C),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD4AF37),
            foregroundColor: const Color(0xFF1B120D),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF4A3325),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Color(0xFFC7AB6F)),
        ),
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Text(
              'Welcome to Dombivali-Kalyan Rides',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter your full name',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                hintText: '+91 98XXXXXXXX',
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileScreen(name: _nameController.text.trim()),
                  ),
                );
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({required this.name, super.key});

  final String name;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _emailController = TextEditingController();
  String _role = 'Commuter';

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Setup / View')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${widget.name.isEmpty ? 'User' : widget.name}'),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _role,
                      items: const [
                        DropdownMenuItem(value: 'Commuter', child: Text('Commuter')),
                        DropdownMenuItem(value: 'Driver', child: Text('Driver')),
                      ],
                      onChanged: (v) => setState(() => _role = v ?? 'Commuter'),
                      decoration: const InputDecoration(labelText: 'Role'),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RideBookingScreen()),
                );
              },
              child: const Text('Proceed to Ride Booking'),
            ),
          ],
        ),
      ),
    );
  }
}

class RideBookingScreen extends StatefulWidget {
  const RideBookingScreen({super.key});

  @override
  State<RideBookingScreen> createState() => _RideBookingScreenState();
}

class _RideBookingScreenState extends State<RideBookingScreen> {
  final _pickupController = TextEditingController(text: 'Dombivali Station');
  final _dropController = TextEditingController(text: 'Kalyan Station');

  final _vehicles = const {
    'Auto': 130,
    'Mini': 190,
    'Sedan': 260,
  };

  String _selectedVehicle = 'Auto';

  @override
  void dispose() {
    _pickupController.dispose();
    _dropController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fare = _vehicles[_selectedVehicle] ?? 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Ride')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _pickupController,
              decoration: const InputDecoration(
                labelText: 'Pickup Location',
                prefixIcon: Icon(Icons.my_location),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _dropController,
              decoration: const InputDecoration(
                labelText: 'Drop Location',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView(
                children: _vehicles.entries.map((entry) {
                  final selected = entry.key == _selectedVehicle;
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: selected
                            ? const Color(0xFFD4AF37)
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      title: Text(entry.key),
                      subtitle: Text('Estimated Fare: ₹${entry.value}'),
                      trailing: selected
                          ? const Icon(Icons.check_circle, color: Color(0xFFD4AF37))
                          : null,
                      onTap: () => setState(() => _selectedVehicle = entry.key),
                    ),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MatchingScreen(
                      vehicle: _selectedVehicle,
                      fare: fare,
                    ),
                  ),
                );
              },
              child: const Text('Confirm Ride'),
            ),
          ],
        ),
      ),
    );
  }
}

class MatchingScreen extends StatefulWidget {
  const MatchingScreen({required this.vehicle, required this.fare, super.key});

  final String vehicle;
  final int fare;

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  bool _matched = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _matched = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Driver Matching')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _matched ? Icons.directions_car_filled : Icons.sync,
              size: 72,
              color: const Color(0xFFD4AF37),
            ),
            const SizedBox(height: 20),
            Text(
              _matched
                  ? 'Driver Found! Vehicle: ${widget.vehicle}'
                  : 'Matching you with nearby drivers...',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (_matched)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TripCompletionScreen(fare: widget.fare),
                    ),
                  );
                },
                child: const Text('Complete Ride'),
              ),
          ],
        ),
      ),
    );
  }
}

class TripCompletionScreen extends StatelessWidget {
  const TripCompletionScreen({required this.fare, super.key});

  final int fare;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trip Complete')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('Pay Cash to Driver', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 12),
                    Text('₹$fare', style: const TextStyle(fontSize: 36)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (_) => const RatingDialog(),
                );
                if (context.mounted) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                }
              },
              child: const Text('Paid - Rate Driver'),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 5;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF3A271C),
      title: const Text('Rate Your Ride'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          final star = index + 1;
          return IconButton(
            onPressed: () => setState(() => _rating = star),
            icon: Icon(
              star <= _rating ? Icons.star : Icons.star_border,
              color: const Color(0xFFD4AF37),
            ),
          );
        }),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
