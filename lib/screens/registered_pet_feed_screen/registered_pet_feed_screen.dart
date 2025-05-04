import 'package:cat_register/entity/pet_detail_entity.dart';
import 'package:cat_register/screens/register_pet_form_screen/cubit/register_pet_form_screen_cubit.dart';
import 'package:cat_register/screens/register_pet_form_screen/register_pet_form_screen.dart';
import 'package:cat_register/screens/registered_pet_feed_screen/cubit/registered_pet_feed_screen_cubit.dart';
import 'package:cat_register/screens/registered_pet_feed_screen/cubit/registered_pet_feed_screen_state.dart';
import 'package:cat_register/utils/color_resource.dart';
import 'package:cat_register/utils/enum.dart';
import 'package:cat_register/utils/image_constant.dart';
import 'package:cat_register/utils/string_resource.dart';
import 'package:cat_register/widget/custom_button.dart';
import 'package:cat_register/widget/custom_scaffold.dart';
import 'package:cat_register/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisteredPetFeedScreen extends StatelessWidget {
  const RegisteredPetFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<
        RegisteredPetFeedScreenCubit,
        RegisteredPetFeedScreenState
      >(
        builder: (context, state) {
          final isLoading = state is RegisteredPetFeedScreenLoadingState;
          final List<PetDetailEntity> petList =
              state is RegisteredPetFeedScreenLoadedState ? state.petList : [];

          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (petList.isEmpty && isLoading)
                    _PetFormEmptyState()
                  else if (!isLoading)
                    _PetFormList(petList: petList),
                  _AddNewPetButton(),
                  const SizedBox(height: 24),
                ],
              ),
              if (isLoading) const Center(child: CircularProgressIndicator()),
            ],
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 29, 20, 10),
        child: GridView.builder(
          itemCount: petList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 14,
            childAspectRatio: 171 / 162,
          ),
          itemBuilder: (context, index) {
            return _PetProfileCard(petDetail: petList[index]);
          },
        ),
      ),
    );
  }
}

class _AddNewPetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: double.infinity,
        child: CustomButton(
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
        ),
      ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PetImageWithGender(petDetail: petDetail),
          const SizedBox(height: 9),
          _buildPetName(),
          const SizedBox(height: 9),
          _buildPetLocation(),
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
      child: SizedBox(width: 39, height: 37),
    ),
  );

  Widget _genderBadge(PetGenderEnum genderType) => Positioned(
    bottom: 3,
    right: 3,
    child: CircleAvatar(
      radius: 12.5,
      backgroundColor: genderType.bgColor,
      child: Image.asset(genderType.image),
    ),
  );

  Widget _likeIcon() => Positioned(
    top: 5,
    right: 5,
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
