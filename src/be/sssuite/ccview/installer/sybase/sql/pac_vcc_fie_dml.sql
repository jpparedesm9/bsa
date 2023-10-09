
use cobis 
go 


if exists(select 1
              from   cobis..sysobjects obj
              where  obj.name = 'cl_asfi_vcc'
              and obj.type = 'V')
begin
   drop view cl_asfi_vcc
end
go 

create view cl_asfi_vcc as
select  en_ente,
        af_cod_obligado, 
        af_cod_entidad,
        af_num_correlativo, 
        af_cod_depart_sucur,  
        'Directa' as 'tipo_deuda',
        af_saldo_deuda_vig as 'saldo_deuda_vigente', 
        (af_saldo_deuda_30 +  af_saldo_deuda_ven) as 'saldo_deuda_vencida', 
        af_saldo_deuda_ejec as 'saldo_deuda_ejecucion',
        (af_saldo_deuda_cast_ins+ af_saldo_deuda_cast_pre) as 'saldo_deuda_castigada', 
        (af_saldo_deuda_vig + af_saldo_deuda_30 +  af_saldo_deuda_ven + af_saldo_deuda_ejec + af_saldo_deuda_cast_ins + af_saldo_deuda_cast_pre) as 'saldo_total',
        af_saldo_deuda_cont as 'saldo_deuda_contingente', 
        af_calificacion as 'calificacion'
from   cl_asfi a , cl_ente b
where  a.af_cod_obligado = en_ced_ruc  
and    a.af_fecha_reporte =  (select max(c.af_fecha_reporte) from cl_asfi c where a.af_cod_obligado = c.af_cod_obligado)
union 
select  en_ente,
        af_cod_obligado, 
        af_cod_entidad,
        af_num_correlativo, 
        af_cod_depart_sucur,  
        'Indirecta' as 'tipo_deuda',
        af_saldo_deuda_gar_vig as 'saldo_deuda_vigente', 
        (af_saldo_deuda_gar_30 +  af_saldo_deuda_gar_ven) as 'saldo_deuda_vencida', 
        af_saldo_deuda_gar_ejec as 'saldo_deuda_ejecucion',
        (af_saldo_deuda_gar_cast_ins+ af_saldo_deuda_gar_cast_pre) as 'saldo_deuda_castigada', 
        (af_saldo_deuda_gar_vig + af_saldo_deuda_gar_30 +  af_saldo_deuda_gar_ven + af_saldo_deuda_gar_ejec + af_saldo_deuda_gar_cast_ins + af_saldo_deuda_gar_cast_pre) as 'saldo_total',
        af_saldo_deuda_gar_cont as 'saldo_deuda_contingente',
        af_calificacion as 'calificacion'
from   cl_asfi a , cl_ente b
where  a.af_cod_obligado = en_ced_ruc  
and    a.af_fecha_reporte =  (select max(c.af_fecha_reporte) from cl_asfi c where a.af_cod_obligado = c.af_cod_obligado)
go
