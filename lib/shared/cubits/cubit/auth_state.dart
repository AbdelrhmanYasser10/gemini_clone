part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}


final class RegisterLoading extends AuthState{}
final class RegisterSuccess extends AuthState{}
final class RegisterError extends AuthState{}

final class LoginLoading extends AuthState{}
final class LoginSuccess extends AuthState{}
final class LoginError extends AuthState{}
