# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile


#Lib Core
-keep public class com.bayteq.libcore.** {
  public protected *;
}
-keep class com.bayteq.libcore.R$* { *; }
-keep public class com.bayteq.thridparty.** { *; }
-dontwarn com.bayteq.libcore.persistence.internal.cipher.AndroidSQLCipherSQLite

#APP
-keep class com.cobis.tuiiob2c.data.models.** { *; }
-keep class com.cobis.tuiiob2c.R$* { *; }
-keep class com.cobis.tuiiob2c.widgets.** { *; }
-keep class com.cobis.tuiiob2c.services.modules.** { *; }
