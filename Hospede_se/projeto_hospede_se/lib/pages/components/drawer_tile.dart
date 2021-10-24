import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/pages/home/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const DrawerTile({required this.icondata, required this.title, required this.page});

  final IconData icondata;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    final int curPage = context.watch<PageManager>().page; //pega a página atual

    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                icondata,
                size: 32,
                color: curPage == page ? Colors.green.shade900 : Colors.green,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
