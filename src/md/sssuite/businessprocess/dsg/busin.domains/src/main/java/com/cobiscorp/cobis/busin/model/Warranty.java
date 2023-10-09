package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Warranty {

	public static final String EN_WARRANTYB710 = "EN_WARRANTYB710";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Warranty";
	
	
	public static final Property<String> CODEWARRANTY = new Property<String>("CodeWarranty", String.class, false);
	
	public static final Property<String> TYPE = new Property<String>("Type", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("Description", String.class, false);
	
	public static final Property<BigDecimal> INITIALVALUE = new Property<BigDecimal>("InitialValue", BigDecimal.class, false);
	
	public static final Property<String> DATEAPPRAISEDVALUE = new Property<String>("DateAppraisedValue", String.class, false);
	
	public static final Property<BigDecimal> VALUEAPPORTIONMENT = new Property<BigDecimal>("ValueApportionment", BigDecimal.class, false);
	
	public static final Property<String> CLASSOPEN = new Property<String>("ClassOpen", String.class, false);
	
	public static final Property<BigDecimal> VALUEAVAILABLE = new Property<BigDecimal>("ValueAvailable", BigDecimal.class, false);
	
	public static final Property<String> IDCUSTOMER = new Property<String>("IdCustomer", String.class, false);
	
	public static final Property<String> NAMEGAR = new Property<String>("NameGar", String.class, false);
	
	public static final Property<String> STATE = new Property<String>("State", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
