package com.cobis.gestionasesores.data.enums;

import java.security.InvalidParameterException;

/**
 * Enum for genders types:
 *  <ul>
 *      <li>Code Server</li>
 *      <li>CURo code compute</li>
 *  </ul>
 * Created by mnaunay on 14/07/2017.
 */
public enum Gender {
    FEMALE("F","M"),
    MALE("M","H");

    private final String codeServer;
    private final String codeCurp;

    Gender(String codeServer, String codeCurp) {
        this.codeServer = codeServer;
        this.codeCurp = codeCurp;
    }

    public String getCodeServer() {
        return codeServer;
    }

    public String getCodeCurp() {
        return codeCurp;
    }

    public static Gender parseFromCodeServer(String codeServer){
        switch (codeServer){
            case "F":
                return FEMALE;
            case "M":
                return MALE;
            default:
                throw new InvalidParameterException("Code server not exist :-( "+codeServer);
        }
    }
}