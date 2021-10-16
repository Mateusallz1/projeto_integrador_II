// import 'package:flutter/material.dart';
// import 'package:projeto_hospede_se/services/auth_service.dart';
// import 'package:projeto_hospede_se/styles/style.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     AuthService auth = Provider.of<AuthService>(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green.shade800,
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Text(
//               'Home',
//               style: titleTextBlack,
//             ),
//             Text(
//               '${auth.userApp?.email}',
//               style: titleTextBlack,
//             ),
//             Text(
//               '${auth.userApp?.name}',
//               style: titleTextBlack,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  //const HomePage({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          drawer: const CustomDrawer(),
          appBar: AppBar(
            title: const Text('Home'),
          ),
        ),
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.blue,
        )
      ],
    );
  }
}
