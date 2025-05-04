import 'dart:io';

import 'package:pet_register/screens/register_pet_form_screen/cubit/register_pet_form_screen_cubit.dart';
import 'package:pet_register/screens/register_pet_form_screen/cubit/resgister_pet_form_screen.state.dart';
import 'package:pet_register/screens/registered_pet_feed_screen/cubit/registered_pet_feed_screen_cubit.dart';
import 'package:pet_register/screens/registered_pet_feed_screen/registered_pet_feed_screen.dart';
import 'package:pet_register/utils/color_resource.dart';
import 'package:pet_register/utils/image_constant.dart';
import 'package:pet_register/utils/string_resource.dart';
import 'package:pet_register/widget/custom_appbar.dart';
import 'package:pet_register/widget/custom_button.dart';
import 'package:pet_register/widget/custom_drop_down.dart';
import 'package:pet_register/widget/custom_scaffold.dart';
import 'package:pet_register/widget/custom_text.dart';
import 'package:pet_register/widget/custom_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPetFormScreen extends StatelessWidget {
  const RegisterPetFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        leading: BackButtonWidget(),
        title: StringResource.addYourPetDetail,
      ),
      body:
          BlocListener<RegisterPetFormScreenCubit, RegisterPetFormScreenState>(
            listener: (context, state) {
              if (state is RegisterPetFormScreenErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: CustomText(
                      state.errorMessage,
                      color: ColorResource.colorFFFFFF,
                    ),
                  ),
                );
              }
              if (state is RegisterPetFormScreenLoadedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: CustomText(
                      state.successMessage,
                      color: ColorResource.colorFFFFFF,
                    ),
                  ),
                );
              }
              if (state is RegisterPetFormScreenSuccessState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BlocProvider(
                          create:
                              (context) =>
                                  RegisteredPetFeedScreenCubit()..init(),
                          child: RegisteredPetFeedScreen(),
                        ),
                  ),
                );
              }
            },
            child: const PetProfileForm(),
          ),
    );
  }
}

class PetProfileForm extends StatelessWidget {
  const PetProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterPetFormScreenCubit>();

    return BlocBuilder<RegisterPetFormScreenCubit, RegisterPetFormScreenState>(
      builder: (context, state) {
        final isLoading = state is RegisterPetFormScreenLoadingState;

        return AbsorbPointer(
          absorbing: isLoading,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(child: _PetProfileFormFields()),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: CustomButton(
                      label: StringResource.submit,
                      textFontSize: 18,
                      textFontWeight: FontWeight.w500,
                      onPressed: cubit.submitPetDetails,
                    ),
                  ),
                ],
              ),
              if (isLoading) const Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }
}

class _PetProfileFormFields extends StatelessWidget {
  const _PetProfileFormFields();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterPetFormScreenCubit>();
    final selectedPetType = context.select(
      (RegisterPetFormScreenCubit c) => c.petType,
    );
    final selectedPetGender = context.select(
      (RegisterPetFormScreenCubit c) => c.gender,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField(
              label: StringResource.yourPetName,
              child: _textField(
                cubit.petNameController,
                'enter your pet name',
                validatorMessage: "Required",
              ),
            ),
            _buildInputField(
              label: StringResource.yourPetOwnerName,
              child: _textField(
                cubit.ownerNameController,
                'enter owner name',
                validatorMessage: "Required",
              ),
            ),
            _buildInputField(
              label: 'Type of Pet',
              child: CustomDropDownWidget<String>(
                items: ['Dog', 'Cat', 'Bird', 'Rabbit', 'Other'],
                selectedValue: selectedPetType,
                hintText: "ex. dog",
                onChanged: cubit.onSelectPetType,
                displayName: (val) => val,
              ),
            ),
            _buildInputField(
              label: 'Gender',
              child: CustomDropDownWidget<String>(
                items: ['Male', 'Female'],
                selectedValue: selectedPetGender,
                hintText: "ex. male",
                onChanged: cubit.onSelectPetGender,
                displayName: (val) => val,
              ),
            ),
            _buildInputField(
              label: StringResource.enterPetLocation,
              child: _textField(
                cubit.locationController,
                'enter your pet location',
                validatorMessage: "Required",
              ),
            ),
            _buildInputField(
              label: StringResource.additionalNotes,
              child: _textField(
                cubit.notesController,
                '',
                maxLines: 5,
                radius: 10,
              ),
            ),
            const SizedBox(height: 30),
            const UploadPhotosWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({required String label, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorResource.color252525,
          ),
          SizedBox(height: 13),
          child,
        ],
      ),
    );
  }

  Widget _textField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
    String? validatorMessage,
    double radius = 25,
  }) {
    return CustomTextField(
      controller: controller,
      hintText: hint,
      maxLines: maxLines,
      focusBorder: true,
      validatorMessage: validatorMessage,
      borderWidth: 1,
      borderRadius: radius,
    );
  }
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),

        child: Image.asset(ImageConstant.backIcon),
      ),
    );
  }
}

class UploadPhotosWidget extends StatelessWidget {
  const UploadPhotosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterPetFormScreenCubit>();
    final pickedImage = context.select<RegisterPetFormScreenCubit, File?>(
      (cubit) => cubit.imageFile,
    );
    return BlocBuilder<RegisterPetFormScreenCubit, RegisterPetFormScreenState>(
      buildWhen: (prev, curr) {
        return curr is RegisterPetFormScreenLoadedState ||
            curr is RegisterPetFormRefreshState;
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              StringResource.petProfileFieldTitle,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              fontSize: 14,
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: cubit.pickImage,
              child: DottedBorder(
                dashPattern: [6, 4],
                strokeWidth: 1.5,
                borderType: BorderType.RRect,
                radius: const Radius.circular(30),
                color: ColorResource.color494FDD,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        StringResource.uploadPhotos,
                        color: ColorResource.color494FDD,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: 8),
                      Image.asset(
                        ImageConstant.uploadIcon,
                        height: 24,
                        width: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 33),
            if (pickedImage != null) ...[
              Stack(
                children: [
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.file(
                      pickedImage,
                      height: 63,
                      width: 63,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: -14,
                    right: -14,
                    child: IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        cubit.removeImage();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
