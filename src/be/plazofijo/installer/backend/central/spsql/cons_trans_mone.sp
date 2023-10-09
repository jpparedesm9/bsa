/************************************************************************/
/*      Archivo:                b_movmon.sp                             */
/*      Stored procedure:       sp_cons_trans_mone                      */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Clotilde Vargas T.                      */
/*      Fecha de documentacion: 19-Set-2005                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este procedure crea los procedimientos para las consultas de    */
/*      transacciones monetarias                                        */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR              RAZON                        */
/*      19-Set-2005     Clotilde Vargas     Emision Inicial             */
/*      10-DIC-2005     Luis Im            Manejo de consulta dinamica  */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_cons_trans_mone')
   drop proc sp_cons_trans_mone
go

create proc sp_cons_trans_mone(
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint,
@i_modo                 int             = 0,
@i_cod_operacion        int             = 0,
@i_secuencial           int             = 0,
@i_subsecuencia         int             = 0,
@i_fecha_ini            datetime        = NULL,
@i_fecha_fin            datetime        = NULL,
@i_incremento           int             = 0,
@i_disminucion          int             = 0,
@i_tasa                 int             = 0,
@i_pagob                int             = 0,
@i_pagoa                int             = 0,
@i_formato_fecha        int             = NULL,
@i_renovacion           int             = 0)
with encryption
as
declare
@w_sp_name              descripcion,
@w_return               int,
@w_transaccion          int,
@w_columnas             varchar(8000),        --LIM 09/DIC/2005
@w_tablas               varchar(5000),        --LIM 09/DIC/2005
@w_condicion            varchar(8000),        --LIM 09/DIC/2005
@w_condicion2           varchar(1000),        --LIM 09/DIC/2005
@w_ordenamiento         varchar(255),         --LIM 09/DIC/2005
@w_cond_o    varchar(6)        --LIM 09/DIC/2005

select @w_sp_name = 'sp_cons_trans_mone'

/*----------------------------------*/
/*  Verificar Codigo de Transaccion */
/*----------------------------------*/
if @t_trn <> 14462
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141018
   return 1
end




/***********LIM 09/DIC/2005**************/
select @w_columnas =    'select
''SECUENCIAL''         = mm_secuencial,
''SUB_SECUENCIA''      = mm_sub_secuencia,
''COD.TRANS.''         = mm_tran,' +
'''DESCRIPCION DE LA TRANSACCION''=
case mm_tran
when 14904 then
case mm_tipo
when ''C'' then
''DISMINUCION/'' + tn_descripcion
else
''INCREMENTO/'' + tn_descripcion
end
else
tn_descripcion
end,'
+
'''FECHA DE LA TRANSACCION''       = convert(varchar(10),mm_fecha_aplicacion,' + convert(varchar,@i_formato_fecha) + '),' +
'''FECHA VALOR         ''          = convert(varchar(10),isnull(mm_fecha_valor,mm_fecha_aplicacion),' + convert(varchar,@i_formato_fecha) + '),'+
'''FECHA PAGO ANTERIOR DE INTERES'' =
case mm_tran
when 14905 then
convert(varchar(10),hi_fecha_anterior,' + convert(varchar,@i_formato_fecha) + ')' +
' when 14155 then
convert(varchar(10),hi_fecha_anterior,' + convert(varchar,@i_formato_fecha)+')' +
'   else ''''
end,
''FECHA DE ULT. PAGO DE INTERES''       =
case mm_tran
when 14905 then
convert(varchar(10),mm_fecha_aplicacion,' + convert(varchar,@i_formato_fecha)+')'+
' when 14155 then
convert(varchar(10),mm_fecha_aplicacion,' + convert(varchar,@i_formato_fecha)+')'+
' else ''''
end,
''MONTO DE LA TRANSACCION''       = isnull(mm_valor,0) + isnull(mm_impuesto,0) +  isnull(mm_ica,0),
''SALDO CAPITAL''                 = hi_saldo_capital,
''FORMA DE PAGO/RECEPCION''       = mm_producto,
''CUENTA''                        = mm_cuenta'

select @w_tablas    =  ' from cob_pfijo..pf_mov_monet a,
cobis..cl_ttransaccion,
cob_pfijo..pf_operacion c,
cob_pfijo..pf_historia b '

if @i_incremento > 0
begin
   select @w_condicion2 = @w_condicion2 + ' mm_tipo = ''B'' '
   select @w_cond_o = ' or '
end
if @i_disminucion > 0
begin
   select @w_condicion2 = @w_condicion2 + @w_cond_o + ' mm_tipo = ''C'' '
   select @w_cond_o = ' or '
end
if @i_tasa > 0
begin
   select @w_condicion2 = @w_condicion2 + @w_cond_o + 'mm_tran =' + convert(varchar,@i_tasa)
   select @w_cond_o = ' or '
end
if @i_pagob > 0
begin
   select @w_condicion2 = @w_condicion2 + @w_cond_o + 'mm_tran =' + convert(varchar,@i_pagob)
   select @w_cond_o = ' or '
end
if @i_pagoa > 0
begin
   select @w_condicion2 = @w_condicion2 + @w_cond_o + 'mm_tran =' + convert(varchar,@i_pagoa)
end
select @w_ordenamiento = ' order by mm_fecha_real,mm_secuencial'

/***********LIM Hasta Aqui**************/

------------------------------------
-- Bosqueda Transacciones Monetarias
------------------------------------
set rowcount 20
if @i_modo = 0
begin

/*******LIM 10/DIC/2005*****/
select @w_condicion =     ' where mm_operacion         =' + convert(varchar,@i_cod_operacion) +
' and mm_tran             in (' + convert(varchar,@i_incremento) +',' +
convert(varchar,@i_disminucion) + ',' +
convert(varchar,@i_tasa) + ',' + convert(varchar,@i_pagob) +',' +
convert(varchar,@i_pagoa) + ',' + convert(varchar,@i_renovacion) + ')'+
' and (mm_secuencial       > ' + convert(varchar,@i_secuencial) + ' or ' +
convert(varchar,@i_secuencial) + '= 0)'+
' and mm_estado            = ''A'' and mm_fecha_aplicacion >=' + '''' + convert(varchar(10),@i_fecha_ini,101) + '''' +
' and mm_fecha_aplicacion <= ' + '''' +  convert(varchar(10),@i_fecha_fin,101) + '''' +
'and mm_producto         <> ''REN''
and op_operacion         = mm_operacion
and tn_trn_code          = mm_tran
and hi_operacion         = mm_operacion
and hi_fecha_crea        = mm_fecha_aplicacion
and hi_trn_code          = mm_tran
and isnull(hi_secuencia,mm_secuencia) = mm_secuencia'




if @w_condicion2 is not null
   select @w_condicion = @w_condicion + ' and (' + @w_condicion2 + ')'

exec (@w_columnas + @w_tablas + @w_condicion + @w_ordenamiento)      --LIM 10/DIC/2005

if @@rowcount = 0
begin
  exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141030
  return 1
end

end


if @i_modo = 1
begin



/***********************/
/*   LIM 10/DIC/2005   */
/***********************/
select @w_condicion =     ' where mm_operacion         =' + convert(varchar,@i_cod_operacion) +
' and mm_tran             in (' + convert(varchar,@i_incremento) + ',' +
convert(varchar,@i_disminucion) + ',' + convert(varchar,@i_tasa) + ',' +
convert(varchar,@i_pagob) +',' +
convert(varchar,@i_pagoa) + ',' +
convert(varchar,@i_renovacion) + ')' +
' and (mm_secuencial        >= ' + convert(varchar,@i_secuencial) +
' and mm_sub_secuencia > ' + convert(varchar,@i_subsecuencia) +
' or  mm_secuencial        > ' + convert(varchar,@i_secuencial) +
' and mm_sub_secuencia >= ' +convert(varchar,@i_subsecuencia) + ')' +
' and mm_estado            = ''A'' and mm_fecha_aplicacion >= '''' '  +
convert(varchar(10),@i_fecha_ini,101) + '''' +
' and mm_fecha_aplicacion <= ' + '''' +  convert(varchar(10),@i_fecha_fin,101) + '''' +
'and mm_producto         <> ''REN''    and op_operacion         = mm_operacion
and tn_trn_code          = mm_tran
and hi_operacion         = mm_operacion
and hi_fecha_crea        = mm_fecha_aplicacion
and hi_trn_code          = mm_tran
and isnull(hi_secuencia,mm_secuencia) = mm_secuencia'

if @w_condicion2 is not null
   select @w_condicion = @w_condicion + ' and (' + @w_condicion2 + ')'

exec (@w_columnas+@w_tablas+@w_condicion+@w_ordenamiento)
if @@rowcount = 0
begin
  exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141030
  return 1
end



end



set rowcount 0
return 0
go


