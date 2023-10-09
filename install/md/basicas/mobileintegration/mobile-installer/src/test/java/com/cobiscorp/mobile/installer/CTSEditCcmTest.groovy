package com.cobiscorp.mobile.installer
;

import javax.xml.parsers.ParserConfigurationException

import junit.framework.Assert

import org.junit.Before
import org.junit.Test
import org.xml.sax.SAXException

import com.cobiscorp.cobis.installer.jobs.EditConfigurationJob

public class CTSEditCcmTest {

	private EditConfigurationJob job;
	private static final String propertyRoot = "root";
	private  XmlParser parser;
	private String[] engineArgs
	private String COBIS_HOME = "src/test/resources/COBIS_HOME"	
	private String APP_NAME = "CLOUD-MOBILE"

	String script
	File currentDir
	String[] roots
	String[] args
	Binding binding

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

		script = "cts-edit-ccm.groovy";
		currentDir=new File("src/main/resources/scripts");
		roots=[currentDir.getAbsolutePath()];
		args = ["src/main/resources/scripts", script];
		binding = new Binding(engineArgs);

	}
	
	@Test
	public void runUpdateEnv() throws Exception {
		
    String fileContents = new File('src/test/resources/samplefiles/cts-ccm-config.xml').text
		Node wRootNode =parser.parseText(fileContents);
		binding.setProperty(propertyRoot, wRootNode);
		GroovyScriptEngine engine = new GroovyScriptEngine(roots);
		//binding = null;
		engine.run(script, binding);
		XmlNodePrinter printer = new XmlNodePrinter();
		printer.setPreserveWhitespace(true);
		//printer.print((Node) binding.getProperty(propertyRoot));
		printer.print(wRootNode);
    assertInstallation(wRootNode)
	}

  private void assertInstallation(def rootNode) {
		def nodePropertyExtra = rootNode."**".property.find { it.@name == "org.osgi.framework.system.packages.extra" }
		assert nodePropertyExtra.@value.contains("org.apache.logging.log4j")

  }

	@Test
	public void runNewEnv() throws Exception {
    String fileContents = new File('src/test/resources/samplefiles/cts-ccm-config-pruebas.xml').text
		Node wRootNode =parser.parseText(fileContents);
		binding.setProperty(propertyRoot, wRootNode);
		GroovyScriptEngine engine = new GroovyScriptEngine(roots);
		//binding = null;
		engine.run(script, binding);
		XmlNodePrinter printer = new XmlNodePrinter();
		printer.setPreserveWhitespace(true);
		//printer.print((Node) binding.getProperty(propertyRoot));
		printer.print(wRootNode);
    assertInstallation(wRootNode)
    
	}
}
