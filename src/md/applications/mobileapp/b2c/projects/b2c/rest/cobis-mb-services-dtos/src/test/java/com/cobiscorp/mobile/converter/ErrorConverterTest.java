package com.cobiscorp.mobile.converter;

import org.junit.Assert;
import org.junit.Test;

import com.cobiscorp.mobile.converter.ErrorConverter;
import com.cobiscorp.mobile.model.KeyValue;

public class ErrorConverterTest {

	@Test
	public void convert() {
		KeyValue error = new KeyValue();
		error.setKey("50000");
		error.setValue("[1875066] [sp_inicia_sesion]  EL USUARIO SE ENCUENTRA BLOQUEADO O INACTIVO, ACERQUESE A UNA OFICINA DEL BANCO PARA ACTIVARLA");

		KeyValue newError = ErrorConverter.convertError(error);
		
		Assert.assertEquals("1875066", newError.getKey());
	}
}
