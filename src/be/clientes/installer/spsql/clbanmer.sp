/************************************************************************/
/*  Archivo           :   clbanmer.sp                                   */
/*  Stored procedure  :   sp_banmer                                     */
/*  Base de datos     :   cobis                                         */
/*  Producto          :   Clientes                                      */
/*  Disenado por      :   Diego Duran                                   */
/*  Fecha de escritura:   12/Noviembre/2002                             */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
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
/*  Este programa procesa las operaciones de Creacion, Busqueda,        */
/*      Actualizacion del mercado objetivo asignado a un cliente        */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR      RAZON                                      */
/*  12/Nov/02     D.Duran    Emision Inicial                            */
/*  30/Abril/03   D.Duran    Valida Actualizacion                       */
/*  20/Mar/2007   L.Alvarez  Req. 737 - Cambio de Tipo de Banca         */
/*                           a compañias Con Naturaleza Oficial         */
/*  20/Feb/2009   E.Alvarez  Req. 001 - Parametrizacion Tipo de Banca   */
/*  15/Mar/2009   J.Quinche  Req      - Mercados Objetivos              */
/*  09/04/2013    A. Munoz   Requerimiento 0353 Alianzas Comerciales    */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_banmer')
  drop proc sp_banmer
go
create proc sp_banmer
(
  @s_ssn              int = null,
  @s_user             login = null,
  @s_term             varchar(30) = null,
  @s_date             datetime = null,
  @s_srv              varchar(30) = null,
  @s_lsrv             varchar(30) = null,
  @s_ofi              smallint = null,
  @t_debug            char(1) = 'N',
  @t_file             varchar(10) = null,
  @t_from             varchar(32) = null,
  @t_trn              smallint = null,
  @t_show_version     bit = 0,
  @i_operacion        char(1),
  @i_ente             int = null,
  @i_mercado_objetivo catalogo = null,
  @i_subtipo_mo       catalogo = null,
  @i_actividad        catalogo = null,
  @i_banca            catalogo = null,
  @i_segmento         catalogo = null,
  @i_subsegmento      catalogo = null,
  @i_actprincipal     catalogo = null,
  @i_actividad2       catalogo = null,
  @i_actividad3       catalogo = null,

  /* campos cca 353 alianzas bancamia --AAMG*/
  @i_crea_ext         char(1) = null,
  @o_msg_msv          varchar(255)= null out
)
as
  declare
    @w_sp_name          varchar(32),
    @w_codigo           int,
    @w_return           int,
    @w_mercado_objetivo catalogo,
    @w_subtipo_mo       catalogo,
    @w_banca            catalogo,
    @w_des_mercado      descripcion,
    @w_des_banca        descripcion,
    @v_mercado_objetivo catalogo,
    @v_banca            catalogo,
    @v_segmento         catalogo,
    @v_subsegmento      catalogo,
    @v_actprincipal     catalogo,
    @v_actividad2       catalogo,
    @v_actividad3       catalogo,
    @w_des_actividad    descripcion,
    @w_des_sector       descripcion,
    @w_cod_sector       catalogo,
    @w_actividad        catalogo,
    @w_subtipo          catalogo,
    @w_des_subtipo      catalogo,
    @v_subtipo_mo       catalogo,
    @o_ente             int,
    @o_mercado_objetivo catalogo,
    @o_subtipo_mo       catalogo,
    @o_banca            catalogo,
    @o_fecha_registro   datetime,
    @o_fecha_modifi     datetime,
    @o_funcionario      login,
    @w_debug            char(1),
    @w_tipo_persona     char(1),
    @w_sector           varchar(10),
    @w_mer              tinyint,
    @w_segmento         catalogo,
    @w_subsegmento      catalogo,
    @w_actprincipal     catalogo,
    @w_actividad2       catalogo,
    @w_actividad3       catalogo,
    @w_des_segmento     descripcion,
    @w_des_subsegmento  descripcion,
    @w_des_actprincipal descripcion,
    @w_des_actividad2   descripcion,
    @w_des_actividad3   descripcion,
    @w_max_riesgo       money

  --V6
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_sp_name = 'sp_banmer',
    @w_debug = 'N'

  -- Seleccionar default de Maximo Riego por Banca
  select
    @w_max_riesgo = convert(money, codigo_sib)
  from   cob_credito..cr_corresp_sib
  where  codigo = @i_banca
     and tabla  = 'T131'

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 1495
    begin
      /* Verificar que exista el ente */
      select
        @w_codigo = null
      from   cl_ente
      where  en_ente = @i_ente

      /* si no existe, error */
      if @@rowcount = 0
      begin
        if @i_crea_ext is null
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101043
          /* 'No existe persona'*/
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: No Existe Persona, Cliente ' + convert(varchar(
                         10
                         ),
                                @i_ente ) + ', ' +
                                @w_sp_name
          select
            @w_return = 101043
          return @w_return
        end
      end

      /* Verifica Relacion de Subtipo Mercado Objetivo*/
      if not exists (select
                       1
                     from   cobis..cl_asociacion_actividad
                     where  aa_actividad = @i_actividad
                        and aa_mercado   = @i_mercado_objetivo
                        and aa_subtipo   = @i_subtipo_mo)
      begin
        if @i_crea_ext is null
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 100218
          /* 'NO EXISTE ASOCIACION ENTRE SUBTIPO DE MERCADO OBJETIVO, MERCADO OBJETIVO Y BANCA' */
          return 100218
        end
        else
        begin
          select
            @o_msg_msv =
            'Error: No Existe Asociacion Entre Mercado Objetivo y Banca, '
            +
                   @w_sp_name
          select
            @w_return = 100218
          return @w_return
        end
      end

      /* Verificar si el ente YA tiene asignado un mercado objetivo */
      select
        @w_mercado_objetivo = mo_mercado_objetivo,
        @w_subtipo_mo = mo_subtipo_mo
      from   cl_mercado_objetivo_cliente
      where  mo_ente = @i_ente

      if (@w_mercado_objetivo is not null)
         and (@w_subtipo_mo is not null)
      begin
        if @i_crea_ext is null
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101195
          /* 'NO EXISTE ASOCIACION ENTRE SUBTIPO DE MERCADO OBJETIVO, MERCADO OBJETIVO Y BANCA' */
          return 1
        end
        else
        begin
          select
            @o_msg_msv =
            'Error: Ya Existe Asociacion Entre Mercado Objetivo y Banca, '
            +
                   @w_sp_name
          select
            @w_return = 101195
          return @w_return
        end
      end

      if @w_debug = 'S'
        print @w_sp_name + ' --> @i_banca: ' + cast(@i_banca as varchar)

      begin tran
      /* Insercion cl_mercado_objetivo_cliente */
      if exists (select
                   1
                 from   cl_mercado_objetivo_cliente
                 where  mo_ente = @i_ente)
      begin
        update cl_mercado_objetivo_cliente
        set    mo_mercado_objetivo = @i_mercado_objetivo,
               mo_subtipo_mo = @i_subtipo_mo,
               mo_fecha_registro = @s_date,
               mo_funcionario = @s_user,
               mo_segmento = @i_segmento,
               mo_subsegmento = @i_subsegmento,
               mo_actprincipal = @i_actprincipal,
               mo_actividad2 = @i_actividad2,
               mo_actividad3 = @i_actividad3
        from   cl_mercado_objetivo_cliente
        where  mo_ente = @i_ente
      end
      else
      begin
        insert into cl_mercado_objetivo_cliente
                    (mo_ente,mo_mercado_objetivo,mo_subtipo_mo,mo_fecha_registro
                     ,
                     mo_funcionario,
                     mo_segmento,mo_subsegmento,mo_actprincipal,mo_actividad2,
                     mo_actividad3)
        values      (@i_ente,@i_mercado_objetivo,@i_subtipo_mo,@s_date,@s_user,
                     @i_segmento,@i_subsegmento,@i_actprincipal,@i_actividad2,
                     @i_actividad3)
      end
      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        if @i_crea_ext is null
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107103
          /* 'Error en creacion de Mercado Objetivo */
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: Insercion Mercado Objetivo, Cliente ' + convert
                         (
                         varchar
                         (
                                10), @i_ente
                                ) + ', '
                         + @w_sp_name
          select
            @w_return = 107103
          return @w_return
        end
      end

      update cl_ente
      set    en_banca = @i_banca,
             en_max_riesgo = @w_max_riesgo
      where  en_ente = @i_ente

      /*  Transaccion de Servicio  */
      insert into ts_mercado_objetivo_cliente
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,mercado,
                   subtipo,banca,fecha_modificacion,segmento,microsegmento,
                   actprincipal,actividad1,actividad2)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_mercado_objetivo,
                   @i_subtipo_mo,@i_banca,@s_date,@i_segmento,@i_subsegmento,
                   @i_actprincipal,@i_actividad2,@i_actividad3)
      if @@error <> 0
      begin
        if @i_crea_ext is null
        begin
          /*  Error en creacion de transaccion de servicio */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103005
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: Insercion TS Mercado Objetivo, Cliente ' +
                         convert(
                         varchar
                                ( 10),
                                @i_ente) + ', '
                         + @w_sp_name
          select
            @w_return = 103005
          return @w_return
        end
      end

      commit tran
      return 0
    end
    else
    begin
      if @i_crea_ext is null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 151051
        /*  'No corresponde codigo de transaccion' */
        return 1
      end
      else
      begin
        select
          @o_msg_msv = 'Error: Numero de Transaccion No Corresponde, ' +
                       @w_sp_name
        select
          @w_return = 151051
        return @w_return
      end
    end
  end

  /** Update **/
  if @i_operacion = 'U'
  begin
    if @t_trn = 1496
    begin
      /* Verifica Relacion de Subtipo Mercado Objetivo*/
      if not exists (select
                       1
                     from   cobis..cl_asociacion_actividad
                     where  aa_actividad = @i_actividad
                        and aa_mercado   = @i_mercado_objetivo
                        and aa_subtipo   = @i_subtipo_mo)
      begin
        if @i_crea_ext is null
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 100218
          /* 'NO EXISTE ASOCIACION ENTRE SUBTIPO DE MERCADO OBJETIVO, MERCADO OBJETIVO Y BANCA' */
          return 100218
        end
        else
        begin
          select
            @o_msg_msv =
            'Error: No Existe Asociacion Entre Mercado Objetivo y Banca, '
            +
                   @w_sp_name
          select
            @w_return = 100218
          return @w_return
        end
      end

      select
        @w_mercado_objetivo = mo_mercado_objetivo,
        @w_subtipo_mo = mo_subtipo_mo,
        @w_banca = en_banca
      from   cl_mercado_objetivo_cliente,
             cl_ente
      where  mo_ente = en_ente
         and mo_ente = @i_ente

      if @@rowcount = 0
      begin
        insert into cl_mercado_objetivo_cliente
                    (mo_ente,mo_mercado_objetivo,mo_subtipo_mo,mo_fecha_registro
                     ,
                     mo_fecha_modificacion,
                     mo_funcionario,mo_segmento,mo_subsegmento,mo_actprincipal,
                     mo_actividad2,
                     mo_actividad3)
        values      (@i_ente,@i_mercado_objetivo,@i_subtipo_mo,getdate(),getdate
                     (
                     ),
                     @s_user,@i_segmento,@i_subsegmento,@i_actprincipal,
                     @i_actividad2,
                     @i_actividad3)

        /* si no se puede modificar, error */
        if @@rowcount = 0
        begin
          if @i_crea_ext is null
          begin
            /*'Error en la insercion del Mercado Objetivo ' */
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 107103
            return 1
          end
          else
          begin
            select
              @o_msg_msv = 'Error: Insercion Mercado Objetivo, Cliente ' +
                           convert
                           (
                           varchar
                           (
                                  10), @i_ente
                                  ) + ', '
                           + @w_sp_name
            select
              @w_return = 107103
            return @w_return
          end
        end
      end

      select
        @v_mercado_objetivo = @w_mercado_objetivo,
        @v_subtipo_mo = @w_subtipo_mo,
        @v_banca = @w_banca

      if @w_mercado_objetivo = @i_mercado_objetivo
        select
          @w_mercado_objetivo = null,
          @v_mercado_objetivo = null
      else
        select
          @w_mercado_objetivo = @i_mercado_objetivo

      if @w_subtipo_mo = @i_subtipo_mo
        select
          @w_subtipo_mo = null,
          @v_subtipo_mo = null
      else
        select
          @w_subtipo_mo = @i_subtipo_mo

      if @w_banca = @i_banca
        select
          @w_banca = null,
          @v_banca = null
      else
        select
          @w_banca = @i_banca

      if @w_segmento = @i_segmento
        select
          @w_segmento = null,
          @v_segmento = null
      else
        select
          @w_segmento = @i_segmento

      if @w_subsegmento = @i_subsegmento
        select
          @w_subsegmento = null,
          @v_subsegmento = null
      else
        select
          @w_subsegmento = @i_subsegmento

      if @w_actprincipal = @i_actprincipal
        select
          @w_actprincipal = null,
          @v_actprincipal = null
      else
        select
          @w_actprincipal = @i_actprincipal

      if @w_actividad2 = @i_actividad2
        select
          @w_actividad2 = null,
          @v_actividad2 = null
      else
        select
          @w_actividad2 = @i_actividad2

      if @w_actividad3 = @i_actividad3
        select
          @w_actividad3 = null,
          @v_actividad3 = null
      else
        select
          @w_actividad3 = @i_actividad3

      begin tran
      /*************** modificar, los datos *****************/
      update cl_mercado_objetivo_cliente
      set    mo_mercado_objetivo = @i_mercado_objetivo,
             mo_subtipo_mo = @i_subtipo_mo,
             mo_fecha_modificacion = @s_date,
             mo_funcionario = @s_user,
             mo_segmento = @i_segmento,
             mo_subsegmento = @i_subsegmento,
             mo_actprincipal = @i_actprincipal,
             mo_actividad2 = @i_actividad2,
             mo_actividad3 = @i_actividad3
      from   cl_mobj_subtipo
      where  mo_ente      = @i_ente
         and ms_mobjetivo = @i_mercado_objetivo
         and ms_codigo    = @i_subtipo_mo

      /* si no se puede modificar, error */
      if @@rowcount = 0
      begin
        if @i_crea_ext is null
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105094
          /*'Error en actualizacion de Mercado Objetivo' */
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: Actualizando Mercado Objetivo, Cliente ' +
                         convert(
                         varchar
                                ( 10),
                                @i_ente) + ', '
                         + @w_sp_name
          select
            @w_return = 105094
          return @w_return
        end
      end

      /* modificar, los datos en la cl_ente*/
      update cl_ente
      set    en_banca = @i_banca
      from   cl_mobj_subtipo
      where  en_ente      = @i_ente
         and ms_codigo    = @i_subtipo_mo
         and ms_mobjetivo = @i_mercado_objetivo

      /* si no se puede modificar, error */
      if @@rowcount = 0
      begin
        if @i_crea_ext is null
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105095
          /*'Error en actualizacion de Banca' */
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: Actualizando Banca, Cliente ' + convert(varchar
                         (
                         10)
                         ,
                                @i_ente) + ', ' +
                                @w_sp_name
          select
            @w_return = 105095
          return @w_return
        end
      end

      /*  Transaccion de Servicio - Previo */
      insert into ts_mercado_objetivo_cliente
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,mercado,
                   subtipo,banca,fecha_modificacion,segmento,microsegmento,
                   actprincipal,actividad1,actividad2)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@v_mercado_objetivo,
                   @v_subtipo_mo,@v_banca,@s_date,@v_segmento,@v_subsegmento,
                   @v_actprincipal,@v_actividad2,@v_actividad3)

      if @@error <> 0
      begin
        if @i_crea_ext is null
        begin
          /*  Error en creacion de transaccion de servicio */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103005
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: Insercion TS Mercado Objetivo, Cliente ' +
                         convert(
                         varchar
                                ( 10),
                                @i_ente) + ', '
                         + @w_sp_name
          select
            @w_return = 103005
          return @w_return
        end
      end

      /*  Transaccion de Servicio - Actual */
      insert into ts_mercado_objetivo_cliente
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,mercado,
                   subtipo,banca,fecha_modificacion,segmento,microsegmento,
                   actprincipal,actividad1,actividad2)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@w_mercado_objetivo,
                   @w_subtipo_mo,@w_banca,@s_date,@w_segmento,@w_subsegmento,
                   @w_actprincipal,@w_actividad2,@w_actividad3)
      if @@error <> 0
      begin
        if @i_crea_ext is null
        begin
          /*  Error en creacion de transaccion de servicio */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103005
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: Insercion TS Mercado Objetivo, Cliente ' +
                         convert(
                         varchar
                                ( 10),
                                @i_ente) + ', '
                         + @w_sp_name
          select
            @w_return = 103005
          return @w_return
        end
      end
      commit tran
      return 0
    end
    else
    begin
      if @i_crea_ext is null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 151051
        /*  'No corresponde codigo de transaccion' */
        return 1
      end
      else
      begin
        select
          @o_msg_msv = 'Error: Numero de Transaccion No Corresponde, ' +
                       @w_sp_name
        select
          @w_return = 151051
        return @w_return
      end
    end
  end

  /** Search **/
  if @i_operacion = 'S'
  begin
    if @t_trn = 1498
    begin
      select
        @w_mer = count(1)
      from   cl_mercado_objetivo_cliente
      where  mo_ente = @i_ente
         and mo_mercado_objetivo is not null
         and mo_subtipo_mo is not null

      if @w_mer > 0
      begin
        select
          @w_mercado_objetivo = mo_mercado_objetivo,
          @w_subtipo_mo = mo_subtipo_mo,
          @w_banca = en_banca,
          @w_actividad = en_actividad,
          @w_sector = en_sector,
          @w_actprincipal = mo_actprincipal,
          @w_actividad2 = mo_actividad2,
          @w_actividad3 = mo_actividad3,
          @w_segmento = mo_segmento,
          @w_subsegmento = mo_subsegmento
        from   cl_mercado_objetivo_cliente,
               cl_ente,
               cl_mobj_subtipo
        where  mo_ente   = en_ente
           and mo_ente   = @i_ente
           and ms_codigo = mo_subtipo_mo

        if @@rowcount <> 0
        begin
          select
            @w_des_mercado = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_mercado_objetivo
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_mercado_objetivo'
             and cl_catalogo.estado = 'V'

          select
            @w_des_banca = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_banca
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_banca_cliente'
             and cl_catalogo.estado = 'V'

          select
            @w_des_actividad = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_actividad
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_actividad'
             and cl_catalogo.estado = 'V'

          select
            @w_des_sector = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_sector
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_sectoreco'
             and cl_catalogo.estado = 'V'

          select
            @w_des_segmento = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_segmento
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_segmento'
             and cl_catalogo.estado = 'V'

          select
            @w_des_subsegmento = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_subsegmento
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_sub_segmento'
             and cl_catalogo.estado = 'V'

          select
            @w_des_actprincipal = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_actprincipal
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_actividad_finagro'
             and cl_catalogo.estado = 'V'

          select
            @w_des_actividad2 = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_actividad2
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_actividad_finagro'
             and cl_catalogo.estado = 'V'

          select
            @w_des_actividad3 = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_actividad3
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_actividad_finagro'
             and cl_catalogo.estado = 'V'

          if @i_crea_ext is null
          begin
            select distinct
              'MERCADO OBJETIVO      ' = mo_mercado_objetivo,
              'SUBTIPO MO            ' = mo_subtipo_mo,
              'BANCA                 ' = en_banca,
              'FECHA DE REGISTRO     ' = convert(char(10), mo_fecha_registro,
                                         101)
              ,
              'FUNCIONARIO           ' = mo_funcionario,
              'FECHA DE MODIFICACION ' = convert(char(10), mo_fecha_modificacion
                                         ,
                                         101)
              ,
              'DESCRIPCION SUBTIPO   ' = ms_descripcion,
              'DESCRIPCION MERCADO   ' = @w_des_mercado,
              'DESCRIPCION BANCA     ' = @w_des_banca,
              'ACTIVIDAD             ' = @w_actividad,
              'DESCRIPCION ACTIVIDAD ' = @w_des_actividad,
              'SECTOR                ' = @w_sector,
              'DESCRIPCION ACTIVIDAD ' = @w_des_sector,
              'ACTIVIDAD PRINCIPAL   ' = @w_actprincipal,
              'DESCRIPCION ACTIVIDAD ' = @w_des_actprincipal,
              'ACTIVIDAD2            ' = @w_actividad2,
              'DESCRIPCION ACTIVIDAD2' = @w_des_actividad2,
              'ACTIVIDAD             ' = @w_actividad3,
              'DESCRIPCION ACTIVIDAD3' = @w_des_actividad3,
              'SEGMENTO              ' = @w_segmento,
              'DESCRIPCION ACTIVIDAD3' = @w_des_segmento,
              'SUBSEGMENTO           ' = @w_subsegmento,
              'DESCRIPCION SUBSEGMENTO' = @w_des_subsegmento
            from   cl_mercado_objetivo_cliente,
                   cl_ente,
                   cl_mobj_subtipo
            where  mo_ente   = en_ente
               and mo_ente   = @i_ente
               and ms_codigo = mo_subtipo_mo
          end

        end
      end

      if @w_mer = 0
      begin
        select
          @w_mercado_objetivo = '',
          @w_subtipo_mo = '',
          @w_banca = en_banca,
          @w_actividad = en_actividad,
          @w_sector = en_sector
        from   cl_ente
        where  en_ente = @i_ente

        if @@rowcount <> 0
        begin
          select
            @w_des_banca = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_banca
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_banca_cliente'
             and cl_catalogo.estado = 'V'

          select
            @w_des_actividad = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_actividad
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_actividad'
             and cl_catalogo.estado = 'V'

          select
            @w_des_sector = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_sector
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_sectoreco'
             and cl_catalogo.estado = 'V'

          select
            @w_des_segmento = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_segmento
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_segmento'
             and cl_catalogo.estado = 'V'

          select
            @w_des_subsegmento = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_subsegmento
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_sub_segmento'
             and cl_catalogo.estado = 'V'

          select
            @w_des_actprincipal = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_actprincipal
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_actividad_finagro'
             and cl_catalogo.estado = 'V'

          select
            @w_des_actividad2 = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_actividad2
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_actividad_finagro'
             and cl_catalogo.estado = 'V'

          select
            @w_des_actividad3 = cl_catalogo.valor
          from   cl_catalogo,
                 cl_tabla
          where  cl_catalogo.codigo = @w_actividad3
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_actividad_finagro'
             and cl_catalogo.estado = 'V'

          if @i_crea_ext is null
          begin
            select distinct
              'MERCADO OBJETIVO      ' = '',
              'SUBTIPO MO            ' = '',
              'BANCA                 ' = en_banca,
              'FECHA DE REGISTRO     ' = '',
              'FUNCIONARIO           ' = '',
              'FECHA DE MODIFICACION ' = '',
              'DESCRIPCION SUBTIPO   ' = '',
              'DESCRIPCION MERCADO   ' = '',
              'DESCRIPCION BANCA     ' = @w_des_banca,
              'ACTIVIDAD             ' = en_actividad,--@w_actividad,
              'DESCRIPCION ACTIVIDAD ' = @w_des_actividad,
              'SECTOR                ' = en_sector,--@w_sector,
              'DESCRIPCION ACTIVIDAD ' = @w_des_sector,
              'ACTIVIDAD PRINCIPAL   ' = @w_actprincipal,
              'DESCRIPCION ACTIVIDAD ' = @w_des_actprincipal,
              'ACTIVIDAD2            ' = @w_actividad2,
              'DESCRIPCION ACTIVIDAD2' = @w_des_actividad2,
              'ACTIVIDAD             ' = @w_actividad3,
              'DESCRIPCION ACTIVIDAD3' = @w_des_actividad3,
              'SEGMENTO              ' = @w_segmento,
              'DESCRIPCION ACTIVIDAD3' = @w_des_segmento,
              'SUBSEGMENTO           ' = @w_subsegmento,
              'DESCRIPCION SUBSEGMENTO' = @w_des_subsegmento
            from   cl_ente
            where  en_ente = @i_ente
          end

        end
      end
      return 0
    end
    else
    begin
      if @i_crea_ext is null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 151051
        /*  'No corresponde codigo de transaccion' */
        return 1
      end
      else
      begin
        select
          @o_msg_msv = 'Error: Numero de Transaccion No Corresponde, ' +
                       @w_sp_name
        select
          @w_return = 151051
        return @w_return
      end
    end
  end

  /* Datos especificos de cliente*/
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1497
    begin
      select
        @o_mercado_objetivo = mo_mercado_objetivo,
        @o_subtipo_mo = mo_subtipo_mo,
        @o_banca = en_banca,
        @o_fecha_registro = mo_fecha_registro,
        @o_funcionario = mo_funcionario,
        @o_fecha_modifi = mo_fecha_modificacion
      from   cl_mercado_objetivo_cliente,
             cl_ente
      where  mo_ente = en_ente
         and mo_ente = @i_ente

      if @@rowcount = 0
      begin
        if @i_crea_ext is null
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105090
          /* 'No existe dato solicitado'*/
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: No Existe Servicio de Banca, Cliente ' +
                         convert(
                         varchar
                         (
                                10 ),
                                @i_ente ) + ', '
                         + @w_sp_name
          select
            @w_return = 105090
          return @w_return
        end
      end

      if @i_crea_ext is null
      begin
        select
          @o_mercado_objetivo,
          @o_subtipo_mo,
          @o_banca,
          convert(char(10), @o_fecha_registro, 101),
          @o_funcionario,
          convert(char(10), @o_fecha_modifi, 101)
      end
      return 0
    end
    else
    begin
      if @i_crea_ext is null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 151051
        /*  'No corresponde codigo de transaccion' */
        return 1
      end
      else
      begin
        select
          @o_msg_msv = 'Error: Numero de Transaccion No Corresponde, ' +
                       @w_sp_name
        select
          @w_return = 151051
        return @w_return
      end
    end
  end

  /* Busqueda Informacion Mercados y actividades */
  if @i_operacion = 'M'
  begin
    select
      @w_actividad = en_actividad,
      @w_cod_sector = en_sector
    from   cl_ente
    where  @i_ente = en_ente

    select
      @w_des_actividad = cl_catalogo.valor
    from   cl_catalogo,
           cl_tabla
    where  cl_catalogo.codigo = @w_actividad
       and cl_catalogo.tabla  = cl_tabla.codigo
       and cl_tabla.tabla     = 'cl_actividad'
       and cl_catalogo.estado = 'V'

    select
      @w_des_sector = cl_catalogo.valor
    from   cl_catalogo,
           cl_tabla
    where  cl_catalogo.codigo = @w_cod_sector
       and cl_catalogo.tabla  = cl_tabla.codigo
       and cl_tabla.tabla     = 'cl_sectoreco'
       and cl_catalogo.estado = 'V'

    if @i_crea_ext is null
    begin
      select
        @w_cod_sector,
        @w_des_sector,
        @w_actividad,
        @w_des_actividad
    end
  end

  /* Busqueda de subtipo permitidos para la actividad */

  if @i_operacion = 'T'
  begin
    select
      @w_tipo_persona = en_subtipo
    from   cobis..cl_ente
    where  en_ente = @i_ente

    if @i_crea_ext is null
    begin
      select distinct
        'CODIGO         ' = aa_subtipo,
        'SUBTIPO MERCADO' = cl_catalogo.valor
      from   cl_asociacion_actividad,
             cl_catalogo,
             cl_tabla
      where  aa_actividad       = @i_actividad
             -- and    aa_banca             = @i_banca
             and aa_mercado         = @i_mercado_objetivo
             and aa_tipo_pers       = @w_tipo_persona
             and aa_subtipo         = cl_catalogo.codigo
             and cl_catalogo.tabla  = cl_tabla.codigo
             and cl_tabla.tabla     = 'cl_subtipo_mercado'
             and cl_catalogo.estado = 'V'
    end
  end

  if @i_operacion = 'X'
  begin
    /*
       select @w_tipo_persona = en_subtipo
       from cobis..cl_ente
       where en_ente = @i_ente
    
         select  'CODIGO BANCA   ' =  aa_banca,
               'DESCRIPCION    ' = cl_catalogo.valor
             from   cl_asociacion_actividad,cl_catalogo, cl_tabla
             where  aa_actividad         = @i_actividad
             and    aa_mercado           = @i_mercado_objetivo
             and    aa_tipo_pers         = @w_tipo_persona
          and    aa_banca             = cl_catalogo.codigo
             and    cl_catalogo.tabla    = cl_tabla.codigo
             and    cl_tabla.tabla       = 'cl_banca_cliente'
             and    cl_catalogo.estado   = 'V'
    */
    if @i_crea_ext is null
    begin
      select
        'CODIGO BANCA   ' = cl_catalogo.codigo,
        'DESCRIPCION    ' = cl_catalogo.valor
      from   cl_catalogo,
             cl_tabla
      where  cl_catalogo.tabla  = cl_tabla.codigo
         and cl_tabla.tabla     = 'cl_banca_cliente'
         and cl_catalogo.estado = 'V'
    end

  end

  /** Modificar **/
  if @i_operacion = 'C'
  begin --nueva
    if @t_trn = 195
    begin
      select
        @w_segmento = mo_segmento,
        @w_subsegmento = mo_subsegmento,
        @w_banca = en_banca
      from   cl_mercado_objetivo_cliente,
             cl_ente
      where  mo_ente = en_ente
         and mo_ente = @i_ente

      if @@rowcount = 0
      begin
        insert into cl_mercado_objetivo_cliente
                    (mo_ente,mo_mercado_objetivo,mo_subtipo_mo,mo_fecha_registro
                     ,
                     mo_fecha_modificacion,
                     mo_funcionario,mo_segmento,mo_subsegmento,mo_actprincipal,
                     mo_actividad2,
                     mo_actividad3)
        values      (@i_ente,@i_mercado_objetivo,@i_subtipo_mo,getdate(),getdate
                     (
                     ),
                     @s_user,@i_segmento,@i_subsegmento,@i_actprincipal,
                     @i_actividad2,
                     @i_actividad3)

        /* si no se puede modificar, error */
        if @@rowcount = 0
        begin
          if @i_crea_ext is null
          begin
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 107103
            /*'Error en la insercion del Mercado Objetivo ' */
            return 1
          end
          else
          begin
            select
              @o_msg_msv = 'Error: Insercion Mercado Objetivo, Cliente ' +
                           convert
                           (
                           varchar
                           (
                                  10), @i_ente
                                  ) + ', '
                           + @w_sp_name
            select
              @w_return = 107103
            return @w_return
          end
        end
      end

      select
        @v_mercado_objetivo = @w_mercado_objetivo,
        @v_subtipo_mo = @w_subtipo_mo,
        @v_banca = @w_banca,
        @v_segmento = @w_segmento,
        @v_subsegmento = @w_subsegmento

      if @w_banca = @i_banca
        select
          @w_banca = null,
          @v_banca = null
      else
        select
          @w_banca = @i_banca

      if @w_segmento = @i_segmento
        select
          @w_segmento = null,
          @v_segmento = null
      else
        select
          @w_segmento = @i_segmento

      if @w_subsegmento = @i_subsegmento
        select
          @w_subsegmento = null,
          @v_subsegmento = null
      else
        select
          @w_subsegmento = @i_subsegmento

      begin tran
      /*************** modificar, los datos *****************/
      update cl_mercado_objetivo_cliente
      set    mo_fecha_modificacion = @s_date,
             mo_funcionario = @s_user,
             mo_segmento = @i_segmento,
             mo_subsegmento = @i_subsegmento
      from   cl_mobj_subtipo
      where  mo_ente = @i_ente

      /* si no se puede modificar, error */
      if @@rowcount = 0
      begin
        if @i_crea_ext is null
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105094
          /*'Error en actualizacion de Mercado Objetivo' */
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: Actualizando Mercado Objetivo, Cliente ' +
                         convert(
                         varchar
                                ( 10),
                                @i_ente) + ', '
                         + @w_sp_name
          select
            @w_return = 105094
          return @w_return
        end
      end

      /* modificar, los datos en la cl_ente*/
      update cl_ente
      set    en_banca = @i_banca
      from   cl_mobj_subtipo
      where  en_ente = @i_ente

      /* si no se puede modificar, error */
      if @@rowcount = 0
      begin
        if @i_crea_ext is null
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105095
          /*'Error en actualizacion de Banca' */
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: Actualizando Banca, Cliente ' + convert(varchar
                         (
                         10)
                         ,
                                @i_ente) + ', ' +
                                @w_sp_name
          select
            @w_return = 105095
          return @w_return
        end
      end

      /*  Transaccion de Servicio - Previo */
      insert into ts_mercado_objetivo_cliente
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,mercado,
                   subtipo,banca,fecha_modificacion,segmento,microsegmento,
                   actprincipal,actividad1,actividad2)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@v_mercado_objetivo,
                   @v_subtipo_mo,@v_banca,@s_date,@v_segmento,@v_subsegmento,
                   @v_actprincipal,@v_actividad2,@v_actividad3)

      if @@error <> 0
      begin
        if @i_crea_ext is null
        begin
          /*  Error en creacion de transaccion de servicio */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103005
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: Insercion TS Mercado Objetivo, Cliente ' +
                         convert(
                         varchar
                                ( 10),
                                @i_ente) + ', '
                         + @w_sp_name
          select
            @w_return = 103005
          return @w_return
        end
      end

      /*  Transaccion de Servicio - Actual */
      insert into ts_mercado_objetivo_cliente
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,mercado,
                   subtipo,banca,fecha_modificacion,segmento,microsegmento,
                   actprincipal,actividad1,actividad2)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@w_mercado_objetivo,
                   @w_subtipo_mo,@w_banca,@s_date,@w_segmento,@w_subsegmento,
                   @w_actprincipal,@w_actividad2,@w_actividad3)
      if @@error <> 0
      begin
        if @i_crea_ext is null
        begin
          /*  Error en creacion de transaccion de servicio */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103005
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: Insercion TS Mercado Objetivo, Cliente ' +
                         convert(
                         varchar
                                ( 10),
                                @i_ente) + ', '
                         + @w_sp_name
          select
            @w_return = 103005
          return @w_return
        end
      end
      commit tran
      return 0
    end
    else
    begin
      if @i_crea_ext is null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 151051
        /*  'No corresponde codigo de transaccion' */
        return 1
      end
      else
      begin
        select
          @o_msg_msv = 'Error: Numero de Transaccion No Corresponde, ' +
                       @w_sp_name
        select
          @w_return = 151051
        return @w_return
      end
    end
  end

  return 0

go

