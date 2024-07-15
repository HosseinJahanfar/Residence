part of 'financial_bloc.dart';

@immutable
sealed class FinancialState {}

final class FinancialInitial extends FinancialState {}

/// call Get info  Financial
final class FinancialLoading extends FinancialState {}

final class FinancialCompleted extends FinancialState {
  final FinancialModel financialModel;

  FinancialCompleted({required this.financialModel});
}

final class FinancialError extends FinancialState {
  final String errorMessage;

  FinancialError({required this.errorMessage});
}

/// call send money  Financial

final class MoneyLoading extends FinancialState {}

final class MoneyCompleted extends FinancialState {
  final String msg;

  MoneyCompleted({required this.msg});
}

final class MoneyError extends FinancialState {
  final String errorMessage;

  MoneyError({required this.errorMessage});
}
