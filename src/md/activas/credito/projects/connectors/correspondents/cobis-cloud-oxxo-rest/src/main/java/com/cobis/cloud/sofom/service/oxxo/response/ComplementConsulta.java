package com.cobis.cloud.sofom.service.oxxo.response;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.cobis.cloud.sofom.service.oxxo.dto.Concept;
import com.cobis.cloud.sofom.service.oxxo.utils.OxxoConstants;
import com.cobis.cloud.sofom.service.oxxo.utils.OxxoTransformMoney;

public class ComplementConsulta {

	public static List<Concept> queryOperation(Map<String, Object> outputs, String operationType) {
		List<Concept> concepts = new ArrayList<Concept>();

		if (outputs != null) {
			int mapMontoMaxRes = OxxoTransformMoney.convertInt(outputs.get(OxxoConstants.OUT_MONTO_MAX).toString());
			int mapMontoMinRes = OxxoTransformMoney.convertInt(outputs.get(OxxoConstants.OUT_MONTO_MIN).toString());
			int mapMontoExig = OxxoTransformMoney.convertInt(outputs.get(OxxoConstants.OUT_SALDO_EXIGIBLE).toString());

			concepts.add(assignConcepts(OxxoConstants.MAXIMO_PAGAR, mapMontoMaxRes, OxxoConstants.OP_MAX));
			concepts.add(assignConcepts(OxxoConstants.MINIMO_PAGAR, mapMontoMinRes, OxxoConstants.OP_MIN));
			if (OxxoConstants.GARANTIA_LIQUIDA.equals(operationType)) {
				concepts.add(assignConcepts(OxxoConstants.GARANTIA, mapMontoExig, OxxoConstants.OP_PLUS));
				concepts.add(assignConcepts(OxxoConstants.TOTAL, mapMontoExig, OxxoConstants.OP_TOTAL));
			} else if (OxxoConstants.PAGO_GRUPAL.equals(operationType) || OxxoConstants.PAGO_INDIVIDUAL.equals(operationType)) {
				int mapMontoCom = OxxoTransformMoney.convertInt(outputs.get(OxxoConstants.OUT_COMISION).toString());
				concepts.add(assignConcepts(OxxoConstants.CUOTA, mapMontoExig, OxxoConstants.OP_PLUS));
				concepts.add(assignConcepts(OxxoConstants.GASTOS_COBRANZA_IVA, mapMontoCom, OxxoConstants.OP_PLUS));
				concepts.add(assignConcepts(OxxoConstants.TOTAL, (mapMontoExig + mapMontoCom), OxxoConstants.OP_TOTAL));
			} else if (OxxoConstants.CANCELACION_GRUPAL.equals(operationType) || OxxoConstants.CANCELACION_INDIVIDUAL.equals(operationType)) {
				int mapMontoCom = OxxoTransformMoney.convertInt(outputs.get(OxxoConstants.OUT_COMISION).toString());
				concepts.add(assignConcepts(OxxoConstants.SALDO, mapMontoExig, OxxoConstants.OP_PLUS));
				concepts.add(assignConcepts(OxxoConstants.GASTOS_COBRANZA_IVA, mapMontoCom, OxxoConstants.OP_PLUS));
				concepts.add(assignConcepts(OxxoConstants.TOTAL, (mapMontoExig + mapMontoCom), OxxoConstants.OP_TOTAL));
			}
		}
		return concepts;

	}

	private static Concept assignConcepts(String descripcion, int monto, String operacion) {
		Concept concept = new Concept();
		concept.setDescription(descripcion);
		concept.setAmount(monto);
		concept.setOperation(operacion);
		return concept;

	}

}
