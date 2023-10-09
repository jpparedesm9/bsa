package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class QuestionsPartThree {

	public static final String EN_QUESTIOSE_840 = "EN_QUESTIOSE_840";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "QuestionsPartThree";
	
	
	public static final Property<String> CELLTYPE = new Property<String>("cellType", String.class, false);
	
	public static final Property<String> FREQUENCYUSEEM = new Property<String>("frequencyUseEM", String.class, false);
	
	public static final Property<Integer> CODEQUESTION5 = new Property<Integer>("codeQuestion5", Integer.class, false);
	
	public static final Property<String> FREQUENCYUSEEMANSWER = new Property<String>("frequencyUseEMAnswer", String.class, false);
	
	public static final Property<String> HAVEEMAILANSWER = new Property<String>("haveEmailAnswer", String.class, false);
	
	public static final Property<Integer> CODEQUESTION1 = new Property<Integer>("codeQuestion1", Integer.class, false);
	
	public static final Property<String> SOCIALNETWORKS = new Property<String>("socialNetworks", String.class, false);
	
	public static final Property<Integer> RESULT = new Property<Integer>("result", Integer.class, false);
	
	public static final Property<Integer> CODEQUESTION2 = new Property<Integer>("codeQuestion2", Integer.class, false);
	
	public static final Property<String> ENABLEVIEW = new Property<String>("enableView", String.class, false);
	
	public static final Property<Integer> CODEQUESTION3 = new Property<Integer>("codeQuestion3", Integer.class, false);
	
	public static final Property<String> PAYMENTMETHODPHONE = new Property<String>("paymentMethodPhone", String.class, false);
	
	public static final Property<String> CELLTYPEANSWER = new Property<String>("cellTypeAnswer", String.class, false);
	
	public static final Property<String> PAYMENTMETHODPHONEANSWER = new Property<String>("paymentMethodPhoneAnswer", String.class, false);
	
	public static final Property<String> HAVEEMAIL = new Property<String>("haveEmail", String.class, false);
	
	public static final Property<Integer> CODEQUESTION4 = new Property<Integer>("codeQuestion4", Integer.class, false);
	
	public static final Property<String> SOCIALNETWORKSANSWER = new Property<String>("socialNetworksAnswer", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
