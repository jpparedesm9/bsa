package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class DebtorGeneral {

	public static final String EN_DEBTORHHW342 = "EN_DEBTORHHW342";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DebtorGeneral";
	

	public static final Property<String> RISKLEVEL = new Property<String>("riskLevel", String.class, false);

	public static final Property<Integer> CUSTOMERCODE = new Property<Integer>("CustomerCode", Integer.class, true);

	public static final Property<String> CREDITBUREAU = new Property<String>("creditBureau", String.class, false);

	public static final Property<String> RFC = new Property<String>("rfc", String.class, false);
	
	public static final Property<String> ROLE = new Property<String>("Role", String.class, false);
	
	public static final Property<String> IDENTIFICATION = new Property<String>("Identification", String.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("CustomerName", String.class, false);
	
	public static final Property<String> TYPEDOCUMENTID = new Property<String>("TypeDocumentId", String.class, false);
	
	public static final Property<String> ADDRESS = new Property<String>("Address", String.class, false);
	
	public static final Property<String> QUALIFICATION = new Property<String>("Qualification", String.class, false);
	
	public static final Property<Integer> ADITIONALCODE = new Property<Integer>("AditionalCode", Integer.class, false);
	
	public static final Property<Date> DATECIC = new Property<Date>("DateCIC", Date.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		pks.add(CUSTOMERCODE);
		return pks;
	}

}
