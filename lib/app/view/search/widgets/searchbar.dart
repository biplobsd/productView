import 'package:flutter/material.dart';

class SearchbarWidget extends StatelessWidget {
  SearchbarWidget({
    required this.onSubmitted,
    this.query = '',
    Key? key,
  }) : super(key: key);
  final TextEditingController searchbarController = TextEditingController();
  final String query;
  final Function onSubmitted;
  @override
  Widget build(BuildContext context) {
    if (query.isNotEmpty && searchbarController.text != query) {
      searchbarController.text = query;
    }

    return TextField(
      controller: searchbarController,
      onSubmitted: (value) {
        onSubmitted(value);
      },
      decoration: InputDecoration(
        hintText: 'কাঙ্খিত পণ্যটি খুঁজুন',
        hintStyle: Theme.of(context).textTheme.caption,
        suffixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
