/*
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */
package com.cobiscorp.ecobis.businessprocess.orchestrator;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetBlock;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestParam;
/**
 * 
 * @author fabad
 * This class helps to manage procedure response
 */
public class UtilsOrchestrator {
	ILogger  logger = LogFactory.getLogger(UtilsOrchestrator.class);
	private IProcedureResponse procedureResp;
	private static final String PARAMS_NEXT_SP = "PARAMS_NEXT_SP";
	public UtilsOrchestrator(IProcedureResponse aProcedureReq) {
		this.procedureResp = aProcedureReq;
	}
	
	
	public IProcedureResponse getProcedureResp() {
		return procedureResp;
	}
	

	/**
	 * this method gets the value
	 * @param aResultSetNumber
	 * @param aRowNumber
	 * @param aColNumber
	 * @return
	 */
	public Object get(int aResultSetNumber, int aRowNumber, int aColNumber){
		
		if(procedureResp.getResultSet(aResultSetNumber)==null){ 
			return null;
		}
		if(procedureResp.getResultSet(aResultSetNumber).getData().getRow(aRowNumber)==null){
			return null;
		}
		if(procedureResp.getResultSet(aResultSetNumber).getData().getRow(aRowNumber).getRowData(aColNumber)==null){
			return null;
		}

		/**
		 * 
		 * get(8,1,1);
		 * get(5,5,8);
		 * get(1,1);
		 * get(1)
		 */

		String wTempValue = procedureResp.getResultSet(aResultSetNumber).getData().getRow(aRowNumber).getRowData(aColNumber).getValue();
		logger.logError("VALO CONSULTADO: " + wTempValue);
		if("null".equals(wTempValue)){
			return null;
		}
		return wTempValue;
	}
	public Integer getColumnType(int aResultSetNumber, int aColNumber){
		if(procedureResp.getResultSet(aResultSetNumber)==null) 
			return null;
		if(procedureResp.getResultSet(aResultSetNumber).getMetaData().getColumnMetaData(aColNumber)==null)
			return null;

		/**
		 * 
		 * get(8,1,1);
		 * get(5,5,8);
		 * get(1,1);
		 * get(1)
		 */
		
		return procedureResp.getResultSet(aResultSetNumber).getMetaData().getColumnMetaData(aColNumber).getType();
	}	
	/**
	 * this method search the parameters for the next sp in all resultsets
	 * only get the first select
	 * 
	 * @return null if there is no parameters
	 */
	public List<ProcedureRequestParam> getParamsForTheNextSP(){
		
		Iterator it =  procedureResp.getResultSets().iterator();
		while (it.hasNext()){
			IResultSetBlock rs = (IResultSetBlock) it.next();
			
			if( rs.getMetaData().getColumnsNumber()>0  && PARAMS_NEXT_SP.equals(rs.getMetaData().getColumnMetaData(1).getName())){
				List<ProcedureRequestParam> params = new ArrayList<ProcedureRequestParam>(rs.getMetaData().getColumnsNumber());
				String tmpValue = null;
				String tmpColumnName = null;
				Integer tmpType = null;
				Integer tmpLen = null;
				ProcedureRequestParam procedureRequestParam = null;
				/**
				 * starts in two because it is not taken into account PARAMS_NEXT_SP
				 */
				for(int i=2; i<=rs.getMetaData().getColumnsNumber(); i++){
					tmpValue = rs.getData().getRow(1).getRowData(i).getValue();
					tmpColumnName = rs.getMetaData().getColumnMetaData(i).getName();
					tmpType = rs.getMetaData().getColumnMetaData(i).getType();
					tmpLen = rs.getMetaData().getColumnMetaData(i).getLength();
					/**
					 * if the parameter name start with @o_ it is consider as ouputparameter
					 */
					if(tmpColumnName!=null && tmpColumnName.startsWith("@o_")){
						procedureRequestParam = new ProcedureRequestParam(tmpColumnName, tmpType, 1, tmpLen, tmpValue);
					}else {
						procedureRequestParam = new ProcedureRequestParam(tmpColumnName, tmpType, 0, tmpLen, tmpValue);
					}
					params.add(procedureRequestParam);
				}
				return params;
			}
			
		}

		return null;
	}	
	public Object[] get(int aResultSetNumber, int aRowNumber){
		if(procedureResp.getResultSet(aResultSetNumber)==null) 
			return null;
		if(procedureResp.getResultSet(aResultSetNumber).getData().getRow(aRowNumber)==null)
			return null;
		
		int tmpNumberOfColumns = procedureResp.getResultSet(aResultSetNumber).getMetaData().getColumnsNumber();
		
		Object[] tmpRowValues = new Object[tmpNumberOfColumns]; 
		for(int i=0;i<tmpNumberOfColumns;i++){
			tmpRowValues[i]= procedureResp.getResultSet(aResultSetNumber).getData().getRow(aRowNumber).getColumnsAsArray()[0].getValueObj();
		}
		return tmpRowValues;
	}
	public Object[][] get(int aResultSetNumber){
		if(procedureResp.getResultSet(aResultSetNumber)==null) 
			return null;
		
		
		int tmpNumberOfRows = procedureResp.getResultSet(aResultSetNumber).getData().getRowsNumber();
		int tmpNumberOfColumns = procedureResp.getResultSet(aResultSetNumber).getMetaData().getColumnsNumber();
		
		
		Object[][] tmpRowValues = new Object[tmpNumberOfRows][tmpNumberOfColumns];
		for(int j=0;j<tmpNumberOfRows;j++){
			tmpRowValues[j] = new Object[tmpNumberOfColumns];
			for(int i=0;i<tmpNumberOfColumns;i++){
				tmpRowValues[i][j] = procedureResp.getResultSet(aResultSetNumber).getData().getRow(j+1).getColumnsAsArray()[i].getValueObj();
			}
		}
		return tmpRowValues;
	}
	public int getReturnCode(){
		return procedureResp.getReturnCode();
	}
	public boolean hasError(){
		return procedureResp.hasError();
	}

	
}
