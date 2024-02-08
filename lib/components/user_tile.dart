import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.text, this.onTap});
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        child: Row(children: [
          const Icon(Icons.verified_user),
          const SizedBox(width: 30),
          Text(text),
        ]),
      ),
    );
  }
}
