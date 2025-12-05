import 'package:flutter/material.dart';

class NetflixCard extends StatefulWidget {
  final String imageUrl;
  final String title;

  const NetflixCard({super.key, required this.imageUrl, required this.title});

  @override
  State<NetflixCard> createState() => _NetflixCardState();
}

class _NetflixCardState extends State<NetflixCard> {
  bool _isHovered = false;

  _cardGenerator() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
            width: 180,
            height: 270,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.black.withOpacity(0.5),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double scale = _isHovered ? 1.1 : 1.0;
    final double elevation = _isHovered ? 12 : 2;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: AnimatedPhysicalModel(
          duration: const Duration(milliseconds: 200),
          shape: BoxShape.rectangle,
          elevation: elevation,
          color: Colors.white,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(12),
          child: _cardGenerator(),
        ),
      ),
    );
  }
}
