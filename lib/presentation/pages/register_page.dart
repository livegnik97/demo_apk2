import 'package:demo_apk/core/helpers/custom_context.dart';
import 'package:demo_apk/core/helpers/snackbar_gi%20copy.dart';
import 'package:demo_apk/core/router/router_path.dart';
import 'package:demo_apk/domain/inputs/inputs.dart';
import 'package:demo_apk/main.dart';
import 'package:demo_apk/presentation/providers/account/account_form_login_provider.dart';
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

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      SnackBarGI.showWithIcon(context,
          icon: Icons.warning_amber_outlined, text: "En desarrollo");
    }

    return BezierBackground(
      btnBack: true,
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
                Hero(
                  tag: "open-register-page",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.datosPersonales,
                        style: context.titleLarge
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        indent: 40,
                        endIndent: 40,
                        height: 40,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.text,
                        hint: AppLocalizations.of(context)!.correoEjemplo,
                        label: AppLocalizations.of(context)!.usuarioCorreo,
                      ),
                      const CustomTextFormField(
                        keyboardType: TextInputType.text,
                        hint: "Nombre",
                        label: "Nombre",
                      ),
                      const CustomTextFormField(
                        keyboardType: TextInputType.text,
                        hint: "Apellidos",
                        label: "Apellidos",
                      ),
                      const CustomTextFormField(
                        keyboardType: TextInputType.multiline,
                        hint: "Otra información",
                        label: "Otra información",
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      CustomGradientButton(
                          label: AppLocalizations.of(context)!.registrar,
                          onPressed: () {
                            onSubmit();
                          }),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
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
              // context.push(RouterPath.AUTH_REGISTER_PAGE);
            })
      ],
    );
  }
}
