package com.cobiscorp.ecobis.external.services.extractor;

import com.cobiscorp.cobis.commons.components.ComponentLocator;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.external.services.bl.IExternalService;

public class ExternalExtractor {

	private static ILogger logger = LogFactory.getLogger(ExternalExtractor.class);

	/**
	 * Execute the instance of Extractor
	 * 
	 * @param String
	 *            filtro The <tt>name</tt> of instance of extractor
	 * @param IProcedureRequest
	 *            request <tt>IProcedureRequest</tt> request
	 * @return String with the execution of extractor class
	 * @throws Exception
	 *             If exist some problems during the execution of extractor
	 *             instance
	 */

	public Object getObject(String filtro, Object... values) {
		try {

			logger.logDebug("Start getValue in ExternalExtractor");

			ComponentLocator componetlocator = ComponentLocator.getInstance(this);

			IExternalService extractor = componetlocator.find(IExternalService.class, filtro);

			if (extractor == null) {
				logger.logError("There is no indicated instance for " + filtro);
				throw new BusinessException(7300026, "Operation failure. Contact Administrator");
			}

			return extractor.executeService(values);

		} catch (BusinessException be) {
			logger.logError("Error at getting " + filtro, be);
			throw be;
		} catch (Exception e) {
			logger.logError("Error", e);

			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug("Finish getValue in ExternalExtractor");
		}

	}
}
