import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/utils/messages.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_loader.dart';
import '../blocs/legal_resources_bloc.dart';
import '../blocs/legal_resources_event.dart';
import '../blocs/legal_resources_state.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalResourceDetailScreen extends StatefulWidget {
  static const routeName = '/resource/detail';
  final int id;
  const LegalResourceDetailScreen({super.key, required this.id});

  @override
  State<LegalResourceDetailScreen> createState() =>
      _LegalResourceDetailScreenState();
}

class _LegalResourceDetailScreenState extends State<LegalResourceDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LegalResourcesBloc>().add(LoadResourceDetail(widget.id));
  }

  Uri _makeAbsoluteUri(String raw) {
  if (raw.startsWith('http')) return Uri.parse(raw);

  final host = ApiEndpoints.baseUrl.replaceFirst('/api', ''); // strip /api
  final cleaned = raw.startsWith('/') ? raw.substring(1) : raw;
  return Uri.parse('$host/$cleaned');
}
Future<void> _openFile(String rawPath) async {
  final uri = _makeAbsoluteUri(rawPath);

  try {
    final opened =
        await launchUrl(uri, mode: LaunchMode.externalApplication);

    // If no external handler, fall back to in‑app web‑view
    if (!opened) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    }
  } catch (_) {
    if (!mounted) return;
    MessageUtils.showErrorMessage(
        context, 'Could not open the file.');
  }
}

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat.yMMMMd();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Legal Resource'),
      body: BlocBuilder<LegalResourcesBloc, LegalResourcesState>(
        builder: (context, state) {
          if (state.status == ResStatus.loadingDetail ||
              state.resourceDetail == null) {
            return const CustomLoader();
          }
          final res = state.resourceDetail!;
          final isFav = state.favoriteIds.contains(res.id);

          return Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  Hero(
                    tag: 'resource-img-${res.id}',
                    child: res.imageUrl != null
                        ? Image.network(res.imageUrl!,
                            height: 240,
                            width: double.infinity,
                            fit: BoxFit.cover)
                        : Container(
                            height: 240,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.15),
                            child: const Icon(Icons.description, size: 80),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          res.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        if (res.createdAt != null)
                          Row(
                            children: [
                              const Icon(Icons.calendar_month, size: 18),
                              const SizedBox(width: 4),
                              Text(
                                'Added • ${dateFmt.format(res.createdAt!)}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        const Divider(height: 24),
                        if (res.description != null &&
                            res.description!.isNotEmpty)
                          Text(
                            res.description!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        const SizedBox(height: 24),
                        if (res.fileUrl != null)
                          CustomButton(
                            label: 'Open PDF',
                            onPressed: () => _openFile(res.fileUrl!),
                          ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 24,
                right: 24,
                child: FloatingActionButton(
                  heroTag: 'fav-btn-${res.id}',
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  onPressed: () => context
                      .read<LegalResourcesBloc>()
                      .add(ToggleFavoriteResource(res.id)),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, anim) =>
                        ScaleTransition(scale: anim, child: child),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey(isFav),
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
