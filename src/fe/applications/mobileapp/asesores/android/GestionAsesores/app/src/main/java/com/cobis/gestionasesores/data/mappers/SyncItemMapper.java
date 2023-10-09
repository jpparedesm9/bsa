package com.cobis.gestionasesores.data.mappers;

import com.cobis.gestionasesores.data.models.SyncItem;
import com.cobis.gestionasesores.data.models.requests.SyncItemRemote;
import com.cobis.gestionasesores.utils.DateUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by mnaunay on 15/08/2017.
 */

public class SyncItemMapper {

    public static List<SyncItem> fromRemote(List<SyncItemRemote> data) {
        List<SyncItem> result = new ArrayList<>();
        for(SyncItemRemote itemRemote : data){
            result.add(transformFromRemote(itemRemote));
        }
        return result;
    }

    private static SyncItem transformFromRemote(SyncItemRemote itemRemote) {
        SyncItem  item = new SyncItem();
        item.setServerId(itemRemote.getIdSync());
        item.setItemCount(itemRemote.getRegistersNumber());
        item.setStatus(itemRemote.getState());
        item.setType(itemRemote.getEntityId());
        item.setCreated(DateUtils.parseDateFromService(itemRemote.getDate()));
        return item;
    }
}
