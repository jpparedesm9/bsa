package com.cobiscorp.cobis.cts.webtoken.api;

import java.util.Map;

/**
 * Created by fervincent on 18/08/17.
 */
public interface IWebTokenService {
    String CHANNEL = "channel";
    String USER = "user";
    String SESSION_ID = "sessionId";
    int MOBILE_OFFICIAL_CHANNEL = 20;
    int MOBILE_BANKING_CHANNEL = 10;
    String BEARER = "Bearer";

    String generateToken(Map<String, Object> login);

    String generateToken(Map<String, Object> login, int expirationSeconds);

    Map getProperties(String token);

    boolean isValidToken(String token);

    String extractTokenFromBearerToken(String bearerToken);
}
