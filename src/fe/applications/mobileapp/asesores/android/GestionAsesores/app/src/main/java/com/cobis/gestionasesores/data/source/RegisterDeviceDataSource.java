package com.cobis.gestionasesores.data.source;

import com.cobis.gestionasesores.data.models.ResultData;

/**
 * Created by jescudero on 8/19/2017.
 */

public interface RegisterDeviceDataSource {
    ResultData registerDevice(String alias, String description) throws Exception;
}
