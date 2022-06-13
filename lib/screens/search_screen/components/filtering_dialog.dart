import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zst_schedule/blocs/search_bloc/search_bloc.dart';

import '../../../models/filter_arguments_model.dart';

class FilteringDialog extends StatefulWidget {
  final bool showClasses;
  final bool showClassrooms;
  final bool showTeachers;
  final ValueChanged<FilterArguments> onChanged;
  const FilteringDialog({
    Key? key,
    required this.showClasses,
    required this.showClassrooms,
    required this.showTeachers,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FilteringDialog> createState() => _SortingDialogState();
}

class _SortingDialogState extends State<FilteringDialog> {
  late bool showClasses;
  late bool showClassrooms;
  late bool showTeachers;

  @override
  void initState() {
    super.initState();
    showClasses = widget.showClasses;
    showClassrooms = widget.showClassrooms;
    showTeachers = widget.showTeachers;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filtrowanie'),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: const Text('Klasy'),
            value: showClasses,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  showClasses = value;
                });
              }
            },
          ),
          CheckboxListTile(
            title: const Text('Sale lekcyjne'),
            value: showClassrooms,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  showClassrooms = value;
                });
              }
            },
          ),
          CheckboxListTile(
            title: const Text('Nauczyciele'),
            value: showTeachers,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  showTeachers = value;
                });
              }
            },
          )
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Anuluj'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<SearchBloc>().add(FilterSearch(
                  showClasses: showClasses,
                  showClassrooms: showClassrooms,
                  showTeachers: showTeachers,
                ));
            widget.onChanged(FilterArguments(
              showClasses: showClasses,
              showClassrooms: showClassrooms,
              showTeachers: showTeachers,
            ));
            Navigator.pop(context);
          },
          child: const Text('Zapisz'),
        ),
      ],
    );
  }
}
