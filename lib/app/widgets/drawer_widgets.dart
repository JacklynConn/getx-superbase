// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
//
// class DrawerWidgets extends StatelessWidget {
//   const DrawerWidgets({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           Obx(
//                 () => DrawerHeader(
//               child: Column(
//                 children: [
//                   const CircleAvatar(
//                     radius: 40,
//                     backgroundColor: Colors.white,
//                     child: Icon(
//                       Icons.person,
//                       size: 50,
//                       color: Colors.purple,
//                     ),
//                   ),
//                   Text(
//                     controller.userData['name'] ?? 'Loading...',
//                     style: const TextStyle(
//                       // fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     controller.userData['email'] ?? '',
//                     style: const TextStyle(
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: const Text('Home'),
//             onTap: () {
//               Get.back();
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.person),
//             title: const Text('Profile'),
//             onTap: () {
//               Get.toNamed('/profile');
//             },
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text('Logout'),
//             onTap: () async {
//               try {
//                 await SuperBaseProvider.instance.logout();
//               } catch (e) {
//                 Get.snackbar('Error', e.toString());
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
