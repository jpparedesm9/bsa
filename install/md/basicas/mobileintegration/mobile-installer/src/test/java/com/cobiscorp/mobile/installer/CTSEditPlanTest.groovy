package com.cobiscorp.mobile.installer
;

import javax.xml.parsers.ParserConfigurationException

import junit.framework.Assert

import org.junit.Before
import org.junit.Test
import org.xml.sax.SAXException

import com.cobiscorp.cobis.installer.jobs.EditConfigurationJob

public class CTSEditPlanTest {

	private EditConfigurationJob job;
	private static final String propertyRoot = "root";
	private  XmlParser parser;
	private String[] engineArgs
	private String COBIS_HOME = "src/test/resources/COBIS_HOME"	
	private String APP_NAME = "CLOUD-MOBILE"

	@Before
	public void initJob() throws ParserConfigurationException, SAXException {
		def folder = new File( COBIS_HOME + "/CTS_MF/plugins/" )
		if( !folder.exists() ) {
		  folder.mkdirs()
		}
		job = new EditConfigurationJob();
		parser = new XmlParser();
		engineArgs = [
			COBIS_HOME,
			APP_NAME];

	}
	
	@Test
	public void runUpdateEnv() throws Exception {
		
		String wScript = "cobis-edit-plan-config.groovy";

		File currentDir=new File("src/main/resources/scripts");
		String[] roots=[currentDir.getAbsolutePath()];

		String[] wArgs = ["src/main/resources/scripts", wScript];
		Binding binding = new Binding(engineArgs);
    String fileContents = new File('cts-ccm-plan-config.xml').text
		Node wRootNode =parser.parseText(fileContents);
		binding.setProperty(propertyRoot, wRootNode);
		GroovyScriptEngine engine = new GroovyScriptEngine(roots);
		//binding = null;
		engine.run(wScript, binding);
		XmlNodePrinter printer = new XmlNodePrinter();
		printer.setPreserveWhitespace(true);
		//printer.print((Node) binding.getProperty(propertyRoot));
		printer.print(wRootNode);
    assertInstallation(wRootNode)
	}

  private void assertInstallation(def rootNode) {
    Assert.assertNotNull(rootNode."**".plan.find { it.@id == "jackson-core-2.7.8-plan" });
		
    Assert.assertNotNull(rootNode."**".plan.find { it.@id == "jackson-databind-2.7.8-plan" });    
    Assert.assertNotNull(rootNode."**".plan.find { it.@id == "jackson-dataformat-cbor-2.7.8-plan" });    
    Assert.assertNotNull(rootNode."**".plan.find { it.@id == "jackson-annotations-2.8.5-plan" });    

		Assert.assertNotNull(rootNode."**".plan.find { it.@id == "com-cobiscorp-jjwt-plan" });
    Assert.assertNotNull(rootNode."**".plan.find { it.@id == "cts-web-token-plan" });
    
    Assert.assertNotNull(rootNode."**".plan.find { it.@id == "cobis-cobisclouddevicemanagement-util-plan" }); 
    Assert.assertNotNull(rootNode."**".plan.find { it.@id == "cobis-cobisclouddevicemanagement-bsl-plan" }); 
    Assert.assertNotNull(rootNode."**".plan.find { it.@id == "cobis-cobisclouddevicemanagement-bsl-impl-plan" }); 
    Assert.assertNotNull(rootNode."**".plan.find { it.@id == "cobis-cobisclouddevicemanagement-rest-plan" }); 
    Assert.assertNotNull(rootNode."**".plan.find { it.@id == "cobis-cobiscloudsecurity-rest-plan" }); 

		def nodeSecurityRest = rootNode."**".plan.find { it.@id == "cobis-cobiscloudsecurity-rest-plan" }
		assert "../../CLOUD-MOBILE/plugins/cobis-cobiscloudsecurity-rest-1.0.0.jar" == nodeSecurityRest.plugin.@path[0]

		def node_cobis_cobiscloudloginvalidationext_impl = rootNode."**".plan.find { it.@id == "cobis-cobiscloudloginvalidationext-impl-plan" }
		assert "../../CLOUD-MOBILE/plugins/cobis-cobiscloudloginvalidationext-impl-1.0.0.jar" == node_cobis_cobiscloudloginvalidationext_impl.plugin.@path[0]
		

		def node_mbile_admin_terminalmanagementform_services = rootNode."**".plugin.find { it.@name == "mbile.admin.terminalmanagementform.services" }
		assert "../../CLOUD-MOBILE/mbile.admin.terminalmanagementform.services-1.0.0.jar" == node_mbile_admin_terminalmanagementform_services.@path

		def node_mbile_admin_terminalmanagementform_customevents = rootNode."**".plugin.find { it.@name == "mbile.admin.terminalmanagementform.customevents" }
		assert "../../CLOUD-MOBILE/plugins/mbile.admin.terminalmanagementform.customevents-1.0.0.jar" == node_mbile_admin_terminalmanagementform_customevents.@path


		def nodembile_terminalmanagementform_licensegenerator_api = rootNode."**".plan.find { it.@id == "mbile.terminalmanagementform.licensegenerator-api" }
		assert "../../CLOUD-MOBILE/plugins/cobis-device-command-api-1.0.3.jar" == nodembile_terminalmanagementform_licensegenerator_api.plugin.@path[0]

		def node_mbile_terminalmanagementform_licensegenerator_rest = rootNode."**".plan.find { it.@id == "mbile.terminalmanagementform.licensegenerator-rest" }
		println ("antes:" + node_mbile_terminalmanagementform_licensegenerator_rest.plugin.@path[0])		
		assert "../../CLOUD-MOBILE/plugins/cobis-cloud-device-license-rest-1.0.0.jar" == node_mbile_terminalmanagementform_licensegenerator_rest.plugin.@path[0]



		def pluginCTSHandlers = rootNode."**".plugin.find { it.@name == "CTSHandlers" }
		assert "../plugins/CTSHandlers-1.1.8.1.jar" == pluginCTSHandlers.@path

  }

	@Test
	public void runNewEnv() throws Exception {


		String wScript = "cobis-edit-plan-config.groovy";

		File currentDir=new File("src/main/resources/scripts");
		String[] roots=[currentDir.getAbsolutePath()];

		String[] wArgs = ["src/main/resources/scripts", wScript];

		Binding binding = new Binding(engineArgs);
    String fileContents = new File('cts-ccm-plan-config_pruebas.xml').text
		Node wRootNode =parser.parseText(fileContents);
		binding.setProperty(propertyRoot, wRootNode);
		GroovyScriptEngine engine = new GroovyScriptEngine(roots);
		//binding = null;
		engine.run(wScript, binding);
		XmlNodePrinter printer = new XmlNodePrinter();
		printer.setPreserveWhitespace(true);
		//printer.print((Node) binding.getProperty(propertyRoot));
		printer.print(wRootNode);
    assertInstallation(wRootNode)
    
	}
}
