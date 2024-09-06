import 'package:demo_apk/data/dio/my_dio.dart';
import 'package:demo_apk/domain/inputs/general.dart';
import 'package:demo_apk/domain/inputs/inputs.dart';
import 'package:demo_apk/presentation/providers/account/account_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final accountFormLoginProvider = StateNotifierProvider.autoDispose<
    AccountFormLoginNotifier, AccountFormLoginState>((ref) {
  return AccountFormLoginNotifier(ref.read(accountProvider.notifier));
});

class AccountFormLoginNotifier extends StateNotifier<AccountFormLoginState> {
  AccountFormLoginNotifier(this._accountNotifier)
      : super(AccountFormLoginState());

  final AccountNotifier _accountNotifier;

  void usernameXemailChanged(String value) {
    final usernameXemail = GeneralInput.dirty(value);
    state = state.copyWith(
        usernameXemail: usernameXemail,
        isvalid: validateForm(usernameXemail: usernameXemail));
  }

  void passwordChanged(String value) {
    final password = GeneralInput.dirty(value);
    state = state.copyWith(
        password: password, isvalid: validateForm(password: password));
  }

  void toggleObscurePassword() {
    state = state.copyWith(isObscurePassword: !state.isObscurePassword);
  }

  bool validateForm({
    GeneralInput? usernameXemail,
    GeneralInput? password,
  }) =>
      Formz.validate([
        usernameXemail ?? state.usernameXemail,
        password ?? state.password,
      ]);

  Future<String> onSubmit() async {
    try {
      state = state.copyWith(
          formStatus: FormStatus.validating,
          usernameXemail: GeneralInput.dirty(state.usernameXemail.value),
          password: GeneralInput.dirty(state.password.value),
          isvalid: validateForm(),
          isFormDirty: true);

      if (!state.isvalid) {
        state = state.copyWith(formStatus: FormStatus.invalid);
        return "412";
      }

      int code = await _accountNotifier.login(
          usernameXemail: state.usernameXemail.realValue,
          password: state.password.realValue);

      state = state.copyWith(formStatus: FormStatus.invalid);
      return code.toString();
    } on CustomDioError catch (e) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return e.message ?? "Ha ocurrido un error";
    } catch (e) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return "";
    }
  }
}

class AccountFormLoginState {
  final FormStatus formStatus;
  final bool isvalid;
  final bool isFormDirty;

  final GeneralInput usernameXemail;
  final GeneralInput password;

  final bool isObscurePassword;

  AccountFormLoginState({
    this.formStatus = FormStatus.invalid,
    this.isvalid = false,
    this.isFormDirty = false,
    this.usernameXemail = const GeneralInput.pure(),
    this.password = const GeneralInput.pure(),
    this.isObscurePassword = true,
  });

  AccountFormLoginState copyWith({
    FormStatus? formStatus,
    bool? isvalid,
    bool? isFormDirty,
    GeneralInput? usernameXemail,
    GeneralInput? password,
    bool? isObscurePassword,
  }) {
    return AccountFormLoginState(
      formStatus: formStatus ?? this.formStatus,
      isvalid: isvalid ?? this.isvalid,
      isFormDirty: isFormDirty ?? this.isFormDirty,
      usernameXemail: usernameXemail ?? this.usernameXemail,
      password: password ?? this.password,
      isObscurePassword: isObscurePassword ?? this.isObscurePassword,
    );
  }
}
