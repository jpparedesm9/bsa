/************************************************************************/
/*  Archivo:            query_up_ah.sp                                  */
/*  Stored procedure:   sp_query_up_ah                                  */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 18-Feb-1993                                     */
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
/*  permisibles para actualizacion critica dado un numero de cuenta.    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  03/Mar/1993 P Mena      Emision inicial                             */
/*  04/Ene/1995 J. Bucheli      Personalizacion para Banco de           */
/*                                      la Produccion                   */
/*      30/Ene/1996     D. Villafuerte  Control de Calidad (dep inicial)*/
/*      25/Sep/1999     Juan F. Cadena  Revision Banco del Caribe       */
/*  17/Mar/2005 L. Bernuil  Adici½n de Campos a persentar en            */
/*                  la consulta de actualizaci½n                        */
/*  03/Ago/2005 L. Bernuil  Extracci½n de la Patente                    */
/*  05/Sep/2005 E. Laguna   Cambio para mostrar nombre largo            */
/*  12/Jul/2006 R. Ramos    Adicion de fideicomiso                      */
/*  02/May/2016 Juan Tagle  Migración a CEN                             */
/*  28/Sep/2016 Juan Tagle  Salida de Cta Relacionada para Act. Cuenta  */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_query_up_ah')
   drop proc sp_query_up_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_query_up_ah (
    @t_debug          char(1) = 'N',
    @t_file           varchar(14) = null,
    @t_from           varchar(32) = null,
    @t_show_version   bit = 0,
    @i_cta            cuenta,
    @i_mon            tinyint = null,
    @i_formato_fecha      int=101
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
    @w_tipo_def     char(1),
    @w_agen_ec              smallint,
    @w_tipodir              char(1),
    @w_funcionario          char(1),
    @w_pers_desc        direccion,
    @w_default      int,
    @w_tdef_des     descripcion,
    @w_det_producto     int,
        @w_fecha_prx_corte      char(10),
        @w_origen               varchar(3),
        @w_categoria            varchar(3),
        @w_ciclo                varchar(3),
        @w_tpromedio            varchar(3),
        @w_capitalizacion       varchar(3),
        @w_numlib               int,
        @w_valor                money,
        @w_oficina              smallint,
        @w_producto             tinyint,
        @w_tipo                 char(1),
        @w_oficial              smallint,
        @w_proban               smallint,
        @w_monto_ini            money,
        @w_dep_ini              tinyint,
    @w_cli1         int,
        @w_promotor         smallint,
        @w_direccion_dv     tinyint,
        @w_tipodir_dv       char(1),
        @w_descdir_dv           direccion,
        @w_agen_dv      smallint,
    @w_cliente_dv       int,
    @w_traslado     char(1),
    @w_aplica_tasa          char(1),
    @w_tipo_ctasuper    char(1),
    @w_ah_estado_cuenta char(1),
    @w_permite_sldcero  char(1),
    @w_tipocta_super    char(1),
        @w_titularidad          char(1),   -- AVI 8-Jun-2005
    @w_patente      varchar(40),
    @w_tipocta      char(1),
        @w_fideicomiso        varchar(15) --RRB

/* Captura del nombre del Store Procedure */
select @w_sp_name = 'sp_query_up_ah'

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

/* Determinacion de los datos para enviarlos al front end */

select  @w_cuenta          = ah_cuenta,
    @w_est             = ah_estado,
    @w_nombre          = ah_nombre,
    @w_direccion_ec    = ah_direccion_ec,
    @w_descripcion_ec  = ah_descripcion_ec,
    @w_cliente_ec      = ah_cliente_ec,
    @w_tipo_def        = ah_tipo_def,
        @w_agen_ec         = ah_agen_ec,
        @w_tipodir         = ah_tipo_dir,
    @w_funcionario     = ah_cta_funcionario,
        @w_fecha_prx_corte = convert(char(10), ah_fecha_prx_corte, @i_formato_fecha),
        @w_origen          = ah_origen,
        @w_tpromedio       = ah_tipo_promedio,
        @w_ciclo           = ah_ciclo,
        @w_categoria       = ah_categoria,
        @w_capitalizacion  = ah_capitalizacion,
        @w_numlib          = ah_numlib,
        @w_cta_banco       = ah_cta_banco,
        @w_oficina         = ah_oficina,
        @w_producto        = ah_producto,
        @w_tipo            = ah_tipo,
        @w_oficial         = ah_oficial,
        @w_proban          = ah_prod_banc,
        @w_dep_ini         = ah_dep_ini,
        @w_nombre1         = ah_nombre1,
        @w_cedruc1         = ah_cedruc1,
    @w_cli1        = ah_cliente1,
        @w_promotor        = ah_promotor,
        @w_direccion_dv    = ah_direccion_dv,
        @w_tipodir_dv      = ah_tipodir_dv,
        @w_descdir_dv      = ah_descripcion_dv,
        @w_agen_dv         = ah_agen_dv,
        @w_cliente_dv      = ah_cliente_dv,
        @w_traslado    = ah_traslado,
    @w_aplica_tasa=ah_aplica_tasacorp,
    @w_tipo_ctasuper = ah_tipocta,     --super
    @w_ah_estado_cuenta = isnull(ah_estado_cuenta,'N'),
    @w_permite_sldcero  = ah_permite_sldcero,
        @w_tipocta_super    = ah_tipocta_super,
        @w_titularidad      = ah_ctitularidad,   -- AVI 8-Jun-2005
    @w_patente      = ah_patente,
    @w_tipocta      = ah_tipocta,
        @w_fideicomiso      = ah_fideicomiso
  from  cob_ahorros..ah_cuenta
 where  ah_cta_banco = @i_cta
   and  ah_moneda = @i_mon
if @@rowcount <> 1
begin
  /* No existe cuenta_banco */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 251001,
       @i_sev   = 0,
       @i_msg   = 'No existe cuenta de ahorros'
   return 1
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

/* Determina Det producto y Monto */
   select @w_det_producto = dp_det_producto,
          @w_monto_ini    = dp_monto
   from cobis..cl_det_producto
    where dp_cuenta = @i_cta
      and dp_producto   = 4

/* Envio de resultados al Front End */
select  'CODIGO'          = en_ente,
        'IDENTIFICACION'  = en_ced_ruc, p_pasaporte,
    'TIPO'            = en_subtipo,
    'NOMBRE'          = en_nomlar,
    'ROL'         = cl_rol,
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
 order by cl_rol desc

if @@error <> 0 or @@rowcount = 0
begin
   /* No existe cliente */
   exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 101061,
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
/* Envia datos de direccion de cheques devueltos */
       @w_tipodir_dv,
       @w_direccion_dv,
       @w_descdir_dv,
       @w_cliente_dv,
       @w_agen_dv,
--   Tipo de cuenta
       @w_tipocta,
       @w_fideicomiso

/* Envio Oficial y Nombre */
select  @w_oficial, fu_nombre
  from  cobis..cc_oficial,
    cobis..cl_funcionario
 where  @w_oficial = oc_oficial
   and  oc_funcionario = fu_funcionario
if @@rowcount = 0
begin
  /* No existe oficial */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 101036,
       @i_sev   = 0,
       @i_msg   = 'No existe oficial'
--   return 1   /* COMENTADO PARA QUE A PESAR DE NO EXISTIR OFICIAL */
        /* SE CONTINUE CON LA BUSQUEDA DE LOS OTROS VALORES DE LA CUENTA */
end

/* Envio Tipo de Promedio y Descripcion */
   select  @w_tpromedio, valor
   from cobis..cl_catalogo
   where  codigo = @w_tpromedio
     and  tabla = (select cobis..cl_tabla.codigo
   from cobis..cl_tabla
   where tabla = 'ah_tpromedio')

/* Envio de Ciclo y Descripcion */
   select  @w_ciclo, valor
   from cobis..cl_catalogo
   where  codigo = @w_ciclo
    and tabla = (select cobis..cl_tabla.codigo
           from cobis..cl_tabla
          where tabla = 'ah_ciclo')

/* Envio de Categoria y Descripcion */
   select @w_categoria, valor
   from cobis..cl_catalogo
   where codigo = @w_categoria
    and tabla = (select cobis..cl_tabla.codigo
                   from cobis..cl_tabla
                  where tabla = 'pe_categoria')

/* Envio de Capitalizacion y Descripcion */
   select @w_capitalizacion, valor
   from cobis..cl_catalogo
   where  codigo = @w_capitalizacion
    and tabla = (select cobis..cl_tabla.codigo
                      from cobis..cl_tabla
                     where tabla = 'ah_capitalizacion')

/* Envio Producto bancario y Descripcion */
   select @w_proban,
       pb_descripcion
   from cob_remesas..pe_pro_bancario
   where @w_proban  = pb_pro_bancario

/* Envio Origen de la Cuenta y Descripcion */
   select @w_origen, valor
   from cobis..cl_catalogo
   where  codigo = @w_origen
    and tabla = (select cobis..cl_tabla.codigo
                      from cobis..cl_tabla
                     where tabla = 'ah_tipocta')

/* Adicion de nuevos campos a obtener en la consulta de Actualizacion */
select @w_titularidad, valor   -- AVI 8-Jun-2005
  from cobis..cl_catalogo
 where codigo = @w_titularidad
   and tabla = (select cobis..cl_tabla.codigo
                  from cobis..cl_tabla
                 where tabla = 're_titularidad')

/* Envio Numero de Libreta */
   select @w_numlib

/* Envio Deposito Inicial */
   select @w_monto_ini

/* Envia si ya se realizo deposito inicial */
   select @w_dep_ini

/* Envia el codigo del cliente cotitular principal */
   select @w_cli1

/* Envia codigo de promotor  */
   select @w_promotor, valor
from cobis..cl_catalogo
where codigo = convert(varchar(4), @w_promotor)
  and   tabla = (select cobis..cl_tabla.codigo
                      from cobis..cl_tabla
                     where tabla = 'cl_promotor')

/* Envio Traslado */
   select @w_traslado

/*Envio aplica tasa corporativa*/
   select @w_aplica_tasa

   select @w_tipo_ctasuper

/* Envio del Campo que determina el envio del estado de cuenta */
   select @w_ah_estado_cuenta

/* Envio del campo para determinar si se permite saldo cero */
   select @w_permite_sldcero

select @w_tipocta_super, valor
  from cobis..cl_catalogo
 where codigo = @w_tipocta_super
   and tabla = (select cobis..cl_tabla.codigo
                  from cobis..cl_tabla
         where tabla = 'ah_cla_cliente')

select  @w_patente

select isnull(ca_cta_banco_rel,'')  -- cta donde iran los intereses por NC
  from cob_ahorros..ah_cuenta_aux
 where ca_cta_banco = @i_cta

 
return 0

go

