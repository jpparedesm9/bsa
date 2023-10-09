use cob_fpm
go


delete fp_fieldsmappings where mp_physicalfield ='dt_desplazamiento'
delete fp_generalparametersvalues where dc_fields_idfk = (select dc_fields_id from fp_dictionaryfields where dc_name = 'Gracia')
delete fp_dictionaryfields where dc_name = 'Gracia'

go

