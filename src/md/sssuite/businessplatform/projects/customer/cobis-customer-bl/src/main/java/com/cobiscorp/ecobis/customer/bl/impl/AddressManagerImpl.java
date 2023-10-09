package com.cobiscorp.ecobis.customer.bl.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetBlock;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetData;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.ecobis.customer.bl.AddressManager;
import com.cobiscorp.ecobis.customer.services.dtos.AddressDataResponse;
import com.cobiscorp.ecobis.customer.util.Utils;

public class AddressManagerImpl implements AddressManager {
	private static ILogger logger = LogFactory.getLogger(AddressManagerImpl.class);

	private ISPOrchestrator spOrchestrator;

	public void validateOpen(String name) {
		if (logger.isDebugEnabled())
			logger.logDebug("validateOpen: " + name);
	}

	public List<AddressDataResponse> getAddresses(Integer customer) {

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		List<AddressDataResponse> addresses = new ArrayList<AddressDataResponse>();

		wProcedureRequest = Utils.setHeaderParams(wProcedureRequest);

		if (wProcedureRequest == null) {
			logger.logDebug("ERROR: Se produjo un error al obtener el Contexto de CTS.");
		} else {

			wProcedureRequest.setSpName("cobis..sp_direccion_cons");
			wProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLCHAR, "S");
			wProcedureRequest.addInputParam("@i_ente", ICTSTypes.SQLINT4, customer.toString());
			wProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, "1227");

			if (logger.isDebugEnabled()) {
				logger.logDebug("<<<<<<<<<< Before execute ProcedureRequest >>>>>>>>>> " + wProcedureRequest.getProcedureRequestAsString());
			}

			ProcedureResponseAS wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(wProcedureRequest, null, null);

			if (logger.isDebugEnabled()) {
				logger.logDebug("<<<<<<<<<< wProcedureResponseAS >>>>>>>>>> " + wProcedureResponseAS);
			}
			wProcedureResponseAS = (ProcedureResponseAS) wProcedureResponseAS.parseMessageData();
			addresses = getResultSets(wProcedureResponseAS);
		}
		return addresses;

	}

	@Override
	public Boolean existAddressData(List<AddressDataResponse> addressDataResponses) {
		Boolean customerExistence;

		if (addressDataResponses.isEmpty()) {
			customerExistence = false;
		} else {
			customerExistence = true;
		}
		return customerExistence;
	}

	public static List<AddressDataResponse> getResultSets(IProcedureResponse wProcedureResponseAS) {

		List<AddressDataResponse> addressDataResponses = new ArrayList<AddressDataResponse>();
		if (wProcedureResponseAS != null) {
			Iterator it = wProcedureResponseAS.getResultSets().iterator();
			BigDecimal rentAmount = null;

			while (it.hasNext()) {
				IResultSetBlock rs = (IResultSetBlock) it.next();
				if (logger.isDebugEnabled()) {
					logger.logDebug("<<<<<<<<<< rs >>>>>>>>>> " + rs);
					logger.logDebug("<<<<<<<<<< rs.getMetaData().getColumnsNumber() >>>>>>>>>> " + rs.getMetaData().getColumnsNumber());
					logger.logDebug("<<<<<<<<<< rs.getData().getRowsNumber() >>>>>>>>>> " + rs.getData().getRowsNumber());
				}
				if (rs != null && rs.getMetaData() != null && rs.getMetaData().getColumnsNumber() > 0) {

					IResultSetData row = rs.getData();
					if (row != null)
						for (int j = 1; j <= row.getRowsNumber(); j++) {
							AddressDataResponse addressDataResponse = new AddressDataResponse();
							if (row.getRow(j) != null && row.getRow(j).getRowData(1).getValue() != null) {
								addressDataResponse.setAddressId(Integer.parseInt(row.getRow(j).getRowData(1).getValue().toString()));
							}
							addressDataResponse.setDescription(row.getRow(j).getRowData(22) == null ? null : row.getRow(j).getRowData(2).getValue());

							if (row.getRow(j).getRowData(4) != null && row.getRow(j).getRowData(4).getValue() != null) {
								addressDataResponse.setCountryCode(Integer.parseInt(row.getRow(j).getRowData(4).getValue()));
							}
							addressDataResponse.setCountry(row.getRow(j).getRowData(5).getValue());
							if (row.getRow(j).getRowData(6) != null && row.getRow(j).getRowData(6).getValue() != null) {
								addressDataResponse.setProvinceCode(Integer.parseInt(row.getRow(j).getRowData(6).getValue()));
							}
							addressDataResponse.setProvince(row.getRow(j).getRowData(7) == null ? null : row.getRow(j).getRowData(7).getValue());
							if (row.getRow(j).getRowData(8) != null && row.getRow(j).getRowData(8).getValue() != null) {
								addressDataResponse.setDepartmentId(row.getRow(j).getRowData(8).getValue());
							}
							addressDataResponse.setDepartment(row.getRow(j).getRowData(9) == null ? null : row.getRow(j).getRowData(9).getValue());
							if (row.getRow(j).getRowData(10) != null && row.getRow(j).getRowData(10).getValue() != null) {
								addressDataResponse.setCityCode(Integer.parseInt(row.getRow(j).getRowData(10).getValue()));
							}
							addressDataResponse.setCity(row.getRow(j).getRowData(11) == null ? null : row.getRow(j).getRowData(11).getValue());

							addressDataResponse.setNeighbordhood(row.getRow(j).getRowData(12) == null ? null : row.getRow(j).getRowData(12).getValue());
							addressDataResponse.setOtherSigns(row.getRow(j).getRowData(13) == null ? null : row.getRow(j).getRowData(13).getValue());
							addressDataResponse.setTypeCode(row.getRow(j).getRowData(14) == null ? null : row.getRow(j).getRowData(14).getValue());
							addressDataResponse.setType(row.getRow(j).getRowData(15) == null ? null : row.getRow(j).getRowData(15).getValue());

							if (row.getRow(j).getRowData(16) != null && row.getRow(j).getRowData(16).getValue() != null) {
								addressDataResponse.setOfficeCode(Integer.parseInt(row.getRow(j).getRowData(16).getValue()));
							}
							addressDataResponse.setOffice(row.getRow(j).getRowData(17) == null ? null : row.getRow(j).getRowData(17).getValue());
							addressDataResponse.setIsVerified(row.getRow(j).getRowData(18) == null ? null : row.getRow(j).getRowData(18).getValue());
							addressDataResponse.setIsMainAddress(row.getRow(j).getRowData(19) == null ? null : row.getRow(j).getRowData(19).getValue());
							addressDataResponse.setIsMailAddress(row.getRow(j).getRowData(20) == null ? null : row.getRow(j).getRowData(20).getValue());
							addressDataResponse.setIsRented(row.getRow(j).getRowData(21) == null ? null : row.getRow(j).getRowData(21).getValue());

							if (row.getRow(j).getRowData(22) != null && row.getRow(j).getRowData(22).getValue() != null) {
								rentAmount = new BigDecimal(row.getRow(j).getRowData(22).getValue());
								addressDataResponse.setRentAmount(rentAmount);
							}

							addressDataResponse.setStreet(row.getRow(j).getRowData(24) == null ? null : row.getRow(j).getRowData(24).getValue());
							addressDataResponse.setHouse(row.getRow(j).getRowData(25) == null ? null : row.getRow(j).getRowData(25).getValue());
							addressDataResponse.setBuilding(row.getRow(j).getRowData(26) == null ? null : row.getRow(j).getRowData(26).getValue());
							addressDataResponse.setComercialAddress(row.getRow(j).getRowData(28) == null ? null : row.getRow(j).getRowData(28).getValue());

							addressDataResponses.add(addressDataResponse);
						}
				}

			}
		} else {
			logger.logError("La ejecución del procedimiento wProcedureResponseAS es nulo. wProcedureResponseAS= " + wProcedureResponseAS);
		}
		return addressDataResponses;
	}

	public ISPOrchestrator getSpOrchestrator() {
		return spOrchestrator;
	}

	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}

}
