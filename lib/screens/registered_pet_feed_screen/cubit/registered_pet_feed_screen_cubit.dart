import 'package:cat_register/repository/pet_repository.dart';
import 'package:cat_register/screens/registered_pet_feed_screen/cubit/registered_pet_feed_screen_state.dart';
import 'package:cat_register/utils/base_cubit.dart';
import 'package:cat_register/utils/string_resource.dart';

class RegisteredPetFeedScreenCubit
    extends BaseCubit<RegisteredPetFeedScreenState> {
  RegisteredPetFeedScreenCubit() : super(RegisteredPetFeedScreenInitState()) {
    init();
  }

  Future<void> init() async {
    emit(RegisteredPetFeedScreenLoadingState());

    final response = await PetRepository.fetchPetList();
    if (response.status != 200) {
      emit(
        RegisteredPetFeedScreenErrorState(
          errorMessage: response.error ?? StringResource.somethingWentWrong,
        ),
      );
      return;
    }
    emit(RegisteredPetFeedScreenLoadedState(petList: response.data ?? []));
  }
}
