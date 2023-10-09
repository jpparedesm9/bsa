package com.cobiscorp.ecobis.htm.api.service.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.Ignore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.ContextRepository;
import com.cobiscorp.cobisv.commons.context.Server;
import com.cobiscorp.ecobis.busin.enums.ColumnCatalog;
import com.cobiscorp.ecobis.busin.enums.ParameterType;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.busin.model.InputParameterDto;
import com.cobiscorp.ecobis.busin.service.IQueryStoredProcedure;
@Ignore
@ContextConfiguration(locations = { "/META-INF/spring/test-cts-context.xml", "/META-INF/spring/test-cts-tx-context.xml" })
@RunWith(SpringJUnit4ClassRunner.class)
public class HumanTaskTest {

	private ISPOrchestrator spOrchestrator;
	@Autowired
	private IQueryStoredProcedure humanTask;

	private static ApplicationContext ctx;

	@BeforeClass
	public static void init() {
		String id = "154654614365";
		Context context = new Context(id, new CobisSession(id, "b1", "admuser", "1", "o1", id, "1", "PC01TEC17", "CTSSRV", "1"), new Server("1", "16385882", "11/01/2013"));
		ContextRepository.setContext(context);
	}

	@Test
	public void testCompleteTask() {

		System.out.println("Ejecuta metodo------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		System.out.println("Ejecuta metodo------------------------>");
		ArrayList<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "7856", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "H", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo_car", "2", ParameterType.VARCHAR));

		List<CatalogDto> catalogDtoList = humanTask.getCatalogByStoredProcedure("cob_cartera..sp_tcca_segcred", inputParameterDtoList, hmColumnsResponse);
		for (CatalogDto catalogDto : catalogDtoList) {
			System.out.println("Code------------------------>" + catalogDto.getCode());
			System.out.println("Name------------------------>" + catalogDto.getName());
		}

	}

}
