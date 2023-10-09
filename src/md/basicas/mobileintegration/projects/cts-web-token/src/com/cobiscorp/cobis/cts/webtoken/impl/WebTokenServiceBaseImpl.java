package com.cobiscorp.cobis.cts.webtoken.impl;

import com.cobiscorp.cobis.commons.converters.ByteConverter;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.webtoken.api.IWebTokenService;
import com.cobiscorp.cobis.cts.webtoken.util.TokenUtilJWT;
import io.jsonwebtoken.Claims;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by fervincent on 18/08/17.
 */
public abstract class WebTokenServiceBaseImpl  implements IWebTokenService {
    private static ILogger logger = LogFactory.getLogger(WebTokenServiceBaseImpl.class);

    private int channel;

    abstract protected String getAudience();

    public WebTokenServiceBaseImpl(int channel) {
        this.channel = channel;
    }
    protected Map<String, Object> getClaims(Map<String, Object> login) {
        Map<String, Object> claims = new HashMap<String, Object>();
        claims.put(IWebTokenService.USER, login.get(IWebTokenService.USER));
        claims.put(IWebTokenService.CHANNEL, login.get(IWebTokenService.CHANNEL));
        claims.put(IWebTokenService.SESSION_ID, login.get(IWebTokenService.SESSION_ID));
        return claims;
    }

    @Override
    public String generateToken(Map<String, Object> login) {
        return TokenUtilJWT.generateToken(getClaims(login), getAudience(), getSecret());

    }

    @Override
    public String generateToken(Map<String, Object> login, int expirationSeconds) {
        return TokenUtilJWT.generateToken(getClaims(login), getAudience(), getSecret(), expirationSeconds);

    }

    @Override
    public Map<String, Object> getProperties(String token) {
        return TokenUtilJWT.getClaimsFromToken(token, getSecret());
    }

    @Override
    public boolean isValidToken(String token) {
        //no es necesario validar la expiracion porque el getCalims valida internamet
        Claims claims = TokenUtilJWT.getClaimsFromToken(token, getSecret());
        if(claims == null) {
            return false;
        }
        Integer channelFromToken = claims.get("channel", Integer.class);
        boolean matchChannels = (channelFromToken == this.channel);
        return matchChannels;
    }

    /**
     * @return
     */
    private byte[] getSecret() {

        return Activator.getPrivateKey();
    }

    public Date getTimeNow() {
        return new Date();
    }

    @Override
    public String extractTokenFromBearerToken(String bearerToken) {
        if(bearerToken == null) {
            throw new COBISInfrastructureRuntimeException("Bearer token must not be null");
        }
        String token =  bearerToken.substring(7,bearerToken.length());
        return token;
    }

}
