/************************************************************************/
/*  Archivo:        propied.sp                                          */
/*  Stored procedure:   sp_propiedad                                    */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 07-Nov-1992                                     */
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
/*  Este programa procesa las transacciones del stored procedure         */
/*  Insercion de propiedad                                              */
/*  Actualizacion de propiedad                                          */
/*      Borrado de propiedad                                            */
/*  Busqueda de propiedad                                               */
/*      Query de propiedad por ente                                     */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  07/Nov/92   M. Davila   Emision Inicial                             */
/*  20/Jul/99   J. Loyo      Se coloco un campo de ciudad del inmueble  */
/*  15/May/03   E. Laguna    Se quita validacion vigencia operacion S   */
/*  21-Feb-06   Silvia Portilla  Mallas. Captura de datos               */
/*  26-Dic-09   D. Gomez     Aumento de campos              */
/*  05-Abr-2010 Raul Altamirano Control de vigencia de datos del Ente   */
/*  05/May/2016 T. Baidal    Migracion a CEN                            */
/************************************************************************/
use cobis
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_propiedad')
    drop proc sp_propiedad
go

create proc sp_propiedad
(
  @s_ssn             int = null,
  @s_user            login = null,
  @s_term            varchar(30) = null,
  @s_date            datetime = null,
  @s_srv             varchar(30) = null,
  @s_lsrv            varchar(30) = null,
  @s_ofi             smallint = null,
  @t_debug           char(1) = 'N',
  @t_file            varchar(10) = null,
  @t_from            varchar(32) = null,
  @t_trn             smallint = null,
  @t_show_version    bit = 0,
  @i_operacion       char(1),
  @i_ente            int = null,
  @i_propiedad       tinyint = null,
  @i_descripcion     varchar(255) = null,
  @i_verificado      char(1) = 'N',
  @i_moneda          tinyint = null,
  @i_valor           money = null,
  @i_tbien           char(3) = null,
  @i_tgarantia       char(3) = null,
  @i_fecha_avaluo    datetime = null,
  @i_fecha_ver       datetime = null,
  @i_gravada         money = null,
  @i_nom_aval        char(30) = null,
  @i_val_aval        money = null,
  @i_ciudad_inm      int = null,
  @i_ciudad_bien     int = null,
  @i_notaria         tinyint = null,
  @i_matricula       char(16) = null,
  @i_escritura       int = null,
  @i_fecha_escritura datetime = null,
  @i_gravamen_afavor char(30) = null,
  @i_tipo_veh        varchar(30) = null,
  @i_placa           varchar(10) = null,
  @i_modelo          varchar(30) = null,
  @i_marca           varchar(30) = null,
  @i_direccion_im    varchar(254) = null,
  @i_area            float = null,
  @i_resultado       catalogo = null,
  @i_porc_partic     float = null,--- Porcentaje de Participacion
  @i_saldo_deuda     money = null,--- Saldo Deuda
  @i_dpto_inm        varchar(10) = null,--- Departamento inmueble
  @i_dpto_not        varchar(10) = null,--- Departamento notaria
  @i_afect_familiar  char(1) = null
)
as
  declare
    @w_sp_name            varchar(32),
    @w_codigo             int,
    @w_descripcion        varchar(255),
    @w_tbien              char(3),
    @w_tgarantia          char(3),
    @w_fecha_registro     datetime,
    @w_fecha_modificacion datetime,
    @w_fecha_avaluo       datetime,
    @w_verificado         char(1),
    @w_moneda             tinyint,
    @w_valor              money,
    @w_gravada            money,
    @w_nom_aval           char(30),
    @w_val_aval           money,
    @w_ciudad_bien        int,
    @w_notaria            tinyint,
    @w_matricula          char(16),
    @w_escritura          int,
    @w_fecha_escritura    datetime,
    @w_gravamen_afavor    char(16),
    @w_fecha_nac          datetime,
    @w_tipo               char(1),
    @w_porc_partic        float,--- Porcentaje de Participacion
    @w_saldo_deuda        money,--- Saldo Deuda
    @w_dpto_inm           varchar(10),--- Departamento inmueble
    @w_dpto_not           varchar(10),--- Departamento notaria
    @w_afect_familiar     char(1),
    @w_resultado          catalogo,
    @v_descripcion        varchar(255),
    @v_tbien              char(3),
    @v_tgarantia          char(3),
    @v_fecha_registro     datetime,
    @v_fecha_modificacion datetime,
    @v_fecha_avaluo       datetime,
    @v_verificado         char(1),
    @v_moneda             tinyint,
    @v_valor              money,
    @v_gravada            money,
    @v_nom_aval           char(30),
    @v_val_aval           money,
    @v_ciudad_bien        int,
    @v_notaria            tinyint,
    @v_matricula          char(16),
    @v_escritura          int,
    @v_fecha_escritura    datetime,
    @v_gravamen_afavor    char(30),
    @v_porc_partic        float,--- Porcentaje de Participacion
    @v_saldo_deuda        money,--- Saldo Deuda
    @v_dpto_inm           varchar(10),--- Departamento inmueble
    @v_dpto_not           varchar(10),--- Departamento notaria
    @v_afect_familiar     char(1),
    @v_resultado          catalogo,
    @o_persona            int,
    @o_ennombre           descripcion,
    @o_cedula             numero,
    @o_propiedad          tinyint,
    @o_descripcion        varchar(255),
    @o_vigencia           char(1),
    @o_fecha_ver          datetime,
    @o_fecha_registro     datetime,
    @o_fecha_modificacion datetime,
    @o_fecha_avaluo       datetime,
    @o_verificado         char(1),
    @o_moneda             tinyint,
    @o_moneda_des         descripcion,
    @o_valor              money,
    @o_tbien              char(3),
    @o_tbien_des          char(32),
    @w_return             int,
    @o_siguiente          tinyint,
    @o_funcionario        login,
    @o_gravada            money,
    @o_nom_aval           char(30),
    @o_ciudad_bien        int,
    @o_desc_ciudad        descripcion,
    @o_notaria            tinyint,
    @o_matricula          char(16),
    @o_escritura          int,
    @o_fecha_escritura    datetime,
    @o_gravamen_afavor    char(30),
    @o_val_aval           money,
    @w_ciudad_inm         int,
    @v_ciudad_inm         int,
    @o_ciudad_inm         int,
    @o_des_ciudad_inm     descripcion,
    @o_tipo_veh           varchar(30),
    @o_placa              varchar(10),
    @o_modelo             varchar(30),
    @o_marca              varchar(30),
    @o_direccion_im       varchar(254),
    @o_area               float,
    @o_porc_partic        float,--- Porcentaje de Participacion
    @o_saldo_deuda        money,--- Saldo Deuda
    @o_dpto_inm           varchar(10),--- Departamento inmueble
    @o_dpto_not           varchar(10),--- Departamento notaria
    @o_afect_familiar     char(1),
    @w_error              int,
    @w_vigencia           catalogo,
    --ream 05.abr.2010 control vigencia de datos del ente
    @v_vigencia           catalogo
  --ream 05.abr.2010 control vigencia de datos del ente

  select
    @w_sp_name = 'sp_propiedad'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /** Insert **/

  if @i_operacion = 'I'
  begin
    if @t_trn = 113
    begin
      select
        @w_fecha_nac = case en_subtipo
                         when 'C' then c_fecha_const
                         else p_fecha_nac
                       end,
        @w_tipo = en_subtipo
      from   cl_ente
      where  en_ente = @i_ente

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101042
        /*'No existe ente'*/
        return 1
      end

      /* verificar que exista el tipo de bien */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_tbien',
        @i_operacion = 'E',
        @i_codigo    = @i_tbien

      /* si no existe error */
      if @w_return <> 0
      begin
        /*  No existe dato en catalogo  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101000
        return 1
      end

    /* Nota: no se verifica que exista el tipo de garantia  pues
       este dato se modifica luego en el registro ingresado */
      /* Se verifica que exista la moneda indicada  */

      if not exists (select
                       1
                     from   cl_moneda
                     where  mo_moneda = @i_moneda
                        and mo_estado = 'V')
      begin
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101045
        /* No existe la moneda indicada */
        return 1
      end

      /* se valida el parametro verificado*/
      if @i_verificado <> 'S'
         and @i_verificado <> 'N'
      begin
        /*  Parametro no valido*/
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101114
        return 1
      end

      if datediff(yy,
                  @w_fecha_nac,
                  @i_fecha_avaluo) <= 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107076
        return 1
      end

      /* Verificar que la fecha de escritura, cuando se trata de un bien
         inmueble,  no sea menor que la fecha de constitucion de la empresa.
         M. Silva.  30/03/1998.  Bco. del Estado */

      if @i_tbien = 'I'
      begin
        if (datediff(yy,
                     @w_fecha_nac,
                     @i_fecha_escritura) <= 0)
           and (@w_tipo = 'C')
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107095
          return 1
        end
        /** Ciudad del inmueble para Corfinsura **/
        if @i_ciudad_inm is not null
        begin
          if not exists (select
                           1
                         from   cl_ciudad
                         where  ci_ciudad = @i_ciudad_inm)
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101024
            /* No existe Ciudad */
            return 1
          end
        end
      end

      begin tran
      update cl_ente
      set    p_propiedad = isnull(p_propiedad, 0) + 1
      where  en_ente = @i_ente
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103039
        /* 'Error en creacion de propiedad'*/
        return 1
      end

      select
        @o_siguiente = p_propiedad
      from   cl_ente
      where  en_ente = @i_ente

      /* Insercion cl_propiedad */

      insert into cl_propiedad
                  (pr_persona,pr_propiedad,pr_descripcion,pr_fecha_registro,
                   pr_fecha_modificacion,
                   pr_verificado,pr_vigencia,pr_moneda,pr_valor,pr_tgarantia,
                   pr_tbien,pr_fec_avaluo,pr_gravada,pr_nom_aval,pr_ciudad,
                   pr_notaria,pr_matricula,pr_escritura,pr_fecha_escritura,
                   pr_gravamen_afavor,
                   pr_val_aval,pr_funcionario,pr_ciudad_inmueble,pr_tipo_veh,
                   pr_placa,
                   pr_modelo,pr_marca,pr_direccion_im,pr_area,pr_porcentaje,
                   pr_saldo_deuda,pr_dpto_inm,pr_dpto_not,pr_afect_familiar)
      values      (@i_ente,@o_siguiente,@i_descripcion,getdate(),getdate(),
                   'N','S',@i_moneda,@i_valor,null,
                   @i_tbien,@i_fecha_avaluo,@i_gravada,@i_nom_aval,
                   @i_ciudad_bien,
                   @i_notaria,@i_matricula,@i_escritura,@i_fecha_escritura,
                   @i_gravamen_afavor,
                   @i_val_aval,@s_user,@i_ciudad_inm,@i_tipo_veh,@i_placa,
                   @i_modelo,@i_marca,@i_direccion_im,@i_area,@i_porc_partic,
                   @i_saldo_deuda,@i_dpto_inm,@i_dpto_not,@i_afect_familiar )
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103039
        /* 'Error en creacion de propiedad'*/
        return 1
      end

      /* Transaccion servicio - cl_propiedad */
      insert into ts_propiedad
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,persona,propiedad,
                   descripcion,verificado,moneda,valor,tbien,
                   tgarantia,fecha_avaluo,gravada,nom_aval,ciudad_bien,
                   notaria,matricula,escritura,fecha_escritura,gravamen_afavor,
                   val_aval,ciudad_inm,porcentaje,saldo_deuda,dpto_inm,
                   dpto_not,afect_familiar,vigencia
      --ream 05.abr.2010 control vigencia de datos del ente

      )
      values      (@s_ssn,@t_trn,'N',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_propiedad,
                   @i_descripcion,'N',@i_moneda,convert(varchar(32), @v_valor),
                   @i_tbien,
                   null,@i_fecha_avaluo,@i_gravada,@i_nom_aval,@i_ciudad_bien,
                   @i_notaria,@i_matricula,@i_escritura,@i_fecha_escritura,
                   @i_gravamen_afavor,
                   @i_val_aval,@i_ciudad_inm,convert(varchar(10), @i_porc_partic
                   ),
                   @i_saldo_deuda,@i_dpto_inm,
                   @i_dpto_not,@i_afect_familiar,'S'
      --ream 05.abr.2010 control vigencia de datos del ente

      )
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /*'Error en creacion de transaccion de servicio'*/
        return 1
      end

      commit tran
      select
        @o_siguiente
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

  /** Update **/

  if @i_operacion = 'U'
  begin
    if @t_trn = 114
        or @t_trn = 1353
    begin
      /* verificar que exista el tipo de bien */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_tbien',
        @i_operacion = 'E',
        @i_codigo    = @i_tbien

      /* si no existe error */
      if @w_return <> 0
      begin
        /*  No existe dato en catalogo  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101000
        return 1
      end

      /*Si se ingresa el parametro verificar que exista el tipo de garantia */
      if @i_tgarantia is not null
      begin
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_tgarantia',
          @i_operacion = 'E',
          @i_codigo    = @i_tgarantia

        /* si no existe error */
        if @w_return <> 0
        begin
          /*  No existe dato en catalogo  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 101000
          return 1
        end
      end

      /* Se verifica la existencia de la moneda indicada */

      if not exists (select
                       1
                     from   cl_moneda
                     where  mo_moneda = @i_moneda
                        and mo_estado = 'V')
      begin
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101045 /* No existe la moneda indicada */
        return 1
      end

      /* se valida el parametro verificado*/
      if @i_verificado <> 'S'
         and @i_verificado <> 'N'
      begin
        /*  Parametro no valido*/
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101114
        return 1
      end

      /** Ciudad del inmueble para Corfinsura **/
      if @i_ciudad_inm is not null
      begin
        if not exists (select
                         1
                       from   cl_ciudad
                       where  ci_ciudad = @i_ciudad_inm)
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101024
          /* No existe Ciudad */
          return 1
        end
      end
      /* Verificar que la fecha de avaluo no sea menor que la fecha de nacimiento. */

      select
        @w_fecha_nac = case en_subtipo
                         when 'C' then c_fecha_const
                         else p_fecha_nac
                       end,
        @w_tipo = en_subtipo
      from   cl_ente
      where  en_ente = @i_ente

      if datediff(yy,
                  @w_fecha_nac,
                  @i_fecha_avaluo) <= 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107076
        return 1
      end

      /* Verificar que la fecha de escritura, cuando se trata de un bien inmueble,
         no sea menor que la fecha de nacimiento del cliente. */

      if @i_tbien = 'I'
      begin
        if datediff(yy,
                    @w_fecha_nac,
                    @i_fecha_escritura) <= 0
        begin
          if @w_tipo = 'C'
            select
              @w_error = 107095
          else
            select
              @w_error = 107077
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = @w_error
          return 1
        end
      end

      /* Control de registros a actualizar */
      select
        @w_descripcion = pr_descripcion,
        @w_verificado = pr_verificado,
        @w_fecha_modificacion = pr_fecha_modificacion,
        @w_moneda = pr_moneda,
        @w_valor = pr_valor,
        @w_tbien = pr_tbien,
        @w_tgarantia = pr_tgarantia,
        @w_fecha_avaluo = pr_fec_avaluo,
        @w_gravada = pr_gravada,
        @w_nom_aval = pr_nom_aval,
        @w_ciudad_bien = pr_ciudad,
        @w_notaria = pr_notaria,
        @w_matricula = pr_matricula,
        @w_escritura = pr_escritura,
        @w_fecha_escritura = pr_fecha_escritura,
        @w_gravamen_afavor = pr_gravamen_afavor,
        @w_val_aval = pr_val_aval,
        @w_ciudad_inm = pr_ciudad_inmueble,
        @w_porc_partic = pr_porcentaje,
        @w_saldo_deuda = pr_saldo_deuda,
        @w_dpto_inm = pr_dpto_inm,
        @w_dpto_not = pr_dpto_not,
        @w_afect_familiar = pr_afect_familiar,
        @w_resultado = pr_obs_verificado,
        @w_vigencia = pr_vigencia
      --ream 05.abr.2010 control vigencia de datos del ente

      from   cl_propiedad
      where  pr_persona   = @i_ente
         and pr_propiedad = @i_propiedad

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105036
        /* 'Error en actualizacion de propiedad'*/
        return 1
      end

      select
        @v_descripcion = @w_descripcion,
        @v_verificado = @w_verificado,
        @v_fecha_modificacion = @w_fecha_modificacion,
        @v_moneda = @w_moneda,
        @v_valor = @w_valor,
        @v_tbien = @w_tbien,
        @v_tgarantia = @w_tgarantia,
        @v_fecha_avaluo = @w_fecha_avaluo,
        @v_gravada = @w_gravada,
        @v_nom_aval = @w_nom_aval,
        @v_ciudad_bien = @w_ciudad_bien,
        @v_notaria = @w_notaria,
        @v_matricula = @w_matricula,
        @v_escritura = @w_escritura,
        @v_fecha_escritura = @w_fecha_escritura,
        @v_gravamen_afavor = @w_gravamen_afavor,
        @v_val_aval = @w_val_aval,
        @v_ciudad_inm = @w_ciudad_inm,
        @v_porc_partic = @w_porc_partic,
        @v_saldo_deuda = @w_saldo_deuda,
        @v_dpto_inm = @w_dpto_inm,
        @v_dpto_not = @w_dpto_not,
        @v_afect_familiar = @w_afect_familiar,
        @v_resultado = @w_resultado,
        @v_vigencia = @w_vigencia
      --ream 05.abr.2010 control vigencia de datos del ente

      if @w_descripcion = @i_descripcion
        select
          @w_descripcion = null,
          @v_descripcion = null
      else
        select
          @w_descripcion = @i_descripcion

      if @w_moneda = @i_moneda
        select
          @w_moneda = null,
          @v_moneda = null
      else
        select
          @w_moneda = @i_moneda

      if @w_verificado = @i_verificado
        select
          @w_verificado = null,
          @v_verificado = null
      else
        select
          @w_verificado = @i_verificado

      if @w_valor = @i_valor
        select
          @w_valor = null,
          @v_valor = null
      else
        select
          @w_valor = @i_valor

      if @w_tbien = @i_tbien
        select
          @w_tbien = null,
          @v_tbien = null
      else
        select
          @w_tbien = @i_tbien

      if @w_tgarantia = @i_tgarantia
        select
          @w_tgarantia = null,
          @v_tgarantia = null
      else
        select
          @w_tgarantia = @i_tgarantia

      if @w_fecha_avaluo = @i_fecha_avaluo
        select
          @w_fecha_avaluo = null,
          @v_fecha_avaluo = null
      else
        select
          @w_fecha_avaluo = @i_fecha_avaluo

      if @w_gravada = @i_gravada
        select
          @w_gravada = null,
          @v_gravada = null
      else
        select
          @w_gravada = @i_gravada
      if @w_ciudad_bien = @i_ciudad_bien
        select
          @w_ciudad_bien = null,
          @v_ciudad_bien = null
      else
        select
          @w_ciudad_bien = @i_ciudad_bien
      if @w_notaria = @i_notaria
        select
          @w_notaria = null,
          @v_notaria = null
      else
        select
          @w_notaria = @i_notaria
      if @w_matricula = @i_matricula
        select
          @w_matricula = null,
          @v_matricula = null
      else
        select
          @w_matricula = @i_matricula
      if @w_escritura = @i_escritura
        select
          @w_escritura = null,
          @v_escritura = null
      else
        select
          @w_escritura = @i_escritura
      if @w_fecha_escritura = @i_fecha_escritura
        select
          @w_fecha_escritura = null,
          @v_fecha_escritura = null
      else
        select
          @w_fecha_escritura = @i_fecha_escritura
      if @w_gravamen_afavor = @i_gravamen_afavor
        select
          @w_gravamen_afavor = null,
          @v_gravamen_afavor = null
      else
        select
          @w_gravamen_afavor = @i_gravamen_afavor

      if @w_ciudad_inm = @i_ciudad_inm
        select
          @w_ciudad_inm = null,
          @v_ciudad_inm = null
      else
        select
          @w_ciudad_inm = @i_ciudad_inm

      if @w_porc_partic = @i_porc_partic
        select
          @w_porc_partic = null,
          @v_porc_partic = null
      else
        select
          @w_porc_partic = @i_porc_partic

      if @w_saldo_deuda = @i_saldo_deuda
        select
          @w_saldo_deuda = null,
          @v_saldo_deuda = null
      else
        select
          @w_saldo_deuda = @i_saldo_deuda

      if @w_dpto_inm = @i_dpto_inm
        select
          @w_dpto_inm = null,
          @v_dpto_inm = null
      else
        select
          @w_dpto_inm = @i_dpto_inm

      if @w_dpto_not = @i_dpto_not
        select
          @w_dpto_not = null,
          @v_dpto_not = null
      else
        select
          @w_dpto_not = @i_dpto_not

      if @w_afect_familiar = @i_afect_familiar
        select
          @w_afect_familiar = null,
          @v_afect_familiar = null
      else
        select
          @w_afect_familiar = @i_afect_familiar

      if @w_resultado = @i_resultado
        select
          @w_resultado = null,
          @v_resultado = null
      else
        select
          @w_resultado = @i_resultado

      select
        @w_vigencia = null,
        @v_vigencia = null --ream 05.abr.2010 control vigencia de datos del ente

      begin tran
      update cl_propiedad
      set    pr_descripcion = @i_descripcion,
             pr_verificado = 'N',
             pr_vigencia = isnull(@w_vigencia,
                                  pr_vigencia),
             --ream 05.abr.2010 control vigencia de datos del ente
             pr_fecha_modificacion = getdate(),
             pr_moneda = @i_moneda,
             pr_valor = @i_valor,
             pr_tbien = @i_tbien,
             pr_tgarantia = @i_tgarantia,
             pr_fec_avaluo = @i_fecha_avaluo,
             pr_fecha_ver = @i_fecha_ver,
             pr_gravada = @i_gravada,
             pr_nom_aval = @i_nom_aval,
             pr_ciudad = @i_ciudad_bien,
             pr_notaria = @i_notaria,
             pr_matricula = @i_matricula,
             pr_escritura = @i_escritura,
             pr_fecha_escritura = @i_fecha_escritura,
             pr_gravamen_afavor = @i_gravamen_afavor,
             pr_val_aval = @i_val_aval,
             pr_funcionario = @s_user,
             pr_ciudad_inmueble = @i_ciudad_inm,
             pr_tipo_veh = @i_tipo_veh,--Mallas 223
             pr_placa = @i_placa,
             pr_modelo = @i_modelo,
             pr_marca = @i_marca,
             pr_direccion_im = @i_direccion_im,
             pr_area = @i_area,--Mallas 223
             pr_porcentaje = @i_porc_partic,
             pr_saldo_deuda = @i_saldo_deuda,
             pr_dpto_inm = @i_dpto_inm,
             pr_dpto_not = @i_dpto_not,
             pr_afect_familiar = @i_afect_familiar,
             pr_obs_verificado = @i_resultado
      where  pr_persona   = @i_ente
         and pr_propiedad = @i_propiedad
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105036
        /* 'Error en actualizacion de propiedad'*/
        return
      end

      if @i_verificado = 'S'
      begin
        update cl_propiedad
        set    pr_verificado = @i_verificado,
               pr_funcionario = @s_user
        where  pr_persona   = @i_ente
           and pr_propiedad = @i_propiedad
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105036
          return
        end
      end

      /* Transaccion servicio - cl_propiedad */
      insert into ts_propiedad
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,persona,propiedad,
                   descripcion,verificado,moneda,valor,tbien,
                   tgarantia,fecha_avaluo,gravada,nom_aval,ciudad_bien,/*IN*/
                   notaria,/*IN*/matricula,/*IN*/escritura,/*IN*/fecha_escritura
                   ,
                   /*IN*/gravamen_afavor,/*IN*/
                   val_aval,ciudad_inm,porcentaje,saldo_deuda,dpto_inm,
                   dpto_not,afect_familiar,vigencia
      --ream 05.abr.2010 control vigencia de datos del ente

      )
      values      (@s_ssn,@t_trn,'P',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_propiedad,
                   @v_descripcion,@v_verificado,@v_moneda,
                   convert(varchar(32), @v_valor),@v_tbien,
                   @v_tgarantia,@v_fecha_avaluo,@v_gravada,@v_nom_aval,
                   @v_ciudad_bien,
                   /*IN*/
                   @v_notaria,/*IN*/@v_matricula,/*IN*/@v_escritura,/*IN*/
                   @v_fecha_escritura,/*IN*/@v_gravamen_afavor,/*IN*/
                   @v_val_aval,@v_ciudad_inm,convert(varchar(10), @v_porc_partic
                   ),
                   @v_saldo_deuda,@v_dpto_inm,
                   @v_dpto_not,@v_afect_familiar,@v_vigencia
      --ream 05.abr.2010 control vigencia de datos del ente
      )

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicio'*/
        return 1
      end

      insert into ts_propiedad
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,persona,propiedad,
                   descripcion,verificado,moneda,valor,tbien,
                   tgarantia,fecha_avaluo,gravada,nom_aval,ciudad_bien,/*IN*/
                   notaria,/*IN*/matricula,/*IN*/escritura,/*IN*/fecha_escritura
                   ,
                   /*IN*/gravamen_afavor,/*IN*/
                   val_aval,ciudad_inm,porcentaje,saldo_deuda,dpto_inm,
                   dpto_not,afect_familiar,vigencia
      --ream 05.abr.2010 control vigencia de datos del ente
      )
      values      (@s_ssn,@t_trn,'A',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_propiedad,
                   @w_descripcion,@w_verificado,@w_moneda,
                   convert(varchar(32), @w_valor),@w_tbien,
                   @w_tgarantia,@w_fecha_avaluo,@w_gravada,@w_nom_aval,
                   @w_ciudad_bien,
                   /*IN*/
                   @w_notaria,/*IN*/@w_matricula,/*IN*/@w_escritura,/*IN*/
                   @w_fecha_escritura,/*IN*/@w_gravamen_afavor,/*IN*/
                   @w_val_aval,@w_ciudad_inm,convert(varchar(10), @w_porc_partic
                   ),
                   @w_saldo_deuda,@w_dpto_inm,
                   @w_dpto_not,@w_afect_familiar,@w_vigencia
      --ream 05.abr.2010 control vigencia de datos del ente
      )

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicio'*/
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

  /** Search **/

  if @i_operacion = 'S'
  begin
    if @t_trn = 134
    begin
      select
        'No. PROPIEDAD' = pr_propiedad,
        'TIPO DE BIEN' = pr_tbien,/*CM*/
        'DESCRIPCION' = substring(valor,
                                  1,
                                  25),/*CM*/
        'VALOR COMERCIAL' = pr_valor,/*CM*/
        'MONEDA' = pr_moneda,
        'DESC.MONEDA' = substring(mo_descripcion,
                                  1,
                                  20),
        'ECHA AVALUO' =convert(char(10), pr_fec_avaluo, 101),/*CM*/
        'VERIF.' = pr_verificado,
        'VIGENTE' = pr_vigencia,
        'NOTARIA' = pr_notaria,/*IN*/
        'MATRICULA' = pr_matricula,/*IN*/
        'ESCRITURA' = pr_escritura,/*IN*/
        'FECHA ESCRITURA' = convert(char(10), pr_fecha_escritura, 101),/*IN*/
        'CIUDAD DEL BIEN' = pr_ciudad,/*IN*/
        'DESC. CIUDAD' = ci_descripcion,/*IN*/
        'GRAVAMEN A FAVOR ' = pr_gravamen_afavor,/*IN*/
        'VALOR GRAVAMEN' = pr_gravada,
        'CIUDAD INMUEBLE' = pr_ciudad_inmueble,/*CM*/
        'DESCRIPCION DEL BIEN' = pr_descripcion,
        'TIPO VEHICULO' = pr_tipo_veh,--Mallas 223
        'PLACA' = pr_placa,
        'MODELO' = pr_modelo,
        'MARCA' = pr_marca,
        'DIRECCION' = pr_direccion_im,
        'AREA TOTAL' = pr_area,
        /*  'PERITO AVALUADOR'  = pr_nom_aval,   CM
            'VALOR AVALUO' =     pr_val_aval**Se ocultaron */

        'PORCENTAJE' = pr_porcentaje,
        'SALDO DEUDA' = pr_saldo_deuda,
        'DPTO INM' = pr_dpto_inm,
        'DPTO NOT' = pr_dpto_not,
        'AFECT FAMILIAR' = pr_afect_familiar,
        'OBS VERIFICADO' = pr_obs_verificado
      from   cl_propiedad
             left outer join cl_ciudad
                          on pr_ciudad = ci_ciudad
             inner join cl_moneda
                     on pr_moneda = mo_moneda
             inner join cobis..cl_catalogo
                     on pr_tbien = codigo
      where  pr_persona = @i_ente
         and tabla      = (select
                             codigo
                           from   cobis..cl_tabla
                           where  tabla = 'cl_tbien')

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

  /** Query **/

  if @i_operacion = 'Q'
  begin
    if @t_trn = 135
    begin
      select
        @o_persona = pr_persona,
        @o_ennombre = rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) + ' ' +
                      rtrim(
                      en_nombre),
        @o_cedula = en_ced_ruc,
        @o_propiedad = pr_propiedad,
        @o_descripcion = pr_descripcion,
        @o_moneda = pr_moneda,
        @o_moneda_des = mo_descripcion,
        @o_valor = pr_valor,
        @o_tbien = pr_tbien,
        @o_tbien_des = valor,
        @o_vigencia = pr_vigencia,
        @o_verificado = pr_verificado,
        @o_fecha_registro = pr_fecha_registro,
        @o_fecha_modificacion = pr_fecha_modificacion,
        @o_fecha_avaluo = pr_fec_avaluo,
        @o_funcionario = pr_funcionario,
        @o_fecha_ver = pr_fecha_ver,
        @o_ciudad_bien = pr_ciudad,/*IN*/
        @o_desc_ciudad = ciu1.ci_descripcion,/*IN*/
        @o_notaria = pr_notaria,/*IN*/
        @o_matricula = pr_matricula,/*IN*/
        @o_escritura = pr_escritura,/*IN*/
        @o_fecha_escritura = pr_fecha_escritura,/*IN*/
        @o_gravamen_afavor = pr_gravamen_afavor,/*IN*/
        @o_gravada = pr_gravada,
        @o_ciudad_inm = pr_ciudad_inmueble,
        @o_des_ciudad_inm = ciu2.ci_descripcion,
        @o_tipo_veh = pr_tipo_veh,--Mallas 223
        @o_placa = pr_placa,
        @o_modelo = pr_modelo,
        @o_marca = pr_marca,
        @o_direccion_im = pr_direccion_im,
        @o_area = pr_area,--Mallas 223
        /****           @o_nom_aval = pr_nom_aval,
                    @o_val_aval = pr_val_aval    ***Se ocultaron **/

        @o_porc_partic = pr_porcentaje,
        @o_saldo_deuda = pr_saldo_deuda,
        @o_dpto_inm = pr_dpto_inm,
        @o_dpto_not = pr_dpto_not,
        @o_afect_familiar = pr_afect_familiar
      from   cobis..cl_propiedad
             left outer join cl_ciudad ciu1
                          on pr_ciudad = ciu1.ci_ciudad
             left outer join cobis..cl_ciudad ciu2
                          on pr_ciudad_inmueble = ciu2.ci_ciudad
             inner join cobis..cl_ente
                     on en_ente = pr_persona
             inner join cobis..cl_catalogo
                     on pr_tbien = cl_catalogo.codigo
             inner join cobis.. cl_tabla
                     on cl_tabla.tabla = 'cl_tbien'
                        and cl_tabla.codigo = cl_catalogo.tabla
             inner join cobis..cl_moneda
                     on pr_moneda = mo_moneda
      where  pr_persona   = @i_ente
         and pr_propiedad = @i_propiedad

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end

      select
        @o_propiedad,
        @o_descripcion,
        @o_moneda,
        @o_moneda_des,
        @o_valor,
        @o_tbien,
        @o_tbien_des,
        @o_vigencia,
        @o_verificado,
        convert(char(10), @o_fecha_registro, 101),
        convert(char(10), @o_fecha_modificacion, 101),
        convert(char(10), @o_fecha_avaluo, 101),
        @o_funcionario,
        convert(char(10), @o_fecha_ver, 101),
        @o_ciudad_bien,
        @o_notaria,
        @o_matricula,
        @o_escritura,
        convert(char(10), @o_fecha_escritura, 101),
        @o_gravamen_afavor,
        @o_gravada,
        @o_desc_ciudad,
        @o_ciudad_inm,
        @o_des_ciudad_inm,
        @o_tipo_veh,--Mallas 223
        @o_placa,
        @o_modelo,
        @o_marca,
        @o_direccion_im,
        @o_area,
        /***** se Ocultaron  ,@o_nom_aval,@o_val_aval ***/

        @o_porc_partic,
        @o_saldo_deuda,
        @o_dpto_inm,
        @o_dpto_not,
        @o_afect_familiar

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

  /** Delete **/

  if @i_operacion = 'D'
  begin
    if @t_trn = 197
    begin
      /* si existe referencia en tabla de garantia de operaciones de cartera
          no se puede permitir el borrado, integridad referencial */
      if exists (select
                   *
                 from   cobis..cl_garantia
                 where  ga_ente      = @i_ente
                    and ga_propiedad = @i_propiedad)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101165
        /* 'Existe referencia en garantia'*/
        return 1
      end

      /* Captura de campos a borrar para transaccion de servicios */
      select
        @w_descripcion = pr_descripcion,
        @w_verificado = pr_verificado,
        @w_moneda = pr_moneda,
        @w_valor = pr_valor,
        @w_tbien = pr_tbien,
        @w_tgarantia = pr_tgarantia,
        @w_gravada = pr_gravada,
        @w_nom_aval = pr_nom_aval,
        @w_ciudad_bien = pr_ciudad,/*IN */
        @w_notaria = pr_notaria,/*IN */
        @w_matricula = pr_matricula,/*IN*/
        @w_escritura = pr_escritura,/*IN */
        @w_fecha_escritura = pr_fecha_escritura,/*IN */
        @w_gravamen_afavor = pr_gravamen_afavor,/*IN*/
        @w_val_aval = pr_val_aval,
        @w_ciudad_inm = pr_ciudad_inmueble,
        @w_porc_partic = pr_porcentaje,
        @w_saldo_deuda = pr_saldo_deuda,
        @w_dpto_inm = pr_dpto_inm,
        @w_dpto_not = pr_dpto_not,
        @w_afect_familiar = pr_afect_familiar
      from   cl_propiedad
      where  pr_persona   = @i_ente
         and pr_propiedad = @i_propiedad

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107039
        /* 'Error en eliminacion de propiedad'*/
        return 1
      end

      begin tran

      /* si existe referencia en tabla de documentos de garantia en cartera
          borrado en cascada */
      if exists (select
                   *
                 from   cobis..cl_dgarantia
                 where  dg_ente      = @i_ente
                    and dg_propiedad = @i_propiedad)
      begin
        delete cobis..cl_dgarantia
        where  dg_ente      = @i_ente
           and dg_propiedad = @i_propiedad
      end

      delete cl_propiedad
      where  pr_persona   = @i_ente
         and pr_propiedad = @i_propiedad

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107039
        /* 'Error en eliminacion de propiedad'*/
        return 1
      end

      /* Transaccion servicio */

      insert into ts_propiedad
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,persona,propiedad,
                   descripcion,verificado,moneda,valor,tbien,
                   tgarantia,gravada,nom_aval,ciudad_bien,/*IN*/notaria,/*IN*/
                   matricula,/*IN*/escritura,/*IN*/fecha_escritura,/*IN*/
                   gravamen_afavor,/*IN*/val_aval,
                   ciudad_inm,porcentaje,saldo_deuda,dpto_inm,dpto_not,
                   afect_familiar)
      values     (@s_ssn,@t_trn,'B',@s_date,@s_user,
                  @s_term,@s_srv,@s_lsrv,@i_ente,@i_propiedad,
                  @w_descripcion,@w_verificado,@w_moneda,
                  convert(varchar(32), @w_valor
                  ),@w_tbien,
                  @w_tgarantia,@w_gravada,@w_nom_aval,@w_ciudad_bien,/*IN*/
                  @w_notaria,
                  /*IN*/
                  @w_matricula,/*IN*/@w_escritura,/*IN*/@w_fecha_escritura,
                  /*IN*/
                  @w_gravamen_afavor,/*IN*/@w_val_aval,
                  @w_ciudad_inm,convert(varchar(10), @w_porc_partic),
                  @w_saldo_deuda,
                  @w_dpto_inm,@w_dpto_not,
                  @w_afect_familiar )
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicios'*/
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

go

