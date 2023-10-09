package com.cobis.tuiiob2c.usecases.source;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.requests.UpdatePasswordRequest;

public interface UpdatePasswordSource {

    BaseModel validateChangePassword(UpdatePasswordRequest updatePasswordRequest);
}
