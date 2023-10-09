package com.cobiscorp.cobis.assts.customevents.baseevents;

import java.math.BigDecimal;

import cobiscorp.ecobis.assets.cloud.dto.GeneralDataCurrency;
import cobiscorp.ecobis.assets.cloud.dto.GeneralDataMarket;
import cobiscorp.ecobis.assets.cloud.dto.GeneralDataResponse;
import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.ColumnsDataValue;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class GeneralInformationQueryBaseEvent extends BaseEvent {

	private static final ILogger logger = LogFactory
			.getLogger(GeneralInformationQueryBaseEvent.class);

	public GeneralInformationQueryBaseEvent(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void twoGeneralDataMarket(DataEntity item,
			GeneralDataMarket[] itemsResponseMarket) {
		try {

			for (GeneralDataMarket itemsMarket : itemsResponseMarket) {

				String col16 = ifGeneralDataCurrencyO(itemsMarket);
				item.set(ColumnsDataValue.COL16, col16);
				item.set(ColumnsDataValue.COL61, itemsMarket.getCampDet());
				String col17 = ifGeneralDataCurrencyT(itemsMarket);

				item.set(ColumnsDataValue.COL17, col17);
				item.set(ColumnsDataValue.COL60,
						Integer.toString(itemsMarket.getCampana()));
				item.set(ColumnsDataValue.COL100,
						itemsMarket.getDescSituacion());
				item.set(ColumnsDataValue.COL102, "".equals(itemsMarket
						.getTotalDesCasual().trim()) ? null : itemsMarket
						.getTotalDesCasual().trim());
				String col103 = ifGeneralDataCurrencyTh(itemsMarket);

				item.set(ColumnsDataValue.COL103, col103);
				break;
			}
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("extwoGeneralDataMarket ", e);
			}
		}
	}

	public String ifGeneralDataCurrencyO(GeneralDataMarket itemsMarket) {
		String col16 = null;
		String col16Aux = null;
		if (itemsMarket.getCalifOrig() != null)
			col16 = itemsMarket.getCalifOrig();
		if (itemsMarket.getDesCalifOrig() != null)
			col16Aux = itemsMarket.getDesCalifOrig();

		col16 = (col16 != null) ? ((col16Aux != null) ? (col16 + " - " + col16Aux)
				: col16)
				: ((col16Aux != null) ? col16Aux : null);

		return col16;

	}

	public String ifGeneralDataCurrencyT(GeneralDataMarket itemsMarket) {
		String col17 = null;
		String col17Aux = null;
		if (itemsMarket.getCalifSegui() != null)
			col17 = itemsMarket.getCalifSegui();
		if (itemsMarket.getDescCalifSegui() != null)
			col17Aux = itemsMarket.getDescCalifSegui();

		col17 = (col17 != null) ? ((col17Aux != null) ? (col17 + " - " + col17Aux)
				: col17)
				: ((col17Aux != null) ? col17Aux : null);

		return col17;

	}

	public String ifGeneralDataCurrencyTh(GeneralDataMarket itemsMarket) {
		String col103 = null;
		String col103Aux = null;
		if (itemsMarket.getCodActividad() != null)
			col103 = itemsMarket.getCodActividad();
		if (itemsMarket.getDesActprod() != null)
			col103Aux = itemsMarket.getDesActprod();

		col103 = (col103 != null) ? ((col103Aux != null) ? (col103 + " - " + col103Aux)
				: col103)
				: ((col103Aux != null) ? col103Aux : null);

		return col103;
	}

	public String generalDataClaseCartera(GeneralDataResponse itemsResponse) {
		String col91 = null;
		String col91Aux = null;

		if (itemsResponse.getPortfolioClassDesc() != null)
			col91 = itemsResponse.getPortfolioClassDesc();
		if (itemsResponse.getNatureDesc() != null)
			col91Aux = itemsResponse.getNatureDesc();

		col91 = (col91 != null) ? ((col91Aux != null) ? (col91 + " - " + col91Aux)
				: col91)
				: ((col91Aux != null) ? col91Aux : null);

		return col91;

	}

	public String generalDataLineaCre(GeneralDataResponse itemsResponse,
			DataEntity loan) {
		String col89 = null;
		String col89Aux = null;

		if (loan.get(Loan.OPERATIONTYPE) != null)
			col89 = loan.get(Loan.OPERATIONTYPE);
		if (itemsResponse.getTypeDesc() != null)
			col89Aux = itemsResponse.getTypeDesc();

		col89 = (col89 != null) ? ((col89Aux != null) ? (col89 + " - " + col89Aux)
				: col89)
				: ((col89Aux != null) ? col89Aux : null);

		return col89;

	}

	public String generalDataPlazo(GeneralDataResponse itemsResponse) {
		String col18 = null;
		String col18Aux = null;
				

		if (itemsResponse.getTermDesc() != null)
			col18 = itemsResponse.getTermDesc();
		if (itemsResponse.getTerm() != 0)
			col18Aux = String.valueOf(itemsResponse.getTerm());

		col18 = (col18 != null) ? ((col18Aux != "0") ? (col18 + " - " + col18Aux)
				: col18)
				: ((col18Aux != "0") ? col18Aux : null);

		return col18;

	}
	public String generalDataPagCap(GeneralDataResponse itemsResponse) {
		String col22 = null;
		String col22Aux = null;				
		
		if (itemsResponse.getPeriodCap() != 0)
			col22 = String.valueOf(itemsResponse.getPeriodCap());
		if (itemsResponse.getDividendoDes() != null)
			col22Aux = itemsResponse.getDividendoDes();

		col22 = (col22 != "0") ? ((col22Aux != null) ? (col22 + " - " + col22Aux)
				: col22)
				: ((col22Aux != null) ? col22Aux : null);

		return col22;

	}
	public String generalDataPagInt(GeneralDataResponse itemsResponse) {
		String col23 = null;
		String col23Aux = null;				
		
		if (itemsResponse.getPeriodInt() != 0)
			col23 = String.valueOf(itemsResponse.getPeriodInt());
		if (itemsResponse.getDividendoDes() != null)
			col23Aux = itemsResponse.getDividendoDes();

		col23 = (col23 != "0") ? ((col23Aux != null) ? (col23 + " - " + col23Aux)
				: col23)
				: ((col23Aux != null) ? col23Aux : null);

		return col23;

	}	
	
	public void ifGeneralInformationAllOne(GeneralDataResponse itemsResponse,
			DataEntity item) {
		if (9 == itemsResponse.getPrdCobis()) {
			item.set(ColumnsDataValue.COL101, itemsResponse.getRefExterior());
			item.set(ColumnsDataValue.COL121, itemsResponse.getShippingDate());
			item.set(ColumnsDataValue.COL122, itemsResponse.getDexDay());
			item.set(ColumnsDataValue.COL123, itemsResponse.getNumDebtExt());
		}

		if (itemsResponse.getSubtype() != null
				&& !"".equals(itemsResponse.getSubtype().trim())
				&& "P".equals(itemsResponse.getSubtype().trim())) {
			item.set(ColumnsDataValue.COL120, Parameter.EXTENSION);
		}

		if (itemsResponse.getSubtype() != null
				&& "F".equals(itemsResponse.getSubtype().trim())) {
			item.set(ColumnsDataValue.COL120, Parameter.FUSION);
		}

		if (itemsResponse.getReestructuration() != null
				&& "".equals(itemsResponse.getReestructuration().trim())) {
			item.set(ColumnsDataValue.COL119, Parameter.NONE);
		}
	}

	public void ifGeneralInformationAlltw(GeneralDataResponse itemsResponse,
			DataEntity item) {
		String vlcjur;
		if (itemsResponse.getType() != null
				&& "".equals(itemsResponse.getType().trim())) {
			item.set(ColumnsDataValue.COL115,
					Integer.toString(itemsResponse.getGroupFact()));
		} else if (itemsResponse.getType() != null
				&& "R".equals(itemsResponse.getType().trim())) {
			vlcjur = (itemsResponse.getGroupFact() == 97) ? Parameter.YES
					: Parameter.NO;
			item.set(ColumnsDataValue.COL129,
					itemsResponse.getOpExternalPassive());
			item.set(ColumnsDataValue.COL130,
					String.valueOf(itemsResponse.getOpRediscountMargin()));
			item.set(ColumnsDataValue.COL131, vlcjur);
		}

		if (itemsResponse.getType() != null
				&& "C".equals(itemsResponse.getType())) {
			item.set(ColumnsDataValue.COL129,
					itemsResponse.getOpExternalPassive());
			item.set(ColumnsDataValue.COL130,
					String.valueOf(itemsResponse.getOpRediscountMargin()));
		}

		if (itemsResponse.getReestructuration() != null
				&& "".equals(itemsResponse.getReestructuration().trim())) {
			item.set(ColumnsDataValue.COL119, Parameter.NO);
		} else
			item.set(ColumnsDataValue.COL119,
					itemsResponse.getReestructuration());

	}

	public void ifGeneralInformationAllth(GeneralDataResponse itemsResponse,
			DataEntity item) {
		if (itemsResponse.getAnticipatedInt() != null
				&& "E".equals(itemsResponse.getAnticipatedInt().trim())) {
			item.set(ColumnsDataValue.COL44, itemsResponse.getAnticipatedInt()
					+ "-" + Parameter.PRESENT_VALUE);
		}
		if (itemsResponse.getAnticipatedInt() != null
				&& "A".equals(itemsResponse.getAnticipatedInt().trim())) {
			item.set(ColumnsDataValue.COL44, itemsResponse.getAnticipatedInt()
					+ "-" + Parameter.ACCUMULATED_VALUES);
		}
		if (itemsResponse.getAnticipatedInt() != null
				&& "P".equals(itemsResponse.getAnticipatedInt().trim())) {
			item.set(ColumnsDataValue.COL44, itemsResponse.getAnticipatedInt()
					+ "-" + Parameter.PROJECTED_VALUES);
		}

		if (itemsResponse.getReduction() != null
				&& "N".equals(itemsResponse.getReduction().trim())) {
			item.set(ColumnsDataValue.COL46, itemsResponse.getReduction() + "-"
					+ Parameter.ADVANCE_QUOTAS);
		}

	}

	public void ifGeneralInformationAllFo(GeneralDataResponse itemsResponse,
			DataEntity item) {
		if (itemsResponse.getReduction() != null
				&& "T".equals(itemsResponse.getReduction().trim())) {
			item.set(ColumnsDataValue.COL46, itemsResponse.getReduction() + "-"
					+ Parameter.REDUCTION_TIME);
		}
		if (itemsResponse.getReduction() != null
				&& "C".equals(itemsResponse.getReduction().trim())) {
			item.set(ColumnsDataValue.COL46, itemsResponse.getReduction() + "-"
					+ Parameter.REDUCTION_QUOTA);
		}
		if (itemsResponse.getAmortizationType() != null
				&& Parameter.FRENCH.equals(itemsResponse.getAmortizationType()
						.trim())) {
			item.set(ColumnsDataValue.COL49, Parameter.FIXED_FEE);
		}
		if (itemsResponse.getAmortizationType() != null
				&& Parameter.GERMAN.equals(itemsResponse.getAmortizationType()
						.trim())) {
			item.set(ColumnsDataValue.COL49, Parameter.CONSTANT_CAPITAL);
		}

	}

	public void ifGeneralInformationAllFi(GeneralDataResponse itemsResponse,
			DataEntity item) {

		if (itemsResponse.getAmortizationType() != null
				&& Parameter.MANUAL.equals(itemsResponse.getAmortizationType()
						.trim())) {
			item.set(ColumnsDataValue.COL49, Parameter.MANUAL);
		}
		if (itemsResponse.getCalculationBase() != null
				&& "R".equals(itemsResponse.getCalculationBase().trim())) {
			item.set(ColumnsDataValue.COL111, Parameter.REAL);
		}
		if (itemsResponse.getCalculationBase() != null
				&& "E".equals(itemsResponse.getCalculationBase().trim())) {
			item.set(ColumnsDataValue.COL111, Parameter.COMMERCIAL);
		}

	}

	public void threeGeneralDataCurrency(DataEntity item,
			GeneralDataCurrency[] itemsResponseCurrency) {
		try {
			for (GeneralDataCurrency itemsCurrency : itemsResponseCurrency) {

				item.set(ColumnsDataValue.COL148,
						itemsCurrency.getValorVencido());

				item.set(ColumnsDataValue.COL149,
						itemsCurrency.getValorVencidoRec());

				item.set(ColumnsDataValue.COL150, itemsCurrency.getMonto());
				item.set(ColumnsDataValue.COL151, itemsCurrency.getMontoRec());
				item.set(ColumnsDataValue.COL165, itemsCurrency.getDescuento());
				break;
			}
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("exthreeGeneralDataCurrency ", e);
			}
		}
	}

	public DataEntity generalInformation(DynamicRequest entities) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia generalInformation");
		}

		try {
			ServiceRequestTO request = new ServiceRequestTO();
			ServiceResponse response;
			LoanRequest loanRequest = new LoanRequest();

			DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);

			loanRequest.setCode(loan.get(Loan.LOANBANKID));
			loanRequest.setDateFormat(Parameter.CODEDATEFORMAT);
			request.addValue("inLoanRequest", loanRequest);

			response = execute(getServiceIntegration(), logger,
					Parameter.PROCESS_GENERAL_LOAN_DATA, request);
			DataEntity item = new DataEntity();

			if (!(response.isResult())) {
				return null;
			}
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();

			GeneralDataResponse[] itemsResponseGen = (GeneralDataResponse[]) resultado
					.getValue("returnGeneralDataResponse");
			GeneralDataMarket[] itemsResponseMarket = (GeneralDataMarket[]) resultado
					.getValue("returnGeneralDataMarket");
			GeneralDataCurrency[] itemsResponseCurrency = (GeneralDataCurrency[]) resultado
					.getValue("returnGeneralDataCurrency");

			for (GeneralDataResponse itemsResponse : itemsResponseGen) {
				item.set(ColumnsDataValue.COL3,
						Integer.toString(itemsResponse.getTransactId()));
				item.set(ColumnsDataValue.COL4, itemsResponse.getLinCredit());
				item.set(ColumnsDataValue.COL5, itemsResponse.getStatus());
				item.set(ColumnsDataValue.COL9,
						Integer.toString(itemsResponse.getCurrencyId()));
				item.set(ColumnsDataValue.COL10, itemsResponse.getEntityDesc());

				item.set(ColumnsDataValue.COL11, itemsResponse.getDateEnd());
				item.set(ColumnsDataValue.COL12,
						Integer.toString(itemsResponse.getOficialId()));
				item.set(ColumnsDataValue.COL13, itemsResponse.getDateBegin());
				item.set(ColumnsDataValue.COL14, itemsResponse.getDateEnd());
				
				item.set(ColumnsDataValue.COL18, generalDataPlazo(itemsResponse));						

				BigDecimal col63 = itemsResponse.getAmount().subtract(
						itemsResponse.getCapitalized());
				item.set(ColumnsDataValue.COL63, col63);
				item.set(ColumnsDataValue.COL28, itemsResponse.getDestinyDes());
				item.set(ColumnsDataValue.COL30, itemsResponse.getCityDes());
				item.set(ColumnsDataValue.COL37, itemsResponse.getRenovation());
				item.set(ColumnsDataValue.COL38,
						Integer.toString(itemsResponse.getRenovationNum()));
				item.set(ColumnsDataValue.COL39, itemsResponse.getPrepayment());
				item.set(ColumnsDataValue.COL55, itemsResponse.getOfficceDes());
				item.set(ColumnsDataValue.COL62, itemsResponse.getOptionCap());
				item.set(ColumnsDataValue.COL70,
						Integer.toString(itemsResponse.getOutlay()));
				item.set(ColumnsDataValue.COL71, itemsResponse.getDateLiq());
				item.set(ColumnsDataValue.COL74,
						itemsResponse.getAmountApproved());
				item.set(ColumnsDataValue.COL82,
						itemsResponse.getDateUltProcess());
				item.set(ColumnsDataValue.COL83,
						itemsResponse.getBalanceOperation());
				item.set(ColumnsDataValue.COL84,
						Integer.toString(itemsResponse.getDaysClause()));
				item.set(ColumnsDataValue.COL85,
						itemsResponse.getAppliedClause());
				item.set(ColumnsDataValue.COL88, itemsResponse.getAddressDesc());
				item.set(ColumnsDataValue.COL89,
						generalDataLineaCre(itemsResponse, loan));

				item.set(ColumnsDataValue.COL91,
						generalDataClaseCartera(itemsResponse));

				item.set(ColumnsDataValue.COL92, itemsResponse.getProgramDesc());
				item.set(ColumnsDataValue.COL93,
						itemsResponse.getOriginFundsDesc());
				item.set(ColumnsDataValue.COL94,
						itemsResponse.getQualificationDesc());
				item.set(ColumnsDataValue.COL95,
						Integer.toString(itemsResponse.getNumReest()));
				item.set(ColumnsDataValue.COL96,
						itemsResponse.getOperationBalanFina());
				item.set(ColumnsDataValue.COL97, itemsResponse.getDateUltRees());
				item.set(ColumnsDataValue.COL98,
						itemsResponse.getDayExpiration());

				twoGeneralDataMarket(item, itemsResponseMarket);

				threeGeneralDataCurrency(item, itemsResponseCurrency);

				item.set(ColumnsDataValue.COL106,
						itemsResponse.getTypeEntityDesc());
				item.set(ColumnsDataValue.COL115,
						Integer.toString(itemsResponse.getGroupFact()));
				item.set(ColumnsDataValue.COL116,
						Integer.toString(itemsResponse.getDayCapVen()));
				item.set(ColumnsDataValue.COL117, itemsResponse.getBvirtual());
				item.set(ColumnsDataValue.COL118, itemsResponse.getExtracto());
				item.set(ColumnsDataValue.COL127, itemsResponse.getDesAge());
				item.set(ColumnsDataValue.COL128,
						itemsResponse.getStatusCollection());
				item.set(ColumnsDataValue.COL132, itemsResponse.getNomLawyer());
				item.set(ColumnsDataValue.COL133,
						itemsResponse.getTotalDeferred());
				item.set(ColumnsDataValue.COL134,
						itemsResponse.getPendingDeferral());

				item.set(ColumnsDataValue.COL136, itemsResponse.getPhones());
				item.set(ColumnsDataValue.COL137, itemsResponse.getAddress1());
				item.set(ColumnsDataValue.COL138, itemsResponse.getVlrRecIni());
				item.set(ColumnsDataValue.COL139, itemsResponse.getVlrxAmort());
				item.set(ColumnsDataValue.COL140, itemsResponse.getOpFather());
				item.set(ColumnsDataValue.COL141, itemsResponse.getOpSon());
				item.set(ColumnsDataValue.COL143,
						itemsResponse.getAllianceDesc());
				item.set(ColumnsDataValue.COL144, itemsResponse.getFinagroKey());
				item.set(ColumnsDataValue.COL145, itemsResponse.getFinagro());
				item.set(ColumnsDataValue.COL146, itemsResponse.getFinagroGar());

				// FILL GENERAL CONDITION

				item.set(ColumnsDataValue.COL32, itemsResponse.getProductDes());
				item.set(ColumnsDataValue.COL54,
						String.valueOf(itemsResponse.getDayPay()));
				item.set(ColumnsDataValue.COL77,
						String.valueOf(itemsResponse.getGraceMonth()));						
				item.set(ColumnsDataValue.COL22, generalDataPagCap(itemsResponse));						
				item.set(ColumnsDataValue.COL23, generalDataPagInt(itemsResponse));	
						
				item.set(ColumnsDataValue.COL24,
						String.valueOf(itemsResponse.getPeriodGrac()));
				item.set(ColumnsDataValue.COL25,
						String.valueOf(itemsResponse.getPeriodGracInt()));

				item.set(ColumnsDataValue.COL48,
						String.valueOf(itemsResponse.getDayYear()));
				item.set(ColumnsDataValue.COL112,
						itemsResponse.getRecalculation());
				item.set(ColumnsDataValue.COL81,
						itemsResponse.getAvoidHolidays());
				item.set(ColumnsDataValue.COL113, itemsResponse.getSkilledDay());
				item.set(ColumnsDataValue.COL114, itemsResponse.getUsaRateEq());
				item.set(ColumnsDataValue.COL53,
						String.valueOf(itemsResponse.getDayGrac()));
				item.set(ColumnsDataValue.COL80, itemsResponse.getReajust());
				item.set(ColumnsDataValue.COL34,
						String.valueOf(itemsResponse.getPeriodReaj()));
				item.set(ColumnsDataValue.COL35, itemsResponse.getDateReaj());
				
				item.set(ColumnsDataValue.COL153, itemsResponse.getMembersNumber());
				item.set(ColumnsDataValue.COL154, itemsResponse.getArrears());
				item.set(ColumnsDataValue.COL155, itemsResponse.getLastPaymentDate());
				item.set(ColumnsDataValue.COL156, itemsResponse.getPromotion());
				
				item.set(ColumnsDataValue.COL158, itemsResponse.getApprovedAmount());
				item.set(ColumnsDataValue.COL159, itemsResponse.getBalanceOperation());
				item.set(ColumnsDataValue.COL160, itemsResponse.getAvailable());
				
				item.set(ColumnsDataValue.COL161, col63);//antes monto desembolsado
				
				item.set(ColumnsDataValue.COL162, itemsResponse.getMandatory());
				item.set(ColumnsDataValue.COL163, itemsResponse.getOperationBalanFina());
				

				break;
			}

			entities.setEntity(ColumnsDataValue.ENTITY_NAME, item);
			return item;
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("exGeneralInformation", e);
			}
		}
		return null;
	}

}
