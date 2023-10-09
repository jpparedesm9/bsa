package com.cobiscorp.cobis.cts.webtoken.util;

/**
 * Created by fervincent on 18/08/17.
 */

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Calendar;
import java.util.Date;
import java.util.Map;

/**
 * Created by fervincent on 16/08/17.
 */
public class TokenUtilJWT {

    private final static ILogger LOGGER = LogFactory.getLogger(TokenUtilJWT.class);

    public static String generateToken(Map<String, Object> claims, String audience, byte[] secret, int expirationSeconds) {
        Date expirationDate = calculateExpirationDate(expirationSeconds).getTime();
        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("expirationDate " + expirationDate);
        }

        claims.putAll(claims);

        String token = Jwts.builder()
                .setAudience(audience)
                .setClaims(claims)
                .setExpiration(expirationDate)
                .signWith(SignatureAlgorithm.HS512, secret)
                .compact();
        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("generated token:" + token);
        }
        return token;
    }

    public static String generateToken(Map<String, Object> claims,
                                       String audience, byte[] secret) {
        return generateToken(claims, audience, secret, 3600);  // 1 hour default
    }

    protected static Calendar calculateExpirationDate(int expirationSeconds) {
        Calendar expirationDate = Calendar.getInstance();
        expirationDate.add(Calendar.SECOND, expirationSeconds);
        return expirationDate;
    }

    public static Claims getClaimsFromToken(String token, byte[] key) {
        Claims claims;
        try {
            claims = Jwts.parser()
                    .setSigningKey(key)
                    .parseClaimsJws(token)
                    .getBody();
        } catch (Exception e) {
            LOGGER.logError("invalid token:", e);
            return null;
        }
        return claims;
    }


    public static Boolean isExpiredToken(String token, byte[] key, Date now) {
        Claims claims = getClaimsFromToken(token, key);
        return isExpiredToken(claims, now);

    }

    public static Boolean isExpiredToken(Claims claims, Date now) {
        Date expiration = claims.getExpiration();
        return expiration.before(now);
    }


}
