package com.cobiscorp.ecobis.busin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.cobiscorp.ecobis.busin.enums.ColumnCatalog;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.busin.model.InputParameterDto;

public interface IQueryStoredProcedure {

	List<CatalogDto> getCatalogByStoredProcedure(String storedProcedureName, ArrayList<InputParameterDto> parameterValueDtoList,
			HashMap<ColumnCatalog, Integer> hmColumnsResponse);

}
