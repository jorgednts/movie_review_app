import 'package:app/src/domain/model/app_collection_item_model.dart';
import 'package:app/src/presentation/utils/form_field_validators.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internationalization/internationalization.dart';

class ReviewBottomSheet extends StatefulWidget {
  const ReviewBottomSheet({super.key, required this.item});

  final AppCollectionItemModel item;

  @override
  State<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  double rating = 3;
  final formKey = GlobalKey<FormState>();
  final TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    if (widget.item.review != null) {
      rating = widget.item.voteAverage;
      reviewController.text = widget.item.review!;
    }
  }

  void updateRating(double newRating) {
    setState(() {
      rating = newRating;
    });
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: WindowUtils.heightOf(context) * 0.9,
        maxWidth:
            WindowUtils.isDesktop(context)
                ? WindowUtils.widthOf(context) * 0.9
                : double.infinity,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: LayoutBuilder(
          builder:
              (_, constraints) => Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(Dimensions.radiusLg),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: Dimensions.spacingMd,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(Dimensions.radiusLg),
                          ),
                          child: CustomNetworkImage(
                            url: widget.item.backdropUrl,
                            width: double.infinity,
                            boxFit: BoxFit.cover,
                            placeholder:
                                const _BackdropAspectRatio.placeholder(),
                            errorWidget: const _BackdropAspectRatio.error(),
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth * 0.8,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surface.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusLg,
                            ),
                          ),
                          margin: const EdgeInsets.only(
                            top: Dimensions.spacingXs,
                            left: Dimensions.spacingXs,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.spacingSm,
                            vertical: Dimensions.spacingXs,
                          ),
                          child: StyledText.t3(widget.item.title),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.spacingMd,
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: AppIntl.of(context).reviews_my_rating,
                              style: Theme.of(context).textTheme.titleLarge,
                              children: [
                                TextSpan(
                                  text: ' (${rating.toStringAsFixed(1)})',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                          AddFiveStarsRatingWidget(
                            onRatingChanged: updateRating,
                            initialRating: rating,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.spacingMd,
                      ),
                      child: Form(
                        key: formKey,
                        child: DefaultTextFormField(
                          controller: reviewController,
                          label: AppIntl.of(context).reviews_add_review,
                          validator:
                              (value) => FormFieldValidators.validateString(
                                value,
                                context,
                              ),
                          keyboardType: TextInputType.multiline,
                          minLines: 5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: Dimensions.spacingMd,
                        left: Dimensions.spacingMd,
                        right: Dimensions.spacingMd,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => context.pop(),
                            child: StyledText.b2(
                              AppIntl.of(context).common_cancel,
                              isBold: true,
                              fontColor:
                                  Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          FilledButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                context.pop(
                                  widget.item.copyWith(
                                    review: reviewController.text,
                                    voteAverage: rating,
                                  ),
                                );
                              }
                            },
                            child: StyledText.b2(
                              AppIntl.of(context).reviews_submit_review,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}

class _BackdropAspectRatio extends StatelessWidget {
  const _BackdropAspectRatio.error()
    : child = const DefaultErrorWidget(),
      isError = true;

  const _BackdropAspectRatio.placeholder()
    : child = const DefaultPlaceholder(),
      isError = false;

  final Widget child;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child:
          isError
              ? Container(
                color: Theme.of(context).colorScheme.surface,
                child: child,
              )
              : ShimmerLoading(
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: child,
                ),
              ),
    );
  }
}
