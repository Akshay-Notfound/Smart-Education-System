import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_education_system/firebase_options.dart';
import 'package:smart_education_system/models/app_state.dart';
import 'package:smart_education_system/services/data_service.dart';
import 'package:smart_education_system/services/firebase_auth_service.dart';
import 'package:smart_education_system/screens/login_screen.dart';
import 'package:smart_education_system/screens/home_screen.dart';
import 'package:smart_education_system/widgets/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SmartEducationApp());
}

class SmartEducationApp extends StatelessWidget {
  const SmartEducationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Education System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late AppState appState;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() async {
    // Initialize data service with sample data
    DataService().initializeData();
    
    // Get initial app state
    setState(() {
      appState = DataService().getAppState();
    });
    
    // Keep splash screen visible for 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    
    setState(() {
      _isLoading = false;
    });
  }

  void _loginStudent(String email) {
    // With Firebase auth, we don't need to validate against a predefined list
    // In a real app, you might fetch user data from a database
    // For now, we'll still use the mock data service for demonstration
    final student = DataService().authenticateStudent(email);
    setState(() {
      appState.currentStudent = student;
    });
  }

  void _logout() async {
    // Sign out from Firebase
    try {
      final authService = FirebaseAuthService();
      await authService.signOut();
    } catch (e) {
      // Handle sign out error if needed
      print('Error signing out: $e');
    }
    
    // Clear app state
    setState(() {
      appState.currentStudent = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SplashScreen(
        onInitializationComplete: () {
          setState(() {
            _isLoading = false;
          });
        },
      );
    }

    // Check Firebase auth state
    final firebaseUser = FirebaseAuth.instance.currentUser;
    
    return (appState.currentStudent != null || firebaseUser != null)
        ? HomeScreen(
            appState: appState,
            onLogout: _logout,
          )
        : LoginScreen(
            onLogin: _loginStudent,
          );
  }
}