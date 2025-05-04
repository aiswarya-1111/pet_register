import 'package:pet_register/entity/pet_detail_entity.dart';
import 'package:pet_register/utils/equatable.dart';

class RegisteredPetFeedScreenState extends BaseEquatable {}

class RegisteredPetFeedScreenInitState extends RegisteredPetFeedScreenState {}

class RegisteredPetFeedScreenLoadingState extends RegisteredPetFeedScreenState {
  @override
  bool operator ==(Object other) => false;
}

class RegisteredPetFeedScreenLoadedState extends RegisteredPetFeedScreenState {
  final List<PetDetailEntity> petList;
  RegisteredPetFeedScreenLoadedState({required this.petList});
}

class RegisteredPetFeedScreenErrorState extends RegisteredPetFeedScreenState {
  final String errorMessage;
  RegisteredPetFeedScreenErrorState({required this.errorMessage});
}
