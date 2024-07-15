part of 'financial_bloc.dart';

@immutable
sealed class FinancialEvent {}

final class CallFinancialEvent extends FinancialEvent {}

final class CallMoneyEvent extends FinancialEvent {
  final String price;

  CallMoneyEvent({required this.price});
}
