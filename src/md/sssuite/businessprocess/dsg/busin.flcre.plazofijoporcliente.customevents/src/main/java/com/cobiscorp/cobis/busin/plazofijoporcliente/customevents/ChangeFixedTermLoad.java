package com.cobiscorp.cobis.busin.plazofijoporcliente.customevents;

import java.math.BigDecimal;

import cobiscorp.ecobis.collateral.dto.AccountData;
import cobiscorp.ecobis.collateral.dto.AccountResponse;
import cobiscorp.ecobis.collateral.dto.DepositData;
import cobiscorp.ecobis.collateral.dto.FixedTermData;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CollateralManagement;
import com.cobiscorp.cobis.busin.model.AccountInfomation;
import com.cobiscorp.cobis.busin.model.CustomerSearch;
import com.cobiscorp.cobis.busin.model.FixedTermOperation;
import com.cobiscorp.cobis.busin.model.WarrantyGeneral;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ChangeFixedTermLoad extends BaseEvent implements IChangedEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(ChangeFixedTermLoad.class);

	public ChangeFixedTermLoad(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs arg1) {
		// TODO Auto-generated method stub		
		try {
			if(LOGGER.isDebugEnabled()){
				LOGGER.logDebug(":>:>Inicia ChangeFixedTermLoad:>:>");
			}			
			DataEntity customerSearch = entities.getEntity(CustomerSearch.ENTITY_NAME);
			DataEntity warrantyGeneral = entities.getEntity(WarrantyGeneral.ENTITY_NAME);
			DataEntityList fixedTermList=new DataEntityList();
			DataEntityList accountList=new DataEntityList();
			//consumo del servicio para la consulta de las polizas por cliente cob_pfijo..sp_consop, S,14806
			if(LOGGER.isDebugEnabled()){
				LOGGER.logDebug(":>:>customerSearch:>:>"+customerSearch.getData());
			}
			if(LOGGER.isDebugEnabled()){
				LOGGER.logDebug(":>:>warrantyGeneral:>:>"+warrantyGeneral.getData());
			}
			CollateralManagement collateralManagement=new CollateralManagement(super.getServiceIntegration());
			DepositData[] depositDataResponse = collateralManagement.searchDepositByClient(customerSearch.get(CustomerSearch.CUSTOMERID), arg1, new BehaviorOption(true));
			AccountData[] accountDataResponse = collateralManagement.searchAccountByClient(customerSearch.get(CustomerSearch.CUSTOMERID), warrantyGeneral.get(WarrantyGeneral.CURRENCY), arg1, new BehaviorOption(true));
			//mapeo de polizas
			if(depositDataResponse!=null){				
				for (DepositData depositData : depositDataResponse) {					
					DataEntity fixedTermEnt=new DataEntity();
					fixedTermEnt.set(FixedTermOperation.NUMBANCO, depositData.getDepositNumber());
					fixedTermEnt.set(FixedTermOperation.DESCRIPCION, depositData.getDescription());
					fixedTermEnt.set(FixedTermOperation.ESTADO, depositData.getStatus());
					fixedTermEnt.set(FixedTermOperation.MONTODISPONIBLE, BigDecimal.valueOf(0.0));
					if(LOGGER.isDebugEnabled()){
						LOGGER.logDebug(":>:>plazo en entidad:>:>"+fixedTermEnt.getData());
						LOGGER.logDebug(":>:>servicio de detalle de montos en entidad:>:>"+fixedTermEnt.getData());
					}
					//montos del plazo fijo 
					fixedTermEnt=queryTermDetail(fixedTermEnt, customerSearch, arg1);
					
					fixedTermList.add(fixedTermEnt);
				}
			}
			
			//mapeo de cuentas de ahorro
			if(accountDataResponse!=null){				
				for (AccountData accountData : accountDataResponse) {					
					DataEntity accountEnt=new DataEntity();
					if ("A".equals(accountData.getStatusAccount().toString())){
						accountEnt.set(AccountInfomation.ACCOUNTBANK, accountData.getAccountNumber());
						accountEnt.set(AccountInfomation.DESCRIPTION, accountData.getCustomerName());
						accountEnt.set(AccountInfomation.ACCOUNTSTATUS, accountData.getStatusAccount());
						accountEnt.set(AccountInfomation.AVAILABLEBALANCE, BigDecimal.valueOf(0.0));
						if(LOGGER.isDebugEnabled()){
							LOGGER.logDebug(":>:>plazo en entidad:>:>"+accountEnt.getData());
							LOGGER.logDebug(":>:>servicio de detalle de montos en entidad:>:>"+accountEnt.getData());
						}
						//montos de la cuenta de ahorro 
						accountEnt=queryAccountDetail(accountEnt, customerSearch, warrantyGeneral, arg1);
						
						accountList.add(accountEnt);
					}
				}
			}
			
			entities.setEntityList(FixedTermOperation.ENTITY_NAME, fixedTermList);			
			if(LOGGER.isDebugEnabled()){
				LOGGER.logDebug(":>:>Lista de Plazos Fijos Consultados en la entidadList:>:>"+entities.getEntityList(FixedTermOperation.ENTITY_NAME).getDataList());
				LOGGER.logDebug(":>:>Finaliza ChangeFixedTermLoad:>:>");
			}
			
			entities.setEntityList(AccountInfomation.ENTITY_NAME, accountList);			
			if(LOGGER.isDebugEnabled()){
				LOGGER.logDebug(":>:>Lista de Cuentas de Ahorros Consultadas en la entidadList:>:>"+entities.getEntityList(AccountInfomation.ENTITY_NAME).getDataList());
				LOGGER.logDebug(":>:>Finaliza ChangeFixedTermLoad:>:>");
			}			

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PLAZO_CHANGE_FIXED_TERM, e, arg1, LOGGER);
		}
	}
	
	private DataEntity queryTermDetail(DataEntity row, DataEntity cliente,IChangedEventArgs args) {
		if (LOGGER.isDebugEnabled()){
			LOGGER.logDebug(":>:>metodo queryTermDetail:>:>");
		}		
		CollateralManagement collateralManagement=new CollateralManagement(super.getServiceIntegration());			
		FixedTermData fixedTermDetailResponse = collateralManagement.queryFixedTermDetail(cliente.get(CustomerSearch.CUSTOMERID),row.get(FixedTermOperation.NUMBANCO), args, new BehaviorOption(true));
		BigDecimal montoInicial,montoBloqueado,montoGarantia,montoDisponible,montoResta;
		if(fixedTermDetailResponse!=null){
			/*mapeo de datos*/
			montoInicial=fixedTermDetailResponse.getAmount();
			montoGarantia=fixedTermDetailResponse.getGuaranteeAmount();
			montoBloqueado=fixedTermDetailResponse.getBlockedAmount();
			/*seteo de datos a la entidad*/
			row.set(FixedTermOperation.MONTOINICIAL, BigDecimal.valueOf(montoInicial.doubleValue()));
			row.set(FixedTermOperation.MONTOGARANTIA, BigDecimal.valueOf(montoGarantia.doubleValue()));
			row.set(FixedTermOperation.MONTOBLOQUEADO, BigDecimal.valueOf(montoBloqueado.doubleValue()));			
			/*calculo del monto disponible y seteo*/
			if (montoGarantia.doubleValue() >= montoBloqueado.doubleValue()){
				montoResta=montoGarantia.subtract(montoBloqueado);			
			}else
			{
				montoResta = BigDecimal.valueOf(0.00);
			}
			LOGGER.logDebug(":>:>montoBloqueado:>:>"+montoResta.toString());
			montoDisponible=montoInicial.subtract(montoResta);		
			LOGGER.logDebug(":>:>seteo de data:>:>"+montoDisponible.toString());
			row.set(FixedTermOperation.MONTODISPONIBLE, BigDecimal.valueOf(montoDisponible.doubleValue()));
			
			if (LOGGER.isDebugEnabled()){
				LOGGER.logDebug(":>:>seteo de data:>:>"+row.getData());
			}					
			LOGGER.logDebug(":>:>generalData:>:>");
		}
		if (LOGGER.isDebugEnabled()){
			LOGGER.logDebug(":>:>fin metodo queryTermDetail:> row seteada:>"+row.getData());
		}
		return row;
	}

	private DataEntity queryAccountDetail(DataEntity row, DataEntity cliente, DataEntity warrantyGeneral, IChangedEventArgs args) {
		if (LOGGER.isDebugEnabled()){
			LOGGER.logDebug(":>:>metodo queryAccountDetail:>:>");
		}		
		CollateralManagement collateralManagement=new CollateralManagement(super.getServiceIntegration());			
		AccountResponse accountDetailResponse = collateralManagement.queryAccountDetail(cliente.get(CustomerSearch.CUSTOMERID), warrantyGeneral.get(WarrantyGeneral.CURRENCY), row.get(AccountInfomation.ACCOUNTBANK), args, new BehaviorOption(true));
		BigDecimal saldoDisponible;
		if(accountDetailResponse!=null){
			/*mapeo de datos*/
			saldoDisponible=accountDetailResponse.getAvailbale();
			/*seteo de datos a la entidad*/
			row.set(AccountInfomation.AVAILABLEBALANCE, BigDecimal.valueOf(saldoDisponible.doubleValue()));
			LOGGER.logDebug(":>:>seteo de data:>:>"+saldoDisponible.toString());
			
			if (LOGGER.isDebugEnabled()){
				LOGGER.logDebug(":>:>seteo de data:>:>"+row.getData());
			}					
			LOGGER.logDebug(":>:>generalData:>:>");
		}
		if (LOGGER.isDebugEnabled()){
			LOGGER.logDebug(":>:>fin metodo queryAccountDetail:> row seteada:>"+row.getData());
		}
		return row;
	}

}