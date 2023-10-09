package com.cobis.gestionasesores.utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.typeadapters.RuntimeTypeAdapterFactory;

/**
 * Created by mnaunay on 22/06/2017.
 */

public final class GsonHelper {
    private GsonHelper(){}

    private static final GsonBuilder gsonBuilder = new GsonBuilder();

    public static void registerType(RuntimeTypeAdapterFactory<?> adapter) {
        gsonBuilder.registerTypeAdapterFactory(adapter);
    }

    public static GsonBuilder getBuilder() {
        return gsonBuilder;
    }

    public static Gson getGson() {
        return gsonBuilder.create();
    }
}
