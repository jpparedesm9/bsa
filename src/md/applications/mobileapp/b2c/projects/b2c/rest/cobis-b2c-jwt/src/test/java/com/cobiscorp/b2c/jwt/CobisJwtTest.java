package com.cobiscorp.b2c.jwt;

import static org.mockito.Matchers.any;
import static org.mockito.Matchers.anyInt;
import static org.mockito.Mockito.when;

import java.util.Date;
import java.util.Map;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Spy;
import org.mockito.runners.MockitoJUnitRunner;
import org.powermock.reflect.Whitebox;

@RunWith(MockitoJUnitRunner.class)
public class CobisJwtTest extends BaseTest {

	// Usando private key
//	private static String EXPIRED_JWS = "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJDb2Jpc2NvcnAgQjJDIiwiZXhwIjoxNTQxNzA4NDAwLCJpc3MiOiJjb2Jpcy1idDItand0In0.bv7zkP1RiYYr_MNR5xnQIx00aQLMER1w6GdytA0pBEV46qx2pO7DqL7JAqajlAfLzAJQYt6iVPPYA-8YvHDLf1w32vHKBcgPAzMEAPL94aZ9L5OIZEUQdqrH_fVhoaurAFZ0q2q0q6eyNBRow0he3JCcoRZeVjilkJvA3RxllDJNWb43NDO0IDmYrT4jqKb-E_QALrz_XazJZMDU6LSZoymsI7F9RxnCm7E8brow2YlW2Y_56MdJYM55mB9ycgHgQPLfOA2UHeDLmM4AdcdGozW2cTTXyLIOWljeG2ov8bGpQnIRKfa9keKF8JJva8XLgvixwbXwM9igzJA9UFkISA";
//
//	private static String VALID_JWS = "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJDb2Jpc2NvcnAgQjJDIiwiZXhwIjoyNTUxNTUxNjAwLCJpc3MiOiJjb2Jpcy1idDItand0In0.eAMdSDLBDYLGgKWVlVL5VnwI5FYGqqh95wEtBhSYXgmvMu0dBAsBwMoHovDaNuSqY7mq8MB1EGPpt51uaYgPH118UBO43-3L67Z0XX2sxrAVgwll6_tOuQ5M_GcV1gkgYGkpTWHiLT63VtweIes4R2OHTK_0Qp4cDLkrw6qgua755cQ3JkF0JSdnrlq-lw9-QGS3vxdMdBx-ZChpqGcTbFEgzhlhbDRU_-jXNCWNkNgAVuOrkDIR3jI4UOQjMlHEbQrpNyU2vtFIbEvYQLuS-RSrO_u9j6jX8bb-FkrfPdAPYagQdNtym8ukmbPhZpz6HHow-QzRIf2MTwME81-fAw";

	// Usando hmacShaKeyFor
    private static String EXPIRED_JWS = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJDb2Jpc2NvcnAgQjJDIiwiZXhwIjoxNTQxNzA4NDAwLCJpc3MiOiJjb2Jpcy1idDItand0In0.MQucYO-JIU8rgw3X5nv9AkPY6ExmMKyirBgHdyngNA8";
    
    private static String EXPIRED_JWS_BEARER = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJDb2Jpc2NvcnAgQjJDIiwiZXhwIjoxNTQxNzA4NDAwLCJpc3MiOiJjb2Jpcy1idDItand0In0.MQucYO-JIU8rgw3X5nv9AkPY6ExmMKyirBgHdyngNA8";
    
	private static String VALID_JWS = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJDb2Jpc2NvcnAgQjJDIiwiZXhwIjoyNTUxNTUxNjAwLCJpc3MiOiJjb2Jpcy1idDItand0In0.vR22Ob4Qnvz1a0bV4I8znSZCOV8E1-pp9mpj2aXb7Ko";

	@Mock
	private DateCalculator dateCalculator;
	
	@Mock
	private AlgnReader algnReader;
	
	@Spy
	private ShakeJwtKeyGenerator keyGenerator;

	@InjectMocks
	private CobisJwt cobisJwt;
	
	@Before
	public void init( ) {
		when(algnReader.readSeed()).thenReturn("esteesmibytearrayquecontienelaclave");
		Whitebox.setInternalState(keyGenerator, "algnReader", algnReader);
	}
	
	@Test(expected = InvalidTokenException.class)
	public void shouldThrowInvalidToken() throws TokenExpiredException, InvalidTokenException {
		new CobisJwt("Bearer ", keyGenerator);
	}
	
	@Test
	public void shouldGenerateExpired() {
		when(dateCalculator.addMinutes(any(Date.class), anyInt())).thenReturn(generateCalendar(2018, 11, 8, 15, 20));
		String jws = cobisJwt.generateJws();
		Assert.assertEquals(EXPIRED_JWS, jws);
	}

    @Test(expected = TokenExpiredException.class)
    public void dateExpiredBearer() throws TokenExpiredException, InvalidTokenException {
        new CobisJwt(EXPIRED_JWS_BEARER, keyGenerator);
    }
	
    @Test(expected = TokenExpiredException.class)
	public void dateExpired() throws TokenExpiredException, InvalidTokenException {
	    new CobisJwt(EXPIRED_JWS, keyGenerator);
	}

    @Test
    public void shouldGenerateNotExpired() {
        when(dateCalculator.addMinutes(any(Date.class), anyInt())).thenReturn(generateCalendar(2050, 11, 8, 15, 20));
        String jws = cobisJwt.generateJws();
        Assert.assertEquals(VALID_JWS, jws);
    }

	@Test
	public void shouldGenerateTokenWithSessionId() throws TokenExpiredException, InvalidTokenException {
		when(dateCalculator.addMinutes(any(Date.class), anyInt())).thenReturn(generateCalendar(2050, 11, 8, 15, 20));

        cobisJwt.addAttribute("CID", "cid-0001");
		String jws = cobisJwt.generateJws();
		System.out.println(jws);

		String cobisSessionId = cobisJwt.getCobisSessionid(jws);
		Assert.assertEquals("cid-0001", cobisSessionId);
	}
	
    @Test
    public void shouldStoreAndRetrieveData() throws TokenExpiredException, InvalidTokenException {
        when(dateCalculator.addMinutes(any(Date.class), anyInt())).thenReturn(generateCalendar(2050, 11, 8, 15, 20));

        String customerId = "666666";

        cobisJwt.addAttribute("customerId", customerId);
        cobisJwt.generateJws();

        Map<String, Object> returnPayload = cobisJwt.getPayload();
        String recoveredCustomerId = (String) returnPayload.get("customerId");
        Assert.assertEquals(customerId, recoveredCustomerId);
    }
    
    @Test
    public void shouldCreateWithPreviousAttributes() throws TokenExpiredException, InvalidTokenException {
        when(dateCalculator.addMinutes(any(Date.class), anyInt())).thenReturn(generateCalendar(2050, 11, 8, 15, 20));
        
        cobisJwt.addAttribute("attr-1", "value-1");
        cobisJwt.addAttribute("attr-2", "value-3");
        cobisJwt.addAttribute("attr-3", "value-2");

        String originalToken = cobisJwt.generateJws();
        
        CobisJwt newCobisJwt = new CobisJwt(originalToken, keyGenerator);
        String newToken = newCobisJwt.generateJws();
        
        CobisJwt finalCobisJwt = new CobisJwt(newToken, keyGenerator);
        String cid = finalCobisJwt.getAttribute("attr-1");
        
        Assert.assertEquals("value-1", cid);
    }

    @Test
    public void shouldThrowAttributeNotFound() throws TokenExpiredException {
		when(dateCalculator.addMinutes(any(Date.class), anyInt())).thenReturn(generateCalendar(2050, 11, 8, 15, 20));

        cobisJwt.addAttribute("CID", "cid-0001");
		String jws = cobisJwt.generateJws();
		System.out.println(jws);

		try {
			cobisJwt.getAttribute("_CID");
			Assert.fail();
		} catch (InvalidTokenException e) {
			Assert.assertEquals("Attribute not found: _CID", e.getMessage());
		}
    }
}
