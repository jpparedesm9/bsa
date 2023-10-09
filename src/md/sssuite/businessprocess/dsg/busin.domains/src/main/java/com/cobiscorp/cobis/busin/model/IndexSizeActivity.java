package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class IndexSizeActivity {

	public static final String EN_NXIZECVIY784 = "EN_NXIZECVIY784";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "IndexSizeActivity";
	
	
	public static final Property<Double> PATRIMONY = new Property<Double>("Patrimony", Double.class, false);
	
	public static final Property<Double> SALES = new Property<Double>("Sales", Double.class, false);
	
	public static final Property<Integer> PERSONALNUMBER = new Property<Integer>("PersonalNumber", Integer.class, false);
	
	public static final Property<Double> INDEXSIZEACTIVITY = new Property<Double>("IndexSizeActivity", Double.class, false);
	
	public static final Property<Double> ANNUALSALES = new Property<Double>("AnnualSales", Double.class, false);
	
	public static final Property<Double> PRODUCTIVEASSETS = new Property<Double>("ProductiveAssets", Double.class, false);
	
	public static final Property<String> PARAMETERFIXEDINCOME = new Property<String>("ParameterFixedIncome", String.class, false);
	
	public static final Property<Double> BTNCALCULATE = new Property<Double>("BtnCalculate", Double.class, false);
	
	public static final Property<String> SIZECOMPANY = new Property<String>("sizeCompany", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
