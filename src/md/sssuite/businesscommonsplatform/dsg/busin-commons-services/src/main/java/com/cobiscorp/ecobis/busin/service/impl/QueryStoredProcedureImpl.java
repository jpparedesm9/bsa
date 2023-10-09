package com.cobiscorp.ecobis.busin.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.cobiscorp.cobis.commons.components.ComponentLocator;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.commons.serializer.Serializer;
import com.cobiscorp.cobis.commons.serializer.SerializerFactory;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetBlock;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetData;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetRow;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.ecobis.busin.enums.ColumnCatalog;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.busin.model.InputParameterDto;
import com.cobiscorp.ecobis.busin.service.IQueryStoredProcedure;
import com.cobiscorp.ecobis.busin.util.Utils;

public class QueryStoredProcedureImpl implements IQueryStoredProcedure {

	private static ILogger logger = LogFactory.getLogger(QueryStoredProcedureImpl.class);
	private ISPOrchestrator spOrchestrator;

	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}

	@Override
	public List<CatalogDto> getCatalogByStoredProcedure(String storedProcedureName, ArrayList<InputParameterDto> inputParameterDtoList,
			HashMap<ColumnCatalog, Integer> hmColumnsResponse) {

		logger.logDebug("Declaro la lista variables a devolver por el servicio");

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();
		HashMap<String, InputParameterDto> hmInputParameterDto = new HashMap<String, InputParameterDto>();

		Integer columnNumberCode = 1;
		Integer columnNumberName = 2;
		Integer queryBlock = 1;
		Integer columnDescription1 = 2;
		Integer columnDescription2 = 2;
		Integer columnDescription3 = 2;
		Integer columnDescription4 = 2;
		Integer columnDescription5 = 2;

		try {

			logger.logDebug("Declaro de variables para ejecutar el sp : " + storedProcedureName);
			IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
			wProcedureRequest = Utils.setHeaderParams(wProcedureRequest);
			wProcedureRequest.setSpName(storedProcedureName);

			logger.logDebug("Recupero los parametros para configurar la forma de mapear el resultado de respuesta");
			if (hmColumnsResponse != null) {
				columnNumberCode = hmColumnsResponse.get(ColumnCatalog.CODE) == null ? 1 : hmColumnsResponse.get(ColumnCatalog.CODE);
				columnNumberName = hmColumnsResponse.get(ColumnCatalog.NAME) == null ? 2 : hmColumnsResponse.get(ColumnCatalog.NAME);
				queryBlock = hmColumnsResponse.get(ColumnCatalog.QUERY_BLOCK) == null ? 1 : hmColumnsResponse.get(ColumnCatalog.QUERY_BLOCK);
				columnDescription1 = hmColumnsResponse.get(ColumnCatalog.DESCRIPTION_1) == null ? 2 : hmColumnsResponse.get(ColumnCatalog.DESCRIPTION_1);
				columnDescription2 = hmColumnsResponse.get(ColumnCatalog.DESCRIPTION_2) == null ? 2 : hmColumnsResponse.get(ColumnCatalog.DESCRIPTION_2);
				columnDescription3 = hmColumnsResponse.get(ColumnCatalog.DESCRIPTION_3) == null ? 2 : hmColumnsResponse.get(ColumnCatalog.DESCRIPTION_3);
				columnDescription4 = hmColumnsResponse.get(ColumnCatalog.DESCRIPTION_4) == null ? 2 : hmColumnsResponse.get(ColumnCatalog.DESCRIPTION_4);
				columnDescription5 = hmColumnsResponse.get(ColumnCatalog.DESCRIPTION_5) == null ? 2 : hmColumnsResponse.get(ColumnCatalog.DESCRIPTION_5);
			}

			logger.logDebug("Recorro el mapa de parametros para realizar el set de los parametros del sp : " + storedProcedureName);
			for (InputParameterDto inputParameterDto : inputParameterDtoList) {
				if (!hmInputParameterDto.containsKey(inputParameterDto.getParameter())) {
					Utils.validateRegistry(wProcedureRequest, inputParameterDto.getParameter(), inputParameterDto.getParameterType().getDataType(), inputParameterDto.getValue());
					hmInputParameterDto.put(inputParameterDto.getParameter(), inputParameterDto);
				}
			}

			logger.logDebug("Ejecucion del sp : " + storedProcedureName);
			ProcedureResponseAS wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(wProcedureRequest, null, null);

			logger.logDebug("Mapeo de Dto con el reulset del catalogo ");
			if (wProcedureResponseAS != null) {

				wProcedureResponseAS = (ProcedureResponseAS) wProcedureResponseAS.parseMessageData();

				if (!wProcedureResponseAS.hasError()) {

					for (int i = 1; i <= wProcedureResponseAS.getResultSetListSize(); i++) {

						// Recupero los bloques de resulsets de la consulta
						// (Esto se da cuando el sp devuelve varias consultas)
						IResultSetBlock resultSetBlock = wProcedureResponseAS.getResultSet(i);

						if (resultSetBlock != null) {

							if (i == queryBlock) {

								// Recupero la data del bloque de la consulta
								// que se especifico
								IResultSetData resultSetData = resultSetBlock.getData();
								for (int j = 1; j <= resultSetData.getRowsNumber(); ++j) {

									// Recupero las filas del bloque de conuslta
									IResultSetRow row = resultSetData.getRow(j);
									if (row != null) {

										CatalogDto catalogDto = new CatalogDto();

										// Creo el objeto con las columnas
										// definidas enviadas por parametros
										for (int k = 1; k <= row.getColumnsNumber(); k++) {
											if (k == columnNumberCode) {
												catalogDto.setCode(Utils.getStringRowDataValue(row.getRowData(k)));
											} else if (k == columnNumberName) {
												catalogDto.setName(Utils.getStringRowDataValue(row.getRowData(k)));
											} else if (k == columnDescription1) {
												catalogDto.setDescription1(Utils.getStringRowDataValue(row.getRowData(k)));
											} else if (k == columnDescription2) {
												catalogDto.setDescription2(Utils.getStringRowDataValue(row.getRowData(k)));
											} else if (k == columnDescription3) {
												catalogDto.setDescription3(Utils.getStringRowDataValue(row.getRowData(k)));
											} else if (k == columnDescription4) {
												catalogDto.setDescription4(Utils.getStringRowDataValue(row.getRowData(k)));
											} else if (k == columnDescription5) {
												catalogDto.setDescription5(Utils.getStringRowDataValue(row.getRowData(k)));
											}
										}
										catalogDtoList.add(catalogDto);
									}
								}
							}
						}
					}
				}
			}

			return catalogDtoList;

		} catch (Exception ex) {
			logger.logError("service execution problems", ex);
		}
		return catalogDtoList;
	}

	private ArrayList COBISDeSerialize(String objXML) {
		ComponentLocator locator = ComponentLocator.getInstance(this);
		SerializerFactory serializerFactory = (SerializerFactory) locator.find(SerializerFactory.class);
		Serializer serializer = serializerFactory.getInstance(List.class);
		ArrayList resp = (ArrayList) serializer.deserializeFromXml(objXML);
		return resp;
	}

	private <T> String COBISSerialize(T obj) {
		ComponentLocator locator = ComponentLocator.getInstance(this);
		SerializerFactory serializerFactory = locator.find(SerializerFactory.class);
		Serializer<T> serializer = serializerFactory.getInstance(obj.getClass());
		String msg = serializer.serializeToXml(obj);
		return msg;
	}

}
