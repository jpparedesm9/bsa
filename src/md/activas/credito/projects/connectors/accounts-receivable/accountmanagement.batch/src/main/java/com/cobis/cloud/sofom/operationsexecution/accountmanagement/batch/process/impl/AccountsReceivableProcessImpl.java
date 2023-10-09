package com.cobis.cloud.sofom.operationsexecution.accountmanagement.batch.process.impl;

import cobiscorp.ecobis.cloud.sofom.operationsexecution.accountmanagement.batch.dto.AccountsReceivableResponse;
import cobiscorp.ecobis.integrationengine.commons.Constants;
import cobiscorp.ecobis.integrationengine.commons.dto.IEResponse;
import cobiscorp.ecobis.integrationengine.commons.dto.IntegrationContext;
import cobiscorp.ecobis.integrationengine.commons.exceptions.EngineFinalException;
import cobiscorp.ecobis.integrationengine.process.service.TransactionExecuter;
import com.cobis.cloud.sofom.operationsexecution.accountmanagement.batch.process.IAccountsReceivableProcess;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.jdbc.CobisDataException;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.context.Target;
import org.apache.commons.lang.time.DateUtils;

import java.sql.Types;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.Date;
import java.util.Map;
import java.util.regex.Pattern;

import static java.sql.Types.VARCHAR;

public class AccountsReceivableProcessImpl extends TransactionExecuter implements IAccountsReceivableProcess {
    private ILogger logger = LogFactory.getLogger(AccountsReceivableProcessImpl.class);
    private CobisStoredProcedureUtils cobisStoredProcedureUtils;
    private ICobisParameter cobisParameter;

    private static final String[] PAGOS_PRESTAMOS_GRUPALES = {"PG", "01", "20"};
    private static final String[] PAGOS_GARANTIAS_LIQUIDAS = {"GL", "00"};
    private static final String[] PAGOS_PRESTAMOS_INDIVIDUALES = {"PI", "03"};
    private static final String[] PRECANCELACION_INDIVIDUAL = {"CI", "04"};
    private static final String[] PAGOS_GARANTIAS_LIQUIDAS_INDIVIDUALES = {"GI", "11"};

    private static final Integer LONGITUD_MNEMONICO_TIPO_PAGO = 2;
    private static final Integer LONGITUD_REFERENCIAS_PRESTAMOS = 15;
    private static final Integer LONGITUD_REFERENCIAS_GARANTIAS = 22;
    private static final Integer LONGITUD_REFERENCIAS_CANCELACION_IND = 22;
    private static final Integer LONGITUD_REFERENCIAS_GARANTIAS_INDIVIDUAL = 22;

    public void setCobisStoredProcedureUtils(CobisStoredProcedureUtils cobisStoredProcedureUtils) {
        this.cobisStoredProcedureUtils = cobisStoredProcedureUtils;
    }

    public void setDatabaseName(String databaseName) {
    }

    public void setCobisParameter(ICobisParameter cobisParameter) {
        this.cobisParameter = cobisParameter;
    }

    public void unsetCobisParameter(ICobisParameter cobisParameter) {
        this.cobisParameter = null;
    }

    /**
     *
     */
    public IEResponse execute(IntegrationContext context, Map<String, Object> mapaRes) throws EngineFinalException {
        if (logger.isInfoEnabled()) {
            logger.logInfo("Se empezo a ejecutar el servicio AccountsReceivableProcessImpl");
        }

        AccountsReceivableResponse wAccountsReceivable = (AccountsReceivableResponse) mapaRes.get("AccountsReceivable");

        String fileName = context.getProperties().get(Constants.PROPERTY_FILE_NAME);
        String rowNumberString = context.getProperties().get(Constants.PROPERTY_ROW_NUMBER);

        IEResponse response = new IEResponse();

        if (logger.isInfoEnabled()) {
            logger.logInfo("File [" + fileName + "] on row [" + rowNumberString + "]");
            logger.logInfo("wAccountsReceivable: " + wAccountsReceivable.toString());
        }

        int returnCode = -1;
        try {
            returnCode = executeSpAccountsReceivable(context, wAccountsReceivable);
        } catch (Exception e) {
            response.setSuccess(false);
            if (logger.isErrorEnabled()) {
                logger.logError("Error on file [" + fileName + "] on row [" + rowNumberString + "]", e);
            }
        }

        if (returnCode == 0) {
            response.setSuccess(true);
        }

        if (logger.isInfoEnabled()) {
            logger.logInfo("Se termino de ejecutar el servicio AccountsReceivableProcessImpl");
        }

        return response;
    }

    private int executeSpAccountsReceivable(IntegrationContext aContext, AccountsReceivableResponse aAccountsReceivable) {
        if (logger.isInfoEnabled()) {
            logger.logInfo("Transaction Type [PGRFR]");
        }

        String guaranteePaymentAccount = cobisParameter.getParameter(null, "CRE", "PRGRNT", String.class).trim();
        if ("".contentEquals(guaranteePaymentAccount)) {
            if (logger.isErrorEnabled()) {
                logger.logError("Debe estar configurada la cuenta para recibir pagos de garantias de prestamos PRGRNT en modulo CRE");
            }
            return -1;
        }

        String creditPaymentAccount = cobisParameter.getParameter(null, "CRE", "PRCRDT", String.class).trim();
        if ("".contentEquals(creditPaymentAccount)) {
            if (logger.isErrorEnabled()) {
                logger.logError("Debe estar configurada la cuenta para recibir pagos de cuotas de préstamos PRCRDT en modulo CRE");
            }
            return -1;
        }

        String accountNumber = aAccountsReceivable.getAccountNumber().trim();
        String operationDate = aAccountsReceivable.getOperationDate();
        // String operationHour = aAccountsReceivable.getOperationHour();
        // String channel = aAccountsReceivable.getChannel();
        // String conceptCode = aAccountsReceivable.getConceptCode();
        String concept = aAccountsReceivable.getConcept().trim();
        String sign = aAccountsReceivable.getSign();
        String amount = aAccountsReceivable.getAmount();
        // String balance = aAccountsReceivable.getBalance();
        // String bankPage = aAccountsReceivable.getBankPage();
        // String conceptCodeDescription =
        // aAccountsReceivable.getConceptCodeDescription().trim();
        // String legend = aAccountsReceivable.getLegend();
        // String interbankReference =
        // aAccountsReceivable.getInterbankReference();
        // String blanks = aAccountsReceivable.getBlanks();
        // String initialBalance = aAccountsReceivable.getInitialBalance();
        // String finalBalance = aAccountsReceivable.getFinalBalance();
        // String customerReference =
        // aAccountsReceivable.getCustomerReference();
        // Integer currency =
        // aAccountsReceivable.getCurrency().contentEquals("MXP") ? 0

        String idTranCorresponsal = aAccountsReceivable.getBankPage();
        String operationNumber = aAccountsReceivable.getOperationNumber();

        boolean processPayment = false;

        if (logger.isTraceEnabled()) {
            logger.logTrace("accountNumber: " + accountNumber);
            logger.logTrace("operationDate: " + operationDate);
            logger.logTrace("sign: " + sign);
            logger.logTrace("amount: " + amount);
            logger.logTrace("concept: " + concept);
            logger.logTrace("operationNumber: " + operationNumber);
            logger.logTrace("idTranCorresponsal: " + idTranCorresponsal);
        }
        try {
            this.logger.logDebug("processPayment..." + processPayment);
            if ("+".equals(sign)) {
                this.logger.logDebug("Signo +");
                if (accountNumber.contentEquals(guaranteePaymentAccount)) {
                    if (LONGITUD_REFERENCIAS_GARANTIAS.compareTo(concept.length()) == 0) {
                        String paymentType = concept.substring(0, LONGITUD_MNEMONICO_TIPO_PAGO);
                        if (paymentType.contentEquals(PAGOS_GARANTIAS_LIQUIDAS[0]) || paymentType.contentEquals(PAGOS_GARANTIAS_LIQUIDAS[1])) {
                            processPayment = matchPaymentPattern(concept, LONGITUD_REFERENCIAS_GARANTIAS, sign);
                        }
                    }

                    //Individuales
                    if (LONGITUD_REFERENCIAS_GARANTIAS_INDIVIDUAL.compareTo(concept.length()) == 0) {
                        String paymentType = concept.substring(0, LONGITUD_MNEMONICO_TIPO_PAGO);
                        if (paymentType.contentEquals(PAGOS_GARANTIAS_LIQUIDAS_INDIVIDUALES[0]) || paymentType.contentEquals(PAGOS_GARANTIAS_LIQUIDAS_INDIVIDUALES[1])) {
                            processPayment = matchPaymentPattern(concept, LONGITUD_REFERENCIAS_GARANTIAS_INDIVIDUAL, sign);
                        }
                    }
                }

                if (accountNumber.contentEquals(creditPaymentAccount)) {
                    if (LONGITUD_REFERENCIAS_PRESTAMOS.compareTo(concept.length()) == 0) {
                        String paymentType = concept.substring(0, LONGITUD_MNEMONICO_TIPO_PAGO);
                        if (paymentType.contentEquals(PAGOS_PRESTAMOS_GRUPALES[0]) || paymentType.contentEquals(PAGOS_PRESTAMOS_GRUPALES[1]) || paymentType.contentEquals(PAGOS_PRESTAMOS_GRUPALES[2])
                                || paymentType.contentEquals(PAGOS_PRESTAMOS_INDIVIDUALES[0]) || paymentType.contentEquals(PAGOS_PRESTAMOS_INDIVIDUALES[1])) {
                            processPayment = matchPaymentPattern(concept, LONGITUD_REFERENCIAS_PRESTAMOS, sign);
                        }
                    }

                    if (LONGITUD_REFERENCIAS_CANCELACION_IND.compareTo(concept.length()) == 0) {
                        String paymentType = concept.substring(0, LONGITUD_MNEMONICO_TIPO_PAGO);
                        if (paymentType.contentEquals(PRECANCELACION_INDIVIDUAL[0]) || paymentType.contentEquals(PRECANCELACION_INDIVIDUAL[1])) {
                            processPayment = matchPaymentPattern(concept, LONGITUD_REFERENCIAS_CANCELACION_IND, sign);
                        }
                    }
                }

                if (processPayment) {

                    if (!processed(aContext, accountNumber, operationNumber, concept, idTranCorresponsal, sign, amount)) {
                        if (registerPay(aContext, concept, accountNumber, operationDate, operationNumber, idTranCorresponsal, amount) == 0) {
                            return processPay(aContext, amount, concept, accountNumber, operationDate, operationNumber, idTranCorresponsal, sign);
                        } else {
                            return -1;
                        }
                    } else {
                        if (logger.isInfoEnabled()) {
                            logger.logInfo("Pago Referenciado ya fue procesado");
                        }
                        return 0;
                    }

                } else {
                    if (logger.isInfoEnabled()) {
                        logger.logInfo("Cuenta " + accountNumber + " y Referencia " + concept + " no aplican como Pago Referenciado");
                    }
                    return 0;
                }
            } else if ("-".equals(sign)) {
                if ((accountNumber.contentEquals(creditPaymentAccount) || accountNumber.contentEquals(guaranteePaymentAccount)) && (concept == null || "".equals(concept.trim()))
                        && Integer.valueOf(idTranCorresponsal == null ? "0" : idTranCorresponsal) != 0) {
                    if (!processed(aContext, accountNumber, operationNumber, concept, idTranCorresponsal, sign, amount)) {
                        if (registerPay(aContext, concept, accountNumber, operationDate, operationNumber, idTranCorresponsal, amount) == 0) {
                            return processPay(aContext, amount, concept, accountNumber, operationDate, operationNumber, idTranCorresponsal, sign);
                        }
                    } else {
                        if (logger.isInfoEnabled()) {
                            DecimalFormat df = new DecimalFormat("0.00");
                            Double tempAmount = Double.valueOf(amount == null || "".equals(amount.trim()) ? "0" : amount) / 100;
                            logger.logInfo("Error: Existe mas de un registro con referencia H2H: " + idTranCorresponsal + " y monto: " + df.format(tempAmount)
                                    + " ingresados para reverso.");
                        }
                        return 0;

                    }
                } else {
                    if (logger.isInfoEnabled()) {
                        logger.logInfo("Cuenta " + accountNumber + " y Referencia " + concept + " no aplican como Pago Referenciado");
                    }
                    return 0;
                }

            }

            if (logger.isInfoEnabled()) {
                logger.logInfo("Signo no valido.");
            }
            return -1;
        } catch (ParseException e) {
            logger.logError("Fecha de movimiento viene en formato no reconocido");
            return -1;
        } catch (Exception e) {
            logger.logError("Error procesando pago: " + e.getMessage());
            return -1;
        }

    }

    private int processPay(IntegrationContext aContext, String amount, String concept, String accountNumber, String operationDate, String operationNumber,
                           String idTranCorresponsal, String sign) throws ParseException {

        CobisStoredProcedure wSp = cobisStoredProcedureUtils.getStoredProcedureInstance();
        Map<String, Object> wResultMap;

        wSp.setDatabase("cob_cartera");
        wSp.setName("sp_pagos_corresponsal");
        wSp.setSkipResultsProcessing(false);
        wSp.setSkipUndeclaredResults(false);

        cobisStoredProcedureUtils.setContextParameters(aContext.getContext(), Target.TARGET_CENTRAL, wSp);

        Date valueDate = DateUtils.parseDate(operationDate, new String[]{"MMddyyyy"});

        wSp.addInParam("@i_operacion", Types.CHAR, "I");
        wSp.addInParam("@i_referencia", VARCHAR, concept);
        wSp.addInParam("@i_fecha_pago", VARCHAR, operationDate);
        wSp.addInParam("@i_monto_pago", VARCHAR, amount);
        wSp.addInParam("@i_archivo_pago", VARCHAR, aContext.getProperties().get(Constants.PROPERTY_FILE_NAME));
        wSp.addInParam("@i_corresponsal", VARCHAR, "SANTANDER");
        wSp.addInParam("@i_fecha_valor", Types.DATE, valueDate);
        wSp.addInParam("@i_trn_id_corresp", VARCHAR, idTranCorresponsal);

        if (sign.equals("+")) {
            wSp.addInParam("@i_accion", Types.CHAR, "I");
        } else if (sign.equals("-")) {
            wSp.addInParam("@i_accion", Types.CHAR, "R");
        }
        if (logger.isInfoEnabled()) {
            logger.logInfo("Executing sp_pagos_corresponsal");
        }

        wResultMap = wSp.execute();
        int returnCode = Integer.parseInt(wResultMap.get("RETURNCODE").toString());

        if (logger.isDebugEnabled()) {
            logger.logDebug("Codigo de retorno de sp: " + wResultMap.get("RETURNCODE"));
        }

        return returnCode;

    }

    private int registerPay(IntegrationContext aContext, String concept, String accountNumber, String operationDate, String operationNumber, String idTranCorresponsal,
                            String amount) {

        CobisStoredProcedure wSp = cobisStoredProcedureUtils.getStoredProcedureInstance();
        Map<String, Object> wResultMap;

        wSp.setDatabase("cob_cartera");
        wSp.setName("sp_pagos_procesados");
        wSp.setSkipResultsProcessing(false);
        wSp.setSkipUndeclaredResults(false);

        cobisStoredProcedureUtils.setContextParameters(aContext.getContext(), Target.TARGET_CENTRAL, wSp);

        wSp.addInParam("@i_operacion", Types.CHAR, "I");
        wSp.addInParam("@i_referencia", VARCHAR, concept);
        wSp.addInParam("@i_cuenta", VARCHAR, accountNumber);
        wSp.addInParam("@i_fecha_pago", Types.VARCHAR, operationDate);
        wSp.addInParam("@i_movimiento", Types.VARCHAR, operationNumber);
        wSp.addInParam("@i_nombre_archivo", VARCHAR, aContext.getProperties().get(Constants.PROPERTY_FILE_NAME));
        wSp.addInParam("@i_trn_id_corresp", VARCHAR, idTranCorresponsal);
        wSp.addInParam("@i_monto_pago", VARCHAR, amount);

        wResultMap = wSp.execute();
        int returnCode = Integer.parseInt(wResultMap.get("RETURNCODE").toString());

        if (logger.isDebugEnabled()) {
            logger.logDebug("Codigo de retorno de sp: " + wResultMap.get("RETURNCODE"));
        }

        return returnCode;

    }

    private boolean processed(IntegrationContext aContext, String accountNumber, String operationNumber, String referencia, String idTranCorresponsal, String sign, String amount) {

        CobisStoredProcedure wSp = cobisStoredProcedureUtils.getStoredProcedureInstance();
        Map<String, Object> wResultMap;

        wSp.setDatabase("cob_cartera");
        wSp.setName("sp_pagos_procesados");
        wSp.setSkipResultsProcessing(false);
        wSp.setSkipUndeclaredResults(false);

        cobisStoredProcedureUtils.setContextParameters(aContext.getContext(), Target.TARGET_CENTRAL, wSp);

        wSp.addInParam("@i_operacion", Types.CHAR, "Q");
        wSp.addInParam("@i_movimiento", VARCHAR, operationNumber);
        wSp.addInParam("@i_cuenta", VARCHAR, accountNumber);
        wSp.addInParam("@i_referencia", VARCHAR, referencia);
        wSp.addInParam("@i_trn_id_corresp", VARCHAR, idTranCorresponsal);
        wSp.addInParam("@i_monto_pago", VARCHAR, amount);

        if (sign.equals("+")) {
            wSp.addInParam("@i_accion", Types.CHAR, "I");
        } else if (sign.equals("-")) {
            wSp.addInParam("@i_accion", Types.CHAR, "R");
        }
        wSp.addInOutParam("@o_row_count", Types.INTEGER, 0);

        if (logger.isDebugEnabled()) {
            logger.logDebug("Consultando pago sp_pagos_procesados operacion Q");
            logger.logDebug("cuenta" + accountNumber);
            logger.logDebug("movimiento" + operationNumber);
            logger.logDebug("referencia" + referencia);
            logger.logDebug("signo" + sign);
        }

        wResultMap = wSp.execute();

        String returnCode = wResultMap.get("RETURNCODE").toString();

        if (logger.isDebugEnabled()) {
            logger.logDebug("Codigo de retorno de sp: " + wResultMap.get("RETURNCODE"));
        }

        int rowsCount = 0;
        if (returnCode.equals("0")) {
            rowsCount = Integer.valueOf(String.valueOf(wResultMap.get("@o_row_count")));
        } else {
            throw new CobisDataException("Error al consultar registros de pago");
        }

        return rowsCount > 0;
    }

    private boolean matchPaymentPattern(String paymentReference, Integer referenceLength, String sign) {
        String referenceComplement = paymentReference.substring(LONGITUD_MNEMONICO_TIPO_PAGO);
        return Pattern.matches("\\d{" + (referenceLength - LONGITUD_MNEMONICO_TIPO_PAGO) + "}", referenceComplement) && (sign.contentEquals("+") || sign.contentEquals("-"));
    }
}
