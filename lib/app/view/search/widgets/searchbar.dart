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
    searchbarController.text =
        query.isNotEmpty ? query : searchbarController.text;
    return TextField(
      controller: searchbarController,
      onSubmitted: (value) {
        onSubmitted(value);
      },
      decoration: InputDecoration(
        hintText: 'কাক্ষিত পন্যটি খুঁজুন',
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
