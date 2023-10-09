package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class AuthorizationTransferRequest {

	public static final String EN_AUTHORITE_435 = "EN_AUTHORITE_435";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "AuthorizationTransferRequest";
	
	
	public static final Property<String> TRANSFERREASON = new Property<String>("transferReason", String.class, false);
	
	public static final Property<String> OFFICIALORG = new Property<String>("officialOrg", String.class, false);
	
	public static final Property<String> OFFICIALDES = new Property<String>("officialDes", String.class, false);
	
	public static final Property<String> DATEREQUEST = new Property<String>("dateRequest", String.class, false);
	
	public static final Property<Integer> IDROLOFFICIAL = new Property<Integer>("idRolOfficial", Integer.class, false);
	
	public static final Property<String> ENDDATEREQUEST = new Property<String>("endDateRequest", String.class, false);
	
	public static final Property<Integer> IDREQUEST = new Property<Integer>("idRequest", Integer.class, false);
	
	public static final Property<Boolean> ISCHECKED = new Property<Boolean>("isChecked", Boolean.class, false);
	
	public static final Property<Integer> IDOFFICE = new Property<Integer>("idOffice", Integer.class, false);
	
	public static final Property<String> LOGINOFFICIAL = new Property<String>("loginOfficial", String.class, false);
	
	public static final Property<String> ROLOFFICIAL = new Property<String>("rolOfficial", String.class, false);
	
	public static final Property<String> NAMEOFFICIAL = new Property<String>("nameOfficial", String.class, false);
	
	public static final Property<String> TYPEREQUEST = new Property<String>("typeRequest", String.class, false);
	
	public static final Property<String> REJECTIONREASON = new Property<String>("rejectionReason", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
