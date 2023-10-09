package com.cobis.gestionasesores.utils;

import com.bayteq.libcore.util.URLUTF8Encoder;

/**
 * Google Static Map Helper
 * Created by mnaunay on 14/06/2017.
 */

public final class GoogleMapsUtil {
    public static final String GOOGLE_STATIC_MAP = "https://maps.googleapis.com/maps/api/staticmap?";//center=#address&zoom=14&size=200x200&key=#api";
    private static final int DEFAULT_WIDTH = 400;
    private static final int DEFAULT_HEIGHT = 400;
    private static final int DEFAULT_ZOOM = 15;


    private static GoogleMapsUtil INSTANCE;

    public static GoogleMapsUtil getInstance() {
        if(INSTANCE==null){
            INSTANCE = new GoogleMapsUtil();
        }
        return INSTANCE;
    }

    private GoogleMapsUtil() {
    }

    public synchronized String buildStaticMap(String address,String key){
        return buildStaticMap(address,DEFAULT_WIDTH,DEFAULT_HEIGHT,DEFAULT_ZOOM,key);
    }

    public synchronized String buildStaticMap(String address,int width, int height,int zoom,String key){
        StringBuffer buffer = new StringBuffer(GOOGLE_STATIC_MAP);
        buffer.append("zoom="+zoom);
        buffer.append("&size=" + width+"x"+height);
        buffer.append("&markers="+ URLUTF8Encoder.encode("color:red|"+address));
        buffer.append("&key=" +key);
        return buffer.toString();
    }
}