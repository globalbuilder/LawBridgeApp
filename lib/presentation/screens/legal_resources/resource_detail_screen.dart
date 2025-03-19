// lib/presentation/screens/legal_resources/resource_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

// Auth
import 'package:law_bridge/logic/auth/auth_bloc.dart';
import 'package:law_bridge/logic/auth/auth_state.dart';

// Favorites
import 'package:law_bridge/logic/favorites/favorites_bloc.dart';
import 'package:law_bridge/logic/favorites/favorites_event.dart';

// Legal Resource
import '../../../logic/legal_resource/legal_resource_bloc.dart';
import '../../../logic/legal_resource/legal_resource_event.dart';
import '../../../logic/legal_resource/legal_resource_state.dart';

// The static property storing the selected resource ID
import 'resource_list_screen.dart' show ResourceDetailArgs;

class ResourceDetailScreen extends StatefulWidget {
  const ResourceDetailScreen({Key? key}) : super(key: key);

  @override
  State<ResourceDetailScreen> createState() => _ResourceDetailScreenState();
}

class _ResourceDetailScreenState extends State<ResourceDetailScreen> {
  int? _resourceId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupDetailFetch();
    });
  }

  /// Retrieve the resourceId from ResourceDetailArgs and fetch the detail
  void _setupDetailFetch() {
    final id = ResourceDetailArgs.resourceId;
    if (id == null) {
      debugPrint('ResourceDetailScreen: No resourceId found in ResourceDetailArgs');
      return;
    }
    _resourceId = id;
    // Dispatch event to fetch detail
    context.read<LegalResourceBloc>().add(FetchResourceDetailEvent(resourceId: id));
  }

  /// Toggle (or just add) favorite resource
  void _toggleFavoriteResource() {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to favorite resources')),
      );
      return;
    }
    final token = authState.accessToken;
    if (_resourceId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No resource ID available')),
      );
      return;
    }

    // For now, just add the resource to favorites
    context.read<FavoritesBloc>().add(
      AddResourceFavoriteEvent(token: token, resourceId: _resourceId!),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resource favorited!')),
    );
  }

  /// Open file using url_launcher
  Future<void> _openFile(String fileUrl) async {
    final uri = Uri.parse(fileUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open the file: $fileUrl')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resource Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: _toggleFavoriteResource,
          ),
        ],
      ),
      body: BlocBuilder<LegalResourceBloc, LegalResourceState>(
        builder: (context, state) {
          if (state is ResourcesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ResourceDetailLoaded) {
            final resource = state.resource;
            final title = resource['title'] as String? ?? 'No Title';
            final description = resource['description'] as String? ?? 'No Description';
            final imageUrl = resource['image'] as String?;
            final fileUrl = resource['file'] as String?;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageUrl != null && imageUrl.isNotEmpty)
                    Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(description),
                  const SizedBox(height: 16),
                  if (fileUrl != null && fileUrl.isNotEmpty)
                    ElevatedButton(
                      onPressed: () => _openFile(fileUrl),
                      child: const Text('Open File'),
                    ),
                ],
              ),
            );
          } else if (state is ResourceError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No resource details available'));
        },
      ),
    );
  }
}
