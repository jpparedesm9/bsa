#Javax and mail
-dontwarn javax.activation.**
-dontwarn javax.security.**
-dontwarn javax.xml.**
-dontwarn java.awt.**

-keep class javax.** {*;}
-keep class com.sun.** {*;}
-keep public class Mail {*;}