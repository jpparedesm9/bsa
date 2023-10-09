/*  Archivo               : sp_con_elect.sp                                 */
/*  Stored procedure      : sp_conta_electro                            */
/*  Base de datos         : cob_conta_super                             */
/*  Producto              : Contabilidad                                */
/*  Disenado por          : Xavier Almache                              */
/*  Fecha de documentacion: 19 de Septiembre de 2017                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Este programa genera el reporte de contabilidad electrónica         */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA          AUTOR              RAZON                             */
/*  19/09/2017    Xavier Almache      Emision Inicial                   */
/************************************************************************/
use cob_conta_super
go
      
if exists (select 1 from sysobjects where  name = 'sp_conta_electro')
   drop proc sp_conta_electro
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

create proc sp_conta_electro 
(
 @s_user       login       = null
)
as
declare @w_empresa              int,
        @w_sp_name         varchar(30),
        @w_return               int,
        @w_ini_mes              datetime,
        @w_fin_mes_hab          datetime, 
        @w_fin_mes_ant_ori      datetime,
        @w_fin_mes_ant          datetime,
        @w_fin_mes              datetime,
        @w_fecha_proceso        datetime,
        @o_msg        varchar(255) = null,
        @w_mensaje              varchar(150),
        @w_msg                  varchar(255),
        @w_sql                  varchar(5000),
        @w_sql_bcp              varchar(5000),
        @w_nombre_arch          varchar(30),
        @w_ruta_arch            varchar(255),
        @w_error                int,
        @w_batch                int,
        @w_solicitud            char(1),
        @w_reporte         catalogo,
        @w_rfc             varchar(30),
        @w_entidad         varchar(30),
        @w_mes             varchar(2),
        @w_anio            varchar(4)

declare @resultadobcp table (linea varchar(max))

select @w_sp_name = 'sp_conta_electro', 
       @w_reporte = 'CE',
       @w_batch = 36425
	   
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

exec @w_return = cob_conta..sp_calcula_ultima_fecha_habil
@i_reporte          = @w_reporte,
@o_existe_solicitud = @w_solicitud out,
@o_ini_mes          = @w_ini_mes out,
@o_fin_mes          = @w_fin_mes out,
@o_fin_mes_hab      = @w_fin_mes_hab out,
@o_fin_mes_ant      = @w_fin_mes_ant_ori out,
@o_fin_mes_ant_hab  = @w_fin_mes_ant out

if @w_return != 0
begin
   select @w_error = @w_return
   goto ERROR_PROCESO
end

if @w_solicitud = 'N' 
   return 0
   
select @w_empresa = pa_tinyint 
from cobis..cl_parametro 
where pa_nemonico = 'EMP' 
and pa_producto = 'ADM'

select @w_rfc = pa_char from cobis..cl_parametro
where pa_nemonico = 'RFCBAN'

select @w_entidad = pa_char from cobis..cl_parametro
where pa_nemonico = 'NSOFON' 

select @w_mes = DATEPART(MM,@w_ini_mes)

select @w_anio = DATEPART(YYYY,@w_ini_mes)

select
@w_ruta_arch    = ba_path_destino,
@w_nombre_arch  = replace(ba_arch_resultado, '.', (concat('_',UPPER(FORMAT(@w_ini_mes, 'MMM', 'es-US')),@w_anio , '.')))
from cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = '' or isnull(@w_nombre_arch, '') = ''
begin
   select @w_error = 70134
   goto ERROR_PROCESO
end

select as_empresa,
as_comprobante poliza,
as_fecha_tran,
co_descripcion,
as_cuenta,
as_debito,
as_credito,
as_concepto concepto,
as_asiento,
as_concepto_adi
into #tmp_conta_elec_1
from cob_conta..cb_asiento,cob_conta..cb_comprobante
where  as_comprobante = co_comprobante
and    as_fecha_tran  = co_fecha_tran
and    as_fecha_tran >= @w_ini_mes
and    as_fecha_tran <= @w_fin_mes
and    as_empresa     = @w_empresa
and    as_mayorizado  = 'S'
ORDER BY as_fecha_tran,as_comprobante,as_asiento

select a.*,cu_descripcion,convert(money,0) saldo_inicial,convert(money,0) saldo_final
into #tmp_conta_elec_2
from #tmp_conta_elec_1 a,cob_conta..cb_cuenta
where as_cuenta = cu_cuenta
and as_empresa = cu_empresa

update #tmp_conta_elec_2
set saldo_inicial = IsNull((select IsNull((sum(hi_saldo)),0)
                     from cob_conta_his..cb_hist_saldo,cob_conta..cb_corte
                     where hi_empresa = co_empresa
                     and   as_empresa = hi_empresa
                     and   co_fecha_ini >= dateadd(dd,-1,as_fecha_tran)
                     and   co_fecha_ini <= dateadd(dd,-1,as_fecha_tran)
                     and   hi_periodo   = co_periodo 
                     and   as_cuenta    = hi_cuenta
                     and   co_corte     = hi_corte
                     group by hi_empresa,hi_cuenta,hi_corte),0)
                     
update #tmp_conta_elec_2                   
set saldo_final =  saldo_inicial + as_debito - as_credito

--Validamos si existen varios movimientos en la misma fecha para la misma cuenta
select as_empresa,as_cuenta,as_fecha_tran,COUNT(*) contador
into #tmp_conta_elec_3
from #tmp_conta_elec_2
group by as_empresa,as_cuenta,as_fecha_tran
having COUNT(*)>1

if (@@ROWCOUNT > 0)
begin
   update #tmp_conta_elec_2
   set saldo_final = saldo_inicial + isnull((select SUM(c.as_debito) - SUM(c.as_credito) 
                                   from #tmp_conta_elec_2 c 
                                   where a.poliza = c.poliza 
                                   and   a.as_asiento >= c.as_asiento
                                   and a.as_empresa      = c.as_empresa     
                                   and   a.as_cuenta       = c.as_cuenta
                                   and   a.as_fecha_tran           = c.as_fecha_tran 
                                   group by c.as_empresa,c.as_cuenta,as_fecha_tran),0  )
                              + isnull((select SUM(d.as_debito) - SUM(d.as_credito) 
                                   from #tmp_conta_elec_2 d 
                                   where a.poliza > d.poliza 
                                   and a.as_empresa      = d.as_empresa     
                                   and   a.as_cuenta       = d.as_cuenta
                                   and   a.as_fecha_tran           = d.as_fecha_tran 
                                   group by d.as_empresa,d.as_cuenta,as_fecha_tran),0  )
   from #tmp_conta_elec_2 a,#tmp_conta_elec_3 b
   where a.as_empresa      = b.as_empresa     
   and   a.as_cuenta       = b.as_cuenta
   and   a.as_fecha_tran           = b.as_fecha_tran

   update #tmp_conta_elec_2
   set saldo_inicial = saldo_final - as_debito + as_credito
   from #tmp_conta_elec_2 a,#tmp_conta_elec_3 b
   where a.as_empresa      = b.as_empresa     
   and   a.as_cuenta       = b.as_cuenta
   and   a.as_fecha_tran   = b.as_fecha_tran

end

truncate table cob_conta_super..sb_conta_elect

insert into cob_conta_super..sb_conta_elect
select RIGHT('0000'+@w_entidad,4) ce_entidad,
       RIGHT(space(13)+@w_rfc,13) ce_rfc,
       RIGHT('00'+@w_mes,2)       ce_mes,
       @w_anio                    ce_anio,
       LEFT((concat(RIGHT('00'+convert(varchar(2),datepart(dd,@w_fecha_proceso)),2) + UPPER(FORMAT(@w_fecha_proceso, 'MMM', 'es-US'))+ convert(varchar(4),datepart(yyyy,@w_fecha_proceso))  ,'-',RIGHT('000000'+convert(varchar(6),poliza),6)))+SPACE(50), 50) ce_nombre,
       convert(char(10),as_fecha_tran,126) 'ce_fecha_poliza',
       LEFT(co_descripcion+SPACE(300),300)  'ce_concepto_poliza',
       LEFT(as_cuenta+SPACE(100),100 )  'ce_cuenta',
       LEFT(cu_descripcion+SPACE(100),100 )  'ce_nombre_cuenta',
       LEFT(concepto + SPACE(200),200) 'ce_concepto',
       case when saldo_inicial >= 0 
            then concat(' ',REPLICATE('0',16 - LEN (replace(convert(varchar(20),saldo_inicial),'.',''))) + replace(convert(varchar(20),saldo_inicial),'.',''))
            else concat('-',REPLICATE('0',16 - LEN (replace(convert(varchar(20),ABS(saldo_inicial)),'.',''))) + replace(convert(varchar(20),ABS(saldo_inicial)),'.',''))
            end 'ce_saldo_ini',       
       case when as_debito >= 0 
            then concat(' ',REPLICATE('0',16 - LEN (replace(convert(varchar(20),as_debito),'.',''))) + replace(convert(varchar(20),as_debito),'.',''))
            else concat('-',REPLICATE('0',16 - LEN (replace(convert(varchar(20),ABS(as_debito)),'.',''))) + replace(convert(varchar(20),ABS(as_debito)),'.',''))
            end 'ce_debito',
       case when as_credito >= 0 
            then concat(' ',REPLICATE('0',16 - LEN (replace(convert(varchar(20),as_credito),'.',''))) + replace(convert(varchar(20),as_credito),'.',''))
            else concat('-',REPLICATE('0',16 - LEN (replace(convert(varchar(20),ABS(as_credito)),'.',''))) + replace(convert(varchar(20),ABS(as_credito)),'.',''))
            end 'ce_credito',
       case when saldo_final >= 0 
            then concat(' ',REPLICATE('0',16 - LEN (replace(convert(varchar(20),saldo_final),'.',''))) + replace(convert(varchar(20),saldo_final),'.',''))
            else concat('-',REPLICATE('0',16 - LEN (replace(convert(varchar(20),ABS(saldo_final)),'.',''))) + replace(convert(varchar(20),ABS(saldo_final)),'.',''))
            end 'ce_saldo_fin',
       LEFT(substring(as_concepto_adi,1,36)+ SPACE(36),36) ce_referencia,
       as_asiento
from #tmp_conta_elec_2 
order by as_fecha_tran,as_cuenta,poliza,as_asiento

select @w_sql = 'SELECT concat(ce_entidad,ce_rfc,ce_mes,ce_anio,LEFT(ce_nombre+SPACE(50),50),ce_fecha_poliza,LEFT(ce_concepto_poliza+SPACE(300),300),LEFT(ce_cuenta+SPACE(100),100 ),LEFT(ce_nombre_cuenta+SPACE(100),100 ),LEFT(ce_concepto + SPACE(200),200),ce_saldo_ini,ce_debito,ce_credito,ce_saldo_fin,LEFT(isnull(ce_referencia,'''')+ SPACE(36),36)) FROM cob_conta_super.dbo.sb_conta_elect order by ce_fecha_poliza,ce_nombre,ce_asiento'
select @w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + @w_nombre_arch + '" -C -c -t\t -T'

delete from @resultadobcp

insert into @resultadobcp
exec xp_cmdshell @w_sql_bcp;

select * from @resultadobcp

--SELECCIONA CON %ERROR% SI NO ENCUENTRA EN EL FORMATO: ERROR = 
if @w_mensaje is null
    select top 1 @w_mensaje = linea
    from  @resultadobcp 
    where upper(linea) like upper('%Error %')

if @w_mensaje is not null
begin
    select @w_error = 70146
    goto ERROR_PROCESO
end

update cob_conta..cb_solicitud_reportes_reg
set   sr_status = 'P'
where sr_reporte = @w_reporte
and   sr_status = 'I' 

if @@error != 0
begin
    select @w_error = 710002
    goto ERROR_PROCESO
end

return 0

ERROR_PROCESO:

select @w_msg = mensaje
from  cobis..cl_errores with (nolock)
where numero = @w_error
set transaction isolation level read uncommitted

select @w_msg = isnull(@w_msg, @w_mensaje)

exec @w_return       = cob_conta_super..sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @w_fecha_proceso,
     @i_origen_error = @w_error,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg

select @o_msg = ltrim(rtrim(@w_msg))
return @w_error

go
