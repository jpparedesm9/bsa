package com.cobiscorp.ecobis.fpm.administration.service.impl;

import java.util.ArrayList;
import java.util.List;

import junit.framework.Assert;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.internal.matchers.Each;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.administration.service.IPaymentTypeFieldsManager;
import com.cobiscorp.ecobis.fpm.model.DicCompanyProductType;
import com.cobiscorp.ecobis.fpm.model.DicFunctionalityGroup;
import com.cobiscorp.ecobis.fpm.model.PaymentType;
import com.cobiscorp.ecobis.fpm.model.PaymentTypeFields;
import com.cobiscorp.ecobis.fpm.model.PaymentTypeFieldsValues;
@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })
public class PaymentTypeFieldsTest {

	@Autowired
	private IPaymentTypeFieldsManager paymentTypeFields;

	/** PaymentTypeFields TESTS */
	@Test
	public void getAllPaymentFieldsTest() {

		List<PaymentTypeFields> pty = paymentTypeFields
				.getPaymentTypeFieldsAll();
		Assert.assertNotNull(pty);
	}

	@Ignore
	public void getPaymentTypeFieldsByProductTypeTest() {
		DicCompanyProductType dc = new DicCompanyProductType(6435, 1, "FP",
				"Collection and Payment Types", "Collection & Paymente Types",
				null);
		List<PaymentTypeFields> pty = paymentTypeFields
				.getPaymentTypeFieldsByProductType(dc);
		Assert.assertNotNull(pty);
	}

	@Test
	public void getPaymentTypeFieldsByIdTest() {
		PaymentTypeFields ptf = new PaymentTypeFields();
		long var = 100;
		ptf = paymentTypeFields.getPaymentTypeFieldsById(var);
		Assert.assertNotNull(ptf);
	}

	@Test
	public void insertPaymentTypeFieldsTest() {
		// DicCompanyProductType dct = new DicCompanyProductType(6435, 1, "FP",
		// "Collection and Payment Types", "Collection & Paymente Types",
		// null);

		DicFunctionalityGroup dfg = new DicFunctionalityGroup(4000, "DFG TEST",
				"DFG TEST", "S");
		PaymentTypeFields ptf = new PaymentTypeFields("Tipo Tarjeta",
				"Credit Card", "String", "S", "S", "S", dfg);
		Assert.assertNotSame(paymentTypeFields.insertPaymentTypeFields(ptf), 0);
	}

	@Test
	public void updatePaymentTypeFieldsTest() {
		//DicCompanyProductType dct = new DicCompanyProductType(6435, 1, "FP",
		//		"Collection and Payment Types", "Collection & Paymente Types",
		//		null);
		DicFunctionalityGroup dfg = new DicFunctionalityGroup(4000, "DFG TEST",
				"DFG TEST", "S");
		PaymentTypeFields pt = new PaymentTypeFields();
		pt.setFieldId(100);
		pt.setDicFunctionalityGroup(dfg);
		pt.setEnabled("N");
		pt.setDescription("UPDATE");
		pt.setName("TEST update");
		pt.setModifyinherited("N");
		pt.setRequired("N");
		pt.setValueType("DOUBLE");
		paymentTypeFields.updatePaymentTypeFields(pt);
		PaymentTypeFields pt1 = new PaymentTypeFields();
		pt1 = paymentTypeFields.getPaymentTypeFieldsById(pt.getFieldId());
	}

	@Test
	public void deletePaymentTypeFieldsTest() {
		PaymentTypeFields ptf = new PaymentTypeFields();
		long var = 100;
		paymentTypeFields.deletePaymentTypeFields(var);
		try {
			ptf = paymentTypeFields.getPaymentTypeFieldsById(var);
		} catch (BusinessException bex) {
			System.out.println(bex);
		}

	}

	/** Payment Type TESTS */
	@Test
	public void getCollectionPaymentTypeTest() {
		List<PaymentType> cpt = paymentTypeFields.getAllPaymentType();
		Assert.assertNotNull(cpt);
		// System.out.println(cpt);

	}

	@Test
	public void getPaymentTypeByIdTest() {
		String mnemonic = "NDAHO";
		// PaymentType cpt =
		// paymentTypeFields.getCollectionPaymentTypeById(mnemonic);
		// List<PaymentTypeFieldsValues> ptfvList =
		// paymentTypeFields.getPaymentTypeFieldsValuesByMnemonic(mnemonic);
		// System.out.println("Esta es la lista1:" + ptfvList);
		PaymentType cpt = paymentTypeFields.getPaymentTypeById(mnemonic);
		// System.out.println("Esta es la lista1:" + cpt);
		Assert.assertNotNull(cpt);
		// Assert.assertNull("El objeto NO trae una lista",
		// cpt.getPaymentTypeFieldsValues());
		// System.out.println("Esta es la lista:" +
		// cpt.getPaymentTypeFieldsValues());
	}

	@Test
	public void updateCollectionPaymentTypeTest() {

		PaymentType cpt = paymentTypeFields.getPaymentTypeById("NDAHO");
		cpt.setDescription("PRUEBA_UPD");
		cpt.setType("P");
		cpt.setName("PRUEBA_UPD");
		int res = paymentTypeFields.updatePaymentType(cpt);
		// System.out.println("IMPRESION ACA:"+ cpt);
		Assert.assertEquals(
				"No hubo error al actualizar un CollectionPaymentType", 1, res);
	}

	@Test
	public void deleteCollectionPaymentTypeTest() {
		String mnemonic = "CTE";
		Assert.assertEquals(
				"No hubo error al eliminar un CollectionPaymentType", 1,
				paymentTypeFields.deletePaymentType(mnemonic));
	}

	@Test
	public void insertCollectionPaymentTypeTest() {
		PaymentType cpt = new PaymentType();
		cpt.setMnemonic("NCCTE");
		cpt.setName("NOTA DE CREDITO CORRIENTE");
		cpt.setDescription("NOTA DE CREDITO EN CTA CTE");
		cpt.setType("C");
		
		//obtengo un PTF para ponerlo en el PTFV
		PaymentTypeFields ptf = new PaymentTypeFields();		
		long var = 300;
		ptf = paymentTypeFields.getPaymentTypeFieldsById(var);

        //Obtengo una lista de PTFV		
		List<PaymentTypeFieldsValues> ptfvList = new ArrayList<PaymentTypeFieldsValues>(); 
		ptfvList = paymentTypeFields.getPaymentTypeFieldsValuesByFieldId((long) 3);
		System.out.println("antes de insertar0" + ptfvList);
		//Seteo el PTF e ID a la lista de PTFV
		int cont = 011;
		for (PaymentTypeFieldsValues paymentTypeFieldsValues : ptfvList) {
			paymentTypeFieldsValues.setValueId(cont);
			paymentTypeFieldsValues.setPaymentTypeFields(ptf);
			cont = cont++;
		}
		System.out.println("antes de insertar1" + ptfvList);
		cpt.setPaymentTypeFieldsValues(ptfvList);
		System.out.println("antes de insertar2" + cpt);
		Assert.assertEquals(
				"No hubo error a insertar un Collection and Payment Type", 1,
				paymentTypeFields.insertPaymentType(cpt));
		System.out.println("INSERCION ACA:"
				+ paymentTypeFields.getPaymentTypeById("NCCTE"));
	}

	@Test
	public void getPaymentTypeFieldValuesListByMnemonicTest() {
		List<PaymentTypeFieldsValues> ptfvList = paymentTypeFields
				.getPaymentTypeFieldsValuesByMnemonic("NDAHO");
		System.out.println("Lista1:" + ptfvList);
		Assert.assertNotNull(ptfvList);
	}

	@Test
	public void getPaymentTypeFieldsValuesListByFieldIdTest() {
		long var = 300;
		List<PaymentTypeFieldsValues> ptfvList = paymentTypeFields
				.getPaymentTypeFieldsValuesByFieldId(var);
		System.out.println("Lista2:" + ptfvList);
		Assert.assertNotNull(ptfvList);

	}

	@Test
	public void getPaymentTypeFieldsByGroupIdTest() {
		DicFunctionalityGroup dfg = new DicFunctionalityGroup();
		dfg.setId(4000);
		Assert.assertNotNull(paymentTypeFields
				.getPaymentTypeFieldsByGroupId(dfg));
	}
	/**
	 * @Test public void insertPaymentTypeFieldsvalueTest() { long var= 300;
	 *       PaymentTypeFields ptf =
	 *       paymentTypeFields.getPaymentTypeFieldsById(var); PaymentType pt =
	 *       paymentTypeFields.getPaymentTypeById("NDAHO");
	 *       PaymentTypeFieldsValues ptfv = new PaymentTypeFieldsValues( "W",
	 *       "PRUEBA I PTFV", "PRUEBA I PTFV", "I", ptf, pt);
	 *       System.out.println("Salida Insert PTFV"+ ptfv);
	 *       Assert.assertEquals(
	 *       "No hubo error a insertar un PaymenTypeFieldValue", 1,
	 *       paymentTypeFields.insertPaymentTypeFieldsvalue(ptfv)); }
	 * @Test public void updatePaymentTypeFieldsvalueTest() { long var= 300;
	 *       PaymentTypeFields pt =
	 *       paymentTypeFields.getPaymentTypeFieldsById(var); PaymentType cpt =
	 *       paymentTypeFields.getPaymentTypeById("NDAHO");
	 *       PaymentTypeFieldsValues ptfv = new PaymentTypeFieldsValues("A",
	 *       "PRUEBA ECO", "PRUEBA ECO DESCRIP", "S", pt, cpt);
	 *       ptfv.setValueId(003); Assert.assertEquals(
	 *       "No hubo error al actualizar un Payment Type Fields", 1,
	 *       paymentTypeFields.updatePaymentTypeFieldsvalue(ptfv)); }
	 * @Test public void deletePaymentTypeFieldsvalueTest() {
	 *       DicCompanyProductType dct = new DicCompanyProductType(6435, 1,
	 *       "FP", "Collection and Payment Types",
	 *       "Collection & Paymente Types", null); PaymentTypeFields pt = new
	 *       PaymentTypeFields("Tipo Tarjeta", "Credit Card", "String", "S",
	 *       "S", "S", dct); List<PaymentTypeFieldsValues> ptfvList =
	 *       paymentTypeFields.getPaymentTypeFieldsValuesByMnemonic("NDAHO");
	 *       PaymentType cpt = new PaymentType("NDCTE",
	 *       "NOTA DE DEBITO CORRIENTE", "NOTA DE DEBITO EN CTA CTE", "C",
	 *       ptfvList); PaymentTypeFieldsValues ptfv = new
	 *       PaymentTypeFieldsValues( "A", "PRUEBA ECO", "PRUEBA ECO DESCRIP",
	 *       "S", pt, cpt); List<PaymentTypeFieldsValues> list = new
	 *       ArrayList<PaymentTypeFieldsValues>(); list.add(ptfv);
	 *       Assert.assertEquals(
	 *       "No hubo error al actualizar un Payment Type Fields", 1,
	 *       paymentTypeFields.deletePaymentTypeFieldsvalue(list)); }
	 */
}
