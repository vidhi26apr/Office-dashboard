import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Office Dashboard',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const ResponsiveDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ResponsiveDashboard extends StatelessWidget {
  const ResponsiveDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        if (width < 600) {
          return const MobileDashboard();
        } else if (width < 1100) {
          return const TabletDashboard();
        } else {
          return const WebDashboard();
        }
      },
    );
  }
}

// 📱 Mobile
class MobileDashboard extends StatelessWidget {
  const MobileDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: const Drawer(
        child: ListTile(title: Text('Menu')),
      ),
      body: const DashboardContent(),
    );
  }
}

// 📟 Tablet
class TabletDashboard extends StatelessWidget {
  const TabletDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: const Drawer(
        child: ListTile(title: Text('Menu')),
      ),
      body: Row(
        children: const [
          Expanded(flex: 1, child: Drawer(child: ListTile(title: Text('Menu')))),
          Expanded(flex: 4, child: DashboardContent()),
        ],
      ),
    );
  }
}

// 🖥️ Web
class WebDashboard extends StatelessWidget {
  const WebDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          NavigationSidebar(),
          Expanded(child: DashboardContent()),
        ],
      ),
    );
  }
}

// Sidebar for Web
class NavigationSidebar extends StatelessWidget {
  const NavigationSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.indigo[100],
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DrawerHeader(child: Text('Office Panel', style: TextStyle(fontSize: 20))),
          ListTile(title: Text('Dashboard')),
          ListTile(title: Text('Employees')),
          ListTile(title: Text('Reports')),
          ListTile(title: Text('Settings')),
        ],
      ),
    );
  }
}

// Main dashboard content
class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: MediaQuery.of(context).size.width < 600 ? 1 : 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: const [
          DashboardCard(title: 'Total Employees', value: '42', icon: Icons.group),
          DashboardCard(title: 'Pending Tasks', value: '13', icon: Icons.pending_actions),
          DashboardCard(title: 'Notifications', value: '5', icon: Icons.notifications),
          DashboardCard(title: 'Reports', value: '9', icon: Icons.bar_chart),
        ],
      ),
    );
  }
}

// Individual card
class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.indigo[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: ListTile(
          leading: Icon(icon, size: 40, color: Colors.indigo),
          title: Text(title, style: const TextStyle(fontSize: 18)),
          subtitle: Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
