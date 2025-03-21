import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorTheme
);

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorTheme
);

const lightColorTheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xffF83758), // Main brand color
    onPrimary: Color(0xffffffff), // Text/icon color on primary

    secondary: Color(0xffFF9AA2), // Soft complementary shade
    onSecondary: Color(0xff000000), // Text/icon color on secondary

    error: Color(0xffba1a1a), // Error color
    onError: Color(0xffffffff), // Text/icon color on error

    background: Color(0xffFFF3F4), // Light pinkish background to match primary
    onBackground: Color(0xff1a1a1a), // Text color on background

    surface: Color(0xffffffff), // Standard white surface for cards, dialogs, etc.
    onSurface: Color(0xff1a1a1a), // Text/icon color on surface
    onSurfaceVariant: Color(0xff333333),

    outline: Color(0xff626262), // border color, hint text
    outlineVariant: Color(0xffc0c8cc), // box shadow

    shadow: Color(0x668C8B8B),
);


const darkColorTheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xffF83758), // Keep primary color the same for brand consistency
    onPrimary: Color(0xffffffff), // Text/icon color on primary

    secondary: Color(0xffFF9AA2), // Soft complementary shade
    onSecondary: Color(0xff000000), // Text/icon color on secondary

    error: Color(0xffcf6679), // Slightly lighter error color for dark mode
    onError: Color(0xff000000), // Text/icon color on error

    background: Color(0xff121212), // Typical dark background
    onBackground: Color(0xffE0E0E0), // Light text color for readability

    surface: Color(0xff1E1E1E), // Darker surface color for cards, dialogs, etc.
    onSurface: Color(0xffE0E0E0), // Light text color on dark surfaces
    onSurfaceVariant: Color(0xffB0B0B0), // Softer contrast for secondary text/icons

    outline: Color(0xff50575c), // Borders, hint text in dark mode
    outlineVariant: Color(0xff383C40), // Subtle box shadows or secondary outlines

    shadow: Color(0x66000000), // Soft black shadow to match dark surfaces
);
