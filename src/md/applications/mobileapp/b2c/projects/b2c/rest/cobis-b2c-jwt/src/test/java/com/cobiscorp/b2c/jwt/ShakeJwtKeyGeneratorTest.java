package com.cobiscorp.b2c.jwt;

import java.net.URL;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.runners.MockitoJUnitRunner;

@RunWith(MockitoJUnitRunner.class)
public class ShakeJwtKeyGeneratorTest {
	
	@Mock
	private AlgnReader algnReader;

	@InjectMocks
	private ShakeJwtKeyGenerator keyGenerator;
	
	@Test
	public void shouldUseAlgnReader() {
		
		Mockito.when(algnReader.readSeed()).thenReturn("esteesmibytearrayquecontienelaclave");
		
		keyGenerator.genKey();
		
		Mockito.verify(algnReader).readSeed();
		
	}

	@Test
//	@Ignore
	public void shouldRead() {
		
		URL resource = this.getClass().getClassLoader().getResource(".");
		System.setProperty("COBIS_HOME", resource.getPath());

		AlgnReader reader = new AlgnReader("/seed");
		
		Assert.assertEquals("useresteesmibytearrayqueserver", reader.readSeed());
		
	}
}
