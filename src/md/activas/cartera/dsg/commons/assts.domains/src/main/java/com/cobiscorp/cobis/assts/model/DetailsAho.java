package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class DetailsAho {

	public static final String EN_DETAILSOO_708 = "EN_DETAILSOO_708";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DetailsAho";
	
	
	public static final Property<Integer> OPERATION = new Property<Integer>("operation", Integer.class, false);
	
	public static final Property<Integer> ENTE = new Property<Integer>("ente", Integer.class, false);
	
	public static final Property<String> NAMEENTE = new Property<String>("nameEnte", String.class, false);
	
	public static final Property<BigDecimal> SALDO = new Property<BigDecimal>("saldo", BigDecimal.class, false);
	
	public static final Property<BigDecimal> INCENTIVE = new Property<BigDecimal>("incentive", BigDecimal.class, false);
	
	public static final Property<BigDecimal> GAIN = new Property<BigDecimal>("gain", BigDecimal.class, false);
	
	public static final Property<String> CUENTAGRUPAL = new Property<String>("cuentaGrupal", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
