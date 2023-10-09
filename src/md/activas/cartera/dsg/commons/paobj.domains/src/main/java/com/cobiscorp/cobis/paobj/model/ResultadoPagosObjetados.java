package com.cobiscorp.cobis.paobj.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class ResultadoPagosObjetados {

	public static final String EN_RESULTAED_237 = "EN_RESULTAED_237";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ResultadoPagosObjetados";
	
	
	public static final Property<String> IDPAGO = new Property<String>("idPago", String.class, false);
	
	public static final Property<Boolean> SELECCIONAR = new Property<Boolean>("seleccionar", Boolean.class, false);
	
	public static final Property<String> IDPRESTAMO = new Property<String>("idPrestamo", String.class, false);
	
	public static final Property<Integer> SEC = new Property<Integer>("sec", Integer.class, false);
	
	public static final Property<String> FECHA = new Property<String>("fecha", String.class, false);
	
	public static final Property<String> TIPOPRESTAMO = new Property<String>("tipoPrestamo", String.class, false);
	
	public static final Property<BigDecimal> MONTOPAGADO = new Property<BigDecimal>("montoPagado", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
