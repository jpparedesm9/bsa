package com.cobis.gestionasesores.data.repositories;

import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.requests.DeviceRegistrationData;
import com.cobis.gestionasesores.data.models.requests.RegisterDeviceRequest;
import com.cobis.gestionasesores.data.models.responses.RegisterDeviceResponse;
import com.cobis.gestionasesores.data.source.RegisterDeviceDataSource;
import com.cobis.gestionasesores.data.source.remote.RegisterDeviceService;

/**
 * Created by jescudero on 8/19/2017.
 */

public class RegisterDeviceRepository implements RegisterDeviceDataSource {

    private static RegisterDeviceRepository sInstance;

    public static RegisterDeviceRepository getInstance() {
        if (sInstance == null) {
            sInstance = new RegisterDeviceRepository();
        }
        return sInstance;
    }
    @Override
    public ResultData registerDevice(String alias, String description) throws Exception {

        RegisterDeviceRequest request = new RegisterDeviceRequest.Builder().
                setDeviceRegistrationData(new DeviceRegistrationData(alias, description)).
                setOnline(true).build();
        RegisterDeviceResponse registerDeviceResponse = new RegisterDeviceService().linkUser(request);
        if(registerDeviceResponse.isResult()){
            return new ResultData(ResultType.SUCCESS, registerDeviceResponse.getFirstMessage());
        }
        else{
            return new ResultData(ResultType.FAILURE, registerDeviceResponse.getFirstMessage());
        }
    }
}
