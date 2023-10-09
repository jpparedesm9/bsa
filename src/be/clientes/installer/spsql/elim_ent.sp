/************************************************************************/
/*  Archivo:            elim_ent.sp                                     */
/*  Stored procedure:   sp_elim_ente                                    */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 13-Sep-1994                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este stored procedure procesa:                                      */
/*  Eliminacion de entes y de todos sus atributos multivalor            */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR           RAZON                                   */
/*  13/Sep/94   C. Rodriguez V. Emision Inicial                         */
/*  04/May/2016 T. Baidal       Migracion a CEN                         */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_elim_ente')
           drop proc sp_elim_ente
go

create proc sp_elim_ente
(
  @s_ssn           int = null,
  @s_user          login = null,
  @s_term          varchar(30) = null,
  @s_date          datetime = null,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_ofi           smallint = null,
  @s_rol           smallint = null,
  @s_org_err       char(1) = null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           descripcion = null,
  @s_org           char(1) = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(10) = null,
  @t_from          varchar(32) = null,
  @t_trn           smallint = null,
  @t_show_version  bit = 0,
  @i_ente          int = null,
  @i_subtipo       char(1) = null,
  @i_conta         char(1) = 'S'
)
as
  declare
    @w_today           datetime,
    @w_sp_name         varchar(32),
    @w_return          int,
    @w_siguiente       int,
    @w_codigo          int,
    @w_nombre          varchar(32),
    @w_p_apellido      varchar(16),
    @w_s_apellido      varchar(16),
    @w_sexo            char(1),
    @w_cedula_ruc      numero,
    @w_tipo_ced        char(2),
    @w_pasaporte       varchar(20),
    @w_pais            smallint,
    @w_profesion       catalogo,
    @w_estado_civil    catalogo,
    @w_num_cargas      tinyint,
    @w_nivel_ing       money,
    @w_nivel_egr       money,
    @w_filial          int,
    @w_oficina         smallint,
    @w_tipo            catalogo,
    @w_grupo           int,
    @w_fecha_nac       datetime,
    @w_fecha_crea      datetime,
    @w_fecha_mod       datetime,
    @w_lugar_doc       int,
    @w_oficial         smallint,
    @w_retencion       char(1),
    @w_mala_referencia char(1),
    @w_actividad       catalogo,
    @w_comentario      varchar(64),
    @v_nombre          varchar(32),
    @v_p_apellido      varchar(16),
    @v_s_apellido      varchar(16),
    @v_sexo            char(1),
    @v_cedula_ruc      numero,
    @v_pasaporte       varchar(20),
    @v_pais            smallint,
    @v_profesion       catalogo,
    @v_estado_civil    catalogo,
    @v_num_cargas      tinyint,
    @v_nivel_ing       money,
    @v_nivel_egr       money,
    @v_tipo            catalogo,
    @v_fecha_nac       datetime,
    @v_grupo           int,
    @v_oficial         smallint,
    @v_oficial_ant     smallint,
    @v_retencion       char(1),
    @v_actividad       catalogo,
    @v_comentario      varchar(64),
    @w_catalogo        catalogo

  select
    @w_sp_name = 'sp_elim_ente'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()

  if @t_trn = 1248
  begin
    if exists (select
                 cl_cliente
               from   cl_cliente
               where  cl_cliente = @i_ente)
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101148
      /* Ente es cliente de un producto */
      return 101148
    end

    /* verificar dependencias */
    if exists (select
                 cg_ente
               from   cl_cliente_grupo
               where  cg_ente = @i_ente)
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101193
      /* Ente es cliente de un producto */
      return 101193
    end

    if exists (select
                 in_relacion
               from   cl_instancia
               where  (in_ente_i = @i_ente
                    or in_ente_d = @i_ente))
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101149
      /* Ente esta relacionado */
      return 101149
    end

    set rowcount 1
    if @i_conta = 'S'
    begin
      select
        *
      from   cob_conta_tercero..ct_saldo_tercero
      where  st_ente = @i_ente
      if @@rowcount > 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105093
        /* Ente con registros contables */
        return 105093
      end
    end
    if exists (select
                 1
               from   cob_credito..cr_tramite
               where  tr_cliente = @i_ente)
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101148,
        @i_msg   =
      'No se puede eliminar Cliente. Tiene tramites de cupo en proceso'
      /* 'No se puede eliminar Cliente. Tiene tramites de cupo en proceso' */
      return 101148
    end

    if exists (select
                 1
               from   cob_credito..cr_deudores
               where  de_cliente = @i_ente)
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101148,
        @i_msg   = 'No se puede eliminar Cliente. Tiene Operaciones cr_deudores'
      /* 'No se puede eliminar Cliente. Tiene Operaciones cr_deudores' */
      return 101148
    end

    if exists (select
                 1
               from   cob_cartera_his..ca_operacion
               where  op_cliente = @i_ente)
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101148,
        @i_msg   = 'No se puede eliminar Cliente. Tiene Operaciones Canceladas'
      /* 'No se puede eliminar Cliente. Tiene Operaciones Canceladas' */
      return 101148
    end

    set rowcount 0
    if exists (select
                 en_ente
               from   cl_ente
               where  en_ente               = @i_ente
                  and en_subtipo            = 'C'
                  and en_gran_contribuyente = 'S')
    begin
      print 'EL CLIENTE ES GRANDE CONTRIBUYENTE'
      return 351077
    end

    /* Consulta Informacion del Cliente */
    select
      @w_cedula_ruc = en_ced_ruc,
      @w_tipo_ced = en_tipo_ced,
      @w_nombre = en_nombre,
      @w_p_apellido = p_p_apellido,
      @w_s_apellido = p_s_apellido,
      @w_sexo = p_sexo,
      @w_oficina = en_oficina,
      @w_fecha_nac = p_fecha_nac,
      @w_fecha_crea = en_fecha_crea,
      @w_fecha_mod = en_fecha_mod,
      @w_estado_civil = p_estado_civil,
      @w_lugar_doc = p_lugar_doc
    from   cobis..cl_ente
    where  en_ente = @i_ente

    begin tran

    delete cl_instancia
    where  (in_ente_i = @i_ente
         or in_ente_d = @i_ente)
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101123
      /* 'Existe referencia en instancia'*/
      return 101123
    end

    delete cl_at_instancia
    where  (ai_ente_i = @i_ente
         or ai_ente_d = @i_ente)
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101124
      /* '  Existe referencia en atributo de instancia '*/
      return 101124
    end

    delete cl_ente
    where  en_ente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107000
      /* 'Error en eliminacion de ente'*/
      return 107000
    end

    delete cl_propiedad
    where  pr_persona = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107039
      /* 'Error en eliminacion de propiedad'*/
      return 107039
    end

    delete cl_referencia
    where  re_ente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107044
      /* ' Error en eliminacion de referencia economica'*/
      return 107044
    end

    delete cl_ref_personal
    where  rp_persona = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107048
      /* 'Error en eliminacion de referencia personal'*/
      return 107048
    end

    delete cl_trabajo
    where  tr_persona = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107045
      /* 'Error en eliminacion de empleo'*/
      return 107045
    end

    delete cl_direccion
    where  di_ente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107007
      /* 'Error en eliminacion de direccion'*/
      return 107007
    end

    delete cl_telefono
    where  te_ente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107038
      /* 'Error en eliminacion de telefono'*/
      return 107038
    end

    delete cl_casilla
    where  cs_ente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107060
      /* 'Error en eliminacion de sucursal de correo'*/
      return 107060
    end

    delete cl_relacion_inter
    where  ri_ente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107070
      /* 'Error en eliminacion de relacion internacional de un cliente'*/
      return 107070
    end

    delete cl_contacto
    where  co_ente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107068
      /* 'Error en eliminacion de contacto'*/
      return 107068
    end

    delete cl_hijos
    where  hi_ente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107069
      /* 'Error en eliminacion de un hijo de l cliente'*/
      return 107069
    end

    delete cl_otros_ingresos
    where  oi_ente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101191
      --'No existen Otros Ingresos'
      return 101191
    end

    delete cl_balance
    where  ba_cliente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107066
      /* 'Error en eliminacion de cuentas de balances'*/
      return 107066
    end

    delete cl_plan
    where  pl_cliente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107065
      --'Error en eliminacion de cuentas de estados financieros'
      return 107065
    end

    delete cl_mercado_objetivo_cliente
    where  mo_ente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 100218
      --'NO EXISTE ASOCIACION ENTRE SUBTIPO DE MERCADO OBJETIVO, MERCADO OBJETIVO Y BANCA'
      return 100218
    end

    delete cl_alerta
    where  al_cliente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105115
      -- 'Error en Eliminacion de Alerta'
      return 105115
    end

    delete cl_log_fiscal
    where  lf_ente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101196
      --'No Existe tipo Regimen Fiscal'
      return 101196
    end

    delete cl_mercado
    where  me_codigo = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101130
      -- 'No existe mala referencia'
      return 101130
    end

    delete cl_origen_fondos
    where  of_ente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107000
      -- 'Error en Eliminacion de Origen de Fondos'
      return 105510
    end

    if @i_subtipo = 'P'
    begin
      insert into ts_persona
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,persona,nombre,
                   p_apellido,s_apellido,sexo,tipo_ced,cedula,
                   estado_civil,fecha_nac,fecha_emision,fecha_expira,lugar_doc,
                   comentario)
      values      (@s_ssn,@t_trn,'E',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@w_nombre,
                   @w_p_apellido,@w_s_apellido,@w_sexo,@w_tipo_ced,@w_cedula_ruc
                   ,
                   @w_estado_civil,@w_fecha_nac,
                   @w_fecha_crea,@w_fecha_mod,
                   @w_lugar_doc,
                   'Eliminacion de Prospecto')

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        --'Error en creacion de transaccion de servicio'
        return 103005
      end
    end

    if @i_subtipo = 'C'
    begin
      insert into ts_compania
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,compania,nombre,
                   ruc,oficina,tipo_nit,fecha_emision,comentario)
      values      (@s_ssn,@t_trn,'E',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@w_nombre,
                   @w_cedula_ruc,@w_oficina,@w_tipo_ced,@w_fecha_crea,
                   'Eliminacion de Prospecto')

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 153023
        /* 'Error en creacion de transaccion de servicio'*/
        return 153023
      end
    end

    commit tran
    return 0
  end
  else
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    /*  'No corresponde codigo de transaccion' */
    return 1
  end

go

