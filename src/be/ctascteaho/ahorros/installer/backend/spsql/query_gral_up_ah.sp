/************************************************************************/
/*  Archivo:            query_gral_up_ah.sp                             */
/*  Stored procedure:   sp_query_gral_up_ah                             */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 14-Dic-1993                                     */
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
/*  Este programa realiza la transaccion de consulta de los campos      */
/*  permisibles para actualizacion general de un numero de cuenta.      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR             RAZON                               */
/*  14/Dic/1993   P Mena          Emision inicial                       */
/*  01/Nov/1994   J. Bucheli      Personalizacion para Banco de         */
/*                                la Produccion                         */
/*  25/Sep/1999   Juan F. Cadena  Revision Banco del Caribe             */
/*  07/Jun/2000   Juan F. Cadena  Optimizaciones                        */
/*  02/May/2016   Juan Tagle      Migración a CEN                       */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_query_gral_up_ah')
   drop proc sp_query_gral_up_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_query_gral_up_ah (
    @t_debug          char(1) = 'N',
    @t_file           varchar(14) = null,
    @t_from           varchar(32) = null,
    @t_show_version   bit = 0,
    @i_cta            cuenta,
    @i_mon            tinyint = null,
    @i_formato_fecha  int=101,
    @i_corresponsal   char(1) = 'N'  --Req. 381 CB Red Posicionada
)
as
declare @w_return       int,
    @w_sp_name      varchar(30),
    @w_est          char(1),
        @w_cuenta               int,
    @w_cta_banco        cuenta,
    @w_nombre       descripcion,
        @w_nombre1              char(64),
        @w_cedruc1              char(13),
    @w_direccion_ec     tinyint,
    @w_descripcion_ec   direccion,
    @w_cliente_ec       int,
    @w_det_producto     int,
        @w_tipodir              char(1),
        @w_funcionario          char(1),
        @w_agen_ec              smallint,
        @w_fecha_prx_corte      char(10),
    @w_numlib               int,
        @w_oficina              smallint,
        @w_producto             tinyint,
        @w_tipo                 char(1),
        @w_ciclo                varchar(3),
        @w_proban               smallint,
    @w_cli1         int,
    @w_direccion_dv         tinyint,
    @w_tipodir_dv            char(1),
    @w_descdir_dv           direccion,
    @w_agen_dv              smallint,
    @w_cliente_dv            int,
    @w_traslado             char(1),
    @w_cliente               int,
    @w_alianza             int,
    @w_des_alianza         varchar(255),
    @w_prod_bancario   varchar(50) --Req. 381 CB Red Posicionada

/* Captura del nombre del Store Procedure */
select @w_sp_name = 'sp_query_gral_up_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

/* Modo de debug */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file=@t_file
    select '/** Store Procedure **/ ' = @w_sp_name,
        t_debug     = @t_debug,
            t_file          = @t_file,
        t_from      = @t_from,
        i_cta       = @i_cta,
        i_mon       = @i_mon
    exec cobis..sp_end_debug
end

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prod_bancario = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla  = cl_tabla.codigo and
      cl_tabla.tabla     = 're_pro_banc_cb'
and   cl_catalogo.estado = 'V'

-- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
if @i_corresponsal = 'N'
begin
   select @w_cuenta          = ah_cuenta,
          @w_est              = ah_estado,
          @w_cliente           = ah_cliente,
          @w_nombre        = ah_nombre,
          @w_direccion_ec    = ah_direccion_ec,
          @w_descripcion_ec  = ah_descripcion_ec,
          @w_cliente_ec    = ah_cliente_ec,
          @w_tipodir       = ah_tipo_dir,
          @w_funcionario     = ah_cta_funcionario,
          @w_agen_ec         = ah_agen_ec,
          @w_fecha_prx_corte = convert(char(10), ah_fecha_prx_corte, @i_formato_fecha),
          @w_numlib          = ah_numlib,
          @w_oficina         = ah_oficina,
          @w_producto        = ah_producto,
          @w_tipo            = ah_tipo,
          @w_ciclo           = ah_ciclo,
          @w_proban          = ah_prod_banc,
          @w_nombre1         = ah_nombre1,
          @w_cedruc1         = ah_cedruc1,
          @w_cli1          = ah_cliente1,
          @w_direccion_dv    = ah_direccion_dv,
          @w_tipodir_dv      = ah_tipodir_dv,
          @w_descdir_dv      = ah_descripcion_dv,
          @w_agen_dv         = ah_agen_dv,
          @w_cliente_dv    = ah_cliente_dv,
          @w_traslado      = ah_traslado
   from cob_ahorros..ah_cuenta
   where ah_cta_banco = @i_cta
   and  ah_moneda    = @i_mon
   and  ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

   if @@rowcount <> 1
   begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
         @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_num = 251001,
         @i_sev = 0
      return 1
   end
end
else
begin
   select @w_cuenta          = ah_cuenta,
          @w_est              = ah_estado,
          @w_cliente           = ah_cliente,
          @w_nombre        = ah_nombre,
          @w_direccion_ec    = ah_direccion_ec,
          @w_descripcion_ec  = ah_descripcion_ec,
          @w_cliente_ec    = ah_cliente_ec,
          @w_tipodir       = ah_tipo_dir,
          @w_funcionario     = ah_cta_funcionario,
          @w_agen_ec         = ah_agen_ec,
          @w_fecha_prx_corte = convert(char(10), ah_fecha_prx_corte, @i_formato_fecha),
          @w_numlib          = ah_numlib,
          @w_oficina         = ah_oficina,
          @w_producto        = ah_producto,
          @w_tipo            = ah_tipo,
          @w_ciclo           = ah_ciclo,
          @w_proban          = ah_prod_banc,
          @w_nombre1         = ah_nombre1,
          @w_cedruc1         = ah_cedruc1,
          @w_cli1          = ah_cliente1,
          @w_direccion_dv    = ah_direccion_dv,
          @w_tipodir_dv      = ah_tipodir_dv,
          @w_descdir_dv      = ah_descripcion_dv,
          @w_agen_dv         = ah_agen_dv,
          @w_cliente_dv    = ah_cliente_dv,
          @w_traslado      = ah_traslado
   from cob_ahorros..ah_cuenta
   where ah_cta_banco = @i_cta
   and  ah_moneda    = @i_mon

   if @@rowcount <> 1
   begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
         @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_num = 251001,
         @i_sev = 0
      return 1
   end
end

/* Validaciones */
if @w_est <> 'A'
begin
  /* Cuenta no activa o cancelada */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num       = 251002
   return 1
end

/* Envio de resultados al Front End */
select @w_det_producto = dp_det_producto
  from cobis..cl_det_producto
 where  dp_cuenta = @i_cta
   and  dp_producto = @w_producto
   and  dp_oficina = @w_oficina
   and  dp_tipo = @w_tipo
   and  dp_moneda = @i_mon
   set transaction isolation level read uncommitted

/* Envio de resultados al Front End */
select  'CODIGO'          = en_ente,
        'IDENTIFICACION'  = en_ced_ruc, p_pasaporte,
    'TIPO'            = en_subtipo,
    'NOMBRE'          =  case en_subtipo
                     when 'C' then
                ltrim(rtrim(isnull(en_nomlar,en_nombre)))
                 else
                 ltrim(rtrim(en_nomlar))
                                /*case p_c_apellido
                    when null then
                        rtrim(ltrim(substring(p_p_apellido, 1, 15) + ' '
                                + substring(p_s_apellido, 1, 15) +  ' '
                                + substring(en_nombre, 1, 20) + ' '
                        + substring(p_s_nombre, 1, 20)))
                    else
                        rtrim(ltrim(substring(p_c_apellido, 1, 15) + ', '
                            + substring(p_p_apellido, 1, 15) + ' '
                                + substring(p_s_apellido, 1, 15) +  ' '
                                + substring(en_nombre, 1, 20) + ' '
                        + substring(p_s_nombre, 1, 20))) + ' DE'
                    end*/
                end,
    'ROL'             = cl_rol,
        'DESCRIPCION'     = valor
  from  cobis..cl_ente,
    cobis..cl_cliente,
        cobis..cl_catalogo
 where  cl_det_producto = @w_det_producto
   and  en_ente = cl_cliente
   and  cl_rol = codigo
   and  tabla = (select cobis..cl_tabla.codigo
           from cobis..cl_tabla
          where tabla = 'cl_rol')
    --set transaction isolation level read uncommitted --Se comenta porque producía error en la siguiente línea debido a que el rowcount se reinicia, esta misma sentencia se encuentra antes del select y afectaría a toda la sesión

	
if @@error <> 0 or @@rowcount = 0
begin
   /* No existe cliente */
   exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 101061,
       @i_sev   = 0,
       @i_msg   = 'No existe cliente'
   return 1
end

select  @w_nombre,
        @w_tipodir,
        @w_direccion_ec,
        @w_descripcion_ec,
        @w_cliente_ec,
        @w_agen_ec,
        @w_funcionario,
        @w_fecha_prx_corte,
        @w_nombre1,
        @w_cedruc1,
--   Cheques devueltos
       @w_tipodir_dv,
       @w_direccion_dv,
       @w_descdir_dv,
       @w_cliente_dv,
       @w_agen_dv

select   @w_alianza = al_alianza,
        @w_des_alianza = isnull((al_nemonico + ' - ' + al_nom_alianza), '  ')
 from cobis..cl_alianza_cliente with (nolock),
      cobis..cl_alianza         with (nolock)
 where ac_ente    = @w_cliente
   and ac_alianza = al_alianza
   and al_estado  = 'V'
   and ac_estado  = 'V'

select  @w_ciclo, valor
  from  cobis..cl_catalogo
 where  tabla = (select cobis..cl_tabla.codigo
           from cobis..cl_tabla
          where tabla = 'ah_ciclo')
   and codigo = @w_ciclo
if @@rowcount = 0
begin
  /* No existe ciclo */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 201015,
       @i_sev   = 0,
       @i_msg   = 'No existe ciclo'
   return 1
end

select  @w_proban, pb_descripcion
  from  cob_remesas..pe_pro_bancario
 where  pb_pro_bancario = @w_proban

select @w_numlib

select @w_cli1

select @w_traslado

select @w_alianza

select  @w_des_alianza

return 0

go

