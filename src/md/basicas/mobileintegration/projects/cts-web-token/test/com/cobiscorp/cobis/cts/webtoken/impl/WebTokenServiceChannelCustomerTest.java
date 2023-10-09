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

import com.cobiscorp.cobis.cts.webtoken.api.IWebTokenService;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import java.util.HashMap;
import java.util.Map;


public class WebTokenServiceChannelCustomerTest {

	IWebTokenService webTokenService;
	Map<String, Object> tokenRequest;

	@Before
	public  void setUp () {
	    System.setProperty("COBIS_HOME", "COBIS_HOME");
		tokenRequest = new HashMap<String, Object>();
		tokenRequest.put(IWebTokenService.CHANNEL, IWebTokenService.MOBILE_BANKING_CHANNEL);
		tokenRequest.put(IWebTokenService.USER, "admin");
		webTokenService = WebTokenFactory.getService(tokenRequest);
		Activator.loadConfig();

	}
	
	@Test
	public void generateToken() {
		String token = webTokenService.generateToken(tokenRequest);
		String[] subtokens = token.split("\\.");
		Assert.assertEquals(3, subtokens.length);

		Map claimsTmp = webTokenService.getProperties(token);
		System.out.println("claims:" + claimsTmp);
		System.out.println("claims:" + claimsTmp.get(IWebTokenService.USER));
		Assert.assertEquals("admin", claimsTmp.get(IWebTokenService.USER));
		Assert.assertEquals(IWebTokenService.MOBILE_BANKING_CHANNEL, claimsTmp.get(IWebTokenService.CHANNEL));
	}


	

}
