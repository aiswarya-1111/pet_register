import 'dart:io';

import 'package:pet_register/repository/pet_repository.dart';
import 'package:pet_register/screens/register_pet_form_screen/cubit/resgister_pet_form_screen.state.dart';
import 'package:pet_register/utils/base_cubit.dart';
import 'package:pet_register/utils/string_resource.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';

class RegisterPetFormScreenCubit extends BaseCubit<RegisterPetFormScreenState> {
  final petNameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final locationController = TextEditingController();
  final notesController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? petType;
  String? gender;
  File? imageFile;

  RegisterPetFormScreenCubit() : super(RegisterPetFormScreenInitState());

  Future<void> submitPetDetails() async {
    emit(RegisterPetFormScreenLoadingState());

    try {
      final isValid = formKey.currentState?.validate() ?? false;
      final customError = validateFields();

      if (!isValid || customError != null) {
        if (customError != null) {
          emit(RegisterPetFormScreenErrorState(errorMessage: customError));
        }
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
        return;
      }

      emit(RegisterPetFormScreenSuccessState());
    } catch (e) {
      emit(
        RegisterPetFormScreenErrorState(
          errorMessage: StringResource.somethingWentWrong,
        ),
      );
    }
  }

  String? validateFields() {
    if ((petType ?? "").isEmpty) return "Pet type is required.";
    if ((gender ?? "").isEmpty) return "Gender is required.";
    if (imageFile == null) return "Pet image is required.";
    return null;
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["jpeg", "png", "jpg"],
        withReadStream: true,
      );

      if (pickedFile == null || pickedFile.files.isEmpty) {
        emit(RegisterPetFormRefreshState());
        return;
      }

      final PlatformFile platformFile = pickedFile.files.first;
      imageFile = File(platformFile.path!);

      emit(RegisterPetFormScreenLoadedState(successMessage: "Image Uploaded"));
    } catch (e) {
      emit(
        RegisterPetFormScreenErrorState(errorMessage: "Failed to pick image."),
      );
    }
  }

  void removeImage() {
    imageFile = null;
    emit(RegisterPetFormScreenLoadedState(successMessage: "Image Removed"));
  }

  void onSelectPetType(String selectType) {
    petType = selectType;
    emit(RegisterPetFormRefreshState());
  }

  void onSelectPetGender(String selectGender) {
    gender = selectGender;
    emit(RegisterPetFormRefreshState());
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
