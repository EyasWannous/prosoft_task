import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prosoft_task/extensions/widget_extension.dart';
import 'package:prosoft_task/theme/bloc/theme_bloc.dart';
import 'package:prosoft_task/theme/theme.dart';

class PageHeading extends StatelessWidget {
  final String title;
  const PageHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      // padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w900,
                  fontFamily: GoogleFonts.lora().fontFamily,
                ),
            // style: const TextStyle(
            //   fontSize: 30,
            //   fontWeight: FontWeight.bold,
            //   fontFamily: 'NotoSerif',
            // ),
          ),
          const Spacer(),
          BlocBuilder<ThemeBloc, ThemeData>(
            builder: (_, themeData) {
              return IconButton(
                onPressed: () =>
                    context.read<ThemeBloc>().add(ThemeSwitchEvent()),
                icon: Icon(
                  themeData.colorScheme == FlutterTasksTheme.dark.colorScheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                ),
              );
            },
          )
        ],
      ),
    ).symmetricPadding(horizontal: 22, vertical: 25);
  }
}
