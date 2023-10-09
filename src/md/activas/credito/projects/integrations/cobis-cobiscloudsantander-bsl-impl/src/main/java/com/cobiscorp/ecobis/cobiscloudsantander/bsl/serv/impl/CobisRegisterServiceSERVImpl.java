
/**
 * Archivo: CobisRegisterService.java
 * Fecha..: 
 * Autor..: Team Evac
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudsantander.bsl.serv.impl;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.math.BigDecimal;
import java.sql.Types;
import java.util.ResourceBundle;
import java.util.Locale;
import com.cobiscorp.cobisv.commons.catalog.CobisCatalogRB;
import com.cobiscorp.cobis.cts.commons.exceptions.CTSInfrastructureException;
import com.cobiscorp.cobis.cts.commons.exceptions.CTSServiceException;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.domains.IResponseBlock;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICOBISSequentialService;
import com.cobiscorp.cobis.cache.ICacheManager;
import com.cobiscorp.ecobis.cobisv.dal.api.dao.IDAO1;
import com.cobiscorp.cobisv.commons.exceptions.ValidationException;

import com.cobiscorp.ecobis.cobiscloudsantander.bsl.dto.Request;
import com.cobiscorp.ecobis.cobiscloudsantander.bsl.dto.SantanderRequest;
//include imports with key: CobisRegisterService.imports


public class CobisRegisterServiceSERVImpl extends ServiceBase implements com.cobiscorp.ecobis.cobiscloudsantander.bsl.serv.bsl.ICobisRegisterService {
	private static ILogger logger = LogFactory.getLogger(CobisRegisterServiceSERVImpl.class);
  private static final ILogger LOGGER = LogFactory.getLogger(CobisRegisterServiceSERVImpl.class);


	//include body with key: CobisRegisterService.body
	





	
	public 	 Integer  registerCustomerInformation (
		com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo aCustomerCoreInfo
		){

Integer wResult = null;

 		//to include in code order use key: cobiscloudsantander.CobisRegisterServiceImpl.registerCustomerInformation
		
		return wResult;
		//wResponse.setStatusCode(0);
				
	}


	

	
}
