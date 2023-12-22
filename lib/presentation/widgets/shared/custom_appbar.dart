import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final titleStyle = theme.textTheme.titleMedium?.apply(color: colors.primary);
    final hasNotch = MediaQuery.of(context).viewPadding.top > 40;

    return SafeArea(
      child: Padding(
      padding: EdgeInsets.fromLTRB(10, hasNotch ? 0 : 15, 10, 0),
      child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 8),
              Text('Cinemapedia', style: titleStyle),
              const Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.search, color: colors.primary))
            ],
          )),
    ));
  }
}
