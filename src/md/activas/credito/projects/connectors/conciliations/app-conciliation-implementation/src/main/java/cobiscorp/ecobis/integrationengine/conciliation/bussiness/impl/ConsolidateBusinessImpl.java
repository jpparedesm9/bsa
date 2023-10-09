package cobiscorp.ecobis.integrationengine.conciliation.bussiness.impl;

import java.sql.Types;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.Target;

import cobiscorp.ecobis.integrationengine.commons.dto.IntegrationContext;
import cobiscorp.ecobis.integrationengine.conciliation.business.api.IConciliationBusiness;
import cobiscorp.ecobis.integrationengine.conciliation.business.constants.ConciliationContextKeys;
import cobiscorp.ecobis.integrationengine.conciliation.bussiness.utils.Util;
import cobiscorp.ecobis.integrationengine.conciliation.service.dto.TransactionDetailDTO;

@Component
@Service({ IConciliationBusiness.class })
@Properties(value = { @Property(name = "service.impl", value = "ConsolidateBusinessImpl") })
public class ConsolidateBusinessImpl implements IConciliationBusiness {

	private static final ILogger LOGGER = LogFactory.getLogger(ConsolidateBusinessImpl.class);

	@Reference(bind = "setCobisStoredProcedureUtils", unbind = "unsetCobisStoredProcedureUtils", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private CobisStoredProcedureUtils cobisStoredProcedureUtils;

	public void setCobisStoredProcedureUtils(CobisStoredProcedureUtils cobisStoredProcedureUtils) {
		this.cobisStoredProcedureUtils = cobisStoredProcedureUtils;
	}

	public void unsetCobisStoredProcedureUtils(CobisStoredProcedureUtils cobisStoredProcedureUtils) {
		this.cobisStoredProcedureUtils = null;
	}

	@Override
	public boolean afterProcessFile(Context context, Map<String, Object> args) {
		boolean ban = true;
		try {

			String fileName = (String) args.get(ConciliationContextKeys.FILE_NAME.name());

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("INICIA POST PROCESADO");
			}

			CobisStoredProcedure wSp = cobisStoredProcedureUtils.getStoredProcedureInstance();
			Map<String, Object> wResultMap;

			wSp.setDatabase("cob_conta_super");
			wSp.setName("sp_conciliar_corresponsal");
			wSp.setSkipResultsProcessing(false);
			wSp.setSkipUndeclaredResults(false);

			cobisStoredProcedureUtils.setContextParameters(context, Target.TARGET_CENTRAL, wSp);
			wSp.addInParam("@i_ultima_linea", Types.CHAR, "S");
			wSp.addInParam("@i_archivo", Types.VARCHAR, fileName);

			wResultMap = wSp.execute();

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Codigo de retorno de sp: " + wResultMap.get("RETURNCODE"));
			}
		} catch (Exception e) {
			LOGGER.logError(
					"Ocurrio un error al procesar el registro: " + args.get(ConciliationContextKeys.ROW_NUMBER.name()),
					e);
			return false;
		}

		return ban;
	}

	@Override
	public boolean beforeProcessFile(Context arg0, Map<String, Object> arg1) {

		return true;
	}

	@Override
	public boolean executeTransactionConciliation(IntegrationContext paramIntegrationContext,
			TransactionDetailDTO transaction, Map<String, Object> args) {
		boolean ban = true;
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Args1: " + args.get(ConciliationContextKeys.AGENT_FILE_DEFINITION_ID.name()));
				LOGGER.logDebug("Args2: " + args.get(ConciliationContextKeys.APPLICATION_NAME.name()));
				LOGGER.logDebug("Args3: " + args.get(ConciliationContextKeys.FLOW_ORIGIN.name()));
				LOGGER.logDebug("Args4: " + args.get(ConciliationContextKeys.FILE_NAME.name()));
				LOGGER.logDebug("Args5: " + args.get(ConciliationContextKeys.ROW_NUMBER.name()));
			}
			String fileName = (String) args.get(ConciliationContextKeys.FILE_NAME.name());

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("INICIA PROCESADO");
			}

			CobisStoredProcedure wSp = cobisStoredProcedureUtils.getStoredProcedureInstance();
			Map<String, Object> wResultMap;

			wSp.setDatabase("cob_conta_super");
			wSp.setName("sp_conciliar_corresponsal");
			wSp.setSkipResultsProcessing(false);
			wSp.setSkipUndeclaredResults(false);

			cobisStoredProcedureUtils.setContextParameters(paramIntegrationContext.getContext(), Target.TARGET_CENTRAL,
					wSp);

			wSp.addInParam("@i_id_trn_corresp", Types.INTEGER, transaction.getTrnCorrespondent());
			wSp.addInParam("@i_referencia_pago", Types.VARCHAR, transaction.getPayReference());
			wSp.addInParam("@i_fecha_valor", Types.DATE, Util.convertStringToDate(transaction.getExecutionDate()));
			wSp.addInParam("@i_monto", Types.DOUBLE, transaction.getAmount());
			wSp.addInParam("@i_reverso", Types.CHAR, transaction.getReverse());
			wSp.addInParam("@i_trn_reverso", Types.INTEGER, transaction.getIdTransaction());
			wSp.addInParam("@i_archivo", Types.VARCHAR, fileName);

			wResultMap = wSp.execute();

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Codigo de retorno de sp: " + wResultMap.get("RETURNCODE"));
			}

		} catch (Exception e) {
			LOGGER.logError(
					"Ocurrio un error al procesar el registro: " + args.get(ConciliationContextKeys.ROW_NUMBER.name()),
					e);
			return false;
		}
		return ban;
	}

}
