// lib/presentation/screens/legal_resources/resource_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/legal_resource/legal_resource_bloc.dart';
import '../../../logic/legal_resource/legal_resource_event.dart';
import '../../../logic/legal_resource/legal_resource_state.dart';

class ResourceListScreen extends StatefulWidget {
  const ResourceListScreen({Key? key}) : super(key: key);

  @override
  State<ResourceListScreen> createState() => _ResourceListScreenState();
}

class _ResourceListScreenState extends State<ResourceListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch all resources on screen load
    context.read<LegalResourceBloc>().add(FetchAllResourcesEvent());
  }

  void _navigateToDetail(BuildContext context, int resourceId) {
    Navigator.pushNamed(context, '/legalresource/detail', arguments: resourceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Legal Resources'),
      ),
      body: BlocBuilder<LegalResourceBloc, LegalResourceState>(
        builder: (context, state) {
          if (state is ResourcesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ResourcesLoaded) {
            final resources = state.resources;
            return ListView.builder(
              itemCount: resources.length,
              itemBuilder: (context, index) {
                final item = resources[index];
                final resourceId = item['id'] as int;
                final title = item['title'] as String? ?? 'No title';
                final imageUrl = item['image'] as String?;

                return ListTile(
                  leading: imageUrl != null 
                    ? Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                    : const Icon(Icons.image_not_supported),
                  title: Text(title),
                  onTap: () => _navigateToDetail(context, resourceId),
                );
              },
            );
          } else if (state is ResourceError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
