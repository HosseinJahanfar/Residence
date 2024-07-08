part of 'send_date_picker_residence_bloc.dart';

@immutable
sealed class SendDatePickerResidenceEvent {}

final class CallSendDatePickerResidenceEvent
    extends SendDatePickerResidenceEvent {
  final String date;
  final int accommodation;
  final int defaultPrice;
  final int discountPercentage;

  CallSendDatePickerResidenceEvent(
      {required this.date,
      required this.accommodation,
      required this.defaultPrice,
      required this.discountPercentage});
}

final class CallGetRegisterResidenceUserEvent
    extends SendDatePickerResidenceEvent {
  final String id;

  CallGetRegisterResidenceUserEvent({required this.id});
}

/// delete date picker residence
final class CallDeleteDatePickerResidenceEvent
    extends SendDatePickerResidenceEvent {
  final String id;
  final int index;

  CallDeleteDatePickerResidenceEvent({
    required this.id,
    required this.index,
  });
}
