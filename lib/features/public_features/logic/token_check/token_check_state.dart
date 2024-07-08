part of 'token_check_cubit.dart';

@immutable
sealed class TokenCheckState {}

final class TokenCheckInitial extends TokenCheckState {}

class TokenCheckIsLog extends TokenCheckState {}

class TokenCheckIsNotLog extends TokenCheckState {}