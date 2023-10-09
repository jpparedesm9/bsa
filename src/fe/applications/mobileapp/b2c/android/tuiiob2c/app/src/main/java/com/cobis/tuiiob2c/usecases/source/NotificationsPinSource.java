package com.cobis.tuiiob2c.usecases.source;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.MessagePin;

public interface NotificationsPinSource {

    BaseModel responseMessagePin(MessagePin messageRequest);
}
