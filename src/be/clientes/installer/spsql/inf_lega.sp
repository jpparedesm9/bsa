/************************************************************************/
/*  Archivo:        inf_lega.sp                                         */
/*  Stored procedure:   sp_inf_legal                                    */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Carlos Rodriguez V.                                  */
/*  Fecha de documentacion: 06/Abr/1994                                 */
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
/*  Actualizacion de la informacion legal de la compania                */
/*      excepto el objeto social y los estatutos                        */
/*  Query de la informacion legal de la compania                        */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/* 95/03/29 Banco de Prestamos                                          */
/* 09/Ago/2004  E. Laguna           Tunning                             */
/* 04/Ene/2010  D. Gomez    Campos nuevos                               */
/* 04/May/2016  T. Baidal   Migracion a CEN                             */
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
           where  name = 'sp_inf_legal')
    drop proc sp_inf_legal
go

create proc sp_inf_legal
(
  @s_ssn                 int = null,
  @s_user                login = null,
  @s_term                varchar(30) = null,
  @s_date                datetime = null,
  @s_srv                 varchar(30) = null,
  @s_lsrv                varchar(30) = null,
  @s_ofi                 smallint = null,
  @s_rol                 smallint = null,
  @s_org_err             char(1) = null,
  @s_error               int = null,
  @s_sev                 tinyint = null,
  @s_msg                 descripcion = null,
  @s_org                 char(1) = null,
  @t_debug               char(1) = 'N',
  @t_file                varchar(10) = null,
  @t_from                varchar(32) = null,
  @t_trn                 smallint = null,
  @t_show_version        bit = 0,
  @i_operacion           char(1),
  @i_compania            int = null,
  @i_patrimonio_neto     money = null,
  @i_capital_social      money = null,
  @i_reserva_legal       money = null,
  @i_fecha_const         datetime = null,
  @i_nombre_completo     varchar(254) = null,
  @i_plazo               tinyint = null,
  @i_direccion_domicilio int = null,
  @i_fecha_inscrp        datetime = null,
  @i_fecha_aum_capital   datetime = null,
  @i_rep_legal           int = null,
  @i_cap_pagado          money = null,
  @i_escritura           int = null,
  @i_notaria             tinyint = null,
  @i_ciudad              int = null,
  @i_fecha_exp           datetime = null,
  @i_fecha_vcto          datetime = null,
  @i_camara              catalogo = null,
  @i_registro            int = null,
  @i_grado_soc           catalogo = null,
  @i_verificado          char(1) = null,
  @i_numsuc              int = null,
  @i_vigilada            catalogo = null,
  @i_resultado           catalogo = null
)
as
  declare
    @w_today               datetime,
    @w_sp_name             varchar(32),
    @w_return              int,
    @w_fecha_mod           datetime,
    @w_codigo              int,
    @w_rep_legal           int,
    @w_c_rep_legal         int,
    @w_patrimonio_neto     money,
    @w_capital_social      money,
    @w_reserva_legal       money,
    @w_fecha_const         datetime,
    @w_nombre_completo     varchar(254),
    @w_plazo               tinyint,
    @w_direccion_domicilio int,
    @w_fecha_inscrp        datetime,
    @w_fecha_aum_capital   datetime,
    @w_escritura           int,
    @w_notaria             tinyint,
    @w_ciudad              int,
    @w_fecha_exp           datetime,
    @w_fecha_vcto          datetime,
    @w_camara              catalogo,
    @w_registro            int,
    @w_grado_soc           catalogo,
    @w_verificado          char(1),
    @w_fecha_verif         datetime,
    @w_fecha_modif         datetime,
    @w_funcionario         login,
    @w_numsuc              int,
    @w_vigilada            catalogo,
    @v_patrimonio_neto     money,
    @v_capital_social      money,
    @v_reserva_legal       money,
    @v_fecha_const         datetime,
    @v_nombre_completo     varchar(254),
    @v_plazo               tinyint,
    @v_direccion_domicilio int,
    @v_fecha_inscrp        datetime,
    @v_fecha_aum_capital   datetime,
    @v_rep_legal           int,
    @v_escritura           int,
    @v_notaria             tinyint,
    @v_ciudad              int,
    @v_fecha_exp           datetime,
    @v_fecha_vcto          datetime,
    @v_camara              catalogo,
    @v_registro            int,
    @v_grado_soc           catalogo,
    @v_numsuc              int,
    @v_vigilada            catalogo,
    @o_patrimonio_neto     money,
    @o_capital_social      money,
    @o_reserva_legal       money,
    @o_fecha_const         datetime,
    @o_nombre_completo     varchar(254),
    @o_nombre_rep_leg      varchar(254),
    @o_rep_legal           int,
    @o_plazo               tinyint,
    @o_direccion_domicilio int,
    @o_fecha_inscrp        datetime,
    @o_fecha_aum_capital   datetime,
    @o_cap_pagado          money,
    @o_escritura           int,/* INCAM */
    @o_notaria             tinyint,
    @o_ciudad              int,
    @o_desc_ciudad         descripcion,
    @o_fecha_exp           datetime,
    @o_fecha_vcto          datetime,
    @o_camara              catalogo,
    @o_desc_camara         descripcion,
    @o_registro            int,
    @o_grado_soc           catalogo,
    @o_desc_grado          descripcion,
    @o_desc_domic          descripcion,
    @o_fecha_registro      datetime,
    @o_fecha_modif         datetime,
    @o_fecha_verif         datetime,
    @o_vigencia            catalogo,
    @o_resultado           catalogo,
    @o_verificado          char(1),
    @o_funcionario         login,
    @o_numsuc              int,
    @o_vigilada            catalogo,
    @o_desc_vigilada       descripcion,
    @w_cap_pagado          money,
    @v_cap_pagado          money

  select
    @w_sp_name = 'sp_inf_legal'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = @s_date

  /* *** Update *** */
  if @i_operacion = 'U'
  begin
    if @t_trn = 102
    begin
      /* Verificacion que existe ciudad  INCAM */
      if @i_ciudad is not null
      begin
        if not exists (select
                         1
                       from   cl_ciudad
                       where  ci_ciudad = @i_ciudad)
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101024
          /*'No existe esa ciudad '*/
          return 1
        end
      end

      /* Verificacion que existe ciudad  de domicilio INCAM */
      if @i_direccion_domicilio is not null
      begin
        if not exists (select
                         1
                       from   cl_ciudad
                       where  ci_ciudad = @i_direccion_domicilio)
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101024
          /*'No existe esa ciudad '*/
          return 1
        end
      end

      /* Verificacion que existe camara  INCAM */
      if @i_camara is not null
      begin
        select
          @w_codigo = null
        from   cl_catalogo
        where  tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_camara')
           and codigo = @i_camara
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101176
          /*'No existe esa camara de comercio'*/
          return 1
        end
      end

      /* Verificacion que existe grado de soc  INCAM */
      if @i_grado_soc is not null
      begin
        select
          @w_codigo = null
        from   cl_catalogo
        where  tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_grado_soc')
           and codigo = @i_grado_soc
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101177
          /*'No existe ese grado de sociedad'*/
          return 1
        end
      end

      /* capturar los datos grabados anteriormente */

      select
        @w_fecha_mod = en_fecha_mod,
        @w_patrimonio_neto = c_capital_social,
        @w_fecha_const = c_fecha_const,
        @w_nombre_completo = en_nomlar,
        @w_plazo = c_plazo,
        @w_direccion_domicilio = c_direccion_domicilio,
        @w_fecha_inscrp = c_fecha_inscrp,
        @w_fecha_aum_capital = c_fecha_aum_capital,
        @w_rep_legal = c_rep_legal,
        @w_escritura = c_escritura,
        @w_notaria = c_notaria,
        @w_ciudad = c_ciudad,
        @w_fecha_exp = c_fecha_exp,
        @w_fecha_vcto = c_fecha_vcto,
        @w_camara = c_camara,
        @w_registro = c_registro,
        @w_grado_soc = c_grado_soc,
        @w_cap_pagado = c_cap_pagado,
        @w_numsuc = c_plazo,
        @w_vigilada = c_posicion
      from   cl_ente
      where  en_ente    = @i_compania
         and en_subtipo = 'C'

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 151030
        /*'No existe compania'*/
        return 1
      end

      /* comprobar que las fechas indicadas sean consistentes */

      if (@i_fecha_const > @w_today)
          or (@i_fecha_inscrp > @w_today)
          or (@i_fecha_exp > @w_today)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101140
        /* 'Fechas inconsistentes '*/
        return 1
      end

      /* guardar solo los datos que han cambiado */
      select
        @v_patrimonio_neto = @w_patrimonio_neto,
        @v_fecha_const = @w_fecha_const,
        @v_nombre_completo = @w_nombre_completo,
        @v_plazo = @w_plazo,
        @v_direccion_domicilio = @w_direccion_domicilio,
        @v_fecha_inscrp = @w_fecha_inscrp,
        @v_rep_legal = @w_rep_legal,
        @v_escritura = @w_escritura,
        @v_notaria = @w_notaria,
        @v_ciudad = @w_ciudad,
        @v_fecha_exp = @w_fecha_exp,
        @v_fecha_vcto = @w_fecha_vcto,
        @v_camara = @w_camara,
        @v_registro = @w_registro,
        @v_grado_soc = @w_grado_soc,
        @v_fecha_aum_capital = @w_fecha_aum_capital,
        @v_cap_pagado = @w_cap_pagado,
        @v_numsuc = @w_numsuc,
        @v_vigilada = @w_vigilada

      if @w_rep_legal = @i_rep_legal
        select
          @w_rep_legal = null,
          @v_rep_legal = null
      else
        select
          @w_rep_legal = @i_rep_legal

      if @w_patrimonio_neto = @i_patrimonio_neto
        select
          @w_patrimonio_neto = null,
          @v_patrimonio_neto = null
      else
        select
          @w_patrimonio_neto = @i_patrimonio_neto

      if @w_fecha_const = @i_fecha_const
        select
          @w_fecha_const = null,
          @v_fecha_const = null
      else
        select
          @w_fecha_const = @i_fecha_const

      if @w_nombre_completo = @i_nombre_completo
        select
          @w_nombre_completo = null,
          @v_nombre_completo = null
      else
        select
          @w_nombre_completo = @i_nombre_completo

      if @w_plazo = @i_plazo
        select
          @w_plazo = null,
          @v_plazo = null
      else
        select
          @w_plazo = @i_plazo

      if @w_direccion_domicilio = @i_direccion_domicilio
        select
          @w_direccion_domicilio = null,
          @v_direccion_domicilio = null
      else
        select
          @w_direccion_domicilio = @i_direccion_domicilio

      if @w_fecha_inscrp = @i_fecha_inscrp
        select
          @w_fecha_inscrp = null,
          @v_fecha_inscrp = null
      else
        select
          @w_fecha_inscrp = @i_fecha_inscrp

      if @w_fecha_aum_capital = @i_fecha_aum_capital
        select
          @w_fecha_aum_capital = null,
          @v_fecha_aum_capital = null
      else
        select
          @w_fecha_aum_capital = @i_fecha_aum_capital

      if @w_escritura = @i_escritura
        select
          @w_escritura = null,
          @v_escritura = null
      else
        select
          @w_escritura = @i_escritura
      if @w_notaria = @i_notaria
        select
          @w_notaria = null,
          @v_notaria = null
      else
        select
          @w_notaria = @i_notaria
      if @w_ciudad = @i_ciudad
        select
          @w_ciudad = null,
          @v_ciudad = null
      else
        select
          @w_ciudad = @i_ciudad
      if @w_fecha_exp = @i_fecha_exp
        select
          @w_fecha_exp = null,
          @v_fecha_exp = null
      else
        select
          @w_fecha_exp = @i_fecha_exp
      if @w_fecha_vcto = @i_fecha_vcto
        select
          @w_fecha_vcto = null,
          @v_fecha_vcto = null
      else
        select
          @w_fecha_vcto = @i_fecha_vcto
      if @w_camara = @i_camara
        select
          @w_camara = null,
          @v_camara = null
      else
        select
          @w_camara = @i_camara
      if @w_registro = @i_registro
        select
          @w_registro = null,
          @v_registro = null
      else
        select
          @w_registro = @i_registro
      if @w_grado_soc = @i_grado_soc
        select
          @w_grado_soc = null,
          @v_grado_soc = null
      else
        select
          @w_grado_soc = @i_grado_soc
      if @w_cap_pagado = @i_cap_pagado
        select
          @w_cap_pagado = null,
          @v_cap_pagado = null
      else
        select
          @w_cap_pagado = @i_cap_pagado

      if @w_numsuc = @i_numsuc
        select
          @w_numsuc = null,
          @v_numsuc = null
      else
        select
          @w_grado_soc = @i_grado_soc

      if @w_vigilada = @i_vigilada
        select
          @w_vigilada = null,
          @v_vigilada = null
      else
        select
          @w_vigilada = @i_vigilada

      if @i_verificado = 'S'
        select
          @w_verificado = 'S',
          @w_fecha_verif = @w_today,
          @w_fecha_modif = @w_today,
          @w_funcionario = @s_user
      else
        select
          @w_verificado = 'N',
          @w_fecha_verif = @s_date,
          @w_fecha_modif = @s_date,
          @w_funcionario = ''

      begin tran
      update cl_ente
      set    en_fecha_mod = @w_today,
             c_fecha_modif = @w_fecha_modif,
             c_capital_social = @i_capital_social,
             c_reserva_legal = @i_reserva_legal,
             c_fecha_const = @i_fecha_const,
             en_nomlar = @i_nombre_completo,
             --No se una @i_plazo c_plazo      = @i_plazo,             --******** OJO PLAZO
             c_direccion_domicilio = @i_direccion_domicilio,
             c_fecha_inscrp = @i_fecha_inscrp,
             c_fecha_aum_capital = @i_fecha_aum_capital,
             c_rep_legal = @i_rep_legal,
             c_escritura = @i_escritura,
             c_notaria = @i_notaria,
             c_ciudad = @i_ciudad,
             c_fecha_exp = @i_fecha_exp,
             c_fecha_vcto = @i_fecha_vcto,
             c_camara = @i_camara,
             c_registro = @i_registro,
             c_grado_soc = @i_grado_soc,
             c_cap_pagado = @i_cap_pagado,
             c_verificado = @w_verificado,
             c_fecha_verif = @w_fecha_verif,
             c_fecha_registro = @s_date,
             c_vigencia = 'VIGENTE',
             c_funcionario = @w_funcionario,
             p_pasaporte = @i_resultado,
             c_plazo = @i_numsuc,
             c_posicion = @i_vigilada
      where  en_ente    = @i_compania
         and en_subtipo = 'C'

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105006
        /* 'Error en actualizacion de compania'*/
        return 1
      end

      /* transaccion de servicio - previo */
      insert into ts_compania
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,compania,capital_social,
                   fecha_const,nombre_completo,plazo,direccion_domicilio,
                   fecha_inscrp,
                   fecha_mod,fecha_aum_capital,escritura,notaria,ciudad,
                   fecha_exp,fecha_vcto,camara,registro,grado_soc,
                   numsuc,vigilada)
      values      (@s_ssn,@t_trn,'P',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_compania,@v_patrimonio_neto,
                   @v_fecha_const,@v_nombre_completo,@v_plazo,
                   @v_direccion_domicilio
                   ,
                   @v_fecha_inscrp,
                   @w_fecha_mod,@v_fecha_aum_capital,@v_escritura,@v_notaria,
                   @v_ciudad
                   ,
                   @v_fecha_exp,@v_fecha_vcto,@v_camara,@v_registro,
                   @v_grado_soc,
                   @v_numsuc,@v_vigilada )

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en la creacion de transaccion de servicio'*/
        return 1
      end

      /* transaccion de servicio - actual */
      insert into ts_compania
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,compania,capital_social,
                   fecha_const,nombre_completo,plazo,direccion_domicilio,
                   fecha_inscrp,
                   fecha_aum_capital,escritura,notaria,ciudad,fecha_exp,
                   fecha_vcto,camara,registro,grado_soc,numsuc,
                   vigilada)
      values      (@s_ssn,@t_trn,'A',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_compania,@w_patrimonio_neto,
                   @w_fecha_const,@w_nombre_completo,@w_plazo,
                   @w_direccion_domicilio
                   ,
                   @w_fecha_inscrp,
                   @w_fecha_aum_capital,@w_escritura,@w_notaria,@w_ciudad,
                   @w_fecha_exp
                   ,
                   @w_fecha_vcto,@w_camara,@w_registro,@w_grado_soc,
                   @w_numsuc,
                   @w_vigilada )

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en la creacion de transaccion de servicio'*/
        return 1
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

  end

/* Query */
  /* Consulta especifica de la informacion legal de una compania */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1185
    begin
      select
        @w_c_rep_legal = c_rep_legal
      from   cl_ente
      where  en_ente    = @i_compania
         and en_subtipo = 'C'

      if @w_c_rep_legal is null
      begin
        select
          @o_capital_social = c_capital_social,
          @o_reserva_legal = c_reserva_legal,
          @o_fecha_const = c_fecha_const,
          @o_nombre_completo = en_nomlar,
          @o_plazo = c_plazo,
          @o_direccion_domicilio = c_direccion_domicilio,
          @o_fecha_inscrp = c_fecha_inscrp,
          @o_fecha_aum_capital = c_fecha_aum_capital,
          @o_cap_pagado = c_cap_pagado,
          @o_escritura = c_escritura,
          @o_notaria = c_notaria,
          @o_ciudad = c_ciudad,
          @o_fecha_exp = c_fecha_exp,
          @o_fecha_vcto = c_fecha_vcto,
          @o_camara = c_camara,
          @o_registro = c_registro,
          @o_grado_soc = c_grado_soc,
          @o_rep_legal = c_rep_legal,
          @o_nombre_rep_leg = en_nomlar,
          @o_fecha_registro = c_fecha_registro,
          @o_fecha_modif = c_fecha_modif,
          @o_fecha_verif = c_fecha_verif,
          @o_vigencia = c_vigencia,
          @o_verificado = c_verificado,
          @o_funcionario = c_funcionario,
          @o_numsuc = c_plazo,
          @o_vigilada = c_posicion,
          @o_resultado = p_pasaporte --Cambio Req 0216

        from   cl_ente
        where  en_ente    = @i_compania
           and en_subtipo = 'C'

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151030
          /*'No existe compania'*/
          return 1
        end
      end
      if @w_c_rep_legal is not null
      begin
        select
          @o_capital_social = e0.c_capital_social,
          @o_reserva_legal = e0.c_reserva_legal,
          @o_fecha_const = e0.c_fecha_const,
          @o_nombre_completo = e0.en_nomlar,
          @o_plazo = e0.c_plazo,
          @o_direccion_domicilio = e0.c_direccion_domicilio,
          @o_fecha_inscrp = e0.c_fecha_inscrp,
          @o_fecha_aum_capital = e0.c_fecha_aum_capital,
          @o_cap_pagado = e0.c_cap_pagado,
          @o_escritura = e0.c_escritura,
          @o_notaria = e0.c_notaria,
          @o_ciudad = e0.c_ciudad,
          @o_fecha_exp = e0.c_fecha_exp,
          @o_fecha_vcto = e0.c_fecha_vcto,
          @o_camara = e0.c_camara,
          @o_registro = e0.c_registro,
          @o_grado_soc = e0.c_grado_soc,
          @o_rep_legal = e0.c_rep_legal,
          @o_nombre_rep_leg = e1.en_nombre,
          @o_fecha_registro = e0.c_fecha_registro,
          @o_fecha_modif = e0.c_fecha_modif,
          @o_fecha_verif = e0.c_fecha_verif,
          @o_vigencia = e0.c_vigencia,
          @o_verificado = e0.c_verificado,
          @o_funcionario = e0.c_funcionario,
          @o_resultado = e0.p_pasaporte,--Cambio Req 0216
          @o_numsuc = e1.c_plazo,
          @o_vigilada = e1.c_posicion
        from   cl_ente e0,
               cl_ente e1
        where  e0.en_ente     = @i_compania
           and e0.en_subtipo  = 'C'
           and e0.c_rep_legal = e1.en_ente
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151030

          /*'No existe compania'*/
          return 1
        end
      end

      /* Verificacion que existe ciudad domicilio  INCAM */
      if @o_direccion_domicilio is not null
      begin
        select
          @o_desc_domic = ci_descripcion
        from   cl_ciudad
        where  ci_ciudad = @o_direccion_domicilio
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101024
          /*'No existe esa ciudad '*/
          return 1
        end
      end
      /* Verificacion que existe ciudad  INCAM */
      if @o_ciudad is not null
      begin
        select
          @o_desc_ciudad = ci_descripcion
        from   cl_ciudad
        where  ci_ciudad = @o_ciudad
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101024
          /*'No existe esa ciudad '*/
          return 1
        end
      end
      /* Verificacion que existe camara  INCAM */
      if @o_camara is not null
      begin
        select
          @o_desc_camara = valor
        from   cl_catalogo
        where  tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_camara')
           and codigo = @o_camara
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101176
          /*'No existe esa camara de comercio'*/
          return 1
        end
      end
      /* Verificacion que existe grado de soc  INCAM */
      if @o_grado_soc is not null
      begin
        select
          @o_desc_grado = valor
        from   cl_catalogo
        where  tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_grado_soc')
           and codigo = @o_grado_soc
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101177
          /*'No existe ese grado de sociedad'*/
          return 1
        end
      end

      /* Verificacion que existe inf vigilado por*/
      if @o_vigilada is not null
      begin
        select
          @o_desc_vigilada = valor
        from   cl_catalogo
        where  tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_entes_control')
           and codigo = @o_vigilada
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101177
          /*'No existe vigilado por '*/
          return 1
        end
      end

      select
        @o_capital_social,
        @o_reserva_legal,
        convert(char(10), @o_fecha_const, 101),
        @o_nombre_completo,
        @o_plazo,
        @o_direccion_domicilio,
        convert(char(10), @o_fecha_inscrp, 101),
        convert(char(10), @o_fecha_aum_capital, 101),
        @o_cap_pagado,
        @o_rep_legal,
        @o_nombre_rep_leg,
        @o_escritura,
        @o_notaria,
        @o_ciudad,
        @o_desc_ciudad,
        convert(char(10), @o_fecha_exp, 101),
        convert(char(10), @o_fecha_vcto, 101),
        @o_camara,
        @o_desc_camara,
        @o_registro,
        @o_grado_soc,
        @o_desc_grado,
        @o_desc_domic,
        convert(char(10), @o_fecha_registro, 101),
        convert(char(10), @o_fecha_modif, 101),
        convert(char(10), @o_fecha_verif, 101),
        @o_vigencia,
        @o_verificado,
        @o_funcionario,
        @o_numsuc,
        @o_vigilada,
        @o_resultado,
        @o_desc_vigilada

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

  end

go

