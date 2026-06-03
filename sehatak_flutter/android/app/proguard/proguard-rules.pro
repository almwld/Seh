# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Agora
-keep class io.agora.** { *; }
-dontwarn io.agora.**

# Remove unused
-dontwarn com.google.android.gms.**
-dontwarn com.google.maps.**
-dontwarn com.squareup.okhttp.**
