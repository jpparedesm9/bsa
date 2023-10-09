package com.cobiscorp.ecobis.fpm.operation.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import junit.framework.Assert;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cobiscorp.cobisv.commons.context.CobisContext;
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.ContextRepository;
import com.cobiscorp.cobisv.commons.context.Server;
import com.cobiscorp.ecobis.fpm.bo.ItemLog;
import com.cobiscorp.ecobis.fpm.model.DicCompanyProductType;
import com.cobiscorp.ecobis.fpm.model.Item;
import com.cobiscorp.ecobis.fpm.model.ItemByProduct;
import com.cobiscorp.ecobis.fpm.model.ItemByProductId;
import com.cobiscorp.ecobis.fpm.operation.service.IItemsManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })
public class ItemsManagerTest {

	@Autowired
	private IItemsManager itemsManagerService;

	@Before
	public void init() throws Exception {
		String id = "1";
		CobisContext context = new CobisContext(new CobisSession(id, "b1",
				"c1", "ci1", "o1", id, "1", "t1", "s1", "1"), new Server("1",
				"s1", "04/26/2006"));
		ContextRepository.setContext(context);
	}

	@Test
	public void createItemByProduct() {

		Item item = new Item();
		item.setName("CAPITAL");
		item.setDescription("Descripción CAPITAL");
		item.setDicAssociate("DicAssociate");
		long itemId = itemsManagerService.manageItem(item, "ML");

		Assert.assertEquals(itemId, 1L);

		ItemByProductId byProductId = new ItemByProductId("ML", itemId);
		ItemByProduct itemByProduct = new ItemByProduct(byProductId, null);

		// Creo el rubro
		itemsManagerService.insertItemByProduct(itemByProduct);
		// Recupero el rubro insertado
		ItemByProduct byProduct = itemsManagerService
				.getItemByProduct(byProductId);

		// Comparo
		Assert.assertEquals(itemByProduct, byProduct);
	}

	@Test
	public void getItemChangeTest() {
		int size = 0;
		Boolean sizeFlag = false;
		Boolean resultFlag = true;

		Map<String, List<String>> map = itemsManagerService
				.getItemsChanges("ML");
		size = ((List<String>) map.get(Constants.AFTER_VALUE)).size();

		if (size > 0)
			sizeFlag = true;

		Assert.assertEquals(sizeFlag, resultFlag);

		size = ((List<String>) map.get(Constants.BEFORE_VALUE)).size();

		if (size > 0)
			sizeFlag = true;

		Assert.assertEquals(sizeFlag, resultFlag);
	}
	
	@Test
	public void getItems()
	{
		List<Item> items = null;
		items = itemsManagerService.getItems("ML");
		
		for (Item item : items) {
			System.out.println("ITEMS - ML-->" + item.getName());
		}
		
		
		Assert.assertNotNull(items);
		List<Item> itemsList = null;
		itemsList = itemsManagerService.getItems("Test");
		
		for (Item item : itemsList) {
			System.out.println("ITEMS - Test-->" + item.getName());
		}
		
		
		Assert.assertNotNull(itemsList);
	}
	
	@Test
	public void getDictionariesAssociate(){
		
		List<DicCompanyProductType> dicCompanyProductType = itemsManagerService.getDictionariesAssociate("ML");
		
		for (DicCompanyProductType dicCompanyProductType2 : dicCompanyProductType) {
			System.out.println(dicCompanyProductType2);
		}
		
		Assert.assertNotNull(dicCompanyProductType);
	}

	@Test
	public void getItemsByProductLogs(){
		Long entrada=(long) 1001;
		ItemLog log =
				itemsManagerService.getItemByProductLog(entrada);
		System.out.println(log);
		Assert.assertNotNull(log);
		
		
		
	}
	
	@Test
	public void insertItemByProductListTest(){
		String bpId = "VL";
		ArrayList<ItemByProduct> ibpList = new ArrayList<ItemByProduct>();
		List<Item> itemsList = itemsManagerService.getAllItemsForCategory(bpId);
		if(itemsList.size()>0){
			for (Item item : itemsList) {
				ItemByProductId ibpId = new ItemByProductId(bpId, item.getId());
				ItemByProduct ibp = new ItemByProduct();
				ibp.setByProductId(ibpId);
				ibp.setItemsValuesList(null);
				ibpList.add(ibp);
			}
			
			if(ibpList.size()>0){
			   itemsManagerService.insertItemByProductList(ibpList);
			}
			List<ItemByProduct> result = itemsManagerService.getItemsByProduct(bpId);
					
			Assert.assertNotNull(result);
		}
	}

}
