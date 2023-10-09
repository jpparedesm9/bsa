/************************************************************************/
/*   Archivo:              cabcpcon.sp                                  */
/*   Stored procedure:     sp_carga_bcps_consolidado                    */
/*   Disenado por:         Monica Vidal                                 */
/*   Fecha de escritura:   08/07/07                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Procesar las custodias o colaterales de manera que se añadan o     */
/*   se eliminen asociaciones de pagares segun se requiera para         */
/*   mantener el valor de cobertura requerido.                          */
/************************************************************************/

use cob_custodia
go


if exists (select 1 from sysobjects where name = 'sp_carga_bcps_consolidado')
   drop proc sp_carga_bcps_consolidado
go


create proc sp_carga_bcps_consolidado
@i_fecha_proc     datetime,
@i_formato_fecha  tinyint = 103,
@o_msg            varchar(250) out
as

declare 
@w_error    int,
@w_file           varchar(250),
@w_path           varchar(250),
@w_s_app          varchar(250),
@w_fecha_arch     varchar(10),
@w_cmd            varchar(250),
@w_bd             varchar(250),
@w_tabla          varchar(250),
@w_comando        varchar(250),
@w_destino        varchar(250),
@w_errores        varchar(250),
@w_path_s_app     varchar(250)

select @w_path_s_app = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'S_APP'

if @w_path_s_app is null begin
   select @o_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
   goto ERROR
end



truncate table cu_pagares_resumen

insert into cu_pagares_resumen(
pr_cliente,     pr_nombre,      pr_numero,      
pr_saldo,       pr_fecha_gen)
select
cdt_ente_pas,   '',             count(*),
sum(cdt_saldo_cap), 
convert(varchar, max(cdt_fecha_proc), @i_formato_fecha)
from  cu_colateral_det_tmp
where cdt_accion = 'R' --RESUMEN
group by cdt_ente_pas
order by cdt_ente_pas

if @@error <> 0 begin
   select @o_msg = 'ERROR AL GENERAR DATOS DE RESUMEN DE PAGARES'
   goto ERROR
end


update cu_pagares_resumen set
pr_nombre = isnull(en_nomlar, '')
from   cobis..cl_ente
where  pr_cliente = en_ente

if @@error <> 0 begin
   select @o_msg = 'ERROR AL ACTUALIZAR NOMBRE DE CLIENTE'
   goto ERROR
end

truncate table cu_pagares_sin_custodia

insert into cu_pagares_sin_custodia (
ps_banco,      ps_toperacion,  ps_fecha_ini,  
ps_ced_ruc,    ps_nomlar,      ps_monto,      
ps_saldo,      ps_oficina,     ps_desc_ofi)
select
cdt_banco_act, cdt_toperacion, convert(varchar, cdt_fecha_ini, @i_formato_fecha),
en_ced_ruc,    isnull(en_nomlar, ''),     cdt_monto,      
cdt_saldo_cap, cdt_oficina,    ''
from  cu_colateral_det_tmp, cobis..cl_ente
where cdt_accion  = 'L' --LISTADO
and   cdt_cliente = en_ente
order by cdt_oficina, cdt_banco_act

if @@error <> 0 begin
   select @o_msg = 'ERROR AL GENERAR DATOS DE PAGARES SIN CUSTODIA'
   goto ERROR
end

update cu_pagares_sin_custodia set
ps_desc_ofi = of_nombre
from   cobis..cl_oficina
where  of_oficina = ps_oficina

if @@error <> 0 begin
   select @o_msg = 'ERROR AL ACTUALIZAR CON NOMBRE DE OFICINA PAGARES SIN CUSTODIA'
   goto ERROR
end

/* REALIZO BCP POR CADA TABLA */
select
@w_file       = 'C',
@w_s_app      = @w_path_s_app + 's_app',
@w_fecha_arch = convert(varchar, @i_fecha_proc, 112)

select
@w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = 19057


/* TABLA DE PAGARES QUE ENTRAN */
select
@w_cmd      = @w_s_app+' bcp -auto -login ',
@w_bd       = 'cob_custodia',
@w_tabla    = 'cu_pagares_resumen',
@w_destino  = @w_path + @w_file + 'RES' + @w_fecha_arch + '.out',
@w_errores  = @w_path + @w_file + 'RES' + @w_fecha_arch + '.err'

select
@w_comando = @w_cmd + @w_bd + '..' + @w_tabla + ' out ' + @w_destino + ' -b5000 -c -e'+@w_errores + ' -t"§" ' + '-config '+@w_s_app+'.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @o_msg = 'ERROR AL GENERAR ARCHIVO '+@w_destino+ ' '+ convert(varchar, @w_error)
   goto ERROR
end

/* TABLA DE PAGARES QUE SIN CUSTODIA */
select
@w_tabla    = 'cu_pagares_sin_custodia',
@w_destino  = @w_path + @w_file + 'LIB' + @w_fecha_arch + '.out',
@w_errores  = @w_path + @w_file + 'LIB' + @w_fecha_arch + '.err'

select
@w_comando = @w_cmd + @w_bd + '..' + @w_tabla + ' out ' + @w_destino + ' -b5000 -c -e'+@w_errores + ' -t"§" ' + '-config '+@w_s_app+'.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @o_msg = 'ERROR AL GENERAR ARCHIVO '+@w_destino+ ' '+ convert(varchar, @w_error)
   goto ERROR
end

return 0
ERROR:
print @o_msg
return 1

go


