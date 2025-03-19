// lib/logic/legal_resource/legal_resource_event.dart

import 'package:equatable/equatable.dart';

abstract class LegalResourceEvent extends Equatable {
  const LegalResourceEvent();

  @override
  List<Object?> get props => [];
}

/// List all resources
class FetchAllResourcesEvent extends LegalResourceEvent {}

/// Get detail for one resource
class FetchResourceDetailEvent extends LegalResourceEvent {
  final int resourceId;
  const FetchResourceDetailEvent({required this.resourceId});

  @override
  List<Object?> get props => [resourceId];
}
