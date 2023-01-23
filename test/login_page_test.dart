import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:inshorts_app/Pages/login_screen.dart';
import 'package:inshorts_app/Pages/news_feed.dart';

void main() {
  testWidgets('Email and password fields should be required',
      (WidgetTester tester) async {
    await tester.pumpWidget(LoginPage());

    // Find the form key
    final formKey = find.byKey(const Key('_formKey'));
    expect(formKey, findsOneWidget);

    // Find the email text field
    final emailTextField = find.byKey(const Key('emailTextField'));
    expect(emailTextField, findsOneWidget);

    // Find the password text field
    final passwordTextField = find.byKey(const Key('passwordTextField'));
    expect(passwordTextField, findsOneWidget);

    // Enter invalid data
    await tester.enterText(emailTextField, '');
    await tester.enterText(passwordTextField, '');

    // Press the login button
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pump();

    // Assert that an error message is displayed for the email field
    expect(find.text('Please enter your email'), findsOneWidget);
    // Assert that an error message is displayed for the password field
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('Navigates to NewsFeed when login is successful',
      (WidgetTester tester) async {
    await tester.pumpWidget(LoginPage());

    // Find the form key
    final formKey = find.byKey(const Key('_formKey'));
    expect(formKey, findsOneWidget);

    // Find the email text field
    final emailTextField = find.byKey(const Key('emailTextField'));
    expect(emailTextField, findsOneWidget);

    // Find the password text field
    final passwordTextField = find.byKey(const Key('passwordTextField'));
    expect(passwordTextField, findsOneWidget);

    // Enter valid data
    await tester.enterText(emailTextField, 'test@email.com');
    await tester.enterText(passwordTextField, 'password123');

    // Press the login button
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pump();

    // Assert that the navigation to NewsFeed is successful
    expect(find.byType(NewsFeed), findsOneWidget);
  });
}
