import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/theme/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class SearchBarApp extends StatelessWidget {
  const SearchBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this TextField Widget...
        Padding(
      padding: const EdgeInsets.all(0),
      child: TextFormField(
        // controller: _model.textController,
        // focusNode: _model.textFieldFocusNode,
        onFieldSubmitted: (_) async {},
        autofocus: false,
        obscureText: false,
        decoration: InputDecoration(
          labelText: 'Search health issues...',
          labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'Poppins',
                fontSize: TSizes.fontSizeSm,
                letterSpacing: 0.0,
              ),
          hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'Poppins',
                letterSpacing: 0.0,
              ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: TColors.textPrimary,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).primary,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).error,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).error,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
          prefixIcon: const Icon(
            Icons.search,
            size: 18,
          ),
        ),
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Poppins',
              letterSpacing: 0.0,
            ),
        // validator: _model.textControllerValidator.asValidator(context),
      ),
    );
  }
}
