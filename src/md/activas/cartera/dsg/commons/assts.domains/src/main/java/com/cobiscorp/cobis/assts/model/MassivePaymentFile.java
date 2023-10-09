package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class MassivePaymentFile {

	public static final String EN_MASSIVEFA_375 = "EN_MASSIVEFA_375";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "MassivePaymentFile";
	
	
	public static final Property<Integer> PROCESSEDRECORDS = new Property<Integer>("processedRecords", Integer.class, false);
	
	public static final Property<Integer> FILEOBSERVATIONS = new Property<Integer>("fileObservations", Integer.class, false);
	
	public static final Property<BigDecimal> PROCESSEDAMOUNT = new Property<BigDecimal>("processedAmount", BigDecimal.class, false);
	
	public static final Property<String> FILENAME = new Property<String>("fileName", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
