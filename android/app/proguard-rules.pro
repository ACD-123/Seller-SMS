# Keep all Firebase-related classes
-keep class com.google.firebase.** { *; }

# Suppress warnings about Firebase-related classes
-dontwarn com.google.firebase.**
-keep class com.google.firebase.messaging.** { *; }