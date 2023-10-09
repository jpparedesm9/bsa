use cobis
go

select *
from cobis..cl_direccion
where   di_tipo  in ('AE', 'RE') 
and    (UPPER(di_calle) like 'NORTE%'    or 
        UPPER(di_calle) like 'SUR%'      or 
        UPPER(di_calle) like 'ORIENTE%'  or 
        UPPER(di_calle) like 'PONIENTE%' or 
        UPPER(di_calle) like 'PTE%' or 
        UPPER(di_calle) like 'NTE%' or 
        UPPER(di_calle) like 'OTE%' )


update cobis..cl_direccion
set di_calle = 'CALLE ' + UPPER(di_calle)
where    di_tipo  in ('AE', 'RE') 
and    (UPPER(di_calle) like 'NORTE%'    or 
        UPPER(di_calle) like 'SUR%'      or 
        UPPER(di_calle) like 'ORIENTE%'  or 
        UPPER(di_calle) like 'PONIENTE%' or 
        UPPER(di_calle) like 'PTE%' or 
        UPPER(di_calle) like 'NTE%' or 
        UPPER(di_calle) like 'OTE%' )
        
select *
from cobis..cl_direccion
where   di_tipo  in ('AE', 'RE')  
and    (UPPER(di_calle) like 'CALLE NORTE%'    or 
        UPPER(di_calle) like 'CALLE SUR%'      or 
        UPPER(di_calle) like 'CALLE ORIENTE%'  or 
        UPPER(di_calle) like 'CALLE PONIENTE%' or 
        UPPER(di_calle) like 'CALLE PTE%' or 
        UPPER(di_calle) like 'CALLE NTE%' or 
        UPPER(di_calle) like 'CALLE OTE%' )        