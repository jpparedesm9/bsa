/*
 * Archivo: COBISHttpFilterHandlerTest.java
 * Fecha: Aug 18, 2017
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */
package com.cobiscorp.cobis.cts.webtoken.impl;

import java.util.HashMap;
import java.util.Map;

import com.cobiscorp.cobis.cts.webtoken.api.IWebTokenService;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;


public class WebTokenServiceChannelOfficerTest {

	IWebTokenService webTokenService;
	Map<String, Object> login;

	@Before
	public  void setUp () {
		login = new HashMap<String, Object>();
		login.put(IWebTokenService.CHANNEL, IWebTokenService.MOBILE_OFFICIAL_CHANNEL);
		login.put(IWebTokenService.USER, "admin");
		login.put(IWebTokenService.SESSION_ID, "ABCE");
		login.put(WebTokenServiceChannelOfficerImpl.DEVICE_ID, "ABC1");
		webTokenService = WebTokenFactory.getService(login);

	}
	
	@Test
	public void generateToken() {
		String token = webTokenService.generateToken(login);
		String[] subtokens = token.split("\\.");
		Assert.assertEquals(3, subtokens.length);

		Map claimsTmp = webTokenService.getProperties(token);
		System.out.println("claims:" + claimsTmp);
		System.out.println("claims:" + claimsTmp.get(IWebTokenService.USER));
		Assert.assertEquals("admin", claimsTmp.get(IWebTokenService.USER));
		Assert.assertEquals("ABC1", claimsTmp.get(WebTokenServiceChannelOfficerImpl.DEVICE_ID));

		Assert.assertEquals("ABCE", claimsTmp.get(IWebTokenService.SESSION_ID));
		Assert.assertEquals(IWebTokenService.MOBILE_OFFICIAL_CHANNEL, claimsTmp.get(IWebTokenService.CHANNEL));
	}

	@Test
	public void validateToken() {
		String token = webTokenService.generateToken(login);
		Assert.assertTrue(webTokenService.isValidToken(token));

	}

	@Test
	public void validateTokenTheSameChannel() {
		String token = webTokenService.generateToken(login);
		IWebTokenService webTokenServiceMobileBanking = WebTokenFactory.getService(IWebTokenService.MOBILE_BANKING_CHANNEL);
		Assert.assertFalse(webTokenServiceMobileBanking.isValidToken(token));

	}

	@Test
	public void itShouldExtractTokenFromBearerToken() {

		String token = "adf";
		String bearerToken = IWebTokenService.BEARER + " " + token;
		String obtainedToken = webTokenService.extractTokenFromBearerToken(bearerToken);
		//System.out.println("-" +token.substring(7,token.length()) + "-");
		Assert.assertEquals(token , obtainedToken);
	}

	

}
