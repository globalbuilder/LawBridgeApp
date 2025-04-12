import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/opportunity_entity.dart';

class OpportunityCard extends StatelessWidget {
  final OpportunityEntity opportunity;
  final bool isFav;
  final VoidCallback onFavTap;
  final VoidCallback onOpen;

  const OpportunityCard({
    super.key,
    required this.opportunity,
    required this.isFav,
    required this.onFavTap,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFmt = DateFormat.yMMMd();

    return InkWell(
      onTap: onOpen,
      borderRadius: BorderRadius.circular(20),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
        child: SizedBox(
          height: 150, 
          child: Row(
            children: [
              Hero(
                tag: 'opportunity-img-${opportunity.id}',
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(20)),
                  child: opportunity.image != null
                      ? Image.network(
                          opportunity.image!,
                          width: 140,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 140,
                          height: 150,
                          color: theme.colorScheme.primary.withOpacity(.15),
                          child: Icon(Icons.school,
                              size: 48, color: theme.colorScheme.primary),
                        ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        opportunity.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (opportunity.startDate != null)
                        Text(
                          'Starts • ${dateFmt.format(opportunity.startDate!)}',
                          style: theme.textTheme.bodySmall,
                        ),
                      if (opportunity.location != null &&
                          opportunity.location!.isNotEmpty)
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                opportunity.location!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey(isFav),
                      color: theme.colorScheme.secondary,
                      size: 30, 
                    ),
                  ),
                  onPressed: onFavTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
