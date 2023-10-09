package com.cobis.gestionasesores.data.mappers;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.RiskLevel;

/**
 * Created by mnaunay on 31/08/2017.
 */

public final class RiskLevelMapper {
    @RiskLevel
    public static String fromRemote(String value) {
        value = StringUtils.nullToString(value).toUpperCase();
        switch (value) {
            case "VERDE":
                return RiskLevel.LOW;
            case "AMARILLO":
                return RiskLevel.MEDIUM;
            case "ROJO":
                return RiskLevel.HIGH;
            default:
                return null;
        }
    }


    public static String toRemote(@RiskLevel String value) {
        if(value == null) return null;
        switch (value) {
            case RiskLevel.LOW:
                return "VERDE";
            case RiskLevel.MEDIUM:
                return "AMARILLO";
            case RiskLevel.HIGH:
                return "ROJO";
            default:
                return value;
        }
    }
}
