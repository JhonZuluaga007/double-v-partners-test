import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';

class UserAvatar extends StatelessWidget {
  final UserEntity user;
  final double radius;
  final String? heroTag;

  const UserAvatar({
    super.key,
    required this.user,
    this.radius = 24,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      radius: radius,
      child: Text(
        user.name[0].toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (heroTag != null) {
      return Hero(tag: heroTag!, child: avatar);
    }

    return avatar;
  }
}
