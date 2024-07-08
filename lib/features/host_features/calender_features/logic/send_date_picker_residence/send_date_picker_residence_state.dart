part of 'send_date_picker_residence_bloc.dart';

@immutable
sealed class SendDatePickerResidenceState {}

final class SendDatePickerResidenceInitial
    extends SendDatePickerResidenceState {}

final class SendDatePickerResidenceLoadingState
    extends SendDatePickerResidenceState {}

final class SendDatePickerResidenceCompletedState
    extends SendDatePickerResidenceState {
  final String success;

  SendDatePickerResidenceCompletedState({required this.success});
}

final class SendDatePickerResidenceErrorState
    extends SendDatePickerResidenceState {
  final String errorMessage;

  SendDatePickerResidenceErrorState({required this.errorMessage});
}

///GetRegisterResidenceUserLoading
final class GetRegisterResidenceUserLoading
    extends SendDatePickerResidenceState {}

final class GetRegisterResidenceUserCompleted
    extends SendDatePickerResidenceState {
  final List<AllDateModel> allDateModel;

  GetRegisterResidenceUserCompleted({required this.allDateModel});
}

final class GetRegisterResidenceUserError extends SendDatePickerResidenceState {
  final String errorMessage;

  GetRegisterResidenceUserError({required this.errorMessage});
}
