/************************************************************************/
/*   Archivo:              sb_riesgo_mora.sp                            */
/*   Stored procedure:     sp_riesgo_mora                               */
/*   Base de datos:        cob_ccnta_super                              */
/*   Producto:             Regulatorios                                 */
/*   Disenado por:         Jorge Salazar Andrade                        */
/*   Fecha de escritura:   Enero 2018                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Genera archivo de interface para operaciones en mora diarias       */
/*   banco SANTANDER MX.                                                */
/*                              CAMBIOS                                 */
/************************************************************************/

use cob_conta_super
go

if exists (select 1 from sysobjects where name = 'sp_riesgo_mora')
   drop proc sp_riesgo_mora
go

create proc sp_riesgo_mora

as

declare 
        @w_error                int,
        @w_return               int,
        @w_msg_error            varchar(150),
        @w_comando              varchar(5000),
        @w_ruta_arch            varchar(255),
        @w_nombre_arch          varchar(150),
        @w_sp_name              varchar(30),
        @w_fecha_proceso        datetime,
        @w_msg                  varchar(255),
        @w_batch                int,
        @w_s_app                varchar(30),
        @w_destino              varchar(1000),
        @w_errores              varchar(1000),
        @w_est_vigente          tinyint,
        @w_est_vencido          tinyint,
        @w_est_cancelado        tinyint,
        @w_ciudad_nacional      int,
        @w_fecha_ini            datetime,
        @w_fecha_fin            datetime


select @w_sp_name = 'sp_riesgo_mora'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_batch = 36426

--Obtiene el parametro de la ubicacion del kernel\bin en el servidor
select @w_s_app = pa_char
from  cobis..cl_parametro
where pa_producto = 'ADM' 
and   pa_nemonico = 'S_APP'


select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

--- ESTADOS DE CARTERA 
exec @w_error     = cob_cartera..sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_cancelado  = @w_est_cancelado out

if @w_error <> 0 goto ERROR_PROCESO



--HASTA ENCONTRAR EL HABIL ANTERIOR
select  @w_fecha_ini  = dateadd(dd,-1,@w_fecha_proceso)
select  @w_fecha_fin  = dateadd(dd,-1,@w_fecha_proceso)


while exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_ini )
begin
   if datepart(dd, @w_fecha_ini) != 1 select @w_fecha_ini = dateadd(dd, -1, @w_fecha_ini) else break
end

select
@w_ruta_arch    = ba_path_destino,
@w_nombre_arch  = isnull(upper(ba_arch_resultado), 'COBIS_RECIBO') + '_' + convert(varchar(8), @w_fecha_ini, 112)
from cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = '' or isnull(@w_nombre_arch, '') = ''
begin
   select @w_error = 70134
   goto ERROR_PROCESO
end


truncate table sb_riesgo_mora

select
banco        = op_banco,
operacion    = op_operacion,
oficina      = op_oficina,
cliente      = op_cliente,
estado       = op_estado,
tasa         = convert(float,0),
di_dividendo = di_dividendo,
di_estado    = di_estado,
di_fecha_ini = di_fecha_ini,
di_fecha_ven = di_fecha_ven,
capinire     = isnull(sum(case am_concepto when 'CAP'       then am_cuota  else 0 end),0),
intinire     = isnull(sum(case am_concepto when 'INT'       then am_cuota  else 0 end),0),
cominire     = isnull(sum(case am_concepto when 'COMMORA'   then am_cuota  else 0 end),0),
ivaintinire  = isnull(sum(case am_concepto when 'IVA_INT'   then am_cuota  else 0 end),0),
ivacominire  = isnull(sum(case am_concepto when 'IVA_CMORA' then am_cuota  else 0 end),0),
caprecre     = isnull(sum(case am_concepto when 'CAP'       then am_pagado else 0 end),0),
intrecre     = isnull(sum(case am_concepto when 'INT'       then am_pagado else 0 end),0),
comrecre     = isnull(sum(case am_concepto when 'COMMORA'   then am_pagado else 0 end),0),
ivaintrecre  = isnull(sum(case am_concepto when 'IVA_INT'   then am_pagado else 0 end),0),
ivacomrecre  = isnull(sum(case am_concepto when 'IVA_CMORA' then am_pagado else 0 end),0),
intdeven     = isnull(sum(case am_concepto when 'INT'       then (am_cuota - am_pagado) else 0 end),0),
intbaseiva   = isnull(sum(case am_concepto when 'INT'       then am_cuota  else 0 end),0),
fecalmor     = convert(datetime,null),
salteor      = convert(money,null),
timestamp    = di_fecha_ven,
ofiulmod     = op_oficina,
grupoid      = convert(int,'0'),
nrociclo     = convert(int,'1'),
grupoint     = convert(int,'1')
into #saldos
from cob_cartera..ca_operacion, cob_cartera..ca_dividendo, cob_cartera..ca_amortizacion
where op_operacion = di_operacion
and   op_operacion = am_operacion
and   di_dividendo = am_dividendo
and   di_fecha_ven between @w_fecha_ini and @w_fecha_fin
and   op_estado in (@w_est_vigente, @w_est_vencido)
and   op_toperacion not in ('REVOLVENTE') 
group by op_banco,op_operacion,op_oficina,op_cliente,op_estado,di_dividendo,di_estado,di_fecha_ini,di_fecha_ven

if @@error != 0  begin
   select @w_error = 708192
   goto ERROR_PROCESO
end

update #saldos
set tasa = ro_porcentaje
from cob_cartera..ca_rubro_op
where ro_operacion = operacion
and   ro_concepto  = 'INT'

if @@error != 0  begin
   select @w_error = 710002
   goto ERROR_PROCESO
end

select
ult_operacion  = tr_operacion,
ult_secuencial = max(tr_secuencial)
into #ultpagos
from cob_cartera..ca_transaccion, cob_cartera..ca_det_trn, #saldos
where tr_operacion  = dtr_operacion
and   tr_operacion  = operacion
and   tr_secuencial = dtr_secuencial
and   tr_tran       = 'PAG'
and   dtr_dividendo = di_dividendo
group by tr_operacion

if @@error != 0  begin
   select @w_error = 708192
   goto ERROR_PROCESO
end


update #saldos set
fecalmor  = tr_fecha_ref,
timestamp = tr_fecha_real,
ofiulmod  = tr_ofi_usu
from cob_cartera..ca_transaccion, #ultpagos
where tr_operacion = ult_operacion
and   tr_secuencial= ult_secuencial
and   tr_operacion = operacion

if @@error != 0  begin
   select @w_error = 710002
   goto ERROR_PROCESO
end


select
sa_operacion  = operacion,
sa_saldo = isnull(sum(am_cuota - am_pagado),0)
into #saldocapital
from cob_cartera..ca_amortizacion, #saldos
where am_operacion  = operacion
and   am_concepto   = 'CAP'
group by operacion

if @@error != 0  begin
   select @w_error = 708192
   goto ERROR_PROCESO
end


update #saldos set
salteor  = sa_saldo
from #saldocapital
where sa_operacion = operacion

if @@error != 0  begin
   select @w_error = 710002
   goto ERROR_PROCESO
end


update #saldos set
grupoid = dc_grupo
from cob_cartera..ca_det_ciclo
where dc_operacion = operacion
and   dc_cliente   = cliente

if @@error != 0  begin
   select @w_error = 710002
   goto ERROR_PROCESO
end


update #saldos set
nrociclo = isnull(en_nro_ciclo,1)
from cobis..cl_ente
where en_ente = cliente

if @@error != 0  begin
   select @w_error = 710002
   goto ERROR_PROCESO
end


select
grupomiembro  = dc_grupo,
miembros = count(1)
into #miembros
from cob_cartera..ca_det_ciclo, #saldos
where dc_operacion = operacion
group by dc_grupo

if @@error != 0  begin
   select @w_error = 708192
   goto ERROR_PROCESO
end


update #saldos set
grupoint = miembros
from #miembros
where grupoid = grupomiembro

if @@error != 0  begin
   select @w_error = 710002
   goto ERROR_PROCESO
end


insert into sb_riesgo_mora
select
entidad        = ' ',                                                                  --1
codiser        = '96',                                                                 --2
ofiape         = cob_cartera.dbo.LlenarI(cast(oficina as varchar), '0', 4),            --3
numecta        = cob_cartera.dbo.LlenarI(banco, '0', 12),                              --4
digicta        = '0',                                                                  --5
indpeco        = case di_estado when @w_est_cancelado then '0' else '1' end,           --6
numrec         = cob_cartera.dbo.LlenarI(cast(di_dividendo as varchar), '0', 4),       --7
feliq          = convert(varchar(10),di_fecha_ven,127),                                --8
capinire       = ' ' + cob_cartera.dbo.LlenarI(cast(cast(floor(capinire) as int) as varchar), '0', 12) + '.' + cob_cartera.dbo.LlenarD(cast(cast((capinire * 100 % 100) as int) as varchar),'0', 2),
intinire       = ' ' + cob_cartera.dbo.LlenarI(cast(cast(floor(intinire) as int) as varchar), '0', 12) + '.' + cob_cartera.dbo.LlenarD(cast(cast((intinire * 100 % 100) as int) as varchar),'0', 2),
cominire       = ' ' + cob_cartera.dbo.LlenarI(cast(cast(floor(cominire) as int) as varchar), '0', 12) + '.' + cob_cartera.dbo.LlenarD(cast(cast((cominire * 100 % 100) as int) as varchar),'0', 2),
seginire       = '0000000000000000',                                                  --12
gasinire       = '0000000000000000',                                                  --13
ivaintinire    = ' ' + cob_cartera.dbo.LlenarI(cast(cast(floor(ivaintinire) as int) as varchar), '0', 12) + '.' + cob_cartera.dbo.LlenarD(cast(cast((ivaintinire * 100 % 100) as int) as varchar),'0', 2),
ivacominire    = ' ' + cob_cartera.dbo.LlenarI(cast(cast(floor(ivacominire) as int) as varchar), '0', 12) + '.' + cob_cartera.dbo.LlenarD(cast(cast((ivacominire * 100 % 100) as int) as varchar),'0', 2),
ivagasinire    = '0000000000000000',                                                  --16
ivaseginire    = '0000000000000000',                                                  --17
caprecre       = ' ' + cob_cartera.dbo.LlenarI(cast(cast(floor(caprecre) as int) as varchar), '0', 12) + '.' + cob_cartera.dbo.LlenarD(cast(cast((caprecre * 100 % 100) as int) as varchar),'0', 2),
intrecre       = ' ' + cob_cartera.dbo.LlenarI(cast(cast(floor(intrecre) as int) as varchar), '0', 12) + '.' + cob_cartera.dbo.LlenarD(cast(cast((intrecre * 100 % 100) as int) as varchar),'0', 2),
comrecre       = ' ' + cob_cartera.dbo.LlenarI(cast(cast(floor(comrecre) as int) as varchar), '0', 12) + '.' + cob_cartera.dbo.LlenarD(cast(cast((comrecre * 100 % 100) as int) as varchar),'0', 2),
segrecre       = '0000000000000000',                                                  --21
gasrecre       = '0000000000000000',                                                  --22
ivaintrecre    = ' ' + cob_cartera.dbo.LlenarI(cast(cast(floor(ivaintrecre) as int) as varchar), '0', 12) + '.' + cob_cartera.dbo.LlenarD(cast(cast((ivaintrecre * 100 % 100) as int) as varchar),'0', 2),
ivacomrecre    = ' ' + cob_cartera.dbo.LlenarI(cast(cast(floor(ivacomrecre) as int) as varchar), '0', 12) + '.' + cob_cartera.dbo.LlenarD(cast(cast((ivacomrecre * 100 % 100) as int) as varchar),'0', 2),
ivagasrecre    = '0000000000000000',                                                  --25
ivasegrecre    = '0000000000000000',                                                  --26
coemora        = '0000000000000000',                                                  --27
coemosus       = '00000000',                                                          --28
coemopen       = '0000000000',                                                        --29
fecalmor       = isnull(convert(varchar(10),fecalmor,127),'0001-01-01'),              --30
fereten        = '0001-01-01',                                                        --31
securet        = '000',                                                               --32
salteor        = ' ' + cob_cartera.dbo.LlenarI(cast(cast(floor(salteor) as int) as varchar), '0', 12) + '.' + cob_cartera.dbo.LlenarD(cast(cast((salteor * 100 % 100) as int) as varchar),'0', 2),
feiniliq       =  convert(varchar(10),di_fecha_ini,127),                              --34
edocont        =  case estado when @w_est_vigente then '0' else '1' end,              --35
tasa           = cob_cartera.dbo.LlenarI(cast(cast(floor(cast(tasa as decimal(16,2))) as int) as varchar), '0', 3) + '.' + cob_cartera.dbo.LlenarD(cast(cast((cast(tasa as decimal(16,2)) * 100 % 100) as int) as varchar),'0', 4),
intdeven       = ' ' + cob_cartera.dbo.LlenarI(cast(cast(floor(intdeven) as int) as varchar), '0', 12) + '.' + cob_cartera.dbo.LlenarD(cast(cast((intdeven * 100 % 100) as int) as varchar),'0', 2),
morapend       = '0000000000000000',                                                  --38
intrefin       = '0000000000000000',                                                  --39
tipcamb        = '00000000000',                                                       --40
intbaseiva     = ' ' + cob_cartera.dbo.LlenarI(cast(cast(floor(intbaseiva) as int) as varchar), '0', 12) + '.' + cob_cartera.dbo.LlenarD(cast(cast((intbaseiva * 100 % 100) as int) as varchar),'0', 2),
--timestamp    = convert(varchar(10),timestamp,127) + '-23.59.59.999999',             --42
timestamp      = convert(varchar(10), timestamp, 121) + '-' + isnull(replace(substring(convert(varchar(25), timestamp, 121), 12, len(convert(varchar(25), timestamp, 121))), ':', '.'), '23.59.59.999') + '000',
numter         = 'COB',                                                               --43
usuario        = 'COB',                                                               --44
ofiulmod       = cob_cartera.dbo.LlenarI(cast(ofiulmod as varchar), '0', 4),          --45
capinirea      = '0000000000000000',                                                  --46
intinirea      = '0000000000000000',                                                  --47
pagogob        = '0000000000000000',                                                  --48
pagban         = '0000000000000000',                                                  --49
intrefina      = '0000000000000000',                                                  --50
salteora       = '0000000000000000',                                                  --51
intmora        = '0000000000000000',                                                  --52
intmoran       = '0000000000000000',                                                  --53
intmorac       = '0000000000000000',                                                  --54
ivamora        = '0000000000000000',                                                  --55
edocont2       =  case estado when @w_est_vigente then '0' else '1' end,              --56
garaejer       = ' ',                                                                 --57
ofiape4n       = cob_cartera.dbo.LlenarI(cast(oficina as varchar), '0', 4),           --58
ofiulmod4      = cob_cartera.dbo.LlenarI(cast(oficina as varchar), '0', 4),           --59
combcoini      = '0000000000000000',                                                  --60
comfovini      = '0000000000000000',                                                  --61
combcorec      = '0000000000000000',                                                  --62
comfovrec      = '0000000000000000',                                                  --63
sitpago        = case di_estado when @w_est_cancelado then '0' else '1' end,          --64
grupoid        = cob_cartera.dbo.LlenarI(cast(cast(grupoid as int) as varchar),  '0', 16),  --65
nrociclo       = cob_cartera.dbo.LlenarI(cast(cast(nrociclo as int) as varchar), '0', 4),   --66
grupoint       = cob_cartera.dbo.LlenarI(cast(cast(grupoint as int) as varchar), '0', 4)    --67
from #saldos

if @@error != 0
begin
   select @w_error = 708192
   goto ERROR_PROCESO
end


update sb_riesgo_mora
set rm_timestamp = substring(rm_timestamp, 1, 11) + '23.59.59.999000'
where convert(decimal(13,0), isnull(replace(substring(rm_timestamp, 12, len(rm_timestamp)), '.', ''), 0)) = 0

if @@error != 0
begin
   select @w_error = 710568
   goto ERROR_PROCESO
end


select @w_comando = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_riesgo_mora out '

select @w_destino = @w_ruta_arch + @w_nombre_arch + '.txt',
       @w_errores = @w_ruta_arch + @w_nombre_arch + '.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

print @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 
begin
   select @w_msg_error = 'Error Generando Archivo 06 - Moras Diario'
   goto ERROR_PROCESO
end

SALIDA_PROCESO:
   return 0

ERROR_PROCESO:

select @w_msg = mensaje
from  cobis..cl_errores with (nolock)
where numero = @w_error
set transaction isolation level read uncommitted

select @w_msg = isnull(@w_msg, @w_msg_error)

exec @w_return       = cob_conta_super..sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @w_fecha_proceso,
     @i_origen_error = @w_error,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg

return @w_error
go

