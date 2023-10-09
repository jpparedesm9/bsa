/**
 * Archivo: OrchestrationClientValidationServiceTest.java
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

package cobiscloudorchestration.test;
import java.util.HashMap;
import java.util.Map;

import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.ClassRule
import org.junit.Test
import org.junit.Ignore
import org.junit.rules.ExternalResource

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest
import com.cobiscorp.test.CTSEnvironment
import com.cobiscorp.test.SetUpTestEnvironment
import com.cobiscorp.test.utils.BDD
import com.cobiscorp.test.utils.DataBaseInformation
import com.cobiscorp.test.utils.SqlExecutorUtils
import com.cobiscorp.test.utils.RegistertServiceUtill
@Ignore
public class OrchestrationClientValidationServiceTest {
 
	/**
	 * setupenvironment in order to set configuration and close database connections
	 */
	@ClassRule
	public static ExternalResource setUpEnvironment = new SetUpTestEnvironment();


	private UtilClientTest util = null;

	@Before
	public void setUp() {
		println "logn:" + CTSEnvironment.login
		println "logn:" + CTSEnvironment.password
		clearInLogin(CTSEnvironment.TARGETID_CENTRAL, CTSEnvironment.login);
		activateLogin(CTSEnvironment.TARGETID_CENTRAL, CTSEnvironment.login);
		
		if(!verifyCobisUser(CTSEnvironment.TARGETID_CENTRAL, CTSEnvironment.login)){
			SqlExecutorUtils.dropRolFromUser(CTSEnvironment.TARGETID_CENTRAL, CTSEnvironment.login, 3)
			SqlExecutorUtils.dropCOBISUser(CTSEnvironment.TARGETID_CENTRAL, CTSEnvironment.login)
			
			SqlExecutorUtils.createCOBISUser(CTSEnvironment.TARGETID_CENTRAL, CTSEnvironment.login, CTSEnvironment.password);
			SqlExecutorUtils.addCOBISUserToRol(CTSEnvironment.TARGETID_CENTRAL, CTSEnvironment.login, 3, 1);
		}
		
		if(verifyIfExistService(CTSEnvironment.TARGETID_CENTRAL,"DocumentSERVImpl.getSignature") == 0){
			RegistertServiceUtill.registerservice(CTSEnvironment.TARGETID_CENTRAL, "DocumentSERVImpl.getSignature",
					"com.cobiscorp.ecobis.document.bl.serv.api.IDocument", "getSignature", "Description", 0)
			         
			SqlExecutorUtils.authorizeRolService("DocumentSERVImpl.getSignature", 1, 1, "R", 0, CTSEnvironment.TARGETID_CENTRAL)
		}
		util = new UtilClientTest();
		Assert.assertTrue("login", util.doLogin());
	}
	private void activateLogin(DataBaseInformation dbInformation,  String aLogin){
	
		def sql = BDD.getInstance(dbInformation)
		try{
			sql.executeUpdate("update cobis"+CTSEnvironment.DB_SEPARATOR+"ad_usuario set us_estado ='V' where  us_login =?", [aLogin])
			sql.executeUpdate("update cobis"+CTSEnvironment.DB_SEPARATOR+"cl_funcionario set fu_estado='V', fu_fec_inicio = null  where  fu_login =?", [aLogin])
		}finally{
			BDD.closeInstance(dbInformation, sql);
		}

		
	}

		
	private void clearInLogin(DataBaseInformation dbInformation,  String aLogin){
		def sql = BDD.getInstance(dbInformation)
		try{
			sql.execute("delete from cobis"+CTSEnvironment.DB_SEPARATOR+"in_login where lo_login=?", [aLogin])
		}finally{
			BDD.closeInstance(dbInformation, sql);
		}

		
	}
	private Boolean verifyCobisUser(DataBaseInformation dbInformation,  String aLogin){
		def sql = BDD.getInstance(dbInformation)
		try{
			def idSeq = sql.firstRow("select  1 from cobis"+CTSEnvironment.DB_SEPARATOR+"cl_funcionario where fu_login= ?", [aLogin])
			if(idSeq != null) {
				return true;
			}
		}finally{
			BDD.closeInstance(dbInformation, sql);
		}

		return false;

		
	}
	
	@After
	public void tearDown() {

	}

private Integer verifyIfExistService(DataBaseInformation dbInformation, String aServiceId){
		/**
		 * 	select * from cobis..ad_servicio_autorizado
		 where ts_servicio = 'CustomerEventHistory.maintenanceEventHistoryConfiguration'
		 select * from  cobis..cts_serv_catalog
		 where csc_service_id = 'CustomerEventHistory.maintenanceEventHistoryConfiguration'
		 */

		//Obtengo el id mayor de la log headear
		def sql = BDD.getInstance(dbInformation)
		try{
			def idSeq = sql.firstRow("select id = count(*) from cobis"+CTSEnvironment.DB_SEPARATOR+"ad_servicio_autorizado where ts_servicio"+
					" = ?", [aServiceId])?.id
			if(idSeq == null) {
				return  0;
			}
			else
			{
				return new Integer(idSeq);
			}
		}finally{
			BDD.closeInstance(dbInformation, sql);
		}
		return 0;
	}



	@Test
	public void validate()	{
 	}
	@Test
	public void validateBuroClientGroupRule()	{
 	}
	@Test
	public void validateBuroClientGroup()	{
 	}
	@Test
	public void validateBuroClientIndividualRule()	{
 	}
;

   }
