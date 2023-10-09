/****************************************************************************/
/*     Archivo:             pecicpro.sp                                     */
/*     Stored procedure:    sp_ciclo_profinal                               */
/*     Base de datos:       cob_remesas                                     */
/*     Producto:            Sub-Modulo de Personalizacion                   */
/*     Disenado por:        Juan Carlos Gordillo                            */
/*     Fecha de escritura:  14 de Enero de 1999                             */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de 'COBISCorp'.                                                         */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como        */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus        */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de   derechos de autor          */
/*  y por las    convenciones  internacionales   de  propiedad inte-        */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para     */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir            */
/*  penalmente a los autores de cualquier   infraccion.                     */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa se encarga de insertar, actualizar, borrar y consultar */
/*  (Search, Query y Help) las categorias relacionadas a un producto final. */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     14/Ene/1999      A. Pazmi¤o      Emision Inicial                     */
/*     28/Jun/2009      M.Velastegui    Mexicanizacion CrediPyme            */
/*     02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/****************************************************************************/

use cob_remesas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ciclo_profinal')
  drop proc sp_ciclo_profinal
go

create proc sp_ciclo_profinal
(
  @s_ssn           int = null,
  @s_user          login = null,
  @s_sesn          int = null,
  @s_term          varchar(30) = null,
  @s_date          datetime = null,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_rol           smallint = null,
  @s_ofi           smallint = null,
  @s_org_err       char(1) = null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           descripcion = null,
  @s_org           char(1) = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_trn           smallint =null,
  @t_show_version  bit = 0,
  @i_oper          char(3),
  @i_cons_profinal char(1) = 'N',
  @i_cons_cta      char(1) = 'N',
  @i_profinal      smallint = null,
  @i_pro_bancario  smallint = null,
  @i_tipo_ente     char(1) = null,
  @i_producto      tinyint = null,
  @i_moneda        tinyint = null,
  @i_filial        tinyint = null,
  @i_oficina       smallint = null,
  @i_cuenta        char(10) = null,
  @i_tipo_cta      char(3) = null,
  @i_ciclo         char(1) = null,
  @i_nuevo_ciclo   char(1) = null
)
as
  declare
    @w_sp_name      varchar(32),
    @w_return       int,
    @w_profinal     smallint,
    @w_pro_bancario smallint,
    @w_tipo_ente    char(1),
    @w_producto     tinyint,
    @w_moneda       tinyint,
    @w_oficina      smallint,
    @w_sucursal     smallint,
    @w_filial       tinyint,
    @w_filas_return int --MVE Mexicanizacion

  /* Captura del nombre del stored procedure */
  select
    @w_sp_name = 'sp_ciclo_profinal'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Validar el codigo de transaccion */
  if @t_trn = 4087
      or @t_trn = 4097
      or @t_trn = 4098
      or @t_trn = 4099
      or @t_trn = 4100
  begin
    /* ** Insert ** */
    if @i_oper = 'I'
    begin
      /* Verificacion de claves foraneas */
      if not exists (select
                       *
                     from   cob_remesas..pe_pro_final
                     where  pf_pro_final = @i_profinal)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351527
        /* 'No existe producto final' */
        return 351527
      end

      if exists (select
                   *
                 from   cob_remesas..pe_ciclo_profinal
                 where  cp_profinal = @i_profinal)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351568
        /* 'Ya existe el tipo de capitalizacion para el producto final' */
        return 351568
      end

      begin tran

      /* Insercion de tipo de capitalizacion a productos finales */
      insert into pe_ciclo_profinal
                  (cp_profinal,cp_ciclo)
      values      (@i_profinal,@i_ciclo)

      if @@error != 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353518
        /* 'Error en creacion de tipo de capitalizacion por producto final' */
        return 353518
      end

      /* transaccion servicio - capitalizacion por producto */
      insert into pe_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                   ts_terminal,
                   ts_reentry,ts_operacion,ts_pro_final,ts_tipo)
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   'N',@i_oper,@i_profinal,@i_ciclo)

      if @@error != 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicios'*/
        return 103005
      end

      commit tran
      return 0
    end

    /* ** Delete ** */
    if @i_oper = 'D'
    begin
      select
        1
      from   cob_remesas..pe_ciclo_profinal
      where  cp_profinal = @i_profinal
         and cp_ciclo    = @i_ciclo

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351569
        /*'No existe el tipo de capitalizacion para el producto final'*/
        return 351569
      end

      begin tran

      /* Eliminacion de un tipo de capitalizaci¢n para un producto final dado */
      delete pe_ciclo_profinal
      where  cp_profinal = @i_profinal
         and cp_ciclo    = @i_ciclo

      if @@error != 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_fil   = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 357509
        /*'Error en eliminacion de tipo de capitalizacion por producto final'*/
        return 357509
      end

      /* transaccion servicio - tipo de capitalizacion por producto */
      insert into pe_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                   ts_terminal,
                   ts_reentry,ts_operacion,ts_pro_final,ts_tipo)
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   'N',@i_oper,@i_profinal,@i_ciclo)

      if @@error != 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicios'*/
        return 103005
      end

      commit tran
      return 0
    end

    /* ** Update ** */
    if @i_oper = 'U'
    begin
      select
        1
      from   cob_remesas..pe_ciclo_profinal
      where  cp_profinal = @i_profinal
         and cp_ciclo    = @i_ciclo

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351569
        /*'No existe tipo de capitalizacion para el producto final'*/
        return 351569
      end

      begin tran

    /* Actualizacion del tipo de capitalizacion para un producto */
      /* final dado */
      update pe_ciclo_profinal
      set    cp_ciclo = @i_nuevo_ciclo
      where  cp_profinal = @i_profinal
         and cp_ciclo    = @i_ciclo

      if @@error != 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_fil   = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 355521
        /*'Error en actualizacion del tipo de capitalizacion por producto final'*/
        return 355521
      end

      /* transaccion servicio - tipo de capitalizacion por producto PREVIO */
      insert into pe_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                   ts_terminal,
                   ts_reentry,ts_operacion,ts_tipo_variacion,ts_pro_final,
                   ts_tipo)
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   'N',@i_oper,'P',@i_profinal,@i_ciclo)

      if @@error != 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicios'*/
        return 103005
      end

      /* transaccion servicio - tipo capitalizacion por producto ACTUAL */
      insert into pe_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                   ts_terminal,
                   ts_reentry,ts_operacion,ts_tipo_variacion,ts_pro_final,
                   ts_tipo)
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   'N',@i_oper,'A',@i_profinal,@i_ciclo)

      if @@error != 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicios'*/
        return 103005
      end

      commit tran
      return 0
    end

    /* Search - Query - Help */
    if @i_oper in ('S', 'Q', 'H')
    begin
      if @i_cons_cta = 'S'
      begin
        if @i_tipo_cta = 'CTE'
        begin
          exec cob_interfase..sp_icte_select_cc_ctacte
            @i_cuenta       = @i_cuenta,
            @i_pro_bancario = @i_pro_bancario,
            @i_tipo_ente    = @i_tipo_ente,
            @o_pro_bancario = @w_pro_bancario out,
            @o_tipo_ente    = @w_tipo_ente out,
            @o_filial       = @w_filial out,
            @o_oficina      = @w_oficina out,
            @o_producto     = @w_producto out,
            @o_moneda       = @w_moneda out,
            @o_filas_return = @w_filas_return out

          if @w_filas_return = 0
          begin
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141047
            /* 'No existe Cuenta Corriente'*/
            return 141047
          end
        end

        if @i_tipo_cta = 'AHO'
        begin
          select
            @w_pro_bancario = ah_prod_banc,
            @w_tipo_ente = ah_tipocta,
            @w_filial = ah_filial,
            @w_oficina = ah_oficina,
            @w_producto = ah_producto,
            @w_moneda = ah_moneda
          from   cob_ahorros..ah_cuenta
          where  ah_cta_banco = @i_cuenta

          if @@rowcount = 0
          begin
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141048
            /* 'No existe Cuenta de Ahorros'*/
            return 141048
          end
        end
      end
      else if @i_cons_cta = 'N'
        select
          @w_pro_bancario = @i_pro_bancario,
          @w_tipo_ente = @i_tipo_ente,
          @w_filial = @i_filial,
          @w_oficina = @i_oficina,
          @w_producto = @i_producto,
          @w_moneda = @i_moneda

      if @i_cons_profinal = 'S'
      begin
        /* Determinar la sucursal */
        select
          @w_sucursal = isnull(of_regional,
                               of_oficina)
        from   cobis..cl_oficina
        where  of_oficina = @w_oficina

        if @@rowcount = 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101028
          /* 'No existe sucursal'*/
          return 101028
        end

        select
          @w_profinal = pf_pro_final
        from   cob_remesas..pe_pro_final,
               cob_remesas..pe_mercado
        where  pf_filial       = @w_filial
           and pf_sucursal     = @w_sucursal
           and pf_producto     = @w_producto
           and pf_moneda       = @w_moneda
           and pf_mercado      = me_mercado
           and me_pro_bancario = @w_pro_bancario
           and me_tipo_ente    = @w_tipo_ente

        if @@rowcount = 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 351527
          /* 'No existe producto final'*/
          return 351527
        end

      end
      else if @i_cons_profinal = 'N'
        select
          @w_profinal = @i_profinal
    end

    /* Search */
    if @i_oper = 'S'
    begin
      select
        '1093' = cp_ciclo,
        '1896' = valor
      from   cob_remesas..pe_ciclo_profinal,
             cobis..cl_tabla a,
             cobis..cl_catalogo b
      where  cp_profinal = @w_profinal
         and a.tabla     = 'cc_ciclo'
         and a.codigo    = b.tabla
         and b.codigo    = cp_ciclo

      return 0
    end

    /* Query */
    if @i_oper = 'Q'
    begin
      select
        '1896' = valor
      from   cob_remesas..pe_ciclo_profinal,
             cobis..cl_tabla a,
             cobis..cl_catalogo b
      where  cp_profinal = @w_profinal
         and cp_ciclo    = @i_ciclo
         and a.tabla     = 'cc_ciclo'
         and a.codigo    = b.tabla
         and b.codigo    = cp_ciclo

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351569
        /* 'No existe tipo de capitalizaci=n para el producto final'*/
        return 351569
      end

      return 0
    end

    /* Help */
    if @i_oper = 'H'
    begin
      select
        '1093' = cp_ciclo,
        '1896' = valor
      from   cob_remesas..pe_ciclo_profinal,
             cobis..cl_tabla a,
             cobis..cl_catalogo b
      where  cp_profinal = @w_profinal
         and a.tabla     = 'cc_ciclo'
         and a.codigo    = b.tabla
         and b.codigo    = cp_ciclo
    end
  end
  else
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    /*  'No corresponde codigo de transaccion' */
    return 1
  end

go 
