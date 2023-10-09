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
import com.cobiscorp.cloud.xmlgenerator.dto.jaxb.EstadoCuentaCa;
import com.cobiscorp.cloud.xmlgenerator.dto.jaxb.ObjectFactory;
import com.cobiscorp.cloud.xmlgenerator.dto.jaxb.Operacion;

public class ServiceStatement {

	private static final Logger logger = Logger
			.getLogger(ServiceStatement.class);

	public List<EstadoCuentaCa> getStatements(ObjectFactory factory,
			String operation, int customerId, String account, Date dateProcess) throws Exception {

		if (logger.isDebugEnabled()) {
			logger.debug("Inicia getStatements ServiceStatement " + factory
					+ " " + operation + " " + customerId + " " + account + " " + dateProcess);
		}

		List<EstadoCuentaCa> statementsResult = new ArrayList<EstadoCuentaCa>();
		Map<String, EstadoCuentaCa> statementsMap = new LinkedHashMap<String, EstadoCuentaCa>();

		// crea query
		String queryDetails = "EXEC cob_conta_super..sp_consulta_estados_js ?,?";
		// parametros de consulta
		Map<Integer, Object> params = new HashMap<Integer, Object>();
		params.put(1, operation);
		params.put(2, new java.sql.Date(dateProcess.getTime()));

		if (account != null && account != "") {
			queryDetails = "EXEC cob_conta_super..sp_consulta_estados_js ?,?,?";
			params.put(3, account);

			if (customerId != 0) {
				queryDetails = "EXEC cob_conta_super..sp_consulta_estados_js ?,?,?,?";
				params.put(4, customerId);
			}
		}

		getData(factory, params, statementsMap, queryDetails);

		for (Map.Entry<String, EstadoCuentaCa> entry : statementsMap.entrySet()) {
			statementsResult.add(entry.getValue());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza getStatements ServiceStatement: "
					+ statementsResult);
		}

		return statementsResult;
	}

	public void getData(ObjectFactory factory, Map<Integer, Object> params,
			Map<String, EstadoCuentaCa> statementsMap, String query)
			throws Exception {

		if (logger.isDebugEnabled()) {
			logger.debug("Inicia getData " + factory + " " + params + " "
					+ statementsMap + " " + query);
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
			getResult(factory, statementsMap, result);

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
				logger.debug("Registro consultados: " + statementsMap.size());
			}
		}
	}

	private void getResult(ObjectFactory factory,
			Map<String, EstadoCuentaCa> statementsMap, ResultSet result)
			throws Exception {

		if (logger.isDebugEnabled()) {
			logger.debug("Inicia getResult " + factory + " " + statementsMap
					+ " " + result);
		}

		if (result != null) {
			while (result.next()) {
				String ctaBancoHeader = result.getString("Cuenta");

				EstadoCuentaCa statement = factory.createEstadoCuentaCa();
				// SET CUENTAS
				Operacion account = factory.createOperacion();
				initDataAccount(account, result);
				statement.setOperacion(account);
				statementsMap.put(ctaBancoHeader, statement);
			}
		}

		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza getResult ");
		}
	}

	private void initDataAccount(Operacion account, ResultSet resultSet)
			throws SQLException {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia initDataAccount " + account + " " + resultSet);
		}
		if (account != null) {
			account.setFecha(Commons.dateToXml(resultSet.getDate("Fecha")));
			account.setRFC((resultSet.getString("RFC")));
			account.setCuenta((resultSet.getString("Cuenta")));
			account.setCliente((resultSet.getInt("Cliente")));
			account.setNombres((resultSet.getString("Nombres")));
			account.setDireccion(resultSet.getString("Direccion"));
			account.setFechaLimitePago(Commons.dateToXml(resultSet
					.getDate("FechaLimitePago")));
			account.setPagoMinimo((resultSet.getFloat("PagoMinimo")));
			account.setDeudaTotal((resultSet.getFloat("DeudaTotal")));
			account.setSaldoFecha((resultSet.getFloat("SaldoFecha")));
			account.setProducto(resultSet.getString("Producto"));
			account.setFinalidad((resultSet.getString("Finalidad")));
			account.setImporteAutorizado((resultSet
					.getFloat("ImporteAutorizado")));
			account.setCreditoOtorgado((resultSet.getFloat("CreditoOtorgado")));
			account.setFechaDisposicion(Commons.dateToXml(resultSet
					.getDate("FechaDisposicion")));
			account.setPlazo(resultSet.getInt("Plazo"));
			account.setDiasPlazo((resultSet.getInt("DiasPlazo")));
			account.setTipoPrestamo((resultSet.getString("TipoPrestamo")));
			account.setFechaVencimiento(Commons.dateToXml(resultSet
					.getDate("FechaVencimiento")));
			account.setProximoAbono((resultSet.getFloat("ProximoAbono")));
			account.setTasaOrdinaria(resultSet.getFloat("TasaOrdinaria"));
			account.setTasaMoratorio((resultSet.getFloat("TasaMoratorio")));
			account.setTasaOrdinariaConcep((resultSet
					.getFloat("TasaOrdinariaConcep")));
			account.setTasaMoratorioConcep((resultSet
					.getFloat("TasaMoratorioConcep")));
			account.setTasaComisionesConcep((resultSet
					.getFloat("TasaComisionesConcep")));
			account.setTasaIvaConcep(resultSet.getFloat("TasaIvaConcep"));
			account.setCAT((resultSet.getFloat("CAT")));
			account.setPorcentajeCubierto((resultSet
					.getFloat("PorcentajeCubierto")));
			account.setAbonoCapital((resultSet.getFloat("AbonoCapital")));
			account.setTasaOrdinarioDet((resultSet.getFloat("TasaOrdinarioDet")));
			account.setTasaMoratorioDet(resultSet.getFloat("TasaMoratorioDet"));
			account.setTasaComisionDet((resultSet.getFloat("TasaComisionDet")));
			account.setTasaIvaDet((resultSet.getFloat("TasaIvaDet")));
			account.setMontoPagado((resultSet.getFloat("MontoPagado")));
			account.setFechaPago(Commons.dateToXml(resultSet
					.getDate("FechaPago")));
			account.setCapital(resultSet.getFloat("Capital"));
			account.setInteresOrdinario((resultSet.getFloat("InteresOrdinario")));
			account.setInteresMoratorio((resultSet.getFloat("InteresMoratorio")));
			account.setIVA((resultSet.getFloat("IVA")));
		}
		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza initDataAccount ");
		}
	}

}
