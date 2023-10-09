package com.cobis.gestionasesores.infrastructure.jwt;

/**
 * Created by mnaunay on 22/08/2017.
 */

class JWTPayload {
    String deviceId;
    String sessionId;
    String channel;
    String user;
    long exp;

    public JWTPayload(String deviceId, String sessionId, String channel, String user, long exp) {
        this.deviceId = deviceId;
        this.sessionId = sessionId;
        this.channel = channel;
        this.user = user;
        this.exp = exp;
    }
}
