// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:food_line/utils/upper_case_formatter.dart';
// import 'package:food_line/widgets/custom_input.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// class _ExampleMask {
//   final MaskTextInputFormatter? formatter;
//   final FormFieldValidator<String>? validator;
//   final double? height;
//   final double? width;
//   final TextEditingController controller;
//   final double? radius;
//   final String? hintText;
//   final TextInputType? keyboardType;
//   final bool? enableField;
//   final VoidCallback? onTap;

//   _ExampleMask({
//     this.formatter,
//     this.onTap,
//     this.enableField = false,
//     this.height = 60,
//     this.width = 303,
//     this.radius = 13,
//     this.keyboardType = TextInputType.text,
//     required this.validator,
//     required this.hintText,
//     required this.controller,
//     key,
//   });
// }

// class _ExamplePageState extends State<CustomInput> {
//   MaskTextInputFormatter? formatter;
//   FormFieldValidator<String>? validator;
//   double? height;
//   double? width;
//   TextEditingController? controller;
//   double? radius;
//   String? hintText;
//   TextInputType? keyboardType;
//   bool? enableField;
//   VoidCallback? onTap;
//   @override
//   void initState() {
//     formatter = widget.formater;
//     validator = widget.validator;
//     height = widget.height;
//     width = widget.width;
//     controller = widget.controller;
//     radius = widget.radius;
//     hintText = widget.hintText;
//     keyboardType = widget.keyboardType;
//     enableField = widget.enableField;
//     onTap = widget.onTap;
//   }

//   final List<_ExampleMask> examples = [
//     _ExampleMask(
//         onTap: onTap,
//         validator: validator,
//         formatter: MaskTextInputFormatter(mask: "+# (###) ###-##-##"),
//         hintText: "+1 (234) 567-89-01"),
//     _ExampleMask(
//         formatter: MaskTextInputFormatter(mask: "##/##/####"),
//         hintText: "31/12/2020",
//         validator:validator,
//         )
//     _ExampleMask(
//         formatter: MaskTextInputFormatter(mask: "(AA) ####-####"),
//         hint: "(AB) 1234-5678"),
//     _ExampleMask(
//         formatter: MaskTextInputFormatter(mask: "####.AAAAAA/####-####"),
//         hint: "1234.ABCDEF/2019-2020"),
//     _ExampleMask(
//         formatter: SpecialMaskTextInputFormatter(), hint: "A.1234 or B.123456"),
//     _ExampleMask(
//         formatter: MaskTextInputFormatter(
//             mask: "##/##/##", type: MaskAutoCompletionType.eager),
//         hint: "12/34/56 (eager type)"),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey.shade200,
//         body: SafeArea(
//             child: ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           children: [
//             for (final example in examples)
//               CustomInput(example.controller, example.formatter,
//                   example.validator, example.hintText),
//           ],
//         )));
//   }
// }
