import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/user.dart';
import 'providers/booking_provider.dart';
import 'providers/chat_provider.dart';
import 'utils/logger.dart' as applogger;

// Screens
import 'screens/onboarding_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/consulting_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  applogger.applogger.info('Application started');
  runApp(const AiDocApp());
}

class AiDocApp extends StatelessWidget {
  const AiDocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AI Doc',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: const AppBarTheme(
            elevation: 1,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        home: const MainAppNavigator(),
      ),
    );
  }
}

class MainAppNavigator extends StatefulWidget {
  const MainAppNavigator({super.key});

  @override
  State<MainAppNavigator> createState() => _MainAppNavigatorState();
}

class _MainAppNavigatorState extends State<MainAppNavigator> {
  String _currentScreen = 'onboarding';
  UserModel? _user;
  bool _isLoading = false;

  Future<void> navigateTo(String screen, {UserModel? user}) async {
    try {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(milliseconds: 150));

      setState(() {
        _currentScreen = screen;
        if (user != null) {
          _user = user;
        }
        applogger.applogger.debug('Navigated to: $_currentScreen');
      });
    } catch (e, stack) {
      applogger.applogger.error('Navigation error', error: e, stackTrace: stack);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong. Try again.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _handleLogout() {
    Provider.of<AuthProvider>(context, listen: false).logout();
    setState(() {
      _user = null;
      _currentScreen = 'auth';
    });
  }

  Widget _buildCurrentScreen() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    switch (_currentScreen) {
      case 'auth':
        return AuthScreen(
          onLogin: (userData) {
            final user = UserModel.fromMap(userData);
            Provider.of<AuthProvider>(context, listen: false).setUser(user);
            navigateTo('dashboard', user: user);
          },
        );

      case 'dashboard':
        return DashboardScreen(
          user: _user?.toMap(),
          onNavigate: navigateTo,
          onLogout: _handleLogout,
        );

      case 'booking':
        return _user != null
            ? BookingScreen(user: _user!, onNavigate: navigateTo)
            : _redirectToAuth();

      case 'consultation':
        return ConsultingScreen(
          user: _user ?? UserModel.defaultUser(),
          onNavigate: navigateTo,
        );

      case 'messages':
        return MessagesScreen(
          user: _user ?? UserModel.defaultUser(),
          onNavigate: navigateTo,
        );

      case 'profile':
        return _user != null
            ? ProfileScreen(user: _user!, onNavigate: navigateTo, onLogout: _handleLogout)
            : _redirectToAuth();

      case 'settings':
        return SettingsScreen(user: _user?.toMap(), onNavigate: navigateTo);

      default:
        return OnboardingScreen(onGetStarted: () => navigateTo('auth'));
    }
  }

  Widget _redirectToAuth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigateTo('auth');
    });
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: _buildCurrentScreen());
}

class AuthProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  // Add authentication logic here

}
