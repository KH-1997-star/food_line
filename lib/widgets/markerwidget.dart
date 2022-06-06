import 'package:flutter/material.dart';
import 'package:food_line/utils/colors.dart';

class MarkerWidget extends StatefulWidget {
  final String imagePath;
  const MarkerWidget({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<MarkerWidget> createState() => _MarkerWidgetState();
}

class _MarkerWidgetState extends State<MarkerWidget> {
  @override
  Widget build(BuildContext context) {
    print('THE IMAGE PATH ::::');
    print(widget.imagePath);
    return ClipRRect(
        child: Container(
      height: 50,
      width: 50,
      /*  child: CachedNetworkImage(
          height: 50,
          width: 50,
          memCacheHeight: 50,
          memCacheWidth: 50,
          imageUrl: widget.imagePath,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ) */
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.transparent,
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            widget.imagePath,
          ),
        ),
      ),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.transparent,
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              widget.imagePath,
            ),
          ),
        ),
      ),
    ));
  }
}
