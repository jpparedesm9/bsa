package com.cobiscorp.ecobis.customer.util;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.customer.services.dtos.AddressDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerQuickCreateRequest;

public class StoreProcedureExecutorImpl implements StoreProcedureExecutor {
	
	private static ILogger logger = LogFactory
			.getLogger(StoreProcedureExecutor.class);
	
	@Override
	public List<AddressDataResponse> executorAddressSearch(Integer customer) {
		logger.logInfo("in to StoreProcedureExecutorImpl");
//		List<AddressDataResponse> addressDataResponses=new ArrayList<AddressDataResponse>();
//		AddressDataResponse addressDataResponse=null;
//		Context wContext = ContextManager.getContext();
//		CobisSession wSession = (CobisSession) wContext.getSession();
//		BigDecimal rentAmount;
// 
//		ProcedureRequestAS preq = new ProcedureRequestAS();
//	 
//		preq.setSpName("cobis..sp_direccion_cons");
//
//		preq.addParam("@s_srv", SybTypes.SQLVARCHAR, 0, 0, wSession.getServer()); // "wSrv"
//		preq.addParam("@s_user ", SybTypes.SQLVARCHAR, 0, 14,
//				wSession.getUser()); // "wUser"
//		preq.addParam("@s_term", SybTypes.SQLVARCHAR, 0, 30,
//				wSession.getTerminal()); // "wTerm"
//		preq.addParam("@s_date", SybTypes.SQLDATETIME, 0, 8,
//				wContext.getProcessDate()); // wDate
//		preq.addParam("@s_sesn", SybTypes.SQLINT4, 0, 4,
//				wContext.getSequencial()); // Integer.toString(sequentialTransaction)
//		preq.addParam("@s_ssn", SybTypes.SQLINT4, 0, 4,
//				wContext.getSequencial()); // Integer.toString(sequentialTransaction)
//		preq.addParam("@s_ofi", SybTypes.SQLINT4, 0, 4, wSession.getOffice()); // "1"
//		preq.addParam("@i_operacion", SybTypes.SQLCHAR, 0, 4, "S");
//		preq.addParam("@i_ente", SybTypes.SQLINT4, 0, 4, customer.toString());
//		preq.addParam("@t_trn", SybTypes.SQLINT4, 0, 4, "1227");
//		// Ejecución del sp
//		IProcedureResponse presp = db.executeStoredProcedure(preq);
//		IResultSetBlock resulSetBlock = presp.getResultSet(0);// 1
//
//		IResultSetData resultSetData = resulSetBlock.getData();
//
//		for (int i = 0; i < resultSetData.getRowsNumber(); ++i) {
//			addressDataResponse = new AddressDataResponse();
//			IResultSetRow row = resultSetData.getRow(i);
//			IResultSetRowColumnData columnData=row.getRowData(0);
//			addressDataResponse.setAddressId(Integer.parseInt(columnData.getValue()));			
//			columnData=row.getRowData(1);
//			addressDataResponse.setDescription(columnData.getValue());
//			columnData=row.getRowData(2);
//			addressDataResponse.setCountryCode(Integer.parseInt(columnData.getValue()));
//			columnData=row.getRowData(3);
//			addressDataResponse.setCountry(columnData.getValue());
//			columnData=row.getRowData(4);
//			addressDataResponse.setProvinceCode(Integer.parseInt(columnData.getValue()));
//			columnData=row.getRowData(5);
//			addressDataResponse.setProvince(columnData.getValue());
//			columnData=row.getRowData(6);
//			addressDataResponse.setCityCode(Integer.parseInt(columnData.getValue()));
//			columnData=row.getRowData(7);
//			addressDataResponse.setCity(columnData.getValue());
//			columnData=row.getRowData(8);
//			addressDataResponse.setDistrictCode(Integer.parseInt(columnData.getValue()));
//			columnData=row.getRowData(9);
//			addressDataResponse.setDistrict(columnData.getValue());
//			columnData=row.getRowData(10);
//			addressDataResponse.setNeighbordhoodCode(Integer.parseInt(columnData.getValue()));
//			columnData=row.getRowData(11);
//			addressDataResponse.setNeighbordhood(columnData.getValue());			
//			columnData=row.getRowData(12);
//			addressDataResponse.setOtherSigns(columnData.getValue());			
//			columnData=row.getRowData(13);
//			addressDataResponse.setType(columnData.getValue());
//			columnData=row.getRowData(14);
//			//addressDataResponse.setAddressId(Integer.parseInt(columnData.getValue()));
//			addressDataResponse.setTypeCode(columnData.getValueObj().toString());
//			columnData=row.getRowData(15);
//			addressDataResponse.setOfficeCode(Integer.parseInt(columnData.getValue()));
//			columnData=row.getRowData(16);
//			addressDataResponse.setOffice(columnData.getValue());
//			columnData=row.getRowData(17);
//			addressDataResponse.setIsVerified(columnData.getValue());
//			columnData=row.getRowData(18);
//			addressDataResponse.setIsMainAddress(columnData.getValue());
//			columnData=row.getRowData(19);
//			addressDataResponse.setIsMailAddress(columnData.getValue());
//			columnData=row.getRowData(20);
//			addressDataResponse.setIsRented(columnData.getValue());
//			columnData=row.getRowData(21);
//			rentAmount =new BigDecimal(columnData.getValue()) ;
//			addressDataResponse.setRentAmount(rentAmount);
//			columnData=row.getRowData(22);
//			addressDataResponse.setIsBillingAddress(columnData.getValue());
//			columnData=row.getRowData(23);
//			addressDataResponse.setStreet(columnData.getValue());
//			columnData=row.getRowData(24);
//			addressDataResponse.setHouse(columnData.getValue());
//			columnData=row.getRowData(25);
//			addressDataResponse.setBuilding(columnData.getValue());
//			columnData=row.getRowData(26);
//			addressDataResponse.setComercialAddress(columnData.getValue());
//			
//			
//			addressDataResponses.add(addressDataResponse);
//			/*for (int j = 0; j < row.getColumnsNumber(); j++) {
//				if(j=0){					
//					IResultSetRowColumnData columnData = row.getRowData(j);	
//					addressDataResponse.setCode(columnData.getValueObj());
//					addressDataResponse= (AddressDataResponse) columnData.getValueObj();
//				}
//				addressDataResponses.add(addressDataResponse);
//
//			}*/
//		}

		 
		return null;
	}
	
	@Override
	public CustomerDataResponse executorQuickCreate(CustomerQuickCreateRequest request) {
		
//		Integer customerID = null;
		
//		
//		CustomerDataResponse customerDataResponse=null;
//		
//		Context wContext = ContextManager.getContext();
//		CobisSession wSession = (CobisSession) wContext.getSession();
//		
//		//BigDecimal rentAmount;
// 
//		ProcedureRequestAS preq = new ProcedureRequestAS();
//	 
//		preq.setSpName("cobis..sp_persona_no_ruc");
//
//		preq.addParam("@s_ssn", SybTypes.SQLINT4, 0, 4,
//				wContext.getSequencial()); // Integer.toString(sequentialTransaction)		
//		preq.addParam("@s_user ", SybTypes.SQLVARCHAR, 0, 14,
//				wSession.getUser()); // "wUser"
//		preq.addParam("@s_term", SybTypes.SQLVARCHAR, 0, 30,
//				wSession.getTerminal()); // "wTerm"
//		preq.addParam("@s_date", SybTypes.SQLDATETIME, 0, 8,
//				wContext.getProcessDate()); // wDate
//		preq.addParam("@s_srv", SybTypes.SQLVARCHAR, 0, 0, wSession.getServer()); // "wSrv"
//		//preq.addParam("@s_sev", SybTypes.SQLINT4, 0, 4, value);
//		preq.addParam("@s_ofi", SybTypes.SQLINT4, 0, 4, wSession.getOffice()); // "1"
//		preq.addParam("@s_sesn", SybTypes.SQLINT4, 0, 4,
//				wContext.getSequencial()); // Integer.toString(sequentialTransaction)		
//		preq.addParam("@t_trn", SybTypes.SQLINT4, 0, 4, "1026");
//		preq.addParam("@i_operacion", SybTypes.SQLCHAR, 0, 4, "I");
//		preq.addParam("@i_tipo_ced", SybTypes.SQLVARCHAR, 0, 3, request.getIdentificationTypeCode());
//		preq.addParam("@i_cedula", SybTypes.SQLVARCHAR, 0, 14, request.getId());
//		preq.addParam("@i_nombre", SybTypes.SQLVARCHAR, 0, 50, request.getFirstName());
//		preq.addParam("@i_segnombre", SybTypes.SQLVARCHAR, 0, 50, request.getMiddleName());
//		preq.addParam("@i_papellido", SybTypes.SQLVARCHAR, 0, 50, request.getLastName());
//		preq.addParam("@i_sapellido", SybTypes.SQLVARCHAR, 0, 50, request.getAdditionalLastName());
//		preq.addParam("@i_nacionalidad", SybTypes.SQLINT4, 0, 4, String.valueOf(request.getNationalityCode()));
//		preq.addParam("@i_profesion", SybTypes.SQLVARCHAR, 0, 10, request.getProfessionCode());
//		preq.addParam("@i_filial",SybTypes.SQLINT4, 0, 4, String.valueOf(wSession.getOffice()));
//	//	preq.addParam("@i_oficina", SybTypes.SQLINT4, 0, 4,  String.valueOf(request.getProfessionCode()));
//	//	preq.addParam("@i_estado", SybTypes.SQLVARCHAR, 0, 10, request.getStatusCode());
//		
//		preq.addParam("@o_ente", SybTypes.SQLINT4, 0, 4, "0");
//		//preq.addParam("@o_tip_ente", SybTypes.SQLINT4, 0, 4, "0");
//
//		// Ejecuci�n del sp
//		IProcedureResponse presp = db.executeStoredProcedure(preq);
//		
//		// Recuperaci�n de result sets
//		for (Object rsb : presp.getParams()) {
//			IProcedureResponseParam param = (IProcedureResponseParam) rsb;
//			if (param.getName().equals("@o_ente"))
//				customerID = Integer.parseInt(param.getValue());
//			
//		}
//		
//		if(logger.isDebugEnabled()){
//		  logger.logDebug("customerPerson" +customerID);
//		}
//		/*if(logger.isDebugEnabled()){
//			  logger.logDebug("customerPersonType" +customerPersonType);
//			}*/
//		if(presp.hasError()){
//			logger.logError(presp.getErrors());
//		}
//		 
//		customerDataResponse = new CustomerDataResponse();
//		customerDataResponse.setCustomerID(customerID);
//	
	//	return customerDataResponse;
		return null;

		
	}

}
