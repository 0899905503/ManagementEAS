// import 'package:flutter/material.dart';

// import 'package:flutter_base/models/entities/user/normal_select_model.dart';

// class MultiSelect extends StatefulWidget {
//   final String title;
//   final List<NormalSelectModel> items;
//   final List<NormalSelectModel>? selectedItems;
//   const MultiSelect({
//     Key? key,
//     required this.items,
//     required this.title,
//     this.selectedItems,
//   }) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _MultiSelectState();
// }

// class _MultiSelectState extends State<MultiSelect> {
//   // this variable holds the selected items
//   final List<NormalSelectModel> _selectedItems = [];
//   @override
//   void initState() {
//     if (widget.selectedItems != null && widget.selectedItems!.isNotEmpty) {
//       _selectedItems.addAll(widget.selectedItems!);
//     }
//     super.initState();
//   }

// // This function is triggered when a checkbox is checked or unchecked
//   void _itemChange(NormalSelectModel itemValue, bool isSelected) {
//     setState(() {
//       if (isSelected) {
//         _selectedItems.add(itemValue);
//       } else {
//         _selectedItems.remove(itemValue);
//       }
//     });
//   }

//   // this function is called when the Cancel button is pressed
//   void _cancel() {
//     Navigator.pop(context);
//   }

// // this function is called when the Submit button is tapped
//   void _submit() {
//     Navigator.pop(context, _selectedItems);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(widget.title),
//       content: SingleChildScrollView(
//         child: ListBody(
//           children: widget.items
//               .map(
//                 (item) => CheckboxListTile(
//                   value: _selectedItems.contains(item),
//                   title: Text(item.display ?? ""),
//                   controlAffinity: ListTileControlAffinity.leading,
//                   onChanged: (isChecked) => _itemChange(item, isChecked!),
//                 ),
//               )
//               .toList(),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: _cancel,
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: _submit,
//           child: const Text('Submit'),
//         ),
//       ],
//     );
//   }
// }
