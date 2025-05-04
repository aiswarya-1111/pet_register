import 'dart:io';

import 'package:cat_register/screens/register_pet_form_screen/cubit/register_pet_form_screen_cubit.dart';
import 'package:cat_register/screens/register_pet_form_screen/cubit/resgister_pet_form_screen.state.dart';
import 'package:cat_register/screens/registered_pet_feed_screen/cubit/registered_pet_feed_screen_cubit.dart';
import 'package:cat_register/screens/registered_pet_feed_screen/registered_pet_feed_screen.dart';
import 'package:cat_register/utils/color_resource.dart';
import 'package:cat_register/utils/image_constant.dart';
import 'package:cat_register/utils/string_resource.dart';
import 'package:cat_register/widget/custom_appbar.dart';
import 'package:cat_register/widget/custom_button.dart';
import 'package:cat_register/widget/custom_drop_down.dart';
import 'package:cat_register/widget/custom_scaffold.dart';
import 'package:cat_register/widget/custom_text.dart';
import 'package:cat_register/widget/custom_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPetFormScreen extends StatelessWidget {
  const RegisterPetFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(ImageConstant.backIcon),
        ),
        title: StringResource.addYourPetDetail,
      ),
      body:
          BlocListener<RegisterPetFormScreenCubit, RegisterPetFormScreenState>(
            listener: (context, state) {
              if (state is RegisterPetFormScreenErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errorMessage,
                      style: TextStyle(color: Colors.white),
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
                          create: (context) => RegisteredPetFeedScreenCubit(),
                          child: RegisteredPetFeedScreen(),
                        ),
                  ),
                );
              }
            },
            child: PetProfileForm(),
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
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Your pet name'),
                    CustomTextField(
                      hintText: 'enter your pet name',
                      focusBorder: true,
                      borderWidth: 1,
                      borderRadius: 25,
                      controller: cubit.petNameController,
                    ),
                    _buildLabel('Your pet owner name'),
                    CustomTextField(
                      hintText: 'enter owner name',
                      controller: cubit.ownerNameController,
                      focusBorder: true,
                      borderWidth: 1,
                      borderRadius: 25,
                    ),
                    _buildLabel('Type of Pet'),
                    CustomDropDownWidget<String?>(
                      items: ['Dog', 'Cat', 'Bird', 'Rabbit', 'Other'],
                      selectedValue: null,
                      hintText: "ex. dog",
                      onChanged: (_) {},
                      displayName: (val) => val,
                    ),
                    _buildLabel('Gender'),
                    CustomDropDownWidget<String?>(
                      items: ['Male', 'Female'],
                      selectedValue: null,
                      hintText: "ex. dog",
                      onChanged: (_) {},
                      displayName: (val) => val,
                    ),
                    _buildLabel('Enter pet location'),
                    CustomTextField(
                      hintText: 'enter your pet location',
                      controller: cubit.locationController,
                      focusBorder: true,
                      borderWidth: 1,
                      borderRadius: 25,
                    ),
                    _buildLabel('Additional Notes'),
                    CustomTextField(
                      hintText: '',
                      maxLines: 5,
                      controller: cubit.notesController,
                      focusBorder: true,
                      borderWidth: 1,
                      borderRadius: 10,
                    ),
                    SizedBox(height: 30),
                    UploadPhotosWidget(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: CustomButton(
                label: "Submit",
                textFontSize: 18,
                textFontWeight: FontWeight.w500,
                onPressed: () {
                  cubit.addPetDetail();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 6),
    child: CustomText(
      text,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: ColorResource.color252525,
    ),
  );
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
      buildWhen:
          (prev, curr) =>
              curr is RegisterPetFormScreenLoadedState ||
              curr is RegisterPetFormRefreshState,
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              "Add your pet profile picture and upload pet photos",
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
                        "Upload Photos",
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
            Stack(
              children: [
                if (pickedImage != null) ...[
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
                    top: -8,
                    right: -8,
                    child: IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        cubit.removeImage();
                      },
                    ),
                  ),
                ],
              ],
            ),
          ],
        );
      },
    );
  }
}
