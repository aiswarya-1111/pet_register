import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_register/entity/pet_detail_entity.dart';
import 'package:pet_register/screens/register_pet_form_screen/cubit/register_pet_form_screen_cubit.dart';
import 'package:pet_register/screens/register_pet_form_screen/register_pet_form_screen.dart';
import 'package:pet_register/screens/registered_pet_feed_screen/cubit/registered_pet_feed_screen_cubit.dart';
import 'package:pet_register/screens/registered_pet_feed_screen/cubit/registered_pet_feed_screen_state.dart';
import 'package:pet_register/utils/color_resource.dart';
import 'package:pet_register/utils/enum.dart';
import 'package:pet_register/utils/image_constant.dart';
import 'package:pet_register/utils/string_resource.dart';
import 'package:pet_register/widget/custom_button.dart';
import 'package:pet_register/widget/custom_scaffold.dart';
import 'package:pet_register/widget/custom_text.dart';

class RegisteredPetFeedScreen extends StatelessWidget {
  const RegisteredPetFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisteredPetFeedScreenCubit>();
    return CustomScaffold(
      body: BlocConsumer<
        RegisteredPetFeedScreenCubit,
        RegisteredPetFeedScreenState
      >(
        listener: (context, state) {
          if (state is RegisteredPetFeedScreenErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomText(
                  state.errorMessage,
                  color: ColorResource.colorFFFFFF,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is RegisteredPetFeedScreenLoadingState;
          final List<PetDetailEntity> petList =
              state is RegisteredPetFeedScreenLoadedState ? state.petList : [];

          return RefreshIndicator(
            onRefresh: () => cubit.init(),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 29, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (petList.isEmpty || isLoading)
                        _PetFormEmptyState()
                      else
                        _PetFormList(petList: petList),
                      _AddNewPetButton(),
                    ],
                  ),
                ),

                if (isLoading) const Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PetFormList extends StatelessWidget {
  final List<PetDetailEntity> petList;
  const _PetFormList({required this.petList});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate item width to fit 2 columns with spacing
    final double itemWidth = (screenWidth - 20 * 2 - 14) / 2;

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              spacing: 14,
              runSpacing: 20,
              children:
                  petList.map((pet) {
                    return SizedBox(
                      width: itemWidth,
                      child: _PetProfileCard(petDetail: pet),
                    );
                  }).toList(),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _AddNewPetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: StringResource.addNewPet,
      textFontSize: 18,
      textFontWeight: FontWeight.w500,
      icon: Icon(Icons.add_box, color: ColorResource.color000000, size: 30),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => BlocProvider(
                  create: (context) => RegisterPetFormScreenCubit(),
                  child: RegisterPetFormScreen(),
                ),
          ),
        );
      },
    );
  }
}

class _PetProfileCard extends StatelessWidget {
  final PetDetailEntity petDetail;

  const _PetProfileCard({required this.petDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorResource.colorE8E8E8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PetImageWithGender(petDetail: petDetail),
          const SizedBox(height: 9),
          _buildPetName(),
          const SizedBox(height: 9),
          _buildPetLocation(),
          const SizedBox(height: 9),
        ],
      ),
    );
  }

  Widget _buildPetName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: CustomText(
        petDetail.petName,
        fontSize: 18,
        color: ColorResource.color262626,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildPetLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Row(
        children: [
          Image.asset(ImageConstant.locationIcon, width: 16, height: 16),
          const SizedBox(width: 4),
          Expanded(
            child: CustomText(
              petDetail.location,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              maxLines: 1,
              color: ColorResource.color5C5E5D,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _PetImageWithGender extends StatelessWidget {
  final PetDetailEntity petDetail;

  const _PetImageWithGender({required this.petDetail});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            child: Image.network(
              petDetail.imageUrl!,
              width: double.infinity,
              height: 106,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                return progress == null ? child : _loadingIndicator();
              },
              errorBuilder: (context, error, stackTrace) => _errorImage(),
            ),
          ),
        ),
        _bottomCornerOverlay(),
        _likeIcon(),
        _genderBadge(petDetail.gender!),
      ],
    );
  }

  Widget _loadingIndicator() => const SizedBox(
    height: 106,
    child: Center(child: CircularProgressIndicator()),
  );

  Widget _errorImage() => const SizedBox(
    height: 106,
    child: Center(child: Icon(Icons.info_outline, size: 48)),
  );

  Widget _bottomCornerOverlay() => const Positioned(
    bottom: 0,
    right: 0,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(23)),
      ),
      child: SizedBox(width: 37, height: 35),
    ),
  );

  Widget _genderBadge(PetGenderEnum genderType) => Positioned(
    bottom: 2,
    right: 3,
    child: CircleAvatar(
      radius: 14,
      backgroundColor: genderType.bgColor,
      child: Image.asset(genderType.image, alignment: Alignment.bottomCenter),
    ),
  );

  Widget _likeIcon() => Positioned(
    top: 14,
    right: 14,
    child: CircleAvatar(
      radius: 18,
      backgroundColor: ColorResource.colorF0F0F0,
      child: Icon(Icons.favorite, size: 20, color: Colors.white),
    ),
  );
}

class _PetFormEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset(ImageConstant.emptyState, height: 300)),
          const SizedBox(height: 24),
          CustomText(
            StringResource.emptyStateMessage,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorResource.color525252,
          ),
        ],
      ),
    );
  }
}
