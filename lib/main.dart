import 'package:flutter/material.dart';
import 'screens/category_screen.dart';
import 'services/api_service.dart';
import 'models/recipe.dart';
import 'screens/recipe_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

}


void main () async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // NotificationSettings settings =
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    // provisional: true,
  );


  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('FCM token: $fcmToken');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Рецепти',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        print('Foreground notification: ${notification.title} - ${notification.body}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      final recipe = await ApiService().getRandomRecipe();
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeScreen(mealId: recipe.id),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoryScreen(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
          icon: Icon(Icons.fastfood_sharp),
          label: Text('Прикажи рандом рецепт'),
          onPressed: () async {
            final recipe = await ApiService().getRandomRecipe();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeScreen(mealId: recipe.id),
              ),
            );
          },
        ),
      ),
    );
  }
}

