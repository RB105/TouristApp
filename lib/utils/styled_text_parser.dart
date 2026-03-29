import 'package:flutter/material.dart';

/// A utility class for parsing styled text with tags and placeholders.
class StyledTextParser {
  /// Parses a string with tags (e.g., [bold]text[/bold]) and placeholders (e.g., {name})
  /// into a TextSpan for RichText.
  ///
  /// [text]: The input string with tags and placeholders.
  /// [placeholders]: A map of placeholder keys to their replacement values.
  /// [tagStyles]: A map of tag names to TextStyle functions or styles.
  /// [defaultStyle]: The default TextStyle for the text.
  ///
  /// Example:
  /// StyledTextParser.parse(
  ///   "Hello [bold]{name}[/bold], welcome!",
  ///   placeholders: {'name': 'John'},
  ///   tagStyles: {'bold': (style) => style.copyWith(fontWeight: FontWeight.bold)},
  ///   defaultStyle: TextStyle(fontSize: 16),
  /// );
  static TextSpan parse(
    String text, {
    Map<String, String> placeholders = const {},
    Map<String, TextStyle Function(TextStyle)> tagStyles = const {},
    required TextStyle defaultStyle,
  }) {
    // First, replace placeholders
    String processedText = text;
    placeholders.forEach((key, value) {
      processedText = processedText.replaceAll('{$key}', value);
    });

    // Now parse tags
    return _parseTags(processedText, tagStyles, defaultStyle);
  }

  static TextSpan _parseTags(
    String text,
    Map<String, TextStyle Function(TextStyle)> tagStyles,
    TextStyle defaultStyle,
  ) {
    final List<TextSpan> spans = [];
    final RegExp tagRegExp = RegExp(r'\[(\w+)\](.*?)\[/\1\]');
    int lastIndex = 0;

    for (final match in tagRegExp.allMatches(text)) {
      // Add text before the tag
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: text.substring(lastIndex, match.start),
          style: defaultStyle,
        ));
      }

      // Add the styled text
      final tag = match.group(1)!;
      final content = match.group(2)!;
      final styleFunction = tagStyles[tag];
      final styledStyle = styleFunction != null
          ? styleFunction(defaultStyle)
          : defaultStyle;

      // Recursively parse nested tags if any
      spans.add(_parseTags(content, tagStyles, styledStyle));

      lastIndex = match.end;
    }

    // Add remaining text
    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
        style: defaultStyle,
      ));
    }

    return TextSpan(children: spans);
  }
}
