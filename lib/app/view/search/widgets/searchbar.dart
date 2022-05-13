import 'package:flutter/material.dart';

class SearchbarWidget extends StatelessWidget {
  const SearchbarWidget({
    required this.onSubmitted,
    required this.searchbarController,
    Key? key,
  }) : super(key: key);
  final Function onSubmitted;
  final TextEditingController searchbarController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: searchbarController,
        onSubmitted: (String value) {
          onSubmitted(value);
        },
        decoration: InputDecoration(
          hintText: 'কাঙ্ক্ষিত পণ্যটি খুঁজুন',
          hintStyle: Theme.of(context).textTheme.caption,
          suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                onSubmitted(searchbarController.text);
              }),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
