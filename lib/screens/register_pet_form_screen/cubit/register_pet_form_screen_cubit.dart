import 'dart:io';

import 'package:cat_register/repository/pet_repository.dart';
import 'package:cat_register/screens/register_pet_form_screen/cubit/resgister_pet_form_screen.state.dart';
import 'package:cat_register/utils/base_cubit.dart';
import 'package:cat_register/utils/string_resource.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';

class RegisterPetFormScreenCubit extends BaseCubit<RegisterPetFormScreenState> {
  final petNameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final locationController = TextEditingController();
  final notesController = TextEditingController();
  String? petType;
  String? gender;
  File? imageFile;

  RegisterPetFormScreenCubit() : super(RegisterPetFormScreenInitState());

  Future<void> addPetDetail() async {
    emit(RegisterPetFormScreenLoadingState());

    final validationError = validateFields();
    if (validationError != null) {
      emit(RegisterPetFormScreenErrorState(errorMessage: ""));
      return;
    }

    final response = await PetRepository.registerPet(
      petName: petNameController.text,
      userName: ownerNameController.text,
      petType: petType!,
      gender: gender!,
      location: locationController.text,
      imageFile: imageFile!,
    );

    if (response.status != 200) {
      emit(
        RegisterPetFormScreenErrorState(
          errorMessage: response.error ?? StringResource.somethingWentWrong,
        ),
      );
    }
    emit(
      RegisterPetFormScreenLoadedState(
        successMessage: response.message ?? "Pet detail added!",
      ),
    );
  }

  String? validateFields() {
    if (petNameController.text.trim().isEmpty) return "Pet name is required.";
    if (ownerNameController.text.trim().isEmpty) {
      return "Owner name is required.";
    }
    if (petType == null || petType!.isEmpty) return "Pet type is required.";
    if (gender == null || gender!.isEmpty) return "Gender is required.";
    if (locationController.text.trim().isEmpty) return "Location is required.";
    if (imageFile == null) return "Pet image is required.";

    return null;
  }

  Future<void> pickImage() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpeg", "png", "jpg"],
      withReadStream: true,
    );

    if (pickedFile == null || pickedFile.files.isEmpty) {
      return emit(RegisterPetFormRefreshState());
    }

    final PlatformFile platformFile = pickedFile.files.first;
    imageFile = File(platformFile.path!);

    emit(RegisterPetFormScreenLoadedState(successMessage: "Image Uploaded"));
  }

  void removeImage() {
    imageFile = null;
    emit(RegisterPetFormScreenLoadedState(successMessage: "Image Removed"));
  }

  @override
  Future<void> close() {
    petNameController.dispose();
    ownerNameController.dispose();
    locationController.dispose();
    notesController.dispose();
    return super.close();
  }
}
