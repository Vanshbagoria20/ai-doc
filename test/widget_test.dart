import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_doc/main.dart';
import 'package:ai_doc/screens/onboarding_screen.dart';
import 'package:ai_doc/screens/auth_screen.dart';
import 'package:ai_doc/screens/dashboard_screen.dart';
import 'package:ai_doc/models/user.dart';
import 'package:provider/provider.dart';
import 'package:ai_doc/providers/auth_provider.dart' as auth_provider;

void main() {
  group('App Navigation Tests', () {
    testWidgets('App starts on OnboardingScreen', ( tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(const AiDocApp());

      // Verify that OnboardingScreen is displayed
      expect(find.byType(OnboardingScreen), findsOneWidget);
      expect(find.text('Welcome to MedAi'), findsOneWidget);
    });

    testWidgets('Navigates to AuthScreen when Get Started is clicked', ( tester) async {
      await tester.pumpWidget(const AiDocApp());

      // Verify OnboardingScreen is shown first
      expect(find.byType(OnboardingScreen), findsOneWidget);

      // Tap the "Get Started" button
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      // Verify navigation to AuthScreen
      expect(find.byType(AuthScreen), findsOneWidget);
      expect(find.text('Welcome Back'), findsOneWidget);
    });

    testWidgets('Toggles between Login and Sign Up forms', ( tester) async {
      await tester.pumpWidget(const AiDocApp());
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      // Verify initial state is login
      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);

      // Switch to sign up
      await tester.tap(find.text("Don't have an account? Sign Up"));
      await tester.pumpAndSettle();

      // Verify sign up form
      expect(find.text('Create Account'), findsOneWidget);
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Phone Number'), findsOneWidget);
      expect(find.text('Create Account'), findsOneWidget);

      // Switch back to login
      await tester.tap(find.text('Already have an account? Sign In'));
      await tester.pumpAndSettle();

      // Verify login form again
      expect(find.text('Welcome Back'), findsOneWidget);
    });

    testWidgets('Successful login navigates to DashboardScreen', ( tester) async {
      // Create a mock user
      final mockUser = UserModel(
        id: 'test123',
        name: 'Test User',
        email: 'test@example.com',
        phone: '1234567890',
        profilePic: '',
        role: 'patient',
        isVerified: true,
      );

      // Build app with providers
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => auth_provider.AuthProvider()),
          ],
          child: const MaterialApp(home: MainAppNavigator()),
        ),
      );

      // Navigate to auth screen
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      // Enter test credentials
      await tester.enterText(find.byKey(const Key('emailField')), 'test@example.com');
      await tester.enterText(find.byKey(const Key('passwordField')), 'password123');
      await tester.pump();

      // Mock successful login
      final authProvider = Provider.of<AuthProvider>(tester.element(find.byType(MainAppNavigator)));
      authProvider.setUser(mockUser);

      // Tap login button
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      // Verify dashboard is shown with user data
      expect(find.byType(DashboardScreen), findsOneWidget);
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('Test User'), findsNWidgets(1));
    });

    testWidgets('Invalid login shows error message', ( tester) async {
      await tester.pumpWidget(const AiDocApp());
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      // Attempt login with empty fields
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Verify error messages
      expect(find.text('Please enter a valid email address'), findsOneWidget);
      expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    });
  });

  group('Widget Rendering Tests', () {
    testWidgets('OnboardingScreen renders correctly', ( tester) async {
      await tester.pumpWidget(MaterialApp(home: OnboardingScreen(onGetStarted: () {})));

      expect(find.text('Welcome to MedAi'), findsOneWidget);
      expect(find.text('Your personal AI-powered healthcare companion'), findsOneWidget);
      expect(find.byIcon(Icons.medical_services), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);
    });

    testWidgets('AuthScreen renders login form by default', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AuthScreen(onLogin: (_) {})));

      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text("Don't have an account? Sign Up"), findsOneWidget);
    });

    testWidgets('DashboardScreen renders with user data', ( tester) async {
      final mockUser = {
        'name': 'Test User',
        'email': 'test@example.com',
        'role': 'patient',
      };

      await tester.pumpWidget(
        MaterialApp(
          home: DashboardScreen(
            user: mockUser,
            onNavigate: (_, {user}) {},
            onLogout: () {},
          ),
        ),
      );

      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('Appointments'), findsOneWidget);
      expect(find.text('Doctors'), findsOneWidget);
      expect(find.text('Messages'), findsOneWidget);
    });
  });
}
