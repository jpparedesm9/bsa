package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.math.BigDecimal;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SalesChiefCommissionDetResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SalesCommissionDetResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SalesCommissionRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SalesCommissionResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Convert;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.busin.model.ExecutiveBonusDetails;
import com.cobiscorp.cobis.busin.model.ExecutiveBonusDetailsRisk;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class BonusManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(BonusManagement.class);
	private SalesCommissionDetResponse[] salesCommissionDetResponselist;
	private SalesCommissionResponse salesCommissionResponse;
	private SalesChiefCommissionDetResponse[] salesChiefCommissionDetResponseList;

	public BonusManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public SalesCommissionDetResponse[] getSalesCommissionDetResponselist() {
		return salesCommissionDetResponselist;
	}

	public SalesCommissionResponse getSalesCommissionResponse() {
		return salesCommissionResponse;
	}

	public SalesChiefCommissionDetResponse[] getSalesChiefCommissionDetResponseList() {
		return salesChiefCommissionDetResponseList;
	}

	public boolean updateBonus(int code, int detailCode, double totalModify, String observation, ICommonEventArgs arg1, BehaviorOption options) {
		SalesCommissionRequest salesCommissionRequest = new SalesCommissionRequest();
		salesCommissionRequest.setMode(Mnemonic.CHAR_2);
		salesCommissionRequest.setCodeCab(code);
		salesCommissionRequest.setCodeDetail(detailCode);
		salesCommissionRequest.setTotalModify(totalModify);
		salesCommissionRequest.setObservation(observation);
		return updateSalesCommission(salesCommissionRequest, arg1, options);
	}

	public boolean approveBonus(char mode, Integer code, ICommonEventArgs arg1, BehaviorOption options) {
		SalesCommissionRequest salesCommissionRequest = new SalesCommissionRequest();
		salesCommissionRequest.setMode(mode);
		salesCommissionRequest.setCodeCab(code);
		return updateSalesCommission(salesCommissionRequest, arg1, options);
	}

	public boolean updateSalesCommission(SalesCommissionRequest salesCommissionRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestReportTO = new ServiceRequestTO();
		serviceRequestReportTO.getData().put(RequestName.INSALESCOMMISSIONREQUEST, salesCommissionRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATESALESCOMMISSION, serviceRequestReportTO);
		if (!serviceResponse.isResult()) {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return serviceResponse.isResult();
	}

	public SalesCommissionResponse[] getSalesCommissionDate(char mode, ICommonEventArgs arg1, BehaviorOption options) {
		SalesCommissionRequest salesCommissionRequest = new SalesCommissionRequest();
		salesCommissionRequest.setMode(mode);
		salesCommissionRequest.setFormatDate(SessionContext.getFormatDate());
		ServiceRequestTO serviceRequestItemsTO = new ServiceRequestTO();
		serviceRequestItemsTO.getData().put(RequestName.INSALESCOMMISSIONREQUEST, salesCommissionRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEGETSALESCOMMISSIONDATE, serviceRequestItemsTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Fechas de Bonos Ejecutivos Gerenciales recuperados exitosamente");
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (SalesCommissionResponse[]) serviceResponseTO.getValue(ReturnName.RETURNSALESCOMMISSIONRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return null;
		}
	}

	public boolean getSalesCommission(Integer codigo, String courtDate, char type, ICommonEventArgs arg1, BehaviorOption options) {
		this.salesCommissionDetResponselist = null;
		this.salesCommissionResponse = null;

		SalesCommissionRequest salesCommissionRequest = new SalesCommissionRequest();// @i_modo=3
		salesCommissionRequest.setFormatDate(SessionContext.getFormatDate());
		salesCommissionRequest.setCodeCab(codigo);
		salesCommissionRequest.setCourtDate(courtDate);
		salesCommissionRequest.setType(type);
		ServiceRequestTO serviceRequestItemsTO = new ServiceRequestTO();
		serviceRequestItemsTO.getData().put(RequestName.INSALESCOMMISSIONREQUEST, salesCommissionRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESHEARSSALESCOMMISSION, serviceRequestItemsTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("bono Ejecutivos recuperados para fecha:" + courtDate);

			ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();
			SalesCommissionResponse[] templist = (SalesCommissionResponse[]) serviceResponseItemsTO.getValue(ReturnName.RETURNSALESCOMMISSIONRESPONSE);
			if (templist != null && templist.length > 0) {
				salesCommissionResponse = templist[0];
			} else {
				return false;
			}
			this.salesCommissionDetResponselist = (SalesCommissionDetResponse[]) serviceResponseItemsTO.getValue(ReturnName.RETURNSALESCOMMISSIONDETRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return serviceResponse.isResult();
	}

	public static DataEntityList getSales(SalesCommissionDetResponse[] salesCommissionReportResponseDetlist) {
		DataEntityList dataEntityList = new DataEntityList();
		BigDecimal zero = new BigDecimal(0);
		logger.logDebug("Ingresa metodo getSales");
		logger.logDebug("salesCommissionDetResponse" + salesCommissionReportResponseDetlist.length);
		for (SalesCommissionDetResponse salesCommissionDetResponse : salesCommissionReportResponseDetlist) {
			DataEntity dataEntity = new DataEntity();
			dataEntity.set(ExecutiveBonusDetails.IDCODE, salesCommissionDetResponse.getCodeCab());
			dataEntity.set(ExecutiveBonusDetails.IDCODEDETAIL, salesCommissionDetResponse.getCodeDet());
			dataEntity.set(ExecutiveBonusDetails.IDOFFICER, salesCommissionDetResponse.getOfficerCode());
			dataEntity.set(ExecutiveBonusDetails.OFFICERNAME, salesCommissionDetResponse.getOfficerName());
			dataEntity.set(ExecutiveBonusDetails.CATEGORY, salesCommissionDetResponse.getCategory());
			dataEntity.set(ExecutiveBonusDetails.LEVEL, salesCommissionDetResponse.getLevel());
			dataEntity.set(ExecutiveBonusDetails.PORTFOLIOBALANCE, Convert.DoubleToBigDecimal(salesCommissionDetResponse.getPortfolioBalance(), zero));
			dataEntity.set(ExecutiveBonusDetails.CUSTOMERSNUMBRES, salesCommissionDetResponse.getCustomersNumbres());
			dataEntity.set(ExecutiveBonusDetails.WEIGHTEDARREARS, salesCommissionDetResponse.getWeightedArrears());
			dataEntity.set(ExecutiveBonusDetails.VIEWNUMBERS, salesCommissionDetResponse.getViewNumbers());
			dataEntity.set(ExecutiveBonusDetails.CUSTOMERRETENTION, salesCommissionDetResponse.getCustomerRetention());
			dataEntity.set(ExecutiveBonusDetails.PORTFOLIOGROWTH, Convert.DoubleToBigDecimal(salesCommissionDetResponse.getPortfolioGrowth(), zero));
			dataEntity.set(ExecutiveBonusDetails.VARA1, Convert.DoubleToBigDecimal(salesCommissionDetResponse.getVarA1(), zero));
			dataEntity.set(ExecutiveBonusDetails.VARA2, Convert.DoubleToBigDecimal(salesCommissionDetResponse.getVarA2(), zero));
			dataEntity.set(ExecutiveBonusDetails.VARB1, Convert.DoubleToBigDecimal(salesCommissionDetResponse.getVarB1(), zero));
			dataEntity.set(ExecutiveBonusDetails.VARB2, Convert.DoubleToBigDecimal(salesCommissionDetResponse.getVarB2(), zero));
			dataEntity.set(ExecutiveBonusDetails.VARC, Convert.DoubleToBigDecimal(salesCommissionDetResponse.getVarC(), zero));
			dataEntity.set(ExecutiveBonusDetails.VARD1, Convert.DoubleToBigDecimal(salesCommissionDetResponse.getVarD1(), zero));
			dataEntity.set(ExecutiveBonusDetails.VARD2, Convert.DoubleToBigDecimal(salesCommissionDetResponse.getVarD2(), zero));
			dataEntity.set(ExecutiveBonusDetails.VARE, Convert.DoubleToBigDecimal(salesCommissionDetResponse.getVarE(), zero));
			dataEntity.set(ExecutiveBonusDetails.TOTAL, Convert.DoubleToBigDecimal(salesCommissionDetResponse.getTotalSystem(), zero));
			dataEntity.set(ExecutiveBonusDetails.TOTALMODIFYEXECUTIVE, Convert.DoubleToBigDecimal(salesCommissionDetResponse.getTotalModify(), zero));
			dataEntity.set(ExecutiveBonusDetails.TOTALPREVIOUS, Convert.DoubleToBigDecimal(salesCommissionDetResponse.getPreviusTotalSystem(), zero));
			dataEntity.set(ExecutiveBonusDetails.OBSERVATION, (salesCommissionDetResponse.getObservation() != null) ? salesCommissionDetResponse.getObservation() : "");
			dataEntity.set(ExecutiveBonusDetails.TOTALMODIFIEDMONTHPREVIOUS, Convert.DoubleToBigDecimal(salesCommissionDetResponse.getTotalModMonthPrevious(), zero));
			dataEntityList.add(dataEntity);
		}
		return dataEntityList;
	}

	public boolean getSalesChiefExecutive(Integer codigo, String courtDate, ICommonEventArgs arg1, BehaviorOption options) {
		this.salesChiefCommissionDetResponseList = null;

		SalesCommissionRequest salesCommissionRequest = new SalesCommissionRequest();// @i_modo=4
		salesCommissionRequest.setFormatDate(SessionContext.getFormatDate());
		salesCommissionRequest.setCodeCab(codigo);
		salesCommissionRequest.setCourtDate(courtDate);
		ServiceRequestTO serviceRequestItemsTO = new ServiceRequestTO();
		serviceRequestItemsTO.getData().put(RequestName.INSALESCOMMISSIONREQUEST, salesCommissionRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SEARCHSALESCHIEFEXECUTIVE, serviceRequestItemsTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Bono Ejecutivos Gerenciales recuperados para fecha:" + courtDate);
			ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();
			this.salesChiefCommissionDetResponseList = (SalesChiefCommissionDetResponse[]) serviceResponseItemsTO.getValue(ReturnName.RETURNSALESCHIEFCOMMISSIONDETRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return serviceResponse.isResult();
	}

	public static DataEntityList getSalesChiefExecutive(SalesChiefCommissionDetResponse[] salesCommissionlist) {
		DataEntityList dataEntityList = new DataEntityList();
		BigDecimal zero = new BigDecimal(0);

		for (SalesChiefCommissionDetResponse salesCommissionDTO : salesCommissionlist) {
			DataEntity dataEntity = new DataEntity();
			dataEntity.set(ExecutiveBonusDetailsRisk.AGENCYID, salesCommissionDTO.getCode());
			dataEntity.set(ExecutiveBonusDetailsRisk.OFFICERNAME, salesCommissionDTO.getOfficerName());
			dataEntity.set(ExecutiveBonusDetailsRisk.POSITIONDESCRIPTION, Convert.IntegerToString(salesCommissionDTO.getPosition(), ""));
			dataEntity.set(ExecutiveBonusDetailsRisk.OFFICEID, salesCommissionDTO.getOfficeCode());
			dataEntity.set(ExecutiveBonusDetailsRisk.RATEDESCRIPTION, salesCommissionDTO.getRateDetail());
			dataEntity.set(ExecutiveBonusDetailsRisk.TOTALAMOUNT, Convert.DoubleToBigDecimal(salesCommissionDTO.getTotalAmount(), zero));
			dataEntity.set(ExecutiveBonusDetailsRisk.TOTALBONUS, Convert.DoubleToBigDecimal(salesCommissionDTO.getTotalBonus(), zero));
			dataEntity.set(ExecutiveBonusDetailsRisk.TOTALBONUSPREVIOUS, Convert.DoubleToBigDecimal(salesCommissionDTO.getPreviusTotalBonus(), zero));
			dataEntityList.add(dataEntity);
		}
		return dataEntityList;
	}

}
