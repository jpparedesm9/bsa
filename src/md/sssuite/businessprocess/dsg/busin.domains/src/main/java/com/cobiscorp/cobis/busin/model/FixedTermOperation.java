package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class FixedTermOperation {

	public static final String EN_IXEMOERON808 = "EN_IXEMOERON808";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "FixedTermOperation";
	
	
	public static final Property<String> NUMBANCO = new Property<String>("numBanco", String.class, true);
	
	public static final Property<String> DESCRIPCION = new Property<String>("descripcion", String.class, false);
	
	public static final Property<String> ESTADO = new Property<String>("estado", String.class, false);
	
	public static final Property<BigDecimal> MONTOINICIAL = new Property<BigDecimal>("montoInicial", BigDecimal.class, false);
	
	public static final Property<BigDecimal> MONTOGARANTIA = new Property<BigDecimal>("montoGarantia", BigDecimal.class, false);
	
	public static final Property<BigDecimal> MONTOBLOQUEADO = new Property<BigDecimal>("montoBloqueado", BigDecimal.class, false);
	
	public static final Property<BigDecimal> MONTODISPONIBLE = new Property<BigDecimal>("montoDisponible", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		pks.add(NUMBANCO);
		return pks;
	}

}
