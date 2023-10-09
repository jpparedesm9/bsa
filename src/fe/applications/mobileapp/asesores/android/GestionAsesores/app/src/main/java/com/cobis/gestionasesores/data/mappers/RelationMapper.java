package com.cobis.gestionasesores.data.mappers;

import com.bayteq.libcore.logs.Log;

import io.reactivex.annotations.Nullable;

/**
 * Created by bqtdesa02 on 9/29/2017.
 */

public class RelationMapper {

    @Nullable
    public static String getCorelation(String relationType){
        switch (relationType){
            case "210": // hijo
                return "211";
            case "211": // padre
                return "210";
            case "212": // hermano
                return relationType;
            default:
                Log.e("RelationMapper: relationType does not exist: " + relationType);
                return null;
        }
    }
}
