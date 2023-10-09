package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportRequest;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Functions;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dto.AvalDTO;
import com.cobiscorp.cobis.loans.reports.dto.FormatNumberExpression;
import com.cobiscorp.cobis.loans.reports.dto.PagareDTO;
import com.cobiscorp.cobis.loans.reports.utils.UtilFunctions;

public class PagareListIMPL {
	private static final ILogger logger = LogFactory.getLogger(PagareListIMPL.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;
	private Services services = new Services();
	FormatNumberExpression formatNumberExpression = new FormatNumberExpression();

	public List<PagareDTO> getPagarePrincipal(ReportResponse[] reportResponse, String sessionId, ICTSServiceIntegration serviceIntegration) {
		List<PagareDTO> dataBeanList = new ArrayList<PagareDTO>();
		if (logger.isDebugEnabled()) {
			logger.logDebug("*****>>Inicia getPagarePrincipal");

			if (reportResponse != null) {
				logger.logDebug("*****>>getPagarePrincipal - size:" + reportResponse.length);

				if (reportResponse.length > 0) {
					for (int i = 0; i < reportResponse.length; i++) {
						logger.logDebug("*****>>getPagarePrincipal - NumBanco:" + reportResponse[i].getBank());
						ReportRequest reportRequest = new ReportRequest();
						reportRequest.setOperation("Q");
						reportRequest.setOption("1");
						reportRequest.setBank(reportResponse[i].getBank());
						reportRequest.setDateFormat(ConstantValue.Params.FORMAT_DATE);
						ReportResponse reportResponsePayment = new ReportResponse();
						reportResponsePayment = services.getPayment(sessionId, reportRequest, serviceIntegration);
						getPagareDetail(reportResponse, reportResponsePayment, dataBeanList);
					}
				} else {
					this.initListPagareDetail(dataBeanList);
				}
			} else {
				this.initListPagareDetail(dataBeanList);
			}
		}
		return dataBeanList;
	}

	public void getPagareDetail(ReportResponse[] reportResponse, ReportResponse reportResponsePayment, List<PagareDTO> dataBeanList) {
		PagareDTO pagare = new PagareDTO();
		if (reportResponsePayment != null) {
			pagare.setNombreCamp01(reportResponsePayment.getClient());
			pagare.setMontoOtorgadoCamp02(Functions.changeCurrencyDouble(reportResponsePayment.getAmount()) + " "+ reportResponsePayment.getAmountLetter());
			pagare.setaPartirCamp03(reportResponsePayment.getFieldOther());
			pagare.setPlazoCamp04(reportResponsePayment.getTerm());
			pagare.setPeriodicidadCamp05(reportResponsePayment.getPeriodicity());
			pagare.setPagoMensualCamp06(Functions.changeCurrencyDouble(reportResponsePayment.getPayment())+ " "+ reportResponsePayment.getWeeklyPaymentLetter());
			pagare.setMontoPagoFinalCamp07(Functions.changeCurrencyDouble(reportResponsePayment.getAmountFinal())+ " "+ reportResponsePayment.getAmountFinalLetter());
			pagare.setTasaCamp08(reportResponsePayment.getRate());
			pagare.setFechaCamp09(reportResponsePayment.getDateApproval());
			logger.logDebug("----->>>AAAAA-getPagareDetail-reportResponsePayment.getClient():" + reportResponsePayment.getClient());
			logger.logDebug("----->>>AAAAA-getPagareDetail-reportResponsePayment.getAmount():" + reportResponsePayment.getAmount());
			pagare.setNumCreditoCamp10(reportResponsePayment.getBank());
			pagare.setFechaEmiCamp11(UtilFunctions.ddMMyy(reportResponsePayment.getDate(), "de", "del"));
			pagare.setNombreSuscriptor(reportResponsePayment.getClient());
			List<AvalDTO> avalDTO = new ArrayList<AvalDTO>();
			avalDTO = avalList(reportResponse, reportResponsePayment, avalDTO);

			pagare.setAval(avalDTO);
			dataBeanList.add(pagare);
		} else {
			this.initListPagareDetail(dataBeanList);
		}
	}

	public List<PagareDTO> initListPagareDetail() {
		List<PagareDTO> pagareList = new ArrayList<PagareDTO>();
		PagareDTO pagare = new PagareDTO();
		pagare.setNombreCamp01("");
		pagare.setMontoOtorgadoCamp02("0.0");
		pagare.setaPartirCamp03("");
		pagare.setPlazoCamp04("");
		pagare.setPeriodicidadCamp05("");
		pagare.setPagoMensualCamp06("0.0");
		pagare.setMontoPagoFinalCamp07("0.0");
		pagare.setTasaCamp08(0.0);
		pagare.setFechaCamp09("");
		pagare.setNumCreditoCamp10("");
		pagare.setFechaEmiCamp11("");
		pagare.setNombreSuscriptor("");
		List<AvalDTO> avalDTO = new ArrayList<AvalDTO>();
		pagare.setAval(avalDTO);
		pagareList.add(pagare);
		return pagareList;
	}

	public void initListPagareDetail(List<PagareDTO> dataBeanList) {
		PagareDTO pagare = new PagareDTO();
		pagare.setNombreCamp01("");
		pagare.setMontoOtorgadoCamp02("0.0");
		pagare.setaPartirCamp03("");
		pagare.setPlazoCamp04("");
		pagare.setPeriodicidadCamp05("");
		pagare.setPagoMensualCamp06("0.0");
		pagare.setMontoPagoFinalCamp07("0.0");
		pagare.setTasaCamp08(0.0);
		pagare.setFechaCamp09("");
		pagare.setNumCreditoCamp10("");
		pagare.setFechaEmiCamp11("");
		pagare.setNombreSuscriptor("");
		List<AvalDTO> avalDTO = new ArrayList<AvalDTO>();
		pagare.setAval(avalDTO);
		dataBeanList.add(pagare);
	}

	private List<AvalDTO> avalList(ReportResponse[] reportResponse, ReportResponse reportResponsePayment, List<AvalDTO> avalDTOList) {
		logger.logDebug("----->>>AAAAA-reportResponse:" + reportResponse);
		logger.logDebug("----->>>AAAAA-reportResponsePayment:" + reportResponsePayment);
		logger.logDebug("----->>>AAAAA-reportResponsePayment.getOperationType():" + reportResponsePayment.getOperationType());

		if (reportResponse != null && reportResponsePayment != null) {
			if (ConstantValue.Params.GROUP.equals(reportResponsePayment.getOperationType())) {
				for (ReportResponse rp : reportResponse) {
					logger.logDebug("----->>>AAAAA-reportResponsePayment.getBank():" + reportResponsePayment.getBank());
					logger.logDebug("----->>>AAAAA-reportResponsePayment.getRole():" + reportResponsePayment.getRole());
					logger.logDebug("----->>>AAAAA-rp.getBank():" + rp.getBank());
					logger.logDebug("----->>>AAAAA-rp.getRole():" + rp.getRole());
					logger.logDebug("----->>>AAAAA-ConstantValue.Member.MEMBER):" + ConstantValue.Member.MEMBER);

					if (!reportResponsePayment.getBank().equals(rp.getBank())) {						
						if (reportResponsePayment.getRole().equals(ConstantValue.Member.MEMBER)) {		
							if (rp.getRole().equals(ConstantValue.Member.PRESIDENT) || rp.getRole().equals(ConstantValue.Member.TREASURER)) {
								AvalDTO aval = new AvalDTO();
								aval.setNombreAval(rp.getClient());
								avalDTOList.add(aval);
							}
						}
						if (reportResponsePayment.getRole().equals(ConstantValue.Member.PRESIDENT)) {
							if (rp.getRole().equals(ConstantValue.Member.TREASURER) || rp.getRole().equals(ConstantValue.Member.SECRETARY)) {
								AvalDTO aval = new AvalDTO();
								aval.setNombreAval(rp.getClient());
								avalDTOList.add(aval);
							}
						}
						if (reportResponsePayment.getRole().equals(ConstantValue.Member.TREASURER)) {
							if (rp.getRole().equals(ConstantValue.Member.PRESIDENT) || rp.getRole().equals(ConstantValue.Member.SECRETARY)) {
								AvalDTO aval = new AvalDTO();
								aval.setNombreAval(rp.getClient());
								avalDTOList.add(aval);
							}
						}
						if (reportResponsePayment.getRole().equals(ConstantValue.Member.SECRETARY)) {
							if (rp.getRole().equals(ConstantValue.Member.PRESIDENT) || rp.getRole().equals(ConstantValue.Member.TREASURER)) {
								AvalDTO aval = new AvalDTO();
								aval.setNombreAval(rp.getClient());
								avalDTOList.add(aval);
							}
						}
					}
				}
			}
		} else {
			AvalDTO aval = new AvalDTO();
			aval.setNombreAval(reportResponsePayment.getAvalName());
			avalDTOList.add(aval);
		}
		return avalDTOList;
	}
}
