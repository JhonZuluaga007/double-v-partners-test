import 'package:flutter/material.dart';

/// A reusable action button widget that provides consistent styling and behavior.
///
/// This widget encapsulates the common functionality of action buttons used
/// throughout the application, such as form submission buttons, confirmation
/// buttons, and other primary actions.
///
/// The widget supports:
/// - Customizable text and icons
/// - Enabled/disabled states
/// - Full-width or auto-width sizing
/// - Custom styling and padding
/// - Predefined constructors for common use cases
///
/// Example usage:
/// ```dart
/// ActionButton.create(
///   onPressed: () => _submitForm(),
///   isEnabled: _isFormValid,
/// )
/// ```
class ActionButton extends StatelessWidget {
  /// The text displayed on the button
  final String text;

  /// The icon displayed on the button
  final IconData icon;

  /// Callback triggered when the button is pressed
  final VoidCallback? onPressed;

  /// Whether the button is enabled and can be pressed
  final bool isEnabled;

  /// Whether the button should take full available width
  final bool isFullWidth;

  /// Custom button styling
  final ButtonStyle? style;

  /// Custom padding for the button
  final EdgeInsetsGeometry? padding;

  /// Creates a new [ActionButton] with the specified properties.
  ///
  /// The [text] parameter is required and specifies the text displayed on the button.
  /// The [icon] parameter defaults to [Icons.check] if not specified.
  ///
  /// The button will be enabled by default and take full width unless specified otherwise.
  const ActionButton({
    super.key,
    required this.text,
    this.icon = Icons.check,
    this.onPressed,
    this.isEnabled = true,
    this.isFullWidth = true,
    this.style,
    this.padding,
  });

  /// Creates a selection confirmation button with predefined text and icon.
  ///
  /// This constructor creates a button specifically for confirming selections
  /// with the text "Confirmar Selección" and a check icon.
  const ActionButton.selection({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    this.isFullWidth = true,
    this.style,
    this.padding,
  }) : text = 'Confirmar Selección',
       icon = Icons.check;

  /// Creates a user creation button with predefined text and icon.
  ///
  /// This constructor creates a button specifically for creating users
  /// with the text "Crear Usuario" and a save icon.
  const ActionButton.create({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    this.isFullWidth = true,
    this.style,
    this.padding,
  }) : text = 'Crear Usuario',
       icon = Icons.save;

  /// Builds the action button widget with the specified configuration.
  ///
  /// This method creates a [FilledButton.icon] with the configured text and icon.
  /// If the button is disabled, the [onPressed] callback will be null.
  ///
  /// The button will be wrapped in a [SizedBox] with full width if [isFullWidth]
  /// is true, otherwise it will use its natural width.
  @override
  Widget build(BuildContext context) {
    final button = FilledButton.icon(
      onPressed: isEnabled ? onPressed : null,
      icon: Icon(icon),
      label: Text(text),
      style: style ?? _getDefaultStyle(),
    );

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  /// Returns the default button style with appropriate padding.
  ///
  /// This method provides a consistent default styling for the button,
  /// including vertical padding of 16 pixels if no custom padding is specified.
  ButtonStyle _getDefaultStyle() {
    return FilledButton.styleFrom(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
    );
  }
}
