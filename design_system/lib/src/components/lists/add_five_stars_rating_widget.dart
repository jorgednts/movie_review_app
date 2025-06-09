import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AddFiveStarsRatingWidget extends StatefulWidget {
  const AddFiveStarsRatingWidget({
    super.key,
    required this.onRatingChanged,
    required this.initialRating,
  });

  final void Function(double rating) onRatingChanged;
  final double initialRating;

  @override
  State<AddFiveStarsRatingWidget> createState() =>
      _AddFiveStarsRatingWidgetState();
}

class _AddFiveStarsRatingWidgetState extends State<AddFiveStarsRatingWidget> {
  double rating = 3;

  @override
  void initState() {
    rating = widget.initialRating;
    super.initState();
  }

  void updateRating(double newRating) {
    setState(() {
      rating = newRating;
    });
    widget.onRatingChanged(newRating);
  }

  void increment() => updateRating((rating + 0.5).clamp(0, 5));

  void decrement() => updateRating((rating - 0.5).clamp(0, 5));

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: IconButton.outlined(
            onPressed: () => decrement(),
            icon: const Icon(Icons.remove),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.expand(
              width: Dimensions.iconSizeSm,
              height: Dimensions.iconSizeSm,
            ),
            iconSize: Dimensions.iconSizeXs,
          ),
        ),
        ...List.generate(5, (index) {
          final starValue = index + 1;
          IconData icon;
          if (rating >= starValue) {
            icon = Icons.star;
          } else if (rating >= starValue - 0.5) {
            icon = Icons.star_half;
          } else {
            icon = Icons.star_outline;
          }

          return Flexible(
            child: IconButton(
              onPressed: () => updateRating(starValue.toDouble()),
              color: Theme.of(context).colorScheme.tertiary,
              icon: Icon(icon),
            ),
          );
        }),
        Expanded(
          child: IconButton.outlined(
            onPressed: () => increment(),
            icon: const Icon(Icons.add),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.expand(
              width: Dimensions.iconSizeSm,
              height: Dimensions.iconSizeSm,
            ),
            iconSize: Dimensions.iconSizeXs,
          ),
        ),
      ],
    );
  }
}
