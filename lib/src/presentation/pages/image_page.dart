import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  final image;
  const ImagePage(this.image, {super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  double offset = 0.0;
  final double threshold = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            setState(() {
              offset += details.delta.dy;
            });
          },
          onVerticalDragEnd: (details) {
            if (offset > threshold) {
              Navigator.pop(context);
            } else {
              setState(() {
                offset = 0.0;
              });
            }
          },
          child: Stack(
            children: [
              Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  transform: Matrix4.translationValues(0, offset, 0),
                  child: Hero(
                      tag: 'tag-1',
                      child: Image(
                          image: AssetImage('assets/images/${widget.image}'))),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
