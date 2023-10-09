/************************************************************************/
/*    Archivo:               ahbencta.sp                                */
/*    Stored procedure:      sp_beneficiario_ahorros                    */
/*    Base de datos:         cob_ahorros                                */
/*    Producto:              Cuentas Ahorros                            */
/*      Disenado por:        Manuel Freire                              */
/*    Fecha de escritura:     19-May-2003                               */
/************************************************************************/
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                              PROPOSITO                               */
/*    Este programa realiza la transaccion de ingreso eliminacion       */
/*      actualizacion consulta de beneficiarios de una cuenta de        */
/*      ahorros.                                                        */
/*                                                                      */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*      FECHA           AUTOR           RAZON                           */
/*    19/May/2003    M. Freire    Emision inicial    BDF                */
/*    02/May/2016    J. Calderon  Migración a CEN                       */
/************************************************************************/

use cob_ahorros
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO
if exists (select
             1
           from   sysobjects
           where  name = 'sp_beneficiario_ahorros')
  drop proc sp_beneficiario_ahorros
go

create proc sp_beneficiario_ahorros
(
  @s_ssn          int,
  @s_ssn_branch   int = null,
  @s_srv          varchar(30),
  @s_user         varchar(30),
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
  @i_tipo         char(1),
  @i_cta          cuenta,
  @i_mon          tinyint,
  @i_ced_ruc      char(20)= '',
  @i_nombre       char(64)= null,
  @i_porcentaje   float = null,
  @i_beneficiario int = 0
)
as
  declare
    @w_return       int,
    @w_sp_name      varchar(30),
    @w_ctacte       int,
    @w_cliente      int,
    @w_est          char(1),
    @w_oficina      smallint,
    @w_beneficiario int,
    @w_sumpctje     float,
    @w_tipocta      char(1),
    @w_msg          char(80)

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_beneficiario_ahorros'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      i_cta = @i_cta,
      i_mon = @i_mon

    exec cobis..sp_end_debug
  end

  if @t_trn <> 333
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  /* Chequeo de existencias */
  select
    @w_ctacte = ah_cuenta,
    @w_est = ah_estado,
    @w_oficina = ah_oficina,
    @w_tipocta = ah_tipocta
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta
     and ah_moneda    = @i_mon

  if @@rowcount <> 1
  begin
    /* No existe cuenta_banco */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201004
    return 1
  end

  /* Validaciones */
  if @w_est not in ('A', 'G')
     and @i_tipo <> 'S'
  begin
    /* Cuenta no activa o cancelada */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251002
    return 1
  end

  -- Insercion de un nuevo beneficiario de una cuenta de ahorros --

  if @i_tipo = 'I'
  begin
    if @w_tipocta <> 'P'
    begin
      select
        @w_msg = '[' + @w_sp_name + '] ' +
                        'ESTE TIPO DE CUENTA NO PERMITE BENEFICIARIOS'
      /* Titular no es persona natural */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = @w_msg,
        @i_num   = 251002
      return 1
    end

    -- Valida que el porcentaje total no sea mayor a 100 --    
    if exists (select
                 1
               from   cob_ahorros..ah_beneficiario_cta
               where  bc_cta_banco  = @i_cta
                  and bc_porcentaje = 100)
       and @i_porcentaje <> 100
    begin
      select
        @w_msg = '[' + @w_sp_name + '] ' +
                 'PORCENTAJE NO PUEDE SER DIFERENTE DE 100'
      -- Porcentaje diferente de 100 --
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251002,
        @i_msg   = @w_msg
      return 1
    end
    else
    begin
      if exists (select
                   1
                 from   cob_ahorros..ah_beneficiario_cta
                 where  bc_cta_banco  = @i_cta
                    and bc_porcentaje < 100)
         and @i_porcentaje = 100
      begin
        select
          @w_msg = '[' + @w_sp_name + '] ' + 'PORCENTAJE NO PUEDE SER 100'
        -- Porcentaje diferente de 100 --
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251002,
          @i_msg   = @w_msg
        return 1
      end

      select
        @w_sumpctje = sum(bc_porcentaje)
      from   cob_ahorros..ah_beneficiario_cta
      where  bc_cta_banco  = @i_cta
         and bc_porcentaje < 100

      if @w_sumpctje + @i_porcentaje > 100
         and @i_porcentaje < 100
      begin
        select
          @w_msg = '[' + @w_sp_name + '] ' +
                   'ERROR PORCENTAJE TOTAL MAYOR A 100'
        -- Porcentaje total mayor a 100 --
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251002,
          @i_msg   = @w_msg
        return 1
      end
    end

    /*Obtiene el secuencial*/
    exec cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'ah_beneficiario_cta',
      @o_siguiente = @w_beneficiario out

    begin tran
    insert into ah_beneficiario_cta
                (bc_beneficiario,bc_cta_banco,bc_ced_ruc,bc_nombre,bc_porcentaje
    )
    values      (@w_beneficiario,@i_cta,@i_ced_ruc,@i_nombre,@i_porcentaje)

    if @@error <> 0
    begin
      select
        @w_msg = '[' + @w_sp_name + '] ' +
                 'ERROR DE INSERCION EN AH_BENEFICIARIO_CTA'
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203028,
        @i_msg   = @w_msg
      return 1
    end

    commit tran
    return 0
  end

  /* Eliminacion de un beneficiario de una cuenta de ahorros */
  if @i_tipo = 'D'
  begin
    begin tran

    delete ah_beneficiario_cta
    where  bc_beneficiario = @i_beneficiario
       and bc_cta_banco    = @i_cta

    if @@error <> 0
    begin
      select
        @w_msg = '[' + @w_sp_name + '] ' +
                 'ERROR DE ELIMINACION EN AH_BENEFICIARIO_CTA'
      /* Error en eliminacion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 207008,
        @i_msg   = @w_msg
      return 1
    end

    commit tran
    return 0
  end

  if @i_tipo = 'U'
  begin
    /*Valida que el porcentaje total no sea mayor a 100*/
    if exists (select
                 1
               from   cob_ahorros..ah_beneficiario_cta
               where  bc_cta_banco    = @i_cta
                  and bc_porcentaje   = 100
                  and bc_beneficiario <> @i_beneficiario)
       and @i_porcentaje <> 100
    begin
      select
        @w_msg = '[' + @w_sp_name + '] ' +
                 'PORCENTAJE NO PUEDE SER DIFERENTE DE 100'
      /* Porcentaje diferente de 100 */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251002,
        @i_msg   = @w_msg
      return 1
    end
    else
    begin
      select
        @w_sumpctje = sum(bc_porcentaje)
      from   cob_ahorros..ah_beneficiario_cta
      where  bc_cta_banco    = @i_cta
         and bc_porcentaje   < 100
         and bc_beneficiario <> @i_beneficiario

      if @w_sumpctje + @i_porcentaje > 100
      begin
        select
          @w_msg = '[' + @w_sp_name + '] ' +
                   'ERROR PORCENTAJE TOTAL MAYOR A 100'
        /* Porcentaje total mayor a 100 */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251002,
          @i_msg   = @w_msg
        return 1
      end
    end

    begin tran

    update ah_beneficiario_cta
    set    bc_ced_ruc = @i_ced_ruc,
           bc_nombre = @i_nombre,
           bc_porcentaje = @i_porcentaje
    where  bc_beneficiario = @i_beneficiario
       and bc_cta_banco    = @i_cta

    if @@error <> 0
    begin
      select
        @w_msg = '[' + @w_sp_name + '] ' +
                 'ERROR EN ACTUALIZACION AH_BENEFICIARIO_CTA'
      /* Error en actualizacion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 207008,
        @i_msg   = @w_msg
      return 1
    end

    commit tran
    return 0
  end

  /* Consulta de beneficiarios de una cuenta de ahorros */
  if @i_tipo = 'S'
  begin
    set rowcount 40

    select
      bc_beneficiario,
      bc_ced_ruc,
      bc_nombre,
      bc_porcentaje
    from   ah_beneficiario_cta
    where  bc_cta_banco    = @i_cta
       and bc_beneficiario > @i_beneficiario

  end

  /* Controla que el total de porcentajes no sea menor a 100 */
  if @i_tipo = 'T'
  begin
    select
      @w_sumpctje = sum(bc_porcentaje)
    from   cob_ahorros..ah_beneficiario_cta
    where  bc_cta_banco = @i_cta

    if @w_sumpctje < 100
    begin
      select
        @w_msg = '[' + @w_sp_name + '] ' + 'DEBE COMPLETAR EL 100 POR CIENTO'
      -- Porcentaje total menor a 100 --
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251002,
        @i_msg   = @w_msg
      return 1
    end
  end

go

