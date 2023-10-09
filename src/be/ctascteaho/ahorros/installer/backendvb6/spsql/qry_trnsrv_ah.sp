/************************************************************************/
/*  Archivo:            qry_trnsrv_ah.sp                                */
/*  Stored procedure:   sp_qry_trnsrv_ah                                */
/*  Base de datos:      cob_cuentas                                     */
/*  Producto:           Cuentas Corrientes y AHO                        */
/*  Disenado por:                                                       */
/*  fecha de escritura: 11/Aug/1995                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa realiza la transaccion de consulta de las             */
/*      transacciones de servicio (del dia)                             */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA        AUTOR       RAZON                                      */
/*  02/May/2016  Juan Tagle      Migración a CEN                        */
/************************************************************************/

use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_qry_trnsrv_ah')
    drop proc sp_qry_trnsrv_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_qry_trnsrv_ah (
@s_ssn          int,
@s_srv          varchar(30),
@s_lsrv         varchar(30),
@s_user         varchar(30),
@s_sesn         int = null,
@s_term         varchar(10),
@s_date         datetime,
@s_ofi          smallint,   /* Localidad origen transaccion */
@s_rol          smallint,
@s_org_err      char(1) = null, /* Origen de error: [A], [S] */
@s_error        int = null,
@s_sev          tinyint = null,
@s_msg          mensaje = null,
@s_org          char(1),
@t_corr         char(1) = 'N',
@t_ssn_corr     int = null, /* Trans a ser reversada */
@t_debug        char(1) = 'N',
@t_file         varchar(14) = null,
@t_from         varchar(32) = null,
@t_rty          char(1) = 'N',
@t_trn          smallint,
@t_show_version bit = 0,
    /*LBM*/
@i_ofi_desde    smallint = 1,
@i_ofi_hasta    smallint = 9999,
@i_monto_desde  money = 0,
@i_monto_hasta  money = 99999999999.99,
@i_prod_banc    smallint = null,
@i_tipotrn      int,
@i_fechatrn     datetime,
@i_vista        smallint,
@i_fecha_hasta  smalldatetime,
@i_moneda       tinyint,
@i_ultimo       int = 0,
@i_alt          int = 0,
@i_cta          varchar(15) = '%',
@i_formato_fecha int = null,
@i_unir         char(1) = 'N'
)
as
declare
    @w_select       varchar(10),
    @w_query        varchar(255),
    @w_query1       varchar(255),
    @w_query2       varchar(255),
    @w_query3       varchar(255),
    @w_query4       varchar(255),
    @w_query5       varchar(255),
    @w_query6       varchar(255),
    @w_query7       varchar(255),
    @w_campo        varchar(255),
    @w_campo2       varchar(255),
    @w_campo3       varchar(255),
    @w_campo4       varchar(255),
    @w_cont         int,
    @w_return       int,
    @w_sp_name      varchar(30),
    @w_filial       tinyint,
    @w_oficina      smallint,
    @w_oficial      tinyint,
    @w_producto     tinyint,
    @w_server_rem   descripcion,
    @w_server_local descripcion,
    @w_tipo         char(1),
    @w_cuenta       cuenta,
    @w_moneda       tinyint

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_qry_trnsrv_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

/*  Modo de debug  */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file=@t_file
    select  '/**  Stored Procedure  **/ ' = @w_sp_name,
        s_ssn       = @s_ssn,
        s_srv       = @s_srv,
        s_lsrv      = @s_lsrv,
        s_user      = @s_user,
        s_sesn      = @s_sesn,
        s_term      = @s_term,
        s_date      = @s_date,
        s_ofi       = @s_ofi,
        s_rol       = @s_rol,
        s_org_err   = @s_org_err,
        s_error     = @s_error,
        s_sev       = @s_sev,
        s_msg       = @s_msg,
        s_ori       = @s_org,
        t_corr      = @t_corr,
        t_debug     = @t_debug,
        t_ssn_corr  = @t_ssn_corr,
        t_from      = @t_from,
        t_file      = @t_file,
        t_rty       = @t_rty,
        t_trn       = @t_trn,
        i_moneda    = @i_moneda,
        i_ofi_desde = @i_ofi_desde,
        i_ofi_hasta = @i_ofi_hasta,
        i_tipotrn   = @i_tipotrn,
        i_fechatrn  = @i_fechatrn,
        i_vista     = @i_vista,
        i_formato_fecha = @i_formato_fecha
    exec cobis..sp_end_debug
end

exec @w_return = cobis..sp_parametros
@t_debug        = @t_debug,
@t_file         = @t_file,
@t_from         = @w_sp_name,
@s_lsrv         = @s_lsrv,
@i_nom_producto = 'CUENTA DE AHORROS',
@o_oficina      = @w_oficina out,
@o_producto     = @w_producto out

if @w_return <> 0
    return @w_return

select @w_server_local = @s_lsrv

/* Inicia el proceso para obtencion de la consulta */

if @t_trn <> 282
begin
  /* Error en codigo de transaccion */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 201002
   return 1
end

/* Valida el producto para la oficina */
if isnull(@s_ofi,0) <> 0
begin
   exec @w_return = cobis..sp_val_prodofi
   @i_modulo   = 4,
   @i_oficina  = @s_ofi
   if @w_return <> 0
      return @w_return
end


select @w_select = 'select '
select @w_query1=" 'TERMINAL' =ts_terminal,'OFICINA'=(select valor from cobis..cl_tabla a , cobis..cl_catalogo b
                    where  a.codigo = b.tabla and  a.tabla = 'cl_oficina'  and convert(varchar(10), d.ts_oficina)=  b.codigo),"
select @w_campo= ''
select @w_campo2= ''
select @w_campo3= ''
select @w_campo4= ''
select @w_cont = 1

-- CURSORES
declare campo cursor for
select cc_campo
from cob_ahorros..cp_campoah
where cc_transaccion = @i_tipotrn  and @w_cont <=4
open campo
fetch campo into @w_query

while  @@fetch_status= 0
begin
   if   @w_cont = 1
   begin
      select @w_campo =  @w_query
      fetch  campo into @w_query
   end
   if @w_cont = 2
   begin
      select @w_campo2 = @w_query
      fetch campo into @w_query
   end
   if @w_cont = 3
   begin
      select @w_campo3 = @w_query
      fetch campo into @w_query
   end
   if @w_cont = 4
   begin
      select @w_campo4 =  @w_query
      fetch campo into @w_query
   end
   select @w_cont = @w_cont + 1
end
close campo
deallocate campo

select @w_query2 = "'FECHA'=ts_tsfecha,'HORA'=ts_hora,'SECUENCIAL' =ts_secuencial, 'CODIGO ALTERNO' =ts_cod_alterno from cob_ahorros..ah_tran_servicio d"
select @w_query3 = " where ts_tsfecha >= '" + convert(varchar(15), @i_fechatrn,101) + "' and ts_tsfecha <= '" + convert(varchar(15),@i_fecha_hasta,101) + "' and ts_tipo_transaccion = " + convert(varchar , @i_tipotrn)

if @i_cta is null or @i_cta = '%'
begin
    select @i_cta = '%'
    select @w_query4 = " and ts_cta_banco  like   '" + @i_cta + "'"
end
else
begin
   select @w_query4 = " and ts_cta_banco  = '" + convert(varchar(64),@i_cta ) + "'"
end

if @w_moneda is null
begin
   select @w_query5 = ' '
end
else
begin
   select @w_query5 = '  and ts_moneda = '  + convert(varchar(10),@i_moneda)
end


if @i_prod_banc is null
begin
   select @w_query6 = ' and (ts_oficina >=  ' + convert(varchar(10),@i_ofi_desde) + ' and ts_oficina <= ' + convert(varchar(10),@i_ofi_hasta)  +')'+
              ' and isnull(ts_saldo,0) >= ' + convert(varchar(20),@i_monto_desde) +  '  and isnull(ts_saldo,0) < =' + convert(varchar(20),@i_monto_hasta )

end
else
begin
    select @w_query6 = ' and (ts_oficina >= ' + convert(varchar(10),@i_ofi_desde) + ' and ts_oficina <= ' + convert(varchar(10),@i_ofi_hasta) + ')' +
                       ' and isnull(ts_saldo,0) >= ' + convert(varchar(20),@i_monto_desde) + ' and isnull(ts_saldo,0) <= ' + convert(varchar(20),@i_monto_hasta )+
                       ' and ts_prod_banc = ' + convert(varchar(10),@i_prod_banc)

end
select @w_query7 = ' and ((ts_secuencial > ' + convert(varchar(10),@i_ultimo) + ') or (ts_secuencial = ' + convert(varchar(10),@i_ultimo) + ''+
                   ' and isnull(ts_cod_alterno,0) > ' + convert(varchar(10),isnull(@i_alt,0)) + ')) order by ts_secuencial, isnull(ts_cod_alterno,0)'

set rowcount 20
--print ( @w_select + @w_campo + @w_campo2 + @w_campo3 + @w_campo4  + @w_query1 + @w_query2 + @w_query3 + @w_query4 + @w_query5 + @w_query6 + @w_query7)
exec (@w_select + @w_campo + @w_campo2 + @w_campo3 + @w_campo4  + @w_query1 + @w_query2 + @w_query3 + @w_query4 + @w_query5 + @w_query6 + @w_query7)
set rowcount 0
return 0

go

