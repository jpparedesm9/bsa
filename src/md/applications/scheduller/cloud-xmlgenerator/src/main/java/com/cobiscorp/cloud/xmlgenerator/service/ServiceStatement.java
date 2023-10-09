package com.cobiscorp.cloud.xmlgenerator.service;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cloud.xmlgenerator.commons.Commons;
import com.cobiscorp.cloud.xmlgenerator.dto.jaxb.Cuenta;
import com.cobiscorp.cloud.xmlgenerator.dto.jaxb.EstadoCuenta;
import com.cobiscorp.cloud.xmlgenerator.dto.jaxb.Movimiento;
import com.cobiscorp.cloud.xmlgenerator.dto.jaxb.Movimientos;
import com.cobiscorp.cloud.xmlgenerator.dto.jaxb.ObjectFactory;

public class ServiceStatement {

	private static final Logger logger = Logger
			.getLogger(ServiceStatement.class);

	public List<EstadoCuenta> getStatements(ObjectFactory factory,
			int initialRange, int finalRange, Date dateProcess,
			Date dateNextLabor) throws Exception {

		if (logger.isDebugEnabled()) {
			logger.debug("Inicia getStatements ServiceStatement " + factory
					+ " " + initialRange + " " + finalRange + " " + dateProcess
					+ " " + dateNextLabor);
		}

		List<EstadoCuenta> statementsResult = new ArrayList<EstadoCuenta>();
		Map<String, EstadoCuenta> statementsMap = new LinkedHashMap<String, EstadoCuenta>();

		// crea query
		String queryHeader = "EXEC cob_ahorros..sp_ah_cons_cabecera_ext ?,?,?,?";
		String queryDetails = "EXEC cob_ahorros..sp_ah_cons_detalle_ext ?,?,?,?";
		// paraemtros de consulta
		Map<Integer, Object> params = new HashMap<Integer, Object>();
		params.put(1, initialRange);
		params.put(2, finalRange);
		params.put(3, new java.sql.Date(dateProcess.getTime()));
		params.put(4, new java.sql.Date(dateNextLabor.getTime()));

		getData(factory, params, statementsMap, queryHeader, "C");
		getData(factory, params, statementsMap, queryDetails, "D");

		for (Map.Entry<String, EstadoCuenta> entry : statementsMap.entrySet()) {
			statementsResult.add(entry.getValue());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza getStatements ServiceStatement: "
					+ statementsResult);
		}

		return statementsResult;
	}

	public void getData(ObjectFactory factory, Map<Integer, Object> params,
			Map<String, EstadoCuenta> statementsMap, String query, String type)
			throws Exception {

		if (logger.isDebugEnabled()) {
			logger.debug("Inicia getData " + factory + " " + params + " "
					+ statementsMap + " " + query + " " + type);
		}

		// ejecuta consulta
		PreparedStatement ps = null;
		ResultSet result = null;
		try {
			if (logger.isDebugEnabled()) {
				logger.debug("Ejecuta sp : ");
			}
			ps = ConnectionManager.executeQuery(query, params);
			result = ps.executeQuery();

			if (logger.isDebugEnabled()) {
				logger.debug("Resultado del sp : " + result);
			}
			// obtiene resultado
			getResult(factory, statementsMap, result, type);

		} finally {
			if (result != null) {
				result.close();
			}
			if (ps != null) {
				ps.close();
			}
			ConnectionManager.closeConnection();
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza getData : " + statementsMap);
			}
		}
	}

	private void getResult(ObjectFactory factory,
			Map<String, EstadoCuenta> statementsMap, ResultSet result,
			String type) throws Exception {

		if (logger.isDebugEnabled()) {
			logger.debug("Inicia getResult " + factory + " " + statementsMap
					+ " " + result + " " + type);
		}

		if (result != null && "C".equals(type)) {
			while (result.next()) {
				String ctaBancoHeader = result.getString("ec_cta_banco");

				EstadoCuenta statement = factory.createEstadoCuenta();
				// SET CUENTAS
				Cuenta account = factory.createCuenta();
				initDataAccount(account, result);
				statement.setCuenta(account);
				Movimientos movements = factory.createMovimientos();
				statement.setMovimientos(movements);
				statementsMap.put(ctaBancoHeader, statement);
			}
		}

		if (result != null && "D".equals(type)) {
			while (result.next()) {
				String ctaBancoDetails = result.getString("de_cta_banco");
				EstadoCuenta statement = statementsMap.get(ctaBancoDetails);
				// SET DETALLES
				if (statement != null) {
					Movimiento movement = factory.createMovimiento();
					initDataMovement(movement, result);
					statement.getMovimientos().getMovimiento().add(movement);
				}
			}
		}

		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza getResult ");
		}
	}

	private void initDataAccount(Cuenta account, ResultSet resultSet)
			throws SQLException {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia initDataAccount " + account + " " + resultSet);
		}
		if (account != null) {
			account.setNumero(resultSet.getString("ec_cta_banco"));
			account.setCodigo(resultSet.getInt("ec_cuenta"));
			account.setTasa(resultSet.getFloat("ec_tasa_hoy"));
			account.setSaldo(resultSet.getFloat("ec_saldo_promedio"));
			account.setNombreCuenta(resultSet.getString("ec_nombre"));
			account.setFechaCorte(Commons.dateToXml(resultSet
					.getDate("ec_fecha_ult_corte")));
			account.setFechaCierre(Commons.dateToXml(resultSet
					.getDate("ec_fecha_ult_mov")));
			account.setOficina(resultSet.getString("of_nombre"));
			account.setDireccion(resultSet.getString("ec_descripcion_ec"));
			account.setFechaPeriodoDesde(Commons.dateToXml(resultSet
					.getDate("ec_fecha_ult_corte")));
			account.setFechaPeriodoHasta(Commons.dateToXml(resultSet
					.getDate("ec_fecha_prx_corte")));
			account.setSaldoAnterior(resultSet.getFloat("ec_saldo_promedio"));
			account.setTotalIntereses(resultSet.getFloat("ec_monto_imp"));
			account.setSaldoFechaCorte(resultSet.getFloat("ec_saldo_ult_corte"));
			account.setMensaje1("ok1");
			account.setMensaje2("ok2");
			account.setMensaje3("ok3");
		}
		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza initDataAccount ");
		}
	}

	private void initDataMovement(Movimiento movement, ResultSet resultSet)
			throws SQLException {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia initDataMovement " + movement + " "
					+ resultSet);
		}
		if (movement != null) {
			movement.setFecha(Commons.stringToXml(resultSet
					.getString("de_fecha")));
			movement.setDescripcion(resultSet.getString("de_transaccion"));
			movement.setOficina(resultSet.getString("de_nombre"));
			if ("C".equals(resultSet.getString("de_signo"))) {
				movement.setDepositos(resultSet.getFloat("de_valor"));
			}
			if ("D".equals(resultSet.getString("de_signo"))) {
				movement.setRetiros(resultSet.getFloat("de_valor"));
			}
			movement.setSaldo(resultSet.getFloat("de_saldo_contable"));
		}
		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza initDataMovement ");
		}
	}
}
