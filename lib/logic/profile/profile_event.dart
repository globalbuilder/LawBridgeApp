// lib/logic/profile/profile_event.dart
import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class FetchProfileEvent extends ProfileEvent {
  final String token;
  const FetchProfileEvent({required this.token});
  @override
  List<Object?> get props => [token];
}

class UpdateProfileEvent extends ProfileEvent {
  final String token;
  final int profileId;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final String bio;
  final File? image;
  const UpdateProfileEvent({
    required this.token,
    required this.profileId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.bio,
    this.image,
  });
  @override
  List<Object?> get props => [token, profileId, firstName, lastName, phone, address, bio, image];
}
