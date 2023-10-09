package cobis.web.collateral.views;

import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceRegistration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.plugin.activator.HttpServiceActivator;
import com.cobiscorp.cobis.web.service.container.IContainerConfiguration;
import com.cobiscorp.cobis.web.service.container.impl.ContainerConfiguration;

public class Activator extends HttpServiceActivator {
	private static ILogger logger = LogFactory.getLogger(Activator.class);
	private ServiceRegistration<IContainerConfiguration> serviceRegistration;

	@Override
	protected String getContextRoot() {
		return "/cobis/web/collateral";
	}

	@Override
	public void loadHttpService() {
		// register the directory for html files
		registerDirectory("views/collateral", "views/collateral", true);
	}

	@Override
	public void continueStart() throws Exception {
		BundleContext context = this.getBundleContext();
		IContainerConfiguration loadConfigContainer = new ContainerConfiguration();
		this.serviceRegistration = context.registerService(
				IContainerConfiguration.class, loadConfigContainer, null);
		super.continueStart();
	}

	@Override
	public void continueStop() throws Exception {
		this.serviceRegistration.unregister();
		super.continueStop();
	}

	@Override
	protected void loadConfiguration() throws Exception {
		String pathConfig = "/services-as/cobis-web-container/cobis-web-container-config.xml";
		if (logger.isDebugEnabled())
			logger.logDebug("loadConfiguration: " + pathConfig);
		this.registerService(IContainerConfiguration.class, pathConfig);
	}

	private void registerDirectory(String logicalName, String physicalName,
			boolean filtering) {
		String pathResources = null;
		if (ContainerConfiguration.getPropertiesContainer().get("useLocalResources") != null)
			pathResources = "file://"
					+ ContainerConfiguration.getPropertiesContainer().get("localResourcesBaseDirectory")
					+ physicalName + "/";
		else
			pathResources = "bundle://" + physicalName + "/";
		if (logger.isDebugEnabled())
			logger.logDebug("Resource directory " + logicalName
					+ " registered in: " + pathResources);
		this.registerResources("/" + logicalName, pathResources, filtering);
	}

}
