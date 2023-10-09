package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class GeneralData {

	public static final String EN_GENERALAA_827 = "EN_GENERALAA_827";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "GeneralData";
	
	
	public static final Property<String> PRODUCTTYPENAME = new Property<String>("productTypeName", String.class, false);
	
	public static final Property<String> SYMBOLCURRENCY = new Property<String>("symbolCurrency", String.class, false);
	
	public static final Property<String> PAYMENTFRECUENCYNAME = new Property<String>("paymentFrecuencyName", String.class, false);
	
	public static final Property<String> LOANTYPE = new Property<String>("loanType", String.class, false);
	
	public static final Property<String> SECTORNEG = new Property<String>("sectorNeg", String.class, false);
	
	public static final Property<String> VINCULADO = new Property<String>("vinculado", String.class, false);

        public static final Property<Integer> CLIENTID = new Property<Integer>("clientId", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
