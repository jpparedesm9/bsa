package com.cobiscorp.ecobis.fpm.interceptors.service.impl;

import java.io.FileNotFoundException;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cobiscorp.cobis.commons.utils.ConfigurationReader;

@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })
public class DefaultValuesTest {

	@Test
	public void comprobarCargaConfiguraciones() throws FileNotFoundException {

		ConfigurationReader reader = new ConfigurationReader(
				"../fpm-services-impl/src/test/resources/config-default-parameters.xml");
		DefaultValuesManager manager = new DefaultValuesManager();
		manager.loadConfiguration(reader);

	}
}
