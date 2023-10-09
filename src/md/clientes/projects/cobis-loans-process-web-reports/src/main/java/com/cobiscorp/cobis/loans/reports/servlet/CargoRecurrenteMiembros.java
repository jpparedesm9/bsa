package com.cobiscorp.cobis.loans.reports.servlet;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.GroupLoanInfResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.CargoRecurrenteMiembrosDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.MemberChargesDTO;
import com.cobiscorp.cobis.loans.reports.impl.CargoRecurrenteListIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "cargoRecurrenteMain") })
public class CargoRecurrenteMiembros implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(CargoRecurrenteMiembros.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Boolean controlReportGeneration(Map<String, Object> arg0) {
		return true;
	}

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logDebug("Inicio CargoRecurrenteMiembros - FORMATO DE DOMICIALICIACION -- getDatasourceReport - GRUP");

		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String applicationCode = (String) params.get(ConstantValue.Params.APPLICATION);
		Services services = new Services();
		
		try {
			logger.logDebug("FORMATO DE DOMICIALICIACION -- getDatasourceReport - GRUP - applicationCode:" + applicationCode);
			if (sessionId != null && applicationCode != null) {
				CargoRecurrenteMiembrosDATABEAN cargoRecurrenteMiembrosDATABEAN = new CargoRecurrenteMiembrosDATABEAN();

				GroupLoanInfResponse[] recurringChargeResponses = services.getRecurringChargeMembers(sessionId, applicationCode, serviceIntegration);

				List<MemberChargesDTO> memberChargesList = CargoRecurrenteListIMPL.getAllRecurringChargeMembers(recurringChargeResponses, sessionId, serviceIntegration);

				cargoRecurrenteMiembrosDATABEAN.setListaMiembros(memberChargesList);

				Collection<CargoRecurrenteMiembrosDATABEAN> collection = new ArrayList<CargoRecurrenteMiembrosDATABEAN>();
				collection.add(cargoRecurrenteMiembrosDATABEAN);
				return new JRBeanCollectionDataSource(collection);
			}

		} catch (Exception e) {
			logger.logError("Error FORMATO DE DOMICIALICIACION -- getDatasourceReport - GRUP", e);
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public String getGeneratedReportFilename(Map<String, Object> arg0) {
		return REPORTING_NAME_FILTER;
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> arg0) {
		return null;
	}

	@Override
	public String getReportLocation(Map<String, Object> arg0) {
		return getFileLocationReport(ConstantValue.JasperPath.CARGO_RECURRENTE_MAIN);
	}

	private String getFileLocationReport(String pagoRecurrenteReportJasper) {
		return ConstantValue.JasperPath.CARGO_RECURRENTE_MAIN;
	}
}
