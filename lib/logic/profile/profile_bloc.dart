// lib/logic/profile/profile_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import '../../data/repositories/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<FetchProfileEvent>(_onFetchProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onFetchProfile(
      FetchProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final data = await profileRepository.fetchProfile(token: event.token);
      final id = data['id'] as int;
      final firstName = data['first_name'] as String? ?? '';
      final lastName = data['last_name'] as String? ?? '';
      final phone = data['phone'] as String? ?? '';
      final address = data['address'] as String? ?? '';
      final bio = data['bio'] as String? ?? '';
      final imageUrl = data['image'] as String?;
      final email = data['email'] as String? ?? '';

      emit(ProfileFetched(
        id: id,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        address: address,
        bio: bio,
        imageUrl: imageUrl,
        email: email, // pass it to ProfileFetched state
      ));
    } catch (error) {
      emit(ProfileError(error: error.toString()));
    }
  }

  Future<void> _onUpdateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final result = await profileRepository.updateProfile(
        token: event.token,
        profileId: event.profileId,
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email, // pass email
        phone: event.phone,
        address: event.address,
        bio: event.bio,
        image: event.image,
      );
      final msg = result['detail'] ?? 'Profile updated successfully.';
      emit(ProfileUpdated(message: msg));
    } catch (error) {
      emit(ProfileError(error: error.toString()));
    }
  }
}
