import 'package:cat_register/utils/equatable.dart';

class RegisterPetFormScreenState extends BaseEquatable {}

class RegisterPetFormScreenInitState extends RegisterPetFormScreenState {}

class RegisterPetFormScreenLoadingState extends RegisterPetFormScreenState {
  @override
  bool operator ==(Object other) => false;
}

class RegisterPetFormScreenLoadedState extends RegisterPetFormScreenState {
  final String successMessage;
  RegisterPetFormScreenLoadedState({required this.successMessage});
}

class RegisterPetFormScreenErrorState extends RegisterPetFormScreenState {
  final String errorMessage;
  RegisterPetFormScreenErrorState({required this.errorMessage});
}

class RegisterPetFormRefreshState extends RegisterPetFormScreenState {
  @override
  bool operator ==(Object other) => false;
}

class RegisterPetFormScreenSuccessState extends RegisterPetFormScreenState{}
