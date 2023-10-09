package com.cobiscorp.cobis.busin.flcre.commons.utiles;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;

public class ClonarObjetoDataEntity {

	private static final ILogger logger = LogFactory
			.getLogger(ClonarObjetoDataEntity.class);
	
	/**Si se requiere, se puede clonar las entidades atributo por atributo*/
	
	/**
	 * Método para obtener un duplicado de cualquier entidad
	 * 
	 * @param origen
	 *            entidad origen
	 * @return nuevo objeto de la misma entidad
	 */
	public static DataEntity clonarEntidad(DataEntity origen) {
		DataEntity respuesta = null;
		if(logger.isDebugEnabled()){			
			logger.logDebug(":>:>clonarEntidad origen:>:>"+origen.getData());
		}
		if (!Validate.Strings.isNotNullOrEmpty(origen)) {
			respuesta = new DataEntity();
			Map<String, Object> data = new HashMap<String, Object>();
			Iterator iterador = origen.getData().entrySet().iterator();
			while (iterador.hasNext()) {
				Map.Entry<String, Object> dataMapa = (Map.Entry) iterador.next();
				respuesta.getData().put(dataMapa.getKey(), dataMapa.getValue());
			}
		}
		if(logger.isDebugEnabled()){
			if(respuesta != null){
				logger.logDebug(":>:>clonarEntidad respuesta:>:>"+respuesta.getData());
			}
			
		}
		return respuesta;
	}

	/**
	 * Método para obtener un duplicado de cualquier entidad tipo lista
	 * 
	 * @param origen
	 *            listado origen
	 * @return nuevo listado de la misma entidad
	 */
	public static DataEntityList clonarEntidadList(DataEntityList origen) {
		DataEntityList respuesta = new DataEntityList();
		for (DataEntity dataEntity : origen) {
			respuesta.add(clonarEntidad(dataEntity));
		}
		if (respuesta.size() == 0) {
			return null;
		}
		return respuesta;
	}

	/**
	 * Método para obtener un duplicado de cualquier entidad pero solo la
	 * información de los campos
	 * 
	 * @param origen
	 *            entidad origen
	 * @return nuevo objeto de la misma entidad
	 */
	public static DataEntity clonarEntidadSoloDatos(DataEntity origen) {
		DataEntity respuesta = null;
		if (Validate.Strings.isNotNullOrEmpty(origen)) {
			respuesta = new DataEntity();
			Map<String, Object> data = new HashMap<String, Object>();
			Iterator iterador = origen.getData().entrySet().iterator();
			while (iterador.hasNext()) {
				int band = 0;
				Map.Entry<String, Object> dataMapa = (Map.Entry) iterador.next();
				if (dataMapa.getKey().equals("_new")
						|| dataMapa.getKey().equals("_updated")
						|| dataMapa.getKey().equals("_removed")) {
					band = 1;
				}
				if (band == 0) {
					logger.logInfo("datos mapa:" + dataMapa);
					respuesta.getData().put(dataMapa.getKey(),
							dataMapa.getValue());
				}
			}
		}
		return respuesta;
	}
}
