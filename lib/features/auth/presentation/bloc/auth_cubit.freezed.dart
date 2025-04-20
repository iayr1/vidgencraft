// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// @nodoc


class _Initial implements AuthState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.initial()';
}


}




/// @nodoc


class _SendingOtp implements AuthState {
  const _SendingOtp();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendingOtp);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.sendingOtp()';
}


}




/// @nodoc


class _SentOtp implements AuthState {
  const _SentOtp(this.response);
  

 final  SignUpResponseModel response;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SentOtpCopyWith<_SentOtp> get copyWith => __$SentOtpCopyWithImpl<_SentOtp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SentOtp&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'AuthState.sentOtp(response: $response)';
}


}

/// @nodoc
abstract mixin class _$SentOtpCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$SentOtpCopyWith(_SentOtp value, $Res Function(_SentOtp) _then) = __$SentOtpCopyWithImpl;
@useResult
$Res call({
 SignUpResponseModel response
});




}
/// @nodoc
class __$SentOtpCopyWithImpl<$Res>
    implements _$SentOtpCopyWith<$Res> {
  __$SentOtpCopyWithImpl(this._self, this._then);

  final _SentOtp _self;
  final $Res Function(_SentOtp) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_SentOtp(
null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as SignUpResponseModel,
  ));
}


}

/// @nodoc


class _SendOtpError implements AuthState {
  const _SendOtpError(this.error);
  

 final  String error;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendOtpErrorCopyWith<_SendOtpError> get copyWith => __$SendOtpErrorCopyWithImpl<_SendOtpError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendOtpError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'AuthState.sendOtpError(error: $error)';
}


}

/// @nodoc
abstract mixin class _$SendOtpErrorCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$SendOtpErrorCopyWith(_SendOtpError value, $Res Function(_SendOtpError) _then) = __$SendOtpErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class __$SendOtpErrorCopyWithImpl<$Res>
    implements _$SendOtpErrorCopyWith<$Res> {
  __$SendOtpErrorCopyWithImpl(this._self, this._then);

  final _SendOtpError _self;
  final $Res Function(_SendOtpError) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_SendOtpError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoggingIn implements AuthState {
  const _LoggingIn();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoggingIn);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loggingIn()';
}


}




/// @nodoc


class _LoggedIn implements AuthState {
  const _LoggedIn(this.response);
  

 final  LoginResponseModel response;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoggedInCopyWith<_LoggedIn> get copyWith => __$LoggedInCopyWithImpl<_LoggedIn>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoggedIn&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'AuthState.loggedIn(response: $response)';
}


}

/// @nodoc
abstract mixin class _$LoggedInCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$LoggedInCopyWith(_LoggedIn value, $Res Function(_LoggedIn) _then) = __$LoggedInCopyWithImpl;
@useResult
$Res call({
 LoginResponseModel response
});




}
/// @nodoc
class __$LoggedInCopyWithImpl<$Res>
    implements _$LoggedInCopyWith<$Res> {
  __$LoggedInCopyWithImpl(this._self, this._then);

  final _LoggedIn _self;
  final $Res Function(_LoggedIn) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_LoggedIn(
null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as LoginResponseModel,
  ));
}


}

/// @nodoc


class _LoginError implements AuthState {
  const _LoginError(this.error);
  

 final  String error;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginErrorCopyWith<_LoginError> get copyWith => __$LoginErrorCopyWithImpl<_LoginError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'AuthState.loginError(error: $error)';
}


}

/// @nodoc
abstract mixin class _$LoginErrorCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$LoginErrorCopyWith(_LoginError value, $Res Function(_LoginError) _then) = __$LoginErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class __$LoginErrorCopyWithImpl<$Res>
    implements _$LoginErrorCopyWith<$Res> {
  __$LoginErrorCopyWithImpl(this._self, this._then);

  final _LoginError _self;
  final $Res Function(_LoginError) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_LoginError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResettingPassword implements AuthState {
  const _ResettingPassword();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResettingPassword);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.resettingPassword()';
}


}




/// @nodoc


class _ResetPasswordSuccess implements AuthState {
  const _ResetPasswordSuccess(this.response);
  

 final  ResetPasswordResponseModel response;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResetPasswordSuccessCopyWith<_ResetPasswordSuccess> get copyWith => __$ResetPasswordSuccessCopyWithImpl<_ResetPasswordSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetPasswordSuccess&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'AuthState.resetPasswordSuccess(response: $response)';
}


}

/// @nodoc
abstract mixin class _$ResetPasswordSuccessCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$ResetPasswordSuccessCopyWith(_ResetPasswordSuccess value, $Res Function(_ResetPasswordSuccess) _then) = __$ResetPasswordSuccessCopyWithImpl;
@useResult
$Res call({
 ResetPasswordResponseModel response
});




}
/// @nodoc
class __$ResetPasswordSuccessCopyWithImpl<$Res>
    implements _$ResetPasswordSuccessCopyWith<$Res> {
  __$ResetPasswordSuccessCopyWithImpl(this._self, this._then);

  final _ResetPasswordSuccess _self;
  final $Res Function(_ResetPasswordSuccess) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_ResetPasswordSuccess(
null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as ResetPasswordResponseModel,
  ));
}


}

/// @nodoc


class _ResetPasswordError implements AuthState {
  const _ResetPasswordError(this.error);
  

 final  String error;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResetPasswordErrorCopyWith<_ResetPasswordError> get copyWith => __$ResetPasswordErrorCopyWithImpl<_ResetPasswordError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetPasswordError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'AuthState.resetPasswordError(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ResetPasswordErrorCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$ResetPasswordErrorCopyWith(_ResetPasswordError value, $Res Function(_ResetPasswordError) _then) = __$ResetPasswordErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class __$ResetPasswordErrorCopyWithImpl<$Res>
    implements _$ResetPasswordErrorCopyWith<$Res> {
  __$ResetPasswordErrorCopyWithImpl(this._self, this._then);

  final _ResetPasswordError _self;
  final $Res Function(_ResetPasswordError) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_ResetPasswordError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _VerifyingOtp implements AuthState {
  const _VerifyingOtp();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyingOtp);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.verifyingOtp()';
}


}




/// @nodoc


class _VerifiedOtp implements AuthState {
  const _VerifiedOtp(this.response);
  

 final  VerifyOtpResponseModel response;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifiedOtpCopyWith<_VerifiedOtp> get copyWith => __$VerifiedOtpCopyWithImpl<_VerifiedOtp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifiedOtp&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'AuthState.verifiedOtp(response: $response)';
}


}

/// @nodoc
abstract mixin class _$VerifiedOtpCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$VerifiedOtpCopyWith(_VerifiedOtp value, $Res Function(_VerifiedOtp) _then) = __$VerifiedOtpCopyWithImpl;
@useResult
$Res call({
 VerifyOtpResponseModel response
});




}
/// @nodoc
class __$VerifiedOtpCopyWithImpl<$Res>
    implements _$VerifiedOtpCopyWith<$Res> {
  __$VerifiedOtpCopyWithImpl(this._self, this._then);

  final _VerifiedOtp _self;
  final $Res Function(_VerifiedOtp) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_VerifiedOtp(
null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as VerifyOtpResponseModel,
  ));
}


}

/// @nodoc


class _VerifyOtpError implements AuthState {
  const _VerifyOtpError(this.error);
  

 final  String error;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpErrorCopyWith<_VerifyOtpError> get copyWith => __$VerifyOtpErrorCopyWithImpl<_VerifyOtpError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtpError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'AuthState.verifyOtpError(error: $error)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpErrorCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$VerifyOtpErrorCopyWith(_VerifyOtpError value, $Res Function(_VerifyOtpError) _then) = __$VerifyOtpErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class __$VerifyOtpErrorCopyWithImpl<$Res>
    implements _$VerifyOtpErrorCopyWith<$Res> {
  __$VerifyOtpErrorCopyWithImpl(this._self, this._then);

  final _VerifyOtpError _self;
  final $Res Function(_VerifyOtpError) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_VerifyOtpError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _VerifyingToken implements AuthState {
  const _VerifyingToken();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyingToken);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.verifyingToken()';
}


}




/// @nodoc


class _VerifiedToken implements AuthState {
  const _VerifiedToken(this.response);
  

 final  VerifyResponseModel response;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifiedTokenCopyWith<_VerifiedToken> get copyWith => __$VerifiedTokenCopyWithImpl<_VerifiedToken>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifiedToken&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'AuthState.verifiedToken(response: $response)';
}


}

/// @nodoc
abstract mixin class _$VerifiedTokenCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$VerifiedTokenCopyWith(_VerifiedToken value, $Res Function(_VerifiedToken) _then) = __$VerifiedTokenCopyWithImpl;
@useResult
$Res call({
 VerifyResponseModel response
});




}
/// @nodoc
class __$VerifiedTokenCopyWithImpl<$Res>
    implements _$VerifiedTokenCopyWith<$Res> {
  __$VerifiedTokenCopyWithImpl(this._self, this._then);

  final _VerifiedToken _self;
  final $Res Function(_VerifiedToken) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_VerifiedToken(
null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as VerifyResponseModel,
  ));
}


}

/// @nodoc


class _VerifyTokenError implements AuthState {
  const _VerifyTokenError(this.error);
  

 final  String error;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyTokenErrorCopyWith<_VerifyTokenError> get copyWith => __$VerifyTokenErrorCopyWithImpl<_VerifyTokenError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyTokenError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'AuthState.verifyTokenError(error: $error)';
}


}

/// @nodoc
abstract mixin class _$VerifyTokenErrorCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$VerifyTokenErrorCopyWith(_VerifyTokenError value, $Res Function(_VerifyTokenError) _then) = __$VerifyTokenErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class __$VerifyTokenErrorCopyWithImpl<$Res>
    implements _$VerifyTokenErrorCopyWith<$Res> {
  __$VerifyTokenErrorCopyWithImpl(this._self, this._then);

  final _VerifyTokenError _self;
  final $Res Function(_VerifyTokenError) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_VerifyTokenError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
