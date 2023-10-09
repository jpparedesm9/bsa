#include <jni.h>
#include <string>

extern "C"
JNIEXPORT jstring

JNICALL
Java_com_cobis_gestionasesores_infrastructure_KManager_get1(
JNIEnv *env,
jobject /* this */) {
    std::string key = "æz\u0085\u009D\u0089\u0094\u0084\u008Aoª~_j\u0092hªyn}e\u009D¼\u009Av¡cn";
    return env->NewStringUTF(key.c_str());
}

extern "C"
JNIEXPORT jstring

JNICALL
Java_com_cobis_gestionasesores_infrastructure_KManager_get2(
        JNIEnv *env,
        jobject /* this */) {
    std::string key = "\u008AÐ`_WdU£d\u0091`hUc\\©f\u008Chg";
    return env->NewStringUTF(key.c_str());
}

extern "C"
JNIEXPORT jstring

JNICALL
Java_com_cobis_gestionasesores_infrastructure_KManager_get3(
        JNIEnv *env,
        jobject /* this */) {
    #ifdef DEV
        std::string key = "\u008B\u00ADafjxadfpdf`wifmunkg\u008D±bekjfrj{cjqiohmmj";
    #endif
    #ifdef SUST
        std::string key = "\u0090«s_sucdv\u007Fsmre|xyfpzt\u009E¹ssbgtghpsnfhqkyxm";
    #endif
    #ifdef PROD
        std::string key = "¼f`cthefqvoadjmzvimj©fdduium}qgthn{mmo";
    #endif
    return env->NewStringUTF(key.c_str());
}

extern "C"
JNIEXPORT jstring

JNICALL
Java_com_cobis_gestionasesores_infrastructure_KManager_get4(
        JNIEnv *env,
        jobject /* this */) {
    std::string key = "¨ß\u009Df}s\u0086\u009B\u0084gfzj\u0093\u0088t";
    return env->NewStringUTF(key.c_str());
}

extern "C"
JNIEXPORT jstring

JNICALL
Java_com_cobis_gestionasesores_infrastructure_KManager_get5(
        JNIEnv *env,
        jobject /* this */) {
    std::string key = "¹ \u0097\u0096o\u009D\u0083mux\u0091l\u0092\u007Fj\u0097£x¬y¯Ë¼\u0080©¥\u0089£ª\u008F`g";
    return env->NewStringUTF(key.c_str());
}

extern "C"
JNIEXPORT jstring

JNICALL
Java_com_cobis_gestionasesores_infrastructure_KManager_get6(
        JNIEnv *env,
        jobject /* this */) {
    std::string key = "\u008B\u00ADafjxadfpdf`wifmunkg\u008D±bekjfrj{cjqiohmmj";
    return env->NewStringUTF(key.c_str());
}