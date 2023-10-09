/************************************************************************/
/*  Archivo               : rptnewinv.sp                                */
/*  Stored procedure      : sp_rptnewinv                                */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo Fijo                                  */
/*  Disenado por          : ALF                                         */
/*  Fecha de documentacion: 24/Mar/10                                   */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBISCORP'                                                         */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de COBISCORP o su representante.              */
/*                          PROPOSITO                                   */
/*  reporte de nuevas inversiones en el mes,  almacena datos            */
/*  en la tabla cob_externos..re_nueva_inversion, todos los saldos      */
/*  estan en dolares                                                    */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA           AUTOR              RAZON                            */ 
/*  24-Mar-2010     ALF                Emision Inicial                  */
/************************************************************************/ 
use cob_pfijo
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select name from sysobjects where name = 'sp_rptnewinv')
   drop proc sp_rptnewinv
go

create proc sp_rptnewinv (
   	   @i_param1           varchar(255)
)
with encryption
as

declare @w_sp_name       varchar(30),
        @w_msg           varchar(240),
        @w_error         int,
        @w_retorno       int,
        @w_retorno_ej    int,
        @w_error_msg     int,
        @w_fin_mes       datetime,
        @w_fecha_proceso datetime

declare @rangos table
(rango int null,
 desde int null, 
 hasta int null
)

declare @cotizacion table
(ct_empresa tinyint  null,
 ct_fecha   datetime null,
 ct_moneda  tinyint  null,
 ct_valor   money    null,
 ct_compra  money    null,
 ct_venta   money    null
)

select @w_fecha_proceso  = convert(datetime, @i_param1),
       @w_sp_name = 'sp_rptnewinv'

insert into @cotizacion
select 1,
       ct_fecha,
       ct_moneda,
       ct_valor,
       ct_compra,
       ct_venta
from cob_conta..cb_cotizacion a
where ct_fecha   = ( select max(ct_fecha)
                     from cob_conta..cb_cotizacion
                     where ct_moneda  = a.ct_moneda
                       and ct_fecha  <= @w_fecha_proceso )

if @@rowcount = 0
begin
     select @w_retorno_ej = 14000,
            @w_error_msg = '[' + @w_sp_name + '] ' + 'Error en consulta cob_conta..cb_cotizacion'
     goto ERROR
end


select @w_sp_name = 'sp_rptnewinv',
       @w_error   = 0,
       @w_fin_mes = dateadd(dd,-datepart(dd,dateadd(mm,1,@w_fecha_proceso)),dateadd(mm,1,@w_fecha_proceso))

insert into @rangos
values (1, 0, 30)
insert into @rangos
values (2,31, 60)
insert into @rangos
values (3,61, 90)
insert into @rangos
values (4,91, 120)
insert into @rangos
values (5,121,150)
insert into @rangos
values (6,151,180)
insert into @rangos
values (7,181,999999)


delete cob_externos..re_nueva_inversion
where ni_fecha = @w_fin_mes

select @w_error = @@error

if @w_error != 0
begin
     select @w_retorno_ej = 14000,
            @w_error_msg = '[' + @w_sp_name + '] ' + 'Error al eliminar datos en cob_externos..re_nueva_inversion'
     goto ERROR
end

insert into cob_externos..re_nueva_inversion
( ni_fecha,
  ni_tipo_prod,
  ni_rango,
  ni_desde,
  ni_hasta,
  ni_sld_cap
)
-- DPF
select @w_fin_mes,
       op_toperacion,
       rango,
       desde,
       hasta,
       sum(op_monto*isnull(ct_valor,1))
from cob_pfijo..pf_operacion left outer join  cob_pfijo..pf_renovacion on (re_operacion = op_operacion)
                             left outer join  @cotizacion on (op_moneda = ct_moneda),
     @rangos    
where op_estado                                          in ('ACT','VEN')--,'CAN')
  and substring(convert(char(8),op_fecha_valor,112),1,6) = substring(convert(char(8),@w_fin_mes,112),1,6) 
  and op_num_prorroga                                    = 0
  and (op_renovaciones                                   = 0 or (op_renovaciones > 0 and re_estado = 'I'))     
  and datediff(dd,op_fecha_valor,op_fecha_ven)           between desde and hasta
group by op_toperacion, rango, desde, hasta
-- Bonos
-- Repo Pasivo

select @w_error = @@error

if @w_error != 0
begin
     select @w_retorno_ej = 14000,
            @w_error_msg = '[' + @w_sp_name + '] ' + 'Error al registrar datos en cob_externos..re_nueva_inversion'
     goto ERROR
end
return 0

ERROR:

exec @w_retorno     = cob_pfijo..sp_errorlog
     @i_fecha       = @w_fecha_proceso, 
     @i_error       = @w_retorno_ej, 
     @i_usuario     = 'OPERADOR',
     @i_tran        = 14000, 
     @i_tran_name   = @w_sp_name, 
     @i_rollback    = 'N',
     @i_cuenta      = 'sp_rptnewinv', 
     @i_descripcion = @w_error_msg

if @w_retorno > 0
    return @w_retorno
else
    return @w_retorno_ej 

go

