package com.cobis.tuiiob2c.usecases.source;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.requests.CreatePasswordRequest;

public interface CreatePasswordSource {

    BaseModel validatePasswords(CreatePasswordRequest createPasswordRequest);
}
