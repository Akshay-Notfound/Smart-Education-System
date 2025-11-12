import 'package:flutter/material.dart';
import 'package:smart_education_system/models/app_state.dart';
import 'package:smart_education_system/models/student.dart';
import 'package:smart_education_system/screens/election_screen.dart';
import 'package:smart_education_system/screens/application_screen.dart';
import 'package:smart_education_system/screens/complaint_screen.dart';
import 'package:smart_education_system/screens/budget_screen.dart';
import 'package:smart_education_system/screens/facility_screen.dart';
import 'package:smart_education_system/screens/cheating_screen.dart';
import 'package:smart_education_system/screens/firebase_test_screen.dart';

class HomeScreen extends StatelessWidget {
  final AppState appState;
  final VoidCallback onLogout;

  const HomeScreen({super.key, required this.appState, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Education System'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: onLogout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${appState.currentStudent?.name ?? 'Student'}!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Roll No: ${appState.currentStudent?.rollNumber ?? ''} | '
                'Department: ${appState.currentStudent?.department ?? ''}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'College Services',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildFeatureCard(
                    context,
                    title: 'Elections',
                    icon: Icons.how_to_vote,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ElectionScreen(appState: appState),
                        ),
                      );
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Applications',
                    icon: Icons.assignment,
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApplicationScreen(appState: appState),
                        ),
                      );
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Complaints',
                    icon: Icons.report_problem,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComplaintScreen(appState: appState),
                        ),
                      );
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Budgets',
                    icon: Icons.account_balance_wallet,
                    color: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BudgetScreen(appState: appState),
                        ),
                      );
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Facilities',
                    icon: Icons.business,
                    color: Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FacilityScreen(appState: appState),
                        ),
                      );
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Records',
                    icon: Icons.warning,
                    color: Colors.indigo,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheatingScreen(appState: appState),
                        ),
                      );
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Firebase Test',
                    icon: Icons.flutter_dash,
                    color: Colors.blueAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FirebaseTestScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: color,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}