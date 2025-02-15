part of 'app_cubit_cubit.dart';

@immutable
sealed class AppCubitState {}

final class AppCubitInitial extends AppCubitState {}

final class GetChatIdSuccessfully extends AppCubitState {}

final class GetChatIdError extends AppCubitState {}


final class SendMessageSuccessfully extends AppCubitState {}
final class SendMessageWithError extends AppCubitState {}

final class GetGeminiResponseLoading extends AppCubitState {}
final class GetGeminiResponseSuccessfully extends AppCubitState {}
final class GetGeminiResponseError extends AppCubitState {}

final class GetAllMessagesSuccessfully extends AppCubitState {}
final class GetAllMessagesLoading extends AppCubitState {}

final class GetAllChatsSuccessfully extends AppCubitState {}
final class GetAllChatsLoading extends AppCubitState {}

final class GetResponseFromGeminiLoading extends AppCubitState {}
final class UserUploadImageLoading extends AppCubitState {}

final class GetImageSuccessfully extends AppCubitState {}
final class GetImageError extends AppCubitState {}
final class CropImageSuccessfully extends AppCubitState {}
final class RemoveImageFromMemory extends AppCubitState {}
