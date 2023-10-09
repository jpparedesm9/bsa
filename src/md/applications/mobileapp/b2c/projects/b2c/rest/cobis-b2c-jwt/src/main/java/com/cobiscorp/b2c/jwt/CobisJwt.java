package com.cobiscorp.b2c.jwt;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;

public class CobisJwt {
    
	private static final String SUBJECT = "Cobiscorp B2C";
	private static final String ISSUER = "cobis-bt2-jwt";
	private static final String TOKEN_PAYLOAD_KEY = "cbsTokenPayload";
	private DateCalculator dateCalculator = new DateCalculator();

    private String jwsString;
    private Map<String, String> attributes = new HashMap<String, String>();

	private JwtKeyGenerator keyGenerator;

    public CobisJwt(String authorization, JwtKeyGenerator keyGenerator) throws TokenExpiredException, InvalidTokenException {
    	this.keyGenerator = keyGenerator;
        if (authorization!= null && !authorization.isEmpty()) {
            int indexOf = authorization.indexOf("Bearer ");
            if (indexOf > -1) {
                jwsString = authorization.substring(7, authorization.length());
            } else {
                jwsString = authorization;
            }
            initAttributes();
        }
    }
    
    private void initAttributes() throws TokenExpiredException, InvalidTokenException {
        Map<String, Object> payload = getPayload();
        Set<String> keySet = payload.keySet();
        for (String string : keySet) {
            addAttribute(string, (String) payload.get(string));
        }
        
    }

    public CobisJwt(JwtKeyGenerator keyGenerator) {
    	this.keyGenerator = keyGenerator;

    }
    
	public String generateJws() {
        JwtBuilder builder = Jwts.builder();
        builder.setSubject(SUBJECT).setExpiration(genExpirationDate()).setIssuer(ISSUER);
        if (!attributes.isEmpty()) {
            builder.claim(TOKEN_PAYLOAD_KEY, attributes);
        }
        jwsString = builder.signWith(keyGenerator.genKey()).compact();
        return jwsString;
	}

	private Date genExpirationDate() {
		return dateCalculator.addMinutes(new Date(), 20).getTime();
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> getPayload() throws TokenExpiredException, InvalidTokenException {
	    try {
	        return (Map<String, Object>) Jwts.parser().setSigningKey(keyGenerator.genKey()).parseClaimsJws(jwsString)
	                .getBody().get(TOKEN_PAYLOAD_KEY);
        } catch (ExpiredJwtException e) {
            throw new TokenExpiredException("Token expirado", e);
        } catch (Exception e) {
        	throw new InvalidTokenException(e.getMessage(), e);
		}
	}

	public JwtKeyGenerator getKeyGenerator() {
		return keyGenerator;
	}

	public void setKeyGenerator(JwtKeyGenerator keyGenerator) {
		this.keyGenerator = keyGenerator;
	}

    public String getCobisSessionid(String jws) throws TokenExpiredException, InvalidTokenException {
        Map<String, Object> returnPayload = getPayload();
        return (String) returnPayload.get("CID");
    }

    public void addAttribute(String key, String value) {
        attributes.put(key, value);
    }

    public String getAttribute(String string) throws TokenExpiredException, InvalidTokenException {
        Map<String, Object> payload = getPayload();
        if (payload != null && payload.containsKey(string))
            return (String) payload.get(string);
        else {
        	throw new InvalidTokenException(String.format("Attribute not found: %s", string));
        }
    }
    public boolean existAttribute(String string) throws TokenExpiredException, InvalidTokenException {
        Map<String, Object> payload = getPayload();
        return (payload != null && payload.containsKey(string));
    }
}
