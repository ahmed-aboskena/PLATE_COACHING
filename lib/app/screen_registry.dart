import '../screens/10d/screen_10d.dart';
import '../screens/1d/screen_1d.dart';
import '../screens/2d/screen_2d.dart';
import '../screens/3d/screen_3d.dart';
import '../screens/4d/screen_4d.dart';
import '../screens/4d/coach_bar_screen.dart';
import '../screens/4d/coach_order_tracking_screen.dart';
import '../screens/4d/coach_train_screen.dart';
import '../screens/5d/screen_5d.dart';
import '../screens/6d/screen_6d.dart';
import '../screens/7d/screen_7d.dart';
import '../screens/8a/screen_8a.dart';
import '../screens/8d/screen_8d.dart';
import '../screens/9d/screen_9d.dart';
import 'screen_definition.dart';

abstract final class ScreenRegistry {
  static const List<ScreenDefinition> screens = [
    ScreenDefinition(
      id: '8A',
      title: 'My coach',
      group: 'Member',
      description: 'Review your training plan and message or call your coach from one place.',
      builder: Screen8A.new,
    ),
    ScreenDefinition(
      id: '1D',
      title: 'Voice / Video call',
      group: 'Member',
      description: 'An active online coaching call with controls to switch call type, mute, and end.',
      builder: Screen1D.new,
    ),
    ScreenDefinition(
      id: '2D',
      title: 'Online training',
      group: 'Member',
      description: 'See the active plan, next live session, completed workouts, and booking shortcuts.',
      builder: Screen2D.new,
    ),
    ScreenDefinition(
      id: '3D',
      title: 'Book a session',
      group: 'Member',
      description: 'Choose a session format, day, and available time to book with Coach Mohamed.',
      builder: Screen3D.new,
    ),
    ScreenDefinition(
      id: '4D',
      title: 'Coach home',
      group: 'Coach',
      description:
          'A quick snapshot of gym activity and today’s coaching sessions.',
      builder: Screen4D.new,
    ),
    ScreenDefinition(
      id: 'coach-train',
      title: 'Personal training',
      group: 'Coach',
      description: 'Review your own training plan and weekly workouts.',
      builder: CoachTrainScreen.new,
    ),
    ScreenDefinition(
      id: 'coach-bar',
      title: 'Gym bar',
      group: 'Coach',
      description: 'Browse the member bar menu, adjust your basket, and reserve an order.',
      builder: CoachBarScreen.new,
    ),
    ScreenDefinition(
      id: 'coach-order',
      title: 'Order tracking',
      group: 'Coach',
      description: 'Track your reserved bar order and confirm pickup.',
      builder: CoachOrderTrackingScreen.new,
    ),
    ScreenDefinition(
      id: '5D',
      title: 'My clients',
      group: 'Coach',
      description: 'Search and filter the client list, then open a member’s coaching plan.',
      builder: Screen5D.new,
    ),
    ScreenDefinition(
      id: '6D',
      title: 'Client & plan editor',
      group: 'Coach',
      description:
          'Review client progress and adjust next week’s training loads.',
      builder: Screen6D.new,
    ),
    ScreenDefinition(
      id: '7D',
      title: 'Chats',
      group: 'Coach',
      description: 'Browse conversations with your clients and fellow coaches.',
      builder: Screen7D.new,
    ),
    ScreenDefinition(
      id: '8D',
      title: 'Other coaches',
      group: 'Coach',
      description:
          'Find available coaches by name and start a coaching conversation.',
      builder: Screen8D.new,
    ),
    ScreenDefinition(
      id: '9D',
      title: 'Online training',
      group: 'Coach',
      description:
          'Manage bookings, start sessions, and respond to client requests.',
      builder: Screen9D.new,
    ),
    ScreenDefinition(
      id: '10D',
      title: 'Profile & contract',
      group: 'Coach',
      description:
          'Review your coaching profile, contract, and account shortcuts.',
      builder: Screen10D.new,
    ),
  ];

  static ScreenDefinition? byId(String id) {
    for (final screen in screens) {
      if (screen.id == id) return screen;
    }
    return null;
  }
}
