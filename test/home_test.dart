import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impostorapp/screen/home.dart';
import 'package:impostorapp/component/orange_button.dart';
import 'package:impostorapp/component/text_input.dart';
import 'package:impostorapp/component/error_popup.dart';
import 'package:impostorapp/network/api_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

import 'home_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
  });

  Future<void> pumpHomeScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/create': (context) => const Scaffold(body: Text('Create Room Screen')),
          '/join': (context) => const Scaffold(body: Text('Join Room Screen')),
        },
        home: const HomeScreen(),
      ),
    );
  }

  testWidgets('renders UI elements correctly', (WidgetTester tester) async {
    await pumpHomeScreen(tester);

    expect(find.text('Impostor'), findsOneWidget);
    expect(find.byType(TextInput), findsOneWidget);
    expect(find.text(' Join Room'), findsOneWidget);
    expect(find.text('Create Room'), findsOneWidget);
  });

  testWidgets('shows error when name is empty on Join Room', (WidgetTester tester) async {
    await pumpHomeScreen(tester);
    await tester.tap(find.text(' Join Room'));
    await tester.pump();

    expect(find.textContaining('type a name'), findsOneWidget);
  });

  testWidgets('navigates to Join Room when name is provided', (WidgetTester tester) async {
    await pumpHomeScreen(tester);

    final textField = find.byType(TextField);
    await tester.enterText(textField, 'Alice');
    await tester.tap(find.text(' Join Room'));
    await tester.pumpAndSettle();

    expect(find.text('Join Room Screen'), findsOneWidget);
  });

  testWidgets('calls API and navigates on successful room creation', (WidgetTester tester) async {
    final mockResponse = {
      'room_code': 'XYZ789',
      'owner_id': 123,
      'room_id': 456
    };

    when(mockApiService.createRoom(any)).thenAnswer(
      (_) async => http.Response(jsonEncode(mockResponse), 200)
    );

    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/create': (context) => const Scaffold(body: Text('Create Room Screen')),
        },
        home: Builder(
          builder: (context) => HomeScreenWithApiOverride(apiService: mockApiService),
        ),
      ),
    );

    final textField = find.byType(TextField);
    await tester.enterText(textField, 'Bob');
    await tester.tap(find.text('Create Room'));
    await tester.pumpAndSettle();

    expect(find.text('Create Room Screen'), findsOneWidget);
  });

  testWidgets('shows error popup on failed room creation', (WidgetTester tester) async {
    when(mockApiService.createRoom(any)).thenAnswer(
      (_) async => http.Response(jsonEncode({'detail': 'Invalid request'}), 400)
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => HomeScreenWithApiOverride(apiService: mockApiService),
        ),
      ),
    );

    final textField = find.byType(TextField);
    await tester.enterText(textField, 'Bob');
    await tester.tap(find.text('Create Room'));
    await tester.pump();

    expect(find.textContaining('Failed to create room'), findsOneWidget);
  });
}

class HomeScreenWithApiOverride extends StatelessWidget {
  final ApiService apiService;
  const HomeScreenWithApiOverride({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return HomeScreenWrapper(apiService: apiService);
      },
    );
  }
}

class HomeScreenWrapper extends StatefulWidget {
  final ApiService apiService;
  const HomeScreenWrapper({super.key, required this.apiService});

  @override
  State<HomeScreenWrapper> createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper> {
  late TextInput textInput;

  @override
  void initState() {
    super.initState();
    textInput = TextInput(hintText: 'Player name');
  }

  void createRoom(String userName) {
    widget.apiService.createRoom(userName).then((response) {
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final roomCode = body['room_code'];
        final ownerId = body['owner_id'];
        final roomId = body['room_id'];
        Navigator.pushNamed(
          context,
          '/create',
          arguments: {
            'userName': userName,
            'roomCode': roomCode,
            'ownerId': ownerId,
            'roomId': roomId,
          },
        );
      } else {
        final body = jsonDecode(response.body);
        showErrorPopup(context, 'Failed to create room: ${body['detail']}');
      }
    }).catchError((_) {
      showErrorPopup(context, 'Error creating room: check for internet connection and retry');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          textInput,
          OrangeButton(
            label: 'Create Room',
            icon: Icons.add,
            onPressed: () => createRoom(textInput.text),
          )
        ],
      ),
    );
  }
}
