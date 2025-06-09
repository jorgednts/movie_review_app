import 'package:app/src/domain/model/base_tmdb_details_model.dart';
import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:app/src/presentation/ui/search/widgets/tmdb_overview_poster_card.dart';
import 'package:app/src/presentation/utils/form_field_validators.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internationalization/internationalization.dart';

class ReviewBottomSheet extends StatefulWidget {
  const ReviewBottomSheet({
    super.key,
    required this.details,
    required this.type,
  });

  final BaseTMDBDetailsModel details;
  final AppCollectionItemType type;

  @override
  State<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  double rating = 3;
  final formKey = GlobalKey<FormState>();
  final TextEditingController reviewController = TextEditingController();

  void updateRating(double newRating) {
    setState(() {
      rating = newRating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: AppIntl.of(context).reviews_my_review,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Dimensions.spacingMd,
        children: [
          AspectRatio(
            aspectRatio: 3,
            child: TMDBOverviewPosterCard(
              title: widget.details.title,
              posterUrl: widget.details.posterUrl,
              voteAverage: widget.details.voteAverage,
              releaseYear: widget.details.releaseYear,
              overview: '',
              onTap: null,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: AppIntl.of(context).reviews_my_rating,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: ' (${rating.toStringAsFixed(1)})',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: AddFiveStarsRatingWidget(
                  onRatingChanged: updateRating,
                  initialRating: rating,
                ),
              ),
            ],
          ),
          Expanded(
            child: Form(
              key: formKey,
              child: DefaultTextFormField(
                label: AppIntl.of(context).reviews_add_review,
                controller: reviewController,
                expands: true,
                autocorrect: true,
                validator:
                    (value) =>
                        FormFieldValidators.validateString(value, context),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  AppIntl.of(context).common_cancel,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FilledButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    context.pop(
                      widget.details.toCollectionItem(
                        widget.type,
                        reviewController.text,
                        rating,
                      ),
                    );
                  }
                },
                child: Text(AppIntl.of(context).reviews_submit_review),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
