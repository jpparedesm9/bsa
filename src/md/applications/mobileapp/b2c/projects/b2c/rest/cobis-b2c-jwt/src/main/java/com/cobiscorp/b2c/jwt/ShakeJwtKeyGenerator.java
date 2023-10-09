package com.cobiscorp.b2c.jwt;

import java.security.Key;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Service;

import io.jsonwebtoken.security.Keys;

@Component
@Service({JwtKeyGenerator.class})
public class ShakeJwtKeyGenerator implements JwtKeyGenerator {

	private static final String ALGN_PATH = "/CTS_MF/plugins/channels/MB/seed";

	private AlgnReader algnReader = new AlgnReader(ALGN_PATH);
	
    public Key genKey() {
        return Keys.hmacShaKeyFor(algnReader.readSeed().getBytes());
    }

}
