package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class PersonalGuarantor {

	public static final String EN_SNALUATOR601 = "EN_SNALUATOR601";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PersonalGuarantor";
	
	
	public static final Property<String> CODEWARRANTY = new Property<String>("CodeWarranty", String.class, false);
	
	public static final Property<String> TYPE = new Property<String>("Type", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("Description", String.class, false);
	
	public static final Property<String> GUARANTORPRIMARYSECONDARY = new Property<String>("GuarantorPrimarySecondary", String.class, false);
	
	public static final Property<String> CLASSOPEN = new Property<String>("ClassOpen", String.class, false);
	
	public static final Property<String> IDCUSTOMER = new Property<String>("IdCustomer", String.class, false);
	
	public static final Property<String> STATE = new Property<String>("State", String.class, false);
	
	public static final Property<Character> ISHERITAGE = new Property<Character>("isHeritage", Character.class, false);
	
	public static final Property<Double> RELATION = new Property<Double>("relation", Double.class, false);
	
	public static final Property<Date> DATECIC = new Property<Date>("DateCIC", Date.class, false);
	
	public static final Property<BigDecimal> CURRENTVALUE = new Property<BigDecimal>("CurrentValue", BigDecimal.class, false);
	
	public static final Property<String> CURRENCY = new Property<String>("Currency", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
