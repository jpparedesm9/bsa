package com.cobiscorp.cobis.asscr.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Amount {

	public static final String EN_AMOUNTWNM_769 = "EN_AMOUNTWNM_769";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Amount";
	
	
	public static final Property<Integer> IDCLIENTE = new Property<Integer>("idCliente", Integer.class, false);
	
	public static final Property<BigDecimal> AMOUNTAPPROVED = new Property<BigDecimal>("amountApproved", BigDecimal.class, false);
	
	public static final Property<String> OPERATION = new Property<String>("operation", String.class, false);
	
	public static final Property<Integer> PROCESSINTS = new Property<Integer>("processInts", Integer.class, false);
	
	public static final Property<String> MSMDESEMBOLSAR = new Property<String>("msmDesembolsar", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
