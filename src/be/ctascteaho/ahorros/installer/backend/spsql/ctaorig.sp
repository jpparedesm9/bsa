/*FES 16/05/2003 PU:OK*/
/************************************************************************/
/*  Archivo:                ctaorig.sp                                  */
/*  Stored procedure:       sp_cta_origen                               */
/*  Base de datos:          cob_ahorros                                 */
/*  Producto:               Cuentas de Ahorro                           */
/*  Disenado por:           Mauricio Bayas/Sandra Ortiz                 */
/*  Fecha de escritura:     18-Nov-1992                                 */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno  de sus            */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp.     */
/*  Este programa esta protegido por la ley de derechos de autor        */
/*  y por las convenciones  internacionales de propiedad inte-          */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para       */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier infraccion.                   */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa determina si una cuenta es local o remota             */
/*  al servidor donde ha sido solicitado.                               */
/*                                                                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR         RAZON                                     */
/*  18/Nov/1992 S. Ortiz      Emision inicial                           */
/*  23/Mar/1993 S. Ortiz      Identificacion de cuentas correspondientes*/
/*                            a servidores de branch                    */
/*  22/Jun/1995 E. Guerrero   Codigo de cuenta ahorros (1,4)            */
/*  21/May/1998 J. Cadena     Personalizacion B. del Caribe             */
/*  02/Jul/2009 M.Velastegui  Tabla comun re_conversion / Ahorros       */
/*  03/May/2016 J. Salazar    Migracion COBIS CLOUD MEXICO              */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_cta_origen')
  drop proc sp_cta_origen
go

/****** Object:  StoredProcedure [dbo].[sp_cta_origen]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_cta_origen
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(30) = null,
  @t_show_version bit = 0,
  @i_cta          cuenta,
  @i_producto     tinyint,
  @i_mon          tinyint,
  @i_oficina      smallint,
  @o_tipo         char(1) out,
  @o_srv_local    descripcion out,
  @o_srv_rem      descripcion out
)
as
  declare
    @w_filial_p     tinyint,
    @w_oficina_p    smallint,
    @w_tipo_p       char(1),
    @w_filial_i     tinyint,
    @w_oficina_i    smallint,
    @w_return       smallint,
    @w_nodo_i       smallint,
    @w_sp_name      varchar(30),
    @w_mensaje      mensaje,
    @w_ofi_regional smallint

  /*  Captura nombre de stored procedure  */
  select
    @w_sp_name = 'sp_cta_origen'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/**  Stored Procedure  **/' = @w_sp_name,
      t_from = @t_from,
      i_cta = @i_cta,
      i_producto = @i_producto,
      i_mon = @i_mon,
      i_oficina = @i_oficina
    exec cobis..sp_end_debug
  end

  /* Regresa repuesta al FE y termina */
  select
    @o_tipo = 'L',
    @o_srv_local = null,
    @o_srv_rem = null

  return 0

  /*  Determinacion de oficina propietaria de la cuenta corriente */
  if @i_producto = 3
  begin
    select
      @w_filial_p = cv_filial,
      @w_oficina_p = cv_oficina,
      @w_tipo_p = cv_tipo
    from   cob_remesas..re_conversion
    where  cv_producto   = @i_producto
       and cv_moneda     = @i_mon
       and cv_codigo_cta = substring(@i_cta,
                                     1,
                                     3)

    if @@rowcount = 0
    begin
      /*  Codigo de oficina en cuenta no existe  */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201007
      return 201007
    end
  end

  /*  Determinacion de oficina propietaria de la cuenta ahorros */
  if @i_producto = 4
  begin
    select
      @w_filial_p = cv_filial,
      @w_oficina_p = cv_oficina,
      @w_tipo_p = cv_tipo
    from   cob_remesas..re_conversion
    where  cv_producto   = @i_producto
       and cv_moneda     = @i_mon
       and cv_codigo_cta = substring(@i_cta,
                                     1,
                                     6)

    if @@rowcount = 0
    begin
      /*  Codigo de oficina en cuenta no existe  */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201007
      return 201007
    end
  end

  /*   Modo de debug, campos de output  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/**  Stored Procedure  **/' = @w_sp_name,
      w_filial_p = @w_filial_p,
      w_oficina_p = @w_oficina_p,
      w_tipo_p = @w_tipo_p
    exec cobis..sp_end_debug
  end

  /*  Determinacion de condicion de Local o Remoto  */
  if (@w_oficina_p = @i_oficina)
    select
      @o_tipo = 'L',
      @o_srv_local = null,
      @o_srv_rem = null
  else if @w_tipo_p = 'B'
  begin
    select
      @o_tipo = 'L',
      @o_srv_local = null,
      @o_srv_rem = null,
      @w_ofi_regional = nl_oficina
    from   cobis..ad_server_logico,
           cobis..ad_nodo_oficina
    where  sg_oficina_p = @w_oficina_p
       and sg_producto  = @i_producto
       and sg_moneda    = @i_mon
       and sg_tipo      = 'B' /*  Branch  */
       and nl_filial    = sg_filial_i
       and nl_oficina   = sg_oficina_i
       and nl_nodo      = sg_nodo_i

    if @w_ofi_regional <> @i_oficina
    begin
      /*  Cuenta no corresponde a este regional  */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201055
      return 201055
    end
  end
  else
  begin
    /*  Determinacion del servidor remoto  */
    select
      @o_tipo = 'R',
      @o_srv_rem = nl_nombre
    from   cobis..ad_server_logico,
           cobis..ad_nodo_oficina
    where  sg_filial_p  = @w_filial_p
       and sg_oficina_p = @w_oficina_p
       and sg_producto  = @i_producto
       and sg_moneda    = @i_mon
       and sg_tipo      = 'R' /*  Regional  */
       and nl_filial    = sg_filial_i
       and nl_oficina   = sg_oficina_i
       and nl_nodo      = sg_nodo_i

    if @@rowcount = 0
      select
        @o_tipo = 'L',
        @o_srv_rem = null
  end
  /* Modo de debug, campos de output */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/**  Stored Procedure  **/' = @w_sp_name,
      o_tipo = @o_tipo,
      o_srv_local = @o_srv_local,
      o_srv_rem = @o_srv_rem
    exec cobis..sp_end_debug
  end
  return 0

go

