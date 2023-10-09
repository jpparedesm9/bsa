/********************************************************************/
/*  Archivo:                ahoficif.sp                             */
/*  Stored procedure:       sp_mant_oficina_cifrada                 */
/*  Base de datos:          cob_ahorros                             */
/*  Producto:               Cuentas de Ahorros                      */
/*  Disenado por:           David Vasquez                           */
/*  Fecha de escritura:     28-May-2002                             */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                         PROPOSITO                                */
/*  Este programa realiza el mantenimiento de oficinas para cuentas */
/*  Cifradas                                                        */
/********************************************************************/
/*                      MODIFICACIONES                              */
/*  FECHA         AUTOR           RAZON                             */
/*  28/May/2002   D. Vasquez      Emision Inicial                   */
/*  06/jun/2002   A. Pazmino      Personalizacion Agro Mercantil    */
/*  04/May/2016   J. Salazar      Migracion COBIS CLOUD MEXICO      */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_mant_oficina_cifrada')
  drop proc sp_mant_oficina_cifrada
go

/****** Object:  StoredProcedure [dbo].[sp_mant_oficina_cifrada]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_mant_oficina_cifrada
(
  @s_ssn          int,
  @s_ssn_branch   int,
  @s_srv          varchar(30) = null,
  @s_user         varchar(30) = null,
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,/* Localidad origen transaccion */
  @s_rol          smallint = 1,
  @s_org_err      char(1) = null,/* Origen de error:[A], [S] */
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_oficina      smallint = null,
  @i_estado       char(1) = null,
  @i_opcion       char(1),
  @i_turno        smallint = null
)
as
  declare
    @w_return  int,
    @w_sp_name varchar(30)

  /* Captura del nombre del Store Procedure */

  select
    @w_sp_name = 'sp_mant_oficina_cifrada'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  if @i_turno is null
    select
      @i_turno = @s_rol

  /* Modo de debug */

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      i_oficina = @i_oficina,
      i_estado = @i_estado,
      i_opcion = @i_opcion
    exec cobis..sp_end_debug
  end

  if @t_trn <> 319
  begin
    -- Error en codigo de transaccion 
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  if @i_opcion = 'I'
  begin
    begin tran
    --Insercion de nueva oficina de cuentas cifradas

    insert into cob_ahorros..ah_oficina_ctas_cifradas
                (oc_oficina,oc_estado)
    values      (@i_oficina,@i_estado)

    if @@error <> 0
    begin
      -- Error en creacion de oficina de ctas cifradas
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253014
      return 1
    end

    insert into cob_ahorros..ah_tscambia_estado
                (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
                 terminal,reentry,oficina,origen,cta_banco,
                 moneda,estado,oficina_cta,valor,prod_banc,
                 categoria,turno)
    values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
                 @s_term,@t_rty,@s_ofi,@s_org,null,
                 null,@i_estado,@i_oficina,null,null,
                 @i_opcion,@i_turno)

    if @@error <> 0
    begin
      -- Error en creacion de transaccion de servicio
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203005
      return 203005
    end

    commit tran
    return 0

  end

  if @i_opcion = 'U'
  begin
    begin tran
    --Actualizacion de oficina de cuentas cifradas

    update cob_ahorros..ah_oficina_ctas_cifradas
    set    oc_estado = @i_estado
    where  oc_oficina = @i_oficina

    if @@rowcount <> 1
    begin
      -- Error en actualizacion de oficina de ctas cifradas
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 255012
      return 1
    end

    insert into cob_ahorros..ah_tscambia_estado
                (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
                 terminal,reentry,oficina,origen,cta_banco,
                 moneda,estado,oficina_cta,valor,prod_banc,
                 categoria,turno)
    values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
                 @s_term,@t_rty,@s_ofi,@s_org,null,
                 null,@i_estado,@i_oficina,null,null,
                 @i_opcion,@i_turno)

    if @@error <> 0
    begin
      -- Error en creacion de transaccion de servicio
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203005
      return 203005
    end

    commit tran
    return 0

  end

  if @i_opcion = 'S'
  begin
    --Busqueda de oficinas de cuentas cifradas

    select
      'SUCURSAL'= oc_oficina,
      'NOMBRE' = of_nombre,
      'ESTADO' = oc_estado
    from   cob_ahorros..ah_oficina_ctas_cifradas,
           cobis..cl_oficina
    where  oc_oficina = of_oficina

    if @@rowcount = 0
    begin
      -- No existen oficinas de cuentas cifradas
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251080
      return 1
    end

    return 0

  end

  return 0

go

