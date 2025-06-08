import 'package:country_detector/country_detector.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:super_up/app/core/widgets/s_app_button.dart';
import 'package:super_up_core/super_up_core.dart';

import '../../home/mobile/settings_tab/views/sheet_for_choose_language.dart';
import '../social_login_auth.dart';

class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({super.key});

  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  // Constants
  static const double _horizontalPadding = 24.0;
  static const double _logoSize = 120.0;
  static const double _borderRadius = 16.0;
  static const String _defaultCountryCode = "US";

  // Controllers and instances
  final CountryDetector _countryDetector = CountryDetector();
  final PhoneController _phoneController = PhoneController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // State variables
  bool _isButtonActive = false;
  bool _isLoading = false;
  bool _isCountryDetected = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeCountryDetection();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final theme = AppTheme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: theme.background,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildSettingsRow(context),
                  const SizedBox(height: 39),
                  _buildHeader(context),
                  const SizedBox(height: 32),
                  _buildPhoneInput(context),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    _buildErrorMessage(context),
                  ],
                  const SizedBox(height: 48),
                  _buildSubmitButton(context),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the settings row with theme and language options
  Widget _buildSettingsRow(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Language Selector
        IconButton(
          onPressed: _showLanguageSelector,
          icon: Icon(
            Icons.language,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 8),
        // Theme Selector
        IconButton(
          onPressed: _showThemeSelector,
          icon: Icon(
            VThemeListener.I.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// Shows language selection bottom sheet
  void _showLanguageSelector() async {
    final res = await showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const SheetForChooseLanguage(),
    ) as ModelSheetItem?;
    if (res == null) {
      return;
    }

    await VLanguageListener.I.setLocal(Locale(res.id.toString()));
    await VAppPref.setStringKey(
      SStorageKeys.appLanguageTitle.name,
      res.title,
    );
  }

  /// Shows theme selection bottom sheet
  void _showThemeSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildThemeBottomSheet(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }

  /// Builds language selection bottom sheet
  Widget _buildLanguageBottomSheet() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).language,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          _buildLanguageOption('English', 'en', Icons.language),
          _buildLanguageOption('العربية', 'ar', Icons.language),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Builds theme selection bottom sheet
  Widget _buildThemeBottomSheet() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "selectTheme",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          _buildThemeOption("lightTheme", ThemeMode.light, Icons.light_mode),
          _buildThemeOption("darkTheme", ThemeMode.dark, Icons.dark_mode),
          _buildThemeOption("systemTheme", ThemeMode.system, Icons.auto_mode),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Builds language option tile
  Widget _buildLanguageOption(String title, String langCode, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = VLanguageListener.I.appLocal.languageCode == langCode;

    return ListTile(
      leading: Icon(icon, color: colorScheme.primary),
      title: Text(title),
      trailing:
          isSelected ? Icon(Icons.check, color: colorScheme.primary) : null,
      onTap: () {
        VLanguageListener.I.setLocal(Locale(langCode));
        Navigator.pop(context);
      },
    );
  }

  /// Builds theme option tile
  Widget _buildThemeOption(String title, ThemeMode themeMode, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = VThemeListener.I.appTheme == themeMode;

    return ListTile(
      leading: Icon(icon, color: colorScheme.primary),
      title: Text(title),
      trailing:
          isSelected ? Icon(Icons.check, color: colorScheme.primary) : null,
      onTap: () {
        VThemeListener.I.setTheme(themeMode);
        Navigator.pop(context);
      },
    );
  }

  /// Builds the header section with logo and text
  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        // Logo
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Image.asset(
              "assets/logo.png",
              height: _logoSize,
              width: _logoSize,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: _logoSize,
                  width: _logoSize,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    Icons.phone_android,
                    size: 60,
                    color: colorScheme.onPrimary,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 48),
        // Title
        Text(
          S.of(context).enterYourPhoneNumber,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        // Subtitle
        Text(
          S.of(context).weWillSendYouAVerificationCode,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Builds the phone input field
  Widget _buildPhoneInput(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: PhoneFormField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: S.of(context).phoneNumber,
            labelStyle: TextStyle(color: colorScheme.primary),
            helperText: _isCountryDetected ? null : "Detecting country",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_borderRadius),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_borderRadius),
              borderSide: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_borderRadius),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_borderRadius),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_borderRadius),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),
            filled: true,
            fillColor: Colors.transparent,
          ),
          validator: PhoneValidator.compose([
            PhoneValidator.required(context),
            PhoneValidator.validMobile(context),
          ]),
          countrySelectorNavigator:
              const CountrySelectorNavigator.draggableBottomSheet(),
          onChanged: _onPhoneNumberChanged,
          autofocus: true,
          countryButtonStyle: const CountryButtonStyle(
            showDialCode: true,
            showIsoCode: false,
            showFlag: true,
          ),
        ),
      ),
    );
  }

  /// Builds error message widget
  Widget _buildErrorMessage(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: colorScheme.onErrorContainer,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _errorMessage!,
              style: TextStyle(
                color: colorScheme.onErrorContainer,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the submit button
  Widget _buildSubmitButton(BuildContext context) {
    return AppButton(
      text: S.of(context).sendVerificationCode,
      onPressed: _isButtonActive && !_isLoading ? _handleSubmit : null,
    );
  }

  /// Initializes country detection
  Future<void> _initializeCountryDetection() async {
    try {
      // Gets country code in priority: SIM -> Network -> Locale
      final countryCode = await _countryDetector.isoCountryCode();

      if (mounted) {
        _phoneController.changeCountry(
          IsoCode.fromJson(countryCode ?? _defaultCountryCode),
        );
        setState(() {
          _isCountryDetected = true;
        });
      }
    } catch (error) {
      // Fallback to default country
      if (mounted) {
        _phoneController.changeCountry(IsoCode.fromJson(_defaultCountryCode));
        setState(() {
          _isCountryDetected = true;
        });
      }

      // Log error for debugging
      debugPrint('Country detection failed: $error');
    }
  }

  /// Handles phone number changes
  void _onPhoneNumberChanged(PhoneNumber phoneNumber) {
    setState(() {
      _isButtonActive = _validatePhoneNumber(phoneNumber);
      _errorMessage = null; // Clear error when user types
    });
  }

  /// Validates phone number
  bool _validatePhoneNumber(PhoneNumber phoneNumber) {
    return phoneNumber.isValid() && phoneNumber.nsn.isNotEmpty;
  }

  /// Handles form submission
  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final phone = _phoneController.value;
      final countryCode = "+${phone.countryCode}";
      final completeNumber = "$countryCode${phone.nsn}";

      // Validate one more time before submission
      if (!_validatePhoneNumber(phone)) {
        throw Exception("invalid Phone Number");
      }

      // Perform phone sign in
      await SocialLoginAuth.phoneSignIn(completeNumber);

      // Save phone preferences
      await _savePhonePreferences(countryCode, phone.isoCode.name);

      // Success - navigation should be handled by SocialLoginAuth
    } catch (error) {
      if (mounted) {
        setState(() {
          _errorMessage = _getErrorMessage(error);
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Saves phone preferences to storage
  Future<void> _savePhonePreferences(String countryCode, String isoCode) async {
    await Future.wait([
      VAppPref.setStringKey(SStorageKeys.phoneCountryKey.name, countryCode),
      VAppPref.setStringKey(SStorageKeys.countryCode.name, isoCode),
    ]);
  }

  /// Gets user-friendly error message
  String _getErrorMessage(dynamic error) {
    if (error.toString().contains('network')) {
      return S.of(context).networkError;
    } else if (error.toString().contains('invalid')) {
      return "invalid phone number";
    } else {
      return "somethingWentWrong";
    }
  }
}
