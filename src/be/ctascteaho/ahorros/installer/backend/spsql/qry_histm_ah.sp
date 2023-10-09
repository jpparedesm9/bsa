/************************************************************************/
/*  Archivo:            qry_histm_ah.sp                                 */
/*  Stored procedure:   sp_qry_histm_ah                                 */
/*  Base de datos:      cob_cuentas                                     */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:                                                       */
/*  Fecha de escritura: 11/Aug/1995                                     */
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
/*      Este programa realiza la consulta de transacciones monetarias   */
/*  tanto del dia como del historoico                                   */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA        AUTOR       RAZON                                      */
/*  11/Aug/1995  D Villafuerte   Personalizacion Bco Prestamos          */
/*  23/Ene/1996  A. Mencias C.   Revision Final                         */
/*  20/May/1999  M. Sanguino     Personalizacion B. del Caribe          */
/*  19/Oct/2001  C. Vargas       Agregar parame. @i_formato_fecha       */
/*  31/Mar/2006  J. Suarez       Correccion buscar siguiente            */
/*  28/Sep/2006  H.Ayarza        Valida usuaria autorizado.             */
/*  12/Sep/2008  J.Artola        Modificacion del sp utilizando         */
/*                               cursor                                 */
/*  02/May/2016  Juan Tagle      Migración a CEN                        */
/*  16/06/2016   Kmeza           Migración a CEN                        */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_qry_histm_ah')
    drop proc sp_qry_histm_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_qry_histm_ah (
    @s_ssn      int,
    @s_srv          varchar(30),
    @s_lsrv         varchar(30),
    @s_user     varchar(30),
    @s_sesn         int = null,
    @s_term     varchar(10),
    @s_date     datetime,
    @s_ofi      smallint,   /* Localidad origen transaccion */
    @s_rol      smallint,
    @s_org_err  char(1) = null, /* Origen de error: [A], [S] */
    @s_error    int = null,
    @s_sev          tinyint = null,
    @s_msg      mensaje = null,
    @s_org      char(1),
    @t_corr     char(1) = 'N',
    @t_ssn_corr int = null, /* Trans a ser reversada */
    @t_debug    char(1) = 'N',
    @t_file     varchar(14) = null,
    @t_from     varchar(32) = null,
    @t_rty      char(1) = 'N',
    @t_trn      smallint,
    @t_show_version  bit = 0,
    @i_ofi      smallint=null,
    @i_tipotrn  int,
    @i_fechatrn     smalldatetime,
    @i_vista        smallint,
    @i_tabla        char(1) = 'N',
    @i_moneda       tinyint,
    @i_ultimo       int = 0,
    @i_alt          int = 0,
    @i_cta          varchar(15) = '%',
    @i_formato_fecha int = null,
    @i_fecha_hasta     smalldatetime,
    @i_prodbanc     smallint=null,
    @i_corresponsal char(1) = 'N'  --Req. 381 CB Red Posicionada
)
as
declare
        @w_select    varchar(10),
    @w_query         varchar(255),
        @w_query1        varchar(400),
    @w_query2        varchar(255),
    @w_query3        varchar(255),
    @w_query4        varchar(255),
    @w_query5        varchar(255),
        @w_query6        varchar(255),
        @w_query7    varchar(255),
    @w_campo     varchar(255),
        @w_campo2        varchar(255),
        @w_campo3        varchar(255),
        @w_campo4        varchar(255),
        @w_return   int,
    @w_sp_name  varchar(30),
    @w_filial   tinyint,
    @w_oficina  smallint,
    @w_oficial  tinyint,
    @w_producto tinyint,
    @w_server_rem   descripcion,
    @w_server_local descripcion,
    @w_tipo     char(1),
    @w_cont          int,
    @w_prod_bancario   char(2) --Req. 381 CB Red Posicionada

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_qry_histm_ah'

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
        s_srv           = @s_srv,
        s_lsrv          = @s_lsrv,
        s_user      = @s_user,
        s_sesn          = @s_sesn,
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
        i_ofi       = @i_ofi,
        i_tipotrn   = @i_tipotrn,
                i_fechatrn      = @i_fechatrn,
                i_vista         = @i_vista,
                i_tabla         = @i_tabla,
        i_formato_fecha = @i_formato_fecha
    exec cobis..sp_end_debug
end

exec @w_return = cobis..sp_parametros
        @t_debug    = @t_debug,
        @t_file         = @t_file,
        @t_from         = @w_sp_name,
        @s_lsrv         = @s_lsrv,
        @i_nom_producto = 'CUENTA%AHORRO%',
        @o_oficina  = @w_oficina out,
        @o_producto     = @w_producto out

if @w_return <> 0
    return @w_return

select @w_server_local = @s_lsrv

/* Inicia el proceso para obtencion de la consulta */

if @t_trn <> 281
begin
  /* Error en codigo de transaccion */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
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


if not exists (
    select  1
      from  cobis..cl_oficina
     where  of_oficina = @i_ofi or @i_ofi is null)
begin
  /* No existe oficina */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 101016
   return 1
end

/* HA20060928
VALIDACION PARA USUARIOS AUTORIZADOS PARA CONSULTAR
CUENTAS DE COLABORADORES
*/
if substring(@i_cta,3,3) in ('312','313')
begin
    if not exists (
        select 1
          from cob_remesas..re_ofi_personal, cobis..cc_oficial, cobis..cl_funcionario
        where op_oficial = oc_oficial
         and oc_funcionario = fu_funcionario
         and fu_login = @s_user)
    begin
      /* No puede consultar - cta. clasificada */
       exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num   = 252074
       return 1
    end
end


----------------------
--IF @I_TABLA = 'S'
----------------------

if @i_tabla = 'S'
BEGIN

select @w_select = 'select '
select @w_query1=' ''USUARIO''=tm_usuario,''TERMINAL''=tm_terminal,''CORRECCION''=tm_correccion,''FECHA''=tm_fecha,
                   ''HORA''= concat(FORMAT(datepart(hh,tm_hora),''00''),'':'',FORMAT(datepart(mi,tm_hora),''00''),'':'',FORMAT(datepart(s,tm_hora),''00'')),
                   ''OFICINA''=tm_oficina,''SSN BRANCH''=tm_ssn_branch, ''SECUENCIAL''=tm_secuencial,''CODIGO ALTERNO''=tm_cod_alterno'

select @w_campo= ''
select @w_campo2= ''
select @w_campo3= ''
select @w_campo4= ''
select @w_cont = 1

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prod_bancario = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla  = cl_tabla.codigo
and   cl_tabla.tabla     = 're_pro_banc_cb'
and   cl_catalogo.estado = 'V'

---------------
--cursor
---------------

declare campo cursor for
      select ah_campo_m
      from cob_ahorros..cp_campoah_monetario
      where ah_transaccion_m = @i_tipotrn and @w_cont <= 4
                open campo
          fetch campo into @w_query
          while  @@fetch_status= 0
            begin
          if   @w_cont = 1
              begin
             select @w_campo = @w_query
             fetch  campo into @w_query
              end
          if   @w_cont = 2
            begin
        select @w_campo2 = @w_query
            fetch campo into @w_query
          end
             if   @w_cont = 3
            begin
        select @w_campo3 = @w_query
            fetch campo into @w_query
          end
            if   @w_cont = 4
            begin
        select @w_campo4 =  @w_query
            fetch campo into @w_query
          end
            select @w_cont = @w_cont + 1
           end
       close campo
       deallocate campo

   -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
   if @i_corresponsal = 'N'
   begin
      select @w_query2 = ' from cob_ahorros..ah_tran_monet v  '
      select @w_query3 =  ' where tm_tipo_tran = ' + convert(varchar(6), @i_tipotrn) + ' ' +
                          ' and tm_fecha  between  ''' + convert(varchar(15), @i_fechatrn,101) +
                          ''' and '''+ convert(varchar(15),@i_fecha_hasta,101)
                          + ''' and tm_prod_banc <> ' + @w_prod_bancario -- Req. 381 CB Red Posicionada'
   end
   else
   begin
      select @w_query2 = ' from cob_ahorros..ah_tran_monet v  '
      select @w_query3 =  ' where tm_tipo_tran = ' + convert(varchar(6), @i_tipotrn) + ' ' +
                          ' and tm_fecha  between  ''' + convert(varchar(15), @i_fechatrn,101) +
                          ''' and '''+ convert(varchar(15),@i_fecha_hasta,101)
   end

   if @i_cta IS NULL
   BEGIN
    select @i_cta = '%'
     select @w_query4 = ' and tm_cta_banco like ''' + @i_cta + ''' and tm_moneda = ' + convert(varchar(10),@i_moneda)

   end
   else
   begin
		if @i_corresponsal = 'N'
		begin			
			select @w_query4 = ' and tm_cta_banco = ''' + convert(varchar(64),@i_cta ) + ''' '
		end
		else
		begin
			select @w_query4 = ''' and tm_cta_banco = ''' + convert(varchar(64),@i_cta ) + ''' '
		end
   end

   if @i_ofi IS NULL
   BEGIN
      select @w_query5 =  ''
   END


   else
   BEGIN
     select @w_query5 =  ' and tm_oficina = ' + convert(varchar(10),@i_ofi)


   end

       select @w_query6 = ' and ((tm_secuencial > ' + convert(varchar(20),@i_ultimo) + ') or (tm_secuencial = ' + convert(varchar(20),@i_ultimo) +'  '+
                          ' and tm_cod_alterno > ' + convert(varchar(10),@i_alt) + ')) order by tm_secuencial, tm_cod_alterno'

   if @i_prodbanc is not null and @i_prodbanc <> @w_prod_bancario
      select @w_query7 = ' and tm_prod_banc = '+convert(varchar,@i_prodbanc)
   else
      select @w_query7 = ''
END




set rowcount 20

exec (@w_select + @w_campo + @w_campo2 + @w_campo3 + @w_campo4 + @w_query1 + @w_query2 + @w_query3 + @w_query4 + @w_query5 + @w_query7 + @w_query6)
set rowcount 0


---------------------
--IF @I_TABLA = 'N'
---------------------

if @i_tabla = 'N'
BEGIN
select @w_select = 'select '
select @w_query1= '''USUARIO''=hm_usuario,''TERMINAL''=hm_terminal,''CORRECCION''=hm_correccion,''FECHA''=hm_fecha,''HORA''=hm_hora,
                  ''OFICINA''=hm_oficina,''SSN BRANCH''=hm_ssn_branch, ''SECUENCIAL''=hm_transaccion,''CODIGO ALTERNO''=hm_cod_alterno'

select @w_campo= ''
select @w_campo2= ''
select @w_campo3= ''
select @w_campo4= ''
select @w_cont = 1

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prod_bancario = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla  = cl_tabla.codigo
and   cl_tabla.tabla     = 're_pro_banc_cb'
and   cl_catalogo.estado = 'V'

------------
--cursor
------------

     declare campo cursor for
      select ah_campo_m
      from cob_ahorros..cp_campoah_monetario
      where ah_transaccion_m = @i_tipotrn

      open campo
          fetch campo into @w_query

          if @@fetch_status  = -1
                print 'La transaccion no esta parametrizada totalmente'

          while @@fetch_status= 0 and @w_cont <= 4
            begin
          if   @w_cont = 1
              begin
                 select @w_campo = replace (@w_query, 'tm_', 'hm_')
                 fetch  campo into @w_query
              end
          if   @w_cont = 2
          begin

                 select @w_campo2 = replace (@w_query, 'tm_', 'hm_')
             fetch campo into @w_query
          end
              if @w_cont = 3
          begin

                 select @w_campo3 = replace (@w_query, 'tm_', 'hm_')
             fetch campo into @w_query
          end
              if @w_cont = 4
          begin

                 select @w_campo4 = replace (@w_query, 'tm_', 'hm_')
             fetch campo into @w_query
          end
              select @w_cont = @w_cont + 1
           end
       close campo
       deallocate campo

   -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
   if @i_corresponsal = 'N'
   begin
      select @w_query2 = ' from cob_ahorros_his..ah_his_movimiento v'
      select @w_query3 = ' where hm_tipo_tran = ' + convert(varchar(6), @i_tipotrn) + ' ' +
                         ' and hm_fecha  between  ''' + convert(varchar(15), @i_fechatrn,101) +
                         ' '' and '''+ convert(varchar(15),@i_fecha_hasta,101) +
                         ''' and hm_prod_banc <> ' + @w_prod_bancario -- Req. 381 CB Red Posicionada'
   end
   else
   begin
      select @w_query2 = ' from cob_ahorros_his..ah_his_movimiento v'
      select @w_query3 = ' where hm_tipo_tran = ' + convert(varchar(6), @i_tipotrn) + ' ' +
                         ' and hm_fecha  between  ''' + convert(varchar(15), @i_fechatrn,101) +''' and '''+ convert(varchar(15),@i_fecha_hasta,101) + ''
   end

   if @i_cta IS NULL
   BEGIN
      select @i_cta = '%'
      select @w_query4 = ' and hm_cta_banco like ''' + @i_cta + '''  and hm_moneda = ' + convert(varchar(10),@i_moneda)

 end
 else
  begin
  select @w_query4 = ' and hm_cta_banco = ''' + convert(varchar(64),@i_cta ) + ''''
  end




   if @i_ofi IS NULL
   BEGIN
      select @w_query5 = ''
   END
   else
   BEGIN
   select @w_query5 =  ' and hm_oficina = ' + convert(varchar(10),@i_ofi)

   end

   select @w_query6 = ' and hm_transaccion > ' + convert(varchar(20),@i_ultimo) + ' order by hm_transaccion '

   if @i_prodbanc is not null and @i_prodbanc <> @w_prod_bancario
      select @w_query7 = ' and hm_prod_banc = '+convert(varchar,@i_prodbanc)
   else
      select @w_query7 = ''

end

set rowcount 20

--print (@w_select + @w_campo + @w_campo2 + @w_campo3 + @w_campo4 + @w_query1 + @w_query2 + @w_query3 + @w_query4 + @w_query5 + @w_query7 + @w_query6)
exec (@w_select + @w_campo + @w_campo2 + @w_campo3 + @w_campo4 + @w_query1 + @w_query2 + @w_query3 + @w_query4 + @w_query5 + @w_query7 + @w_query6)
set rowcount 0


return 0

go

