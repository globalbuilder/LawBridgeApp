// lib/presentation/screens/legal_resources/resource_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/legal_resource/legal_resource_bloc.dart';
import '../../../logic/legal_resource/legal_resource_event.dart';
import '../../../logic/legal_resource/legal_resource_state.dart';

class ResourceDetailScreen extends StatefulWidget {
  const ResourceDetailScreen({Key? key}) : super(key: key);

  @override
  State<ResourceDetailScreen> createState() => _ResourceDetailScreenState();
}

class _ResourceDetailScreenState extends State<ResourceDetailScreen> {
  int? _resourceId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve resource ID from route arguments
    if (_resourceId == null) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is int) {
        _resourceId = args;
        debugPrint('ResourceDetailScreen: resourceId = $_resourceId');
        // Dispatch event to fetch resource details
        context
            .read<LegalResourceBloc>()
            .add(FetchResourceDetailEvent(resourceId: _resourceId!));
      } else {
        debugPrint('ResourceDetailScreen: No valid resourceId passed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resource Detail'),
      ),
      body: BlocBuilder<LegalResourceBloc, LegalResourceState>(
        builder: (context, state) {
          if (state is ResourcesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ResourceDetailLoaded) {
            final resource = state.resource;
            final title = resource['title'] as String? ?? 'No Title';
            final description =
                resource['description'] as String? ?? 'No Description';
            final imageUrl = resource['image'] as String?;
            final fileUrl = resource['file'] as String?;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageUrl != null && imageUrl.isNotEmpty)
                    Image.network(imageUrl,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover)
                  else
                    const SizedBox(),
                  const SizedBox(height: 16),
                  Text(title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(description),
                  const SizedBox(height: 16),
                  if (fileUrl != null && fileUrl.isNotEmpty)
                    ElevatedButton(
                      onPressed: () {
                        // Optionally, open the file URL in a browser or PDF viewer
                        // For example: launch(fileUrl);
                      },
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
