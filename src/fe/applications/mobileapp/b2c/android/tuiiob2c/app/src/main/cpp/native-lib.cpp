#include <jni.h>
#include <string>

extern "C"
JNIEXPORT jstring JNICALL
Java_com_cobis_tuiiob2c_infraestructure_KManager_get1(JNIEnv *env, jobject instance) {
    std::string key = "\u0093¼jgfmsvn\u007Fcpbwrxmnkgl\u0091©jsdmsunitphtrfynmel\u008B¼jekmvenqspswrjo";
    return env->NewStringUTF(key.c_str());
}

extern "C"
JNIEXPORT jstring JNICALL
Java_com_cobis_tuiiob2c_infraestructure_KManager_get2(JNIEnv *env, jobject instance) {
    std::string key = "ÇÏb `tt\u0095^{\u0098z~v«v";
    return env->NewStringUTF(key.c_str());
}

extern "C"
JNIEXPORT jstring JNICALL
Java_com_cobis_tuiiob2c_infraestructure_KManager_get3(JNIEnv *env, jobject instance) {
    std::string key = "ÀàWf\u008Aj\u009F}\u0099\u00ADVqWXk_";
    return env->NewStringUTF(key.c_str());
}