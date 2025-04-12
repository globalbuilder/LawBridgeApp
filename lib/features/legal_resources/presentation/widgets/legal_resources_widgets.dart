import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/legal_resource_entity.dart';

/// Card for list / search / favourites screens.
class ResourceCard extends StatelessWidget {
  final LegalResourceEntity resource;
  final bool isFav;
  final VoidCallback onFavTap;
  final VoidCallback onOpen;

  const ResourceCard({
    super.key,
    required this.resource,
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
              // Thumbnail (image if exists, otherwise file icon)
              Hero(
                tag: 'resource-img-${resource.id}',
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(20)),
                  child: resource.imageUrl != null
                      ? Image.network(
                          resource.imageUrl!,
                          width: 140,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 140,
                          height: 150,
                          color:
                              theme.colorScheme.primary.withOpacity(0.15),
                          child: Icon(Icons.description,
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
                        resource.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (resource.createdAt != null)
                        Text(
                          'Added • ${dateFmt.format(resource.createdAt!)}',
                          style: theme.textTheme.bodySmall,
                        ),
                      if (resource.fileUrl != null)
                        Row(
                          children: [
                            const Icon(Icons.attach_file, size: 16),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                resource.fileUrl!.split('/').last,
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
