/************************************************************************/
/*   Archivo:              cabcppag.sp                                  */
/*   Stored procedure:     sp_carga_bcps_pagares                        */
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


if exists (select 1 from sysobjects where name = 'sp_carga_bcps_pagares')
   drop proc sp_carga_bcps_pagares
go


create proc sp_carga_bcps_pagares
@i_fecha          datetime,
@i_cliente        int,
@i_codigo         cuenta  = null,
@i_formato_fecha  tinyint = 103,
@o_msg            varchar(250) out
as

declare
@w_error          int,
@w_file           varchar(250),
@w_path           varchar(250),
@w_s_app          varchar(250),
@w_fecha_arch     varchar(10),
@w_cmd            varchar(250),
@w_bd             varchar(250),
@w_tabla          varchar(250),
@w_comando        varchar(500),
@w_destino        varchar(250),
@w_errores        varchar(250),
@w_path_s_app     varchar(250),
@w_pasiva         varchar(250),
@w_cont           int,
@w_valor          int

select @w_path_s_app = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'S_APP'

if @w_path_s_app is null begin
   select @o_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
   goto ERROR
end

select @i_codigo = ltrim(rtrim(isnull(@i_codigo, '')))

truncate table cu_pagares_entran
truncate table cu_pagares_por_entidad
truncate table cu_pagares_certificado

select
pt_banco        = cdt_banco_act,
pt_toperacion   = cdt_toperacion,
pt_cliente      = cdt_cliente,
pt_ced_ruc      = convert(varchar(30), ''),
pt_nomlar       = convert(varchar(254), ''),
pt_fecha_ini    = convert(varchar, cdt_fecha_ini, @i_formato_fecha),
pt_fecha_fin    = convert(varchar, cdt_fecha_fin, @i_formato_fecha),
pt_monto        = cdt_monto,
pt_tasa_int     = cdt_tasa,
pt_amor_cap     = cdt_amor_cap,
pt_amor_int     = cdt_amor_int,
pt_calificacion = cdt_calificacion,
pt_saldo        = cdt_saldo_cap,
pt_oficina      = cdt_oficina,
pt_desc_ofi     = convert(varchar(64), ''),
pt_accion       = cdt_accion,
pt_orden        = isnull(cdt_orden,-1)
into #pagares_total
from  cu_colateral_det_tmp
where cdt_ente_pas = @i_cliente
and   cdt_codigo_pas = @i_codigo
order by pt_banco

update #pagares_total set
pt_ced_ruc      = en_ced_ruc,
pt_nomlar       = isnull(en_nomlar, '')
from   cobis..cl_ente
where  pt_cliente = en_ente

update #pagares_total set
pt_desc_ofi = of_nombre
from   cobis..cl_oficina
where  pt_oficina = of_oficina

/* SEPARO EN TABLAS POR CADA ACCION (ENTRAN, SALEN, POR ENTIDAD) */
select
pt_banco,        pt_toperacion,   pt_ced_ruc,
pt_nomlar,       pt_fecha_ini,    pt_fecha_fin,
pt_monto,        pt_tasa_int,     pt_amor_cap,
pt_amor_int,     pt_calificacion, pt_saldo,
pt_desc_ofi,     pt_oficina,      pt_accion,
pt_orden
into #pagares_entran
from #pagares_total
where pt_accion = 'E'
order by pt_orden, pt_banco

select
pt_banco,        pt_toperacion,   pt_ced_ruc,
pt_nomlar,       pt_fecha_ini,    pt_fecha_fin,
pt_monto,        pt_tasa_int,     pt_amor_cap,
pt_amor_int,     pt_calificacion, pt_saldo,
pt_desc_ofi,     pt_oficina,      pt_accion,
pt_orden
into #pagares_por_entidad
from #pagares_total
where pt_accion = 'T'
order by pt_orden, pt_banco

/* INSERTO EN LAS TABLAS QUE VOY A BAJAR CON BCP */
insert into cu_pagares_entran (
pe_sec,        pe_banco,      pe_toperacion,
pe_fecha_ini,  pe_ced_ruc,    pe_nomlar,
pe_monto,      pe_saldo,      pe_oficina,
pe_desc_ofi)
select
pt_orden,      pt_banco,      pt_toperacion,
pt_fecha_ini,  pt_ced_ruc,    pt_nomlar,
pt_monto,      pt_saldo,      pt_oficina,
pt_desc_ofi
from  #pagares_entran
order by pt_orden, pt_banco

if @@error <> 0 begin
   select @o_msg = 'ERROR AL GENERAR DATOS DE PAGARES QUE ENTRAN'
   goto ERROR
end

insert into cu_pagares_por_entidad (
pe_sec,        pe_banco,      pe_toperacion,
pe_fecha_ini,  pe_ced_ruc,    pe_nomlar,
pe_monto,      pe_saldo,      pe_oficina,
pe_desc_ofi)
select
pt_orden,      pt_banco,      pt_toperacion,
pt_fecha_ini,  pt_ced_ruc,    pt_nomlar,
pt_monto,      pt_saldo,      pt_oficina,
pt_desc_ofi
from #pagares_por_entidad
order by pt_orden, pt_banco

if @@error <> 0 begin
   select @o_msg = 'ERROR AL GENERAR DATOS DE PAGARES POR ENTIDAD'
   goto ERROR
end


insert into cu_pagares_certificado(
pc_banco,        pc_toperacion,   pc_ced_ruc,
pc_nomlar,       pc_fecha_ini,    pc_fecha_fin,
pc_monto,        pc_tasa_int,     pc_amor_cap,
pc_amor_int,     pc_calificacion, pc_saldo,
pc_desc_ofi,     pc_oficina,      pc_sec          )
select
pt_banco,        pt_toperacion,   pt_ced_ruc,
pt_nomlar,       pt_fecha_ini,    pt_fecha_fin,
pt_monto,        pt_tasa_int,     pt_amor_cap,
pt_amor_int,     pt_calificacion, pt_saldo,
pt_desc_ofi,     pt_oficina,      pt_orden
from #pagares_por_entidad
order by pt_orden, pt_banco

if @@error <> 0 begin
   select @o_msg = 'ERROR AL GENERAR DATOS DE PAGARES PARA CERTIFICACION'
   goto ERROR
end


--REENUMERAR LOS SECUENCIALES DE LAS TABLAS PARA LOS BCP'S
/* cu_pagares_certificado */

select @w_valor = 1

update cu_pagares_certificado set
pc_sec = -1

select @w_cont = count(1) 
from cu_pagares_certificado

while @w_valor <= @w_cont
begin

   set rowcount 1

   update cu_pagares_certificado set
   pc_sec = @w_valor
   where pc_sec = -1

   select @w_valor = @w_valor + 1
end

set rowcount 0

/* cu_pagares_por_entidad */

select @w_valor = 1

update cu_pagares_por_entidad set
pe_sec = -1

select @w_cont = count(1) 
from cu_pagares_por_entidad

while @w_valor <= @w_cont
begin

   set rowcount 1

   update cu_pagares_por_entidad set
   pe_sec = @w_valor
   where pe_sec = -1

   select @w_valor = @w_valor + 1
end

set rowcount 0

/* cu_pagares_salen */

select @w_valor = 1

update cu_pagares_salen set
ps_sec = -1

select @w_cont = count(1) 
from cu_pagares_salen 

while @w_valor <= @w_cont
begin

   set rowcount 1

   update cu_pagares_salen set
   ps_sec = @w_valor
   where ps_sec = -1

   select @w_valor = @w_valor + 1
end

set rowcount 0

/* cu_pagares_entran */

select @w_valor = 1

update cu_pagares_entran set
pe_sec = -1

select @w_cont = count(1) 
from cu_pagares_entran 

while @w_valor <= @w_cont
begin

   set rowcount 1

   update cu_pagares_entran set
   pe_sec = @w_valor
   where pe_sec = -1

   select @w_valor = @w_valor + 1
end

set rowcount 0


/* REALIZO BCP POR CADA TABLA */
select
@w_file  = 'C',
@w_s_app = @w_path_s_app + 's_app',
@w_fecha_arch = convert(varchar, @i_fecha, 112)

select 
@w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = 19057

select @w_pasiva = case when datalength(@i_codigo) = 0 then convert(varchar, @i_cliente) else @i_codigo end


/* TABLA DE PAGARES QUE ENTRAN */
select
@w_cmd      = @w_s_app+' bcp -auto -login ',
@w_bd       = 'cob_custodia',
@w_tabla    = 'cu_pagares_entran',
@w_destino  = @w_path + @w_file + 'ENT' + @w_fecha_arch+'_'+@w_pasiva + '.out',
@w_errores  = @w_path + @w_file + 'ENT' + @w_fecha_arch+'_'+@w_pasiva + '.err'

select
@w_comando = @w_cmd + @w_bd + '..' + @w_tabla + ' out ' + @w_destino + ' -b5000 -c -e'+@w_errores + ' -t"§" ' + '-config '+@w_s_app+'.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @o_msg = 'ERROR AL GENERAR ARCHIVO '+@w_destino+ ' '+ convert(varchar, @w_error)
   goto ERROR
end

/* TABLA DE PAGARES QUE SALEN */
select
@w_tabla    = 'cu_pagares_salen',
@w_destino  = @w_path + @w_file + 'SAL'+ @w_fecha_arch+'_'+@w_pasiva + '.out',
@w_errores  = @w_path + @w_file + 'SAL'+ @w_fecha_arch+'_'+@w_pasiva + '.err'

select
@w_comando = @w_cmd + @w_bd + '..' + @w_tabla + ' out ' + @w_destino + ' -b5000 -c -e'+@w_errores + ' -t"§" ' + '-config '+@w_s_app+'.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @o_msg = 'ERROR AL GENERAR ARCHIVO '+@w_destino+ ' '+ convert(varchar, @w_error)
   goto ERROR
end

/* TABLA DE PAGARES QUE POR ENTIDAD */
select
@w_tabla    = 'cu_pagares_por_entidad',
@w_destino  = @w_path + @w_file + 'PAG'+ @w_fecha_arch+'_'+@w_pasiva + '.out',
@w_errores  = @w_path + @w_file + 'PAG'+ @w_fecha_arch+'_'+@w_pasiva + '.err'

select
@w_comando = @w_cmd + @w_bd + '..' + @w_tabla + ' out ' + @w_destino + ' -b5000 -c -e'+@w_errores + ' -t"§" ' + '-config '+@w_s_app+'.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @o_msg = 'ERROR AL GENERAR ARCHIVO '+@w_destino+ ' '+ convert(varchar, @w_error)
   goto ERROR
end

/* TABLA DE PAGARES CERTIFICADO */
select
@w_tabla    = 'cu_pagares_certificado',
@w_destino  = @w_path + @w_file + 'CER'+ @w_fecha_arch+'_'+@w_pasiva + '.out',
@w_errores  = @w_path + @w_file + 'CER'+ @w_fecha_arch+'_'+@w_pasiva + '.err'

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
return 1900001

go


