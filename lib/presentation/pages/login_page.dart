import 'package:demo_apk/core/helpers/custom_context.dart';
import 'package:demo_apk/core/helpers/snackbar_gi%20copy.dart';
import 'package:demo_apk/core/router/router_path.dart';
import 'package:demo_apk/domain/inputs/inputs.dart';
import 'package:demo_apk/main.dart';
import 'package:demo_apk/presentation/providers/account/account_form_login_provider.dart';
import 'package:demo_apk/presentation/providers/conectivity/connectivity_status_provider.dart';
import 'package:demo_apk/presentation/widgets/backgrounds/bezier_background.dart';
import 'package:demo_apk/presentation/widgets/buttons/custom_gradient_button.dart';
import 'package:demo_apk/presentation/widgets/buttons/custom_icon_button.dart';
import 'package:demo_apk/presentation/widgets/buttons/custom_text_button.dart';
import 'package:demo_apk/presentation/widgets/inputs/custom_text_form_field.dart';
import 'package:demo_apk/presentation/widgets/loadings/loading_logo.dart';
import 'package:demo_apk/presentation/widgets/shared/language_picker_horizontal.dart';
import 'package:demo_apk/presentation/widgets/shared/theme_change.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //* accountFormLoginProvider
    // ignore: unused_local_variable
    final connectivityStatus = ref.watch(connectivityStatusProvider);
    final accountFormLoginStatus = ref.watch(accountFormLoginProvider);

    void onSubmit() async {
      final code = await ref.read(accountFormLoginProvider.notifier).onSubmit();
      print("waka $code");
      if (code != "200") {
        switch (code) {
          case "412":
            // ignore: use_build_context_synchronously
            SnackBarGI.showWithIcon(context,
                icon: Icons.error_outline,
                text: AppLocalizations.of(context)!.camposConError);
            break;
          case "498":
            SnackBarGI.showWithIcon(context,
                icon: Icons.error_outline,
                text: AppLocalizations.of(context)!.compruebeConexion);
            break;
          default:
            SnackBarGI.showWithIcon(context,
                icon: Icons.error_outline,
                text: code.isEmpty
                    ? AppLocalizations.of(context)!.haOcurridoError
                    : code);
            if (code
                .toLowerCase()
                .contains("E-mail no verificado".toLowerCase())) {
              //* iría a la página de verificación de código
            }
        }
      } else {
        context.go(RouterPath.HOME_PAGE);
      }
    }

    return BezierBackground(
      child: FadeInUp(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: context.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 40),
                      const Align(
                          alignment: Alignment.centerRight,
                          child: ThemeChangeWidget(
                            color: Colors.white,
                          )),
                      const SizedBox(height: 8),
                      _title(context),
                      const SizedBox(height: 40),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      CustomTextFormField(
                        enabled: accountFormLoginStatus.formStatus !=
                            FormStatus.validating,
                        keyboardType: TextInputType.text,
                        hint: AppLocalizations.of(context)!.correoEjemplo,
                        label: AppLocalizations.of(context)!.usuarioCorreo,
                        initialValue:
                            accountFormLoginStatus.usernameXemail.value,
                        onFieldSubmitted: (_) {
                          if (accountFormLoginStatus.formStatus !=
                              FormStatus.validating) {
                            onSubmit();
                          }
                        },
                        onChanged: ref
                            .read(accountFormLoginProvider.notifier)
                            .usernameXemailChanged,
                        errorMessage: accountFormLoginStatus.isFormDirty
                            ? accountFormLoginStatus.usernameXemail
                                .errorMessage(context)
                            : null,
                      ),
                      CustomTextFormField(
                        enabled: accountFormLoginStatus.formStatus !=
                            FormStatus.validating,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: accountFormLoginStatus.isObscurePassword,
                        hint: "* * * * * *",
                        suffixIcon: CustomIconButton(
                            onPressed: ref
                                .read(accountFormLoginProvider.notifier)
                                .toggleObscurePassword,
                            icon: accountFormLoginStatus.isObscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                        label: AppLocalizations.of(context)!.password,
                        initialValue: accountFormLoginStatus.password.value,
                        onFieldSubmitted: (_) {
                          if (accountFormLoginStatus.formStatus !=
                              FormStatus.validating) {
                            onSubmit();
                          }
                        },
                        onChanged: ref
                            .read(accountFormLoginProvider.notifier)
                            .passwordChanged,
                        errorMessage: accountFormLoginStatus.isFormDirty
                            ? accountFormLoginStatus.password
                                .errorMessage(context)
                            : null,
                      ),
                      const SizedBox(height: 20),
                      accountFormLoginStatus.formStatus != FormStatus.validating
                          ? CustomGradientButton(
                              label: AppLocalizations.of(context)!.autenticar,
                              onPressed: () {
                                onSubmit();
                              })
                          : ZoomIn(
                              child: const SizedBox(
                                  width: double.infinity, child: LoadingLogo()),
                            ),
                      if (accountFormLoginStatus.formStatus !=
                          FormStatus.validating)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: CustomTextButton(
                              label:
                                  AppLocalizations.of(context)!.forgetPassword,
                              onPressed: () {
                                SnackBarGI.showWithIcon(context,
                                    icon: Icons.warning_amber_outlined,
                                    text: "En desarrollo");
                              }),
                        ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      if (accountFormLoginStatus.formStatus !=
                          FormStatus.validating)
                        _createAccountLabel(context, context.primary),
                      Hero(tag: "open-register-page", child: Container()),
                      const LanguagePickerHorizontal(),
                      const SizedBox(height: 20)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.login_rounded, size: 50, color: context.primary),
        Text(
          AppLocalizations.of(context)!.nameApp.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }

  Widget _createAccountLabel(BuildContext context, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.noTienesCuenta,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        CustomTextButton(
            label: AppLocalizations.of(context)!.registrar,
            onPressed: () {
              context.push(RouterPath.REGISTER_PAGE);
            })
      ],
    );
  }
}
