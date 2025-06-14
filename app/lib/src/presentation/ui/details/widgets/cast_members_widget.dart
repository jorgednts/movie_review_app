import 'package:app/src/domain/model/cast_member_model.dart';
import 'package:app/src/presentation/ui/home/widgets/poster_carousel.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class CastMembersWidget extends StatelessWidget {
  const CastMembersWidget({super.key, required this.getCastMembers});

  final Command0<List<CastMemberModel>> getCastMembers;

  @override
  Widget build(BuildContext context) {
    return PosterCarousel<CastMemberModel>(
      title: AppIntl.of(context).details_cast,
      titleStyle: Theme.of(
        context,
      ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      command: getCastMembers,
      cardBuilder:
          (member) => PosterCard(
            posterUrl: member.profileUrl,
            infoWidget: Padding(
              padding: const EdgeInsets.all(Dimensions.spacingXs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StyledText.t2(
                    member.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    isBold: true,
                  ),
                  StyledText.t1(
                    member.character,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    isItalic: true,
                  ),
                ],
              ),
            ),
          ),
      onTapItem: null,
    );
  }
}
