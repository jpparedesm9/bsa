package com.cobis.cloud.sofom.service.oxxo.utils;

public class OxxoConstants {

	// ERRORES
	public static final String ERROR_00 = "00";
	public static final String ERROR_02 = "02";
	public static final String ERROR_10 = "10";
	public static final String ERROR_17 = "17";
	public static final String ERROR_16 = "16";
	public static final String ERROR_27 = "27";

	public static final String DESC_ERROR_00 = "CLIENTE ENCONTRADO";
	public static final String DESC_ERROR_02 = "PARAMETRO TOKEN OBLIGATORIO Y NO INFORMADO";
	public static final String DESC_ERROR_10 = "REFERENCIA PAGADA";
	public static final String DESC_ERROR_17 = "ERROR AL APLICAR EL PAGO";
	public static final String DESC_ERROR_16 = "NO SE PERMITEN PAGOS CON VALOR CERO";
	public static final String DESC_ERROR_27 = "ERROR EN CONSULTA DE DATOS";
	public static final String DESC_ERROR_00_1 = "TRANSACCION APROBADA";

	// TIPOS DE PAGO
	public static final String GARANTIA_LIQUIDA = "GL";
	public static final String PAGO_GRUPAL = "PG";
	public static final String PAGO_INDIVIDUAL = "PI";
	public static final String CANCELACION_GRUPAL = "CG";
	public static final String CANCELACION_INDIVIDUAL = "CI";

	public static final int FORMATO_FECHA_101 = 101;
	public static final String VERSION = "1.0";
	public static final String ALGCON_FILE = "OxxoCred.algncon";

	// OUTPUTs
	public static final String OUT_MONTO_MAX = "@o_monto_max";
	public static final String OUT_MONTO_MIN = "@o_monto_min";
	public static final String OUT_SALDO_EXIGIBLE = "@o_saldo_exigible";
	public static final String OUT_COMISION = "@o_comision";
	public static final String OUT_TIPO_TRAN = "@o_tipo_tran";
	public static final String OUT_CUENTA = "@o_cuenta";
	public static final String OUT_NOMBRE = "@o_nombre";
	public static final String OUT_STATUS = "@o_status";
	public static final String OUT_PARTIAL = "@o_partial";
	public static final String OUT_CODIGO_ERROR = "@o_codigo_err";
	public static final String OUT_MENSAJE_ERROR = "@o_mensaje_err";
	public static final String OUT_CODIGO_REVERSA = "@o_codigo_reversa";
	public static final String OUT_CODIGO_PAGO = "@o_codigo_pago";
	public static final String OUT_MENSAJE_TICKET = "@o_mensaje_ticket";
	public static final String OUT_MONTO_RECIBIDO = "@o_monto_recibido";
	public static final String OUTPUT = "com.cobiscorp.cobis.cts.service.response.output";

	// DESCRIPCION CONCEPTOS
	public static final String MAXIMO_PAGAR = "Maximo a Pagar";
	public static final String MINIMO_PAGAR = "Minimo a Pagar";
	public static final String SALDO = "Saldo";
	public static final String GASTOS_COBRANZA_IVA = "Gastos Cobranza e IVA";
	public static final String CUOTA = "Cuota";
	public static final String GARANTIA = "Garantia";
	public static final String TOTAL = "Total";

	// OPERACIONES
	public static final String OP_MAX = "max";
	public static final String OP_MIN = "min";
	public static final String OP_PLUS = "+";
	public static final String OP_TOTAL = "t";

	// Campo requeridos respuesta consulta

	public static final String[] QUERY_REQUIRED_FIELDS = { OUT_CUENTA, OUT_NOMBRE, OUT_PARTIAL, OUT_MONTO_MAX, OUT_MONTO_MIN, OUT_SALDO_EXIGIBLE, OUT_CODIGO_ERROR,
			OUT_MENSAJE_ERROR };
	public static final String[] PAYMENT_REQUIRED_FIELDS = { OUT_CODIGO_PAGO, OUT_MONTO_RECIBIDO, OUT_MENSAJE_TICKET, OUT_CUENTA, OUT_CODIGO_ERROR, OUT_MENSAJE_ERROR };
	public static final String[] REVERSE_REQUIRED_FIELDS = { OUT_CODIGO_REVERSA, OUT_CODIGO_PAGO, OUT_CODIGO_ERROR, OUT_MENSAJE_ERROR };

	OxxoConstants() {
	}

}
