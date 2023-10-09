/************************************************************************/
/*      Archivo:                sp_aux_contables                        */
/*      Stored procedure:       sp_aux_contables.sp                     */
/*      Base de datos:          cob_conta                               */
/*      Producto:               CONTABILIDAD                            */
/*      Disenado por:                                                   */
/*      Fecha de escritura:     Agosto 2009                             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      generar reporte de auxiliares contables                         */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA            AUTOR                  RAZON                   */
/*                                                                      */
/************************************************************************/

use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_aux_contables')
   drop proc sp_aux_contables 
go 

create proc sp_aux_contables (
   @i_param1      varchar(20) = null,
   @i_param2      varchar(20) = null,
   @i_param3      varchar(20) = null,
   @i_param4      varchar(20) = null,
   @i_param5      varchar(20) = null,
   @i_param6      varchar(20) = null,
   @i_param7      varchar(20) = null,
   @i_param8      varchar(20) = null
)
as
declare 
@w_cuenta_i      varchar(15),
@w_cuenta_f      varchar(15),
@w_valor         varchar(20),
@w_errores       varchar(255),
@w_cmd           varchar(255),
@w_s_app         varchar(255),
@w_path_listados varchar(255),
@w_dia           varchar(2),
@w_mes           varchar(2),
@w_anio          varchar(4),
@w_archivo       varchar(255),
@w_comando       varchar(255),
@w_error         int,
@w_debug         char(1),
@w_cedruc        varchar(21),
@i_empresa       tinyint,  
@i_fecha_ini	 datetime, 
@i_fecha_fin	 datetime, 
@i_opcion        char(1),  
@i_opcion1       char(1),  
@i_cuenta_ini    varchar(14),
@i_cuenta_fin    varchar(14),
@i_separador     char(1)

select @i_empresa    = convert(tinyint,  @i_param1)
select @i_fecha_ini	 = convert(datetime, @i_param2)
select @i_fecha_fin	 = convert(datetime, @i_param3)
select @i_opcion     = convert(char(1),  @i_param4)
select @i_opcion1    = convert(char(1),  @i_param5)
select @i_cuenta_ini = convert(varchar(14), @i_param6)
select @i_cuenta_fin = convert(varchar(14), @i_param7)
select @i_separador  = convert(char(1), @i_param8)

select @w_cuenta_i = ltrim(rtrim(cast(@i_cuenta_ini as varchar)))
select @w_cuenta_i = @w_cuenta_i + '%'
select @w_cuenta_f = ltrim(rtrim(cast(@i_cuenta_fin as varchar)))
select @w_cuenta_f = @w_cuenta_f + '%'
select @w_debug = 'N'

if @i_opcion = 'T' 
   select @w_cedruc = @i_cuenta_ini

select @w_valor = @i_cuenta_ini

truncate table cob_conta..tmp_aux_contables

If @i_opcion = 'C'

Begin

   If @i_opcion1 = 'R'   Begin

      insert into cob_conta..tmp_aux_contables 
      select
      sa_oficina_dest,
      sa_area_dest, 
      sc_comprobante, 
      sc_comp_definit,
      sa_asiento,
      sc_empresa, 
      sa_cuenta, 
      sc_fecha_tran, 
      sa_concepto,
      sa_debito,
      sa_credito,
      sa_ente,
      (select en_tipo_ced  from cobis..cl_ente where en_ente = sa_ente),
      (select en_ced_ruc  from cobis..cl_ente where en_ente = sa_ente),
      (select en_nomlar  from cobis..cl_ente where en_ente = sa_ente),
      sa_cheque,
      sc_oficina_orig,
      sc_fecha_gra,
      sc_producto
      from cob_conta_tercero..ct_scomprobante with (nolock),
           cob_conta_tercero..ct_sasiento with (nolock, index = ct_sasiento_AKey2)
      where sa_cuenta BETWEEN @w_cuenta_i AND @w_cuenta_f
      and   sc_estado = 'P'
      and   sc_fecha_tran >= @i_fecha_ini
      and   sc_fecha_tran <= @i_fecha_fin
      and   sc_comprobante = sa_comprobante
      and   sc_producto = sa_producto
      and   sc_fecha_tran = sa_fecha_tran
      and   sc_empresa = sa_empresa
      order by sa_oficina_dest
   End
   Else If @i_opcion1 = 'A'   Begin
      insert into cob_conta..tmp_aux_contables 
      select
      sa_oficina_dest,
      sa_area_dest, 
      sc_comprobante, 
      sc_comp_definit,
      sa_asiento,
      sc_empresa, 
      sa_cuenta, 
      sc_fecha_tran, 
      sa_concepto,
      sa_debito,
      sa_credito,
      sa_ente,
      (select en_tipo_ced  from cobis..cl_ente where en_ente = sa_ente),
      (select en_ced_ruc  from cobis..cl_ente where en_ente = sa_ente),
      (select en_nomlar  from cobis..cl_ente where en_ente = sa_ente),
      sa_cheque,
      sc_oficina_orig,
      sc_fecha_gra,
      sc_producto     
      from cob_conta_tercero..ct_scomprobante with (nolock),
           cob_conta_tercero..ct_sasiento with (nolock, index = ct_sasiento_AKey2)
      where sc_estado = 'P'
      and   sc_fecha_tran >= @i_fecha_ini
      and   sc_fecha_tran <= @i_fecha_fin
      and   sc_comprobante = sa_comprobante
      and   sc_producto    = sa_producto
      and   sc_fecha_tran  = sa_fecha_tran
      and   sc_empresa     = sa_empresa
      and   sa_cuenta      like @w_cuenta_i
      order by sa_oficina_dest
   End
   Else Begin
      print 'OPCION PARA CUENTA INVALIDA O NO EXISTE'
      return 1
   End
End

Else If @i_opcion = 'T' Begin
   insert into cob_conta..tmp_aux_contables
   select 
   sa_oficina_dest,
   sa_area_dest,
   sc_comprobante, 
   sc_comp_definit,
   sa_asiento,
   sc_empresa, 
   sa_cuenta, 
   sc_fecha_tran,
   sa_concepto,
   sa_debito,
   sa_credito,
   sa_ente,
   (select en_tipo_ced  from cobis..cl_ente where en_ente = sa_ente),
   (select en_ced_ruc  from cobis..cl_ente where en_ente = sa_ente),
   (select en_nomlar  from cobis..cl_ente where en_ente = sa_ente),
   sa_cheque,
   sc_oficina_orig,
   sc_fecha_gra,
   sc_producto
   from cob_conta_tercero..ct_scomprobante with (nolock),
        cob_conta_tercero..ct_sasiento with (nolock, index = ct_sasiento_AKey2)
   where sc_estado = 'P'
   and   sc_fecha_tran >= @i_fecha_ini
   and   sc_fecha_tran <= @i_fecha_fin
   and   sc_comprobante = sa_comprobante
   and   sc_producto = sa_producto
   and   sc_fecha_tran = sa_fecha_tran
   and   sc_empresa = sa_empresa
   and   sa_ente = (select en_ente  from cobis..cl_ente where en_ced_ruc = @w_cedruc)
   order by sa_oficina_dest
End
Else Begin
   print 'OPCION INVALIDA O NO EXISTE'
   return 1
End

-- CAMBIO INCIDENCIA 3269

select @w_path_listados = pp_path_destino
from cobis..ba_path_pro  
where pp_producto = 6

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_dia  = convert(varchar(2), datepart (dd, getdate()))
select @w_mes  = convert(varchar(2), datepart (mm, getdate()))
select @w_anio = convert(varchar(4), datepart (yy, getdate()))

select @w_dia = CASE WHEN convert(int, @w_dia) < 10 then '0' + @w_dia else @w_dia end
select @w_mes = CASE WHEN convert(int, @w_mes) < 10 then '0' + @w_mes else @w_mes end

select @w_archivo = 'cb_auxicon_'+ convert(varchar(2), @w_dia) + convert(varchar(2), @w_mes)+ convert(varchar(4), @w_anio)+ '_' + ltrim(rtrim(@w_valor))

select @w_comando  = 'ERASE ' + @w_path_listados + 'TITULO.TXT'

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
    print 'Error borrando Archivo: ' + 'TITULO.TXT'
    print @w_comando
end

select @w_comando  = 'ERASE ' +  @w_path_listados + @w_archivo + '.lis'

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
    print 'Error borrando Archivo: ' + @w_archivo
    print @w_comando
end

select @w_errores  = @w_path_listados + @w_archivo + '.err'
select @w_cmd      = @w_s_app + 's_app bcp cob_conta..tmp_aux_contables out '
select @w_comando  = @w_cmd + @w_path_listados + 'TITULO.TXT' + ' -b5000 -c -e' + @w_errores + ' -t' + '"' +'|'+ '"' + ' -auto -login ' + '-config ' + @w_s_app + 's_app.ini'

if @w_debug = 'S' begin
   print 'path salida'
   print @w_cmd
   print @w_path_listados
   print @w_comando 
   print @w_errores
end 

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
    print 'Error generando Archivo: ' + 'TITULO.TXT'
    print @w_comando
end

select @w_comando = 'echo ' + '"' + 'OFICINA_DEST|AREA_DEST|COMPROBANTE|COMP_DEFINIT|ASIENTO|EMPRESA|CUENTA|FECHA_TRAN|CONCEPTO|DEBITO|CREDITO|ENTE|TIPO_DOC|DOCUMENTO|NOMBRE|CHEQUE|OFICINA_ORIG|FECHA_GRA' + '"' + ' >> ' + @w_path_listados + @w_archivo + '.lis'

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
    print 'Error generando Archivo: ' + @w_archivo
    print @w_comando
    PRINT @w_error
end

select @w_comando = 'TYPE ' + @w_path_listados + 'TITULO.TXT >> ' + @w_path_listados + @w_archivo + '.lis'

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
    print 'Error uniendo archivos Archivo: ' + @w_archivo
    print @w_comando
    PRINT @w_error
end

select @w_comando  = 'ERASE ' + @w_path_listados + 'TITULO.TXT'

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
    print 'Error borrando Archivo: ' + 'TITULO.TXT'
    print @w_comando
end

return 0

go
