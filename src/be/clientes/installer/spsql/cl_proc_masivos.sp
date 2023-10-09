/************************************************************************/
/*    Archivo:                cl_proc.masivos.sp                        */
/*    Stored Procedure:       sp_proc_masivos                           */
/*    Base de datos:          cobis                                     */
/*    Disenado por:           Jose Julian Cortes                        */
/*    Fecha de escritura:     15/04/2013                                */
/*    Producto:               Credito                                   */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*                            PROPOSITO                                 */
/*  Generar reporte de procesos masivos para creacion de Clientes       */
/*  Tramites y Desembolsos, separando los procesos Exitosos de los que  */
/*  tuvieron algun tipo de inconveniente                                */
/*                                                                      */
/************************************************************************/
/*                           MODIFICACION                               */
/*    FECHA                    AUTOR               RAZON                */
/*  15/04/2013                 Jose Cortes       Emision Inicial        */
/*  02/05/2016                 DFu               Migracion CEN          */
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
           where  name = 'sp_proc_masivos')
  drop proc sp_proc_masivos
go

create proc sp_proc_masivos
(
  @t_show_version bit = 0,
  @i_param1       varchar(255),--Fecha del Proceso
  @i_param2       varchar(255),--Id Transaccion (T,C,N)
  @i_param3       varchar(255),--Id Tipo Trans Si es tipo T (O,C,U,D,R,E)
  @i_param4       varchar(255) = null --Secuencial de Carga
)
as
  declare
    @w_sp_name          varchar(32),/* NOMBRE STORED PROC*/
    @w_msg              varchar(124),
    @w_error            int,
    @i_transaccion      char(1),--T,C,N
    @i_tipo_tran        char(1) = null,-- Si es tipo T (O,C,U,D,R,E)
    @i_carga            int,
    @w_tipo             char(1),
    @w_carga            int,
    @w_alianza          numero,
    @w_cedula           numeric(13),
    @w_tipo_ced         char(2),
    @w_generar_salida   char(1),
    @w_fecha_proceso    datetime,
    @w_procesados       int,
    @w_errores          int,
    @w_total            int,
    @w_nombre           varchar(64),
    @w_nom_alianza      varchar(255),
    @w_tipo_carga       varchar(50),
    @w_archivo          varchar(10),
    @w_ruta             varchar(50),
    @w_ente             int,
    @w_email            varchar(84),
    @w_user             varchar(60),
    @w_dom              varchar(60),
    @w_nombre_archivo   varchar(255),
    @w_fecha_pro_txt    varchar(10),
    @w_fecha_arch       varchar(10),
    @w_hora_arch        varchar(4),
    @w_comando          varchar(1000),
    @w_sp_name_batch    varchar(40),
    @w_s_app            varchar(30),
    @w_path             varchar(255),
    @w_cmd              varchar(255),
    @w_cuerpo_correo    nvarchar(MAX),
    @w_xml              nvarchar(MAX),
    @w_correos          nvarchar(MAX),
    @w_tipo_tramite     char(1),
    @w_genera_notif     char(1),
    @w_fecha            datetime,
    @w_aprocesar        int,
    @w_cont             int,
    @w_cont1            int,
    @w_externos         int,
    @w_no_cta_reg_error int,
    @w_procesados_aux   int,
    @w_errores_aux      int,
    @w_while            int,
    @w_carga_u          int,
    @w_carga_o          int,
    @w_carga_c          int,
    @w_carga_cl         int,
    @w_cont2            int,
    @w_cont3            int,
    @w_carga_min        int

  select
    @w_sp_name = 'sp_proc_masivos'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha_proceso = @i_param1,
    @i_transaccion = @i_param2,
    @i_tipo_tran = @i_param3,
    @i_carga = @i_param4

  select
    @w_carga_min = 0
  select
    @w_generar_salida = 'N'
  select
    @w_fecha = getdate() -- Para tener una fecha default
  if @w_fecha_proceso is null
    select
      @w_fecha_proceso = @w_fecha

  --insert into cl_seguimiento_correo (sc_secuencial,sc_id_carga,sc_tipo_carga,sc_correos,sc_tot_registros,sc_procesados,sc_errores,sc_fecha_proc)
  --values (0,@i_carga,@w_tipo_carga,@i_tipo_tran,@w_total,@w_procesados,@w_errores,getdate())

  ---------------------------------------------------
  -- Generaciæn automﬂtica de correos de notificacion
  ---------------------------------------------------

  /* Parametro General */
  select
    @w_genera_notif = pa_char
  from   cobis..cl_parametro with (nolock)
  where  pa_nemonico = 'NOTMAS'
     and pa_producto = 'MIS'

  -- Si no esta habilitada la generaciæn automﬂtica de correos de notificacion
  if @w_genera_notif = 'N'
    return 0

  if @i_transaccion = 'C' -- CLIENTES
  begin
    if isnull(@i_carga,
              0) > 0
    begin
      /*VALIDA QUE TODOS LOS REGISTROS SE ENCUENTREN PROCESADOS PARA EL ENVIO DEL CORREO*/
      select
        @w_while = 1
      while @w_while <= 15
      begin
        select
          @w_cont = count(1)
        from   cob_externos..ex_msv_clientes with (nolock)
        where  mc_id_carga = @i_carga
           and mc_estado   = 'E'
        select
          @w_cont1 = count(1)
        from   cobis..cl_msv_crear with (nolock)
        where  mc_id_carga = @i_carga
        if (@w_cont + @w_cont1) >= 1
           and (@w_cont + @w_cont1) < 24
          waitfor delay '00:00:02'
        else
          select
            @w_while = 100
        select
          @w_while = @w_while + 1
      end
    end

    --insert into cl_seguimiento_correo (sc_secuencial,sc_id_carga,sc_tipo_carga,sc_correos,sc_tot_registros,sc_procesados,sc_errores,sc_fecha_proc)
    --values (14,@w_carga,@w_tipo_carga,CONVERT(varchar, @w_cont) + ' ' + CONVERT(varchar, @w_cont1),@w_total,@w_procesados,@w_errores,getdate())

    if (@w_cont + @w_cont1) > 0
      return 0

    if isnull(@i_carga,
              0) = 0
    begin
    /*EN CASO DE NO ENVIAR NUMERO DE CARGA SE VERIFICA EL ULTIMO NUMERO DE CARGA PARA ENVIO DE CORREO*/
      -- select @w_carga_cl = MAX(mc_id_carga) from cob_externos..ex_msv_clientes  with (nolock)
      select
        @w_carga_cl = max(mc_id_carga)
      from   cob_externos..ex_msv_clientes with (nolock)
      where  mc_id_carga not in (select
                                   sc_id_carga
                                 from   cobis..cl_seguimiento_correo with (
                                        nolock
                                        )
                                 where  sc_secuencial = 2
                                    and sc_tipo_carga like '%CLIENTES%'
                                    and sc_id_carga   > @w_carga_min)
         and mc_id_carga > @w_carga_min
      -- insert into cl_seguimiento_correo (sc_secuencial,sc_id_carga,sc_tipo_carga,sc_correos,sc_tot_registros,sc_procesados,sc_errores,sc_fecha_proc)
      -- values (15,@w_carga_cl,@w_tipo_carga,CONVERT(varchar, @w_cont) + ' ' + CONVERT(varchar, @w_cont1),@w_total,@w_procesados,@w_errores,getdate())

      --if @w_carga_c = 754 return 0
      --select @w_cont = count(1) from cobis..cl_msv_crear  with (nolock) where mc_id_carga = @w_carga_cl
      --select @w_cont1 = count(1) from cobis..cl_msv_crear_his  with (nolock) where mc_id_carga = @w_carga_cl
      select
        @w_cont2 = count(1)
      from   cob_externos..ex_msv_clientes with (nolock)
      where  mc_id_carga = @w_carga_cl
      select
        @w_cont3 = count(1)
      from   cob_externos..ex_msv_clientes with (nolock)
      where  mc_id_carga = @w_carga_cl
         and mc_estado   = 'P'

      if /*@w_cont= 0 and @w_cont1 = 0 and */@w_cont2 = @w_cont3
                                             and not exists
      (select
         '1'
       from   cobis..cl_seguimiento_correo with (nolock)
       where  sc_secuencial = 2
          and
                                 sc_tipo_carga like '%CLIENTES%'
                                                     and
              sc_id_carga   = @w_carga_cl
      )
      begin
        select
          @i_carga = @w_carga_cl
      end
      else
      begin
        return 0
      end
      if isnull(@i_carga,
                0) = 0
        return 0
    end

  end
  else
  begin -- TRAMITES
    if @i_tipo_tran = 'C'
    begin
      /*VALIDA QUE TODOS LOS REGISTROS SE ENCUENTREN PROCESADOS PARA EL ENVIO DEL CORREO*/
      if isnull(@i_carga,
                0) > 0
      begin
        select
          @w_while = 1
        while @w_while <= 15
        begin
          select
            @w_cont = count(1)
          from   cob_externos..ex_msv_tramites_cupo with (nolock)
          where  mtc_id_carga = @i_carga
             and mtc_estado   = 'E'
          select
            @w_cont1 = count(1)
          from   cob_credito..cr_msv_crear_cupo with (nolock)
          where  mtc_id_carga = @i_carga

          if (@w_cont + @w_cont1) >= 1
             and (@w_cont + @w_cont1) < 24
            waitfor delay '00:00:02'
          else
            select
              @w_while = 100
          select
            @w_while = @w_while + 1
        end
        if (@w_cont + @w_cont1) > 0
          return 0
      end
      /*EN CASO DE NO ENVIAR NUMERO DE CARGA SE VERIFICA EL ULTIMO NUMERO DE CARGA PARA ENVIO DE CORREO*/

      if isnull(@i_carga,
                0) = 0
      begin
        --select @w_carga_c = MAX(mtc_id_carga) from cob_externos..ex_msv_tramites_cupo with (nolock) 
        select
          @w_carga_c = max(mtc_id_carga)
        from   cob_externos..ex_msv_tramites_cupo with (nolock)
        where  mtc_id_carga not in (select
                                      sc_id_carga
                                    from   cobis..cl_seguimiento_correo with (
                                           nolock
                                           )
                                    where  sc_secuencial = 2
                                       and sc_tipo_carga like 'TRAMITES CUPOS%'
                                       and sc_id_carga   > @w_carga_min)
           and mtc_id_carga > @w_carga_min

        --if @w_carga_c = 754 return 0
        --select @w_cont  = count(1) from cob_credito..cr_msv_crear_cupo     with (nolock) where mtc_id_carga = @w_carga_c
        --select @w_cont1 = count(1) from cob_credito..cr_msv_crear_cupo_his  with (nolock) where mtc_id_carga = @w_carga_c
        select
          @w_cont2 = count(1)
        from   cob_externos..ex_msv_tramites_cupo with (nolock)
        where  mtc_id_carga = @w_carga_c
        select
          @w_cont3 = count(1)
        from   cob_externos..ex_msv_tramites_cupo with (nolock)
        where  mtc_id_carga = @w_carga_c
           and mtc_estado   = 'P'

        if /*@w_cont = 0 and @w_cont1 = 0 and */@w_cont2 = @w_cont3
                                                and not exists
        (select
           '1'
         from   cobis..cl_seguimiento_correo with (nolock)
         where  sc_secuencial = 2
            and
                                    sc_tipo_carga like 'TRAMITES CUPOS%'
                                                        and
                sc_id_carga   = @w_carga_c
        )
        begin
          select
            @i_carga = @w_carga_c
        end
        else
        begin
          return 0
        end
        if isnull(@i_carga,
                  0) = 0
          return 0
      end
    end

    if @i_tipo_tran = 'U'
    begin
      if isnull(@i_carga,
                0) > 0
      begin
        /*VALIDA QUE TODOS LOS REGISTROS SE ENCUENTREN PROCESADOS PARA EL ENVIO DEL CORREO*/
        select
          @w_while = 1
        while @w_while <= 15
        begin
          select
            @w_cont = count(1)
          from   cob_externos..ex_msv_tramites_u with (nolock)
          where  mtu_id_carga = @i_carga
             and mtu_estado   = 'E'
          select
            @w_cont1 = count(1)
          from   cob_credito..cr_msv_crear_u with (nolock)
          where  mtu_id_carga = @i_carga

          if (@w_cont + @w_cont1) >= 1
             and (@w_cont + @w_cont1) < 24
            waitfor delay '00:00:02'
          else
            select
              @w_while = 100
          select
            @w_while = @w_while + 1

        end
        if (@w_cont + @w_cont1) > 0
          return 0
      end
      /*EN CASO DE NO ENVIAR NUMERO DE CARGA SE VERIFICA EL ULTIMO NUMERO DE CARGA PARA ENVIO DE CORREO*/
      if isnull(@i_carga,
                0) = 0
      begin
        --select @w_carga_u = MAX(mtu_id_carga) from cob_externos..ex_msv_tramites_u with (nolock) 
        select
          @w_carga_u = max(mtu_id_carga)
        from   cob_externos..ex_msv_tramites_u with (nolock)
        where  mtu_id_carga not in (select
                                      sc_id_carga
                                    from   cobis..cl_seguimiento_correo with (
                                           nolock
                                           )
                                    where  sc_secuencial = 2
                                       and
               sc_tipo_carga like 'TRAMITES UTILIZACIONES%'
                                       and sc_id_carga   > @w_carga_min)
           and mtu_id_carga > @w_carga_min

        --select @w_cont  = count(1) from cob_credito..cr_msv_crear_u      with (nolock) where mtu_id_carga = @w_carga_u
        --select @w_cont1 = count(1) from cob_credito..cr_msv_crear_u_his  with (nolock) where mtu_id_carga = @w_carga_u
        select
          @w_cont2 = count(1)
        from   cob_externos..ex_msv_tramites_u with (nolock)
        where  mtu_id_carga = @w_carga_u
        select
          @w_cont3 = count(1)
        from   cob_externos..ex_msv_tramites_u with (nolock)
        where  mtu_id_carga = @w_carga_u
           and mtu_estado   = 'P'

        if /*@w_cont = 0 and @w_cont1 = 0 and */ @w_cont2 = @w_cont3
                                                 and not exists
        (select
           '1'
         from   cobis..cl_seguimiento_correo with (nolock)
         where  sc_secuencial = 2
            and
                                    sc_tipo_carga like 'TRAMITES UTILIZACIONES%'
                                                         and
                sc_id_carga   = @w_carga_u)
        begin
          select
            @i_carga = @w_carga_u
        end
        else
        begin
          return 0
        end
        if isnull(@i_carga,
                  0) = 0
          return 0
      end
    end
    if @i_tipo_tran = 'O'
    begin
      if isnull(@i_carga,
                0) > 0
      begin
        /*VALIDA QUE TODOS LOS REGISTROS SE ENCUENTREN PROCESADOS PARA EL ENVIO DEL CORREO*/
        select
          @w_while = 1
        while @w_while <= 15
        begin
          select
            @w_cont = count(1)
          from   cob_externos..ex_msv_tramites_orig with (nolock)
          where  mto_id_carga = @i_carga
             and mto_estado   = 'E'
          select
            @w_cont1 = count(1)
          from   cob_credito..cr_msv_crear_orig with (nolock)
          where  mto_id_carga = @i_carga
          if (@w_cont + @w_cont1) >= 1
             and (@w_cont + @w_cont1) < 24
            waitfor delay '00:00:02'
          else
            select
              @w_while = 100
          select
            @w_while = @w_while + 1
        end
        if (@w_cont + @w_cont1) > 0
          return 0
      end
      /*EN CASO DE NO ENVIAR NUMERO DE CARGA SE VERIFICA EL ULTIMO NUMERO DE CARGA PARA ENVIO DE CORREO*/
      if isnull(@i_carga,
                0) = 0
      begin
        --select @w_carga_o = MAX(mto_id_carga) from cob_externos..ex_msv_tramites_orig with (nolock) 
        select
          @w_carga_o = max(mto_id_carga)
        from   cob_externos..ex_msv_tramites_orig with (nolock),
               cobis..cl_seguimiento_correo with (nolock)
        where  mto_id_carga not in (select
                                      sc_id_carga
                                    from   cobis..cl_seguimiento_correo with (
                                           nolock
                                           )
                                    where  sc_secuencial = 2
                                       and
               sc_tipo_carga like 'TRAMITES ORIGINALES%'
                                       and sc_id_carga   > @w_carga_min)
           and mto_id_carga > @w_carga_min

        --select @w_cont  = count(1) from cob_credito..cr_msv_crear_orig   with (nolock) where mto_id_carga = @w_carga_o
        --select @w_cont1 = count(1) from cob_credito..cr_msv_crear_orig_his  with (nolock) where mto_id_carga = @w_carga_o
        select
          @w_cont2 = count(1)
        from   cob_externos..ex_msv_tramites_orig with (nolock)
        where  mto_id_carga = @w_carga_o
        select
          @w_cont3 = count(1)
        from   cob_externos..ex_msv_tramites_orig with (nolock)
        where  mto_id_carga = @w_carga_o
           and mto_estado   = 'P'

        if /*@w_cont = 0 and @w_cont1 = 0 and */@w_cont2 = @w_cont3
                                                and not exists
        (select
           '1'
         from   cobis..cl_seguimiento_correo with (nolock)
         where  sc_secuencial = 2
            and
                                    sc_tipo_carga like 'TRAMITES ORIGINALES%'
                                                        and
                sc_id_carga   = @w_carga_o
        )
        begin
          select
            @i_carga = @w_carga_o
        end
        else
        begin
          return 0
        end
        if isnull(@i_carga,
                  0) = 0
          return 0
      end
    end
  end

/*VALIDA EN TABLA DE ARCHIVOS BASE*/
  --Validar en la tabla ultima carga que se encuentre en estado F, 
  --sacar el tipo de carga (T,C,D,R,N)por @i_transaccion

  -- Si Transaccion es "T" Tramites,  Tipo de Transacciæn debe estar en ("C", "U", "O")
  -- Si Transaccion es "N" Novedades, Tipo de Transacciæn debe estar en ("D", "R", "E")

  create table #cargas
  (
    carga   int,
    alianza numero,
    estado  char(1),
    fecha   datetime
  )

  create table #correos
  (
    nomente int,
    nemail  varchar(84)
  )

  /* INICIALIZAR VARIABLES */

  select
    @w_carga = 0,
    @w_nombre = '',
    @w_nom_alianza = '',
    @w_tipo_carga = '',
    @w_total = 0,
    @w_procesados = 0,
    @w_errores = 0,
    @w_ruta = '',
    @w_alianza = 0,
    @w_procesados_aux = 0

  select
    @w_archivo = pa_char
  from   cobis..cl_parametro with (nolock)
  where  pa_nemonico = 'NOMCOE'
     and pa_producto = 'MIS'

  select
    @w_ruta = pa_char
  from   cobis..cl_parametro with (nolock)
  where  pa_nemonico = 'PATFIN'
     and pa_producto = 'CRE'

  /*VALIDAR TABLAS DE CREACION BASE*/

  if @i_transaccion = 'T' -- TRAMITES
  begin
    if @i_tipo_tran is null
    begin
      -- return error -- Debe exsitir tipo de Transaccion para una transaccion (T)-tramite.
      select
        @w_error = 801077,
        @w_msg = 'TIPO DE TRANSACCION NO CORRESPONDE'
      goto ERRORFIN
    end

    if @i_tipo_tran = 'C'
    begin -- Cupos
      select
        @w_tipo_carga = 'TRAMITES CUPOS'

      insert into #cargas
        select distinct
          mtc_id_carga,mtc_id_Alianza,'I',isnull(mtc_fecha_estado,
                 @w_fecha_proceso)
        from   cob_externos..ex_msv_tramites_cupo with (nolock)
        where  convert(varchar(10), mtc_fecha_estado, 103) =
                      convert(varchar(10), @w_fecha_proceso, 103)
           and mtc_estado in ('P')
           -- Estado de cargas ya procesadas en su totalidad por el Core.
           and mtc_id_carga                              = @i_carga
      -- Manejo de una soloa carga.
      if @@rowcount > 0
      begin
        while 1 = 1
        begin
          set rowcount 1
          select
            @w_carga = carga,
            @w_alianza = alianza,
            @w_fecha = fecha
          from   #cargas
          where  carga > @w_carga
          order  by carga asc

          if @@rowcount = 0
          begin
            set rowcount 0
            break
          end

          if exists (select
                       1
                     from   cob_credito..cr_msv_crear_cupo with (nolock)
                     where  mtc_id_carga = @w_carga)
          begin
            set rowcount 0
            break
          end
          else
            select
              @w_generar_salida = 'S'

          select
            @w_nom_alianza = al_nom_alianza
          from   cl_alianza with (nolock)
          where  al_alianza in
                 (select top 1
                    al_alianza
                  from   cobis..cl_ente with (nolock),
                         cob_externos..ex_msv_tramites_cupo with (nolock),
                         cobis..cl_alianza with (nolock)
                  where  mtc_id_Alianza = en_ced_ruc
                     and en_ente        = al_ente
                     and mtc_id_Alianza = @w_alianza)

          select
            @w_nombre = isnull(aa_nombre_archivo,
  '<< Err. Por favor Validar tabla cob_externos..ex_archivo_alianza >>')
          from   cob_externos..ex_archivo_alianza with (nolock)
          where  aa_id_carga = @w_carga

          -- Proceso de seleccion de datos
          -- Errores

          select
            @w_errores = count(1)--Total Errores 
          from   ca_msv_error with (nolock)
          where  me_id_carga     = @w_carga
             and me_tipo_proceso = 'T'

          select
            @w_procesados = count(1) --Total registros Procesados
          from   cob_credito..cr_msv_proc with (nolock)
          where  mp_id_carga = @w_carga

          /* TOTAL DE REGISTROS */
          select
            @w_total = @w_errores + @w_procesados

          select
            @w_externos = count(1)
          from   cob_externos..ex_msv_tramites_cupo with (nolock)
          where  mtc_id_carga = @i_carga

          -- Fin proceso de seleccion de datos

          update #cargas
          set    estado = 'P'
          where  carga = @w_carga

          select
            @w_generar_salida = 'S'
        end
      end
    end

    if @i_tipo_tran = 'U'
    begin -- Utilizaciones / Unificaciones
      select
        @w_tipo_carga = 'TRAMITES UTILIZACIONES/UNIFICACIONES'
      insert into #cargas
        select distinct
          mtu_id_carga,mtu_id_Alianza,'I',isnull(mtu_fecha_estado,
                 @w_fecha_proceso)
        from   cob_externos..ex_msv_tramites_u with (nolock)
        where  convert(varchar(10), mtu_fecha_estado, 103) =
                      convert(varchar(10), @w_fecha_proceso, 103)
           and mtu_estado in ('P')
           -- Estado de cargas ya procesadas en su totalidad por el Core.
           and mtu_id_carga                              = @i_carga
      -- Manejo de una soloa carga.

      if @@rowcount > 0
      begin
        while 1 = 1
        begin
          set rowcount 1
          select
            @w_carga = carga,
            @w_alianza = alianza,
            @w_fecha = fecha
          from   #cargas
          where  carga > @w_carga
          order  by carga asc

          if @@rowcount = 0
          begin
            set rowcount 0
            break
          end

          if exists (select
                       1
                     from   cob_credito..cr_msv_crear_u with (nolock)
                     where  mtu_id_carga = @w_carga)
          begin
            set rowcount 0
            break
          end
          else
            select
              @w_generar_salida = 'S'

          select
            @w_nom_alianza = al_nom_alianza
          from   cl_alianza with (nolock)
          where  al_alianza in
                 (select top 1
                    al_alianza
                  from   cobis..cl_ente with (nolock),
                         cob_externos..ex_msv_tramites_u with (nolock),
                         cobis..cl_alianza with (nolock)
                  where  mtu_id_Alianza = en_ced_ruc
                     and en_ente        = al_ente
                     and mtu_id_Alianza = @w_alianza)

          select
            @w_nombre = isnull(aa_nombre_archivo,
  '<< Err. Por favor Validar tabla cob_externos..ex_archivo_alianza >>')
          from   cob_externos..ex_archivo_alianza with (nolock)
          where  aa_id_carga = @w_carga

          -- Proceso de seleccion de datos
          -- Errores

          select
            @w_errores = count(1)--Total Errores 
          from   ca_msv_error with (nolock)
          where  me_id_carga     = @w_carga
             and me_tipo_proceso = 'T'

          select
            @w_procesados = count(1) --Total registros Procesados
          from   cob_credito..cr_msv_proc with (nolock)
          where  mp_id_carga = @w_carga

          /* TOTAL DE REGISTROS */
          select
            @w_total = @w_errores + @w_procesados

          select
            @w_externos = count(1)
          from   cob_externos..ex_msv_tramites_u with (nolock)
          where  mtu_id_carga = @i_carga

          -- Fin proceso de seleccion de datos

          update #cargas
          set    estado = 'P'
          where  carga = @w_carga

          select
            @w_generar_salida = 'S'
        end
      end
    end

    if @i_tipo_tran = 'O'
    begin -- Original
      select
        @w_tipo_carga = 'TRAMITES ORIGINALES'
      insert into #cargas
        select distinct
          mto_id_carga,mto_id_Alianza,'I',isnull(mto_fecha_estado,
                 @w_fecha_proceso)
        from   cob_externos..ex_msv_tramites_orig with (nolock)
        where  convert(varchar(10), mto_fecha_estado, 103) =
                      convert(varchar(10), @w_fecha_proceso, 103)
           and mto_estado in ('P')
           -- Estado de cargas ya procesadas en su totalidad por el Core.
           and mto_id_carga                              = @i_carga
      -- Manejo de una soloa carga.
      if @@rowcount > 0
      begin
        while 1 = 1
        begin
          set rowcount 1
          select
            @w_carga = carga,
            @w_alianza = alianza,
            @w_fecha = fecha
          from   #cargas
          where  carga > @w_carga
          order  by carga asc

          if @@rowcount = 0
          begin
            set rowcount 0
            break
          end

          if exists (select
                       1
                     from   cob_credito..cr_msv_crear_orig with (nolock)
                     where  mto_id_carga = @w_carga)
          begin
            set rowcount 0
            break
          end
          else
            select
              @w_generar_salida = 'S'

          select
            @w_nom_alianza = al_nom_alianza
          from   cl_alianza with (nolock)
          where  al_alianza in
                 (select top 1
                    al_alianza
                  from   cobis..cl_ente with (nolock),
                         cob_externos..ex_msv_tramites_orig with (nolock),
                         cobis..cl_alianza with (nolock)
                  where  mto_id_Alianza = en_ced_ruc
                     and en_ente        = al_ente
                     and mto_id_Alianza = @w_alianza)

          select
            @w_nombre = isnull(aa_nombre_archivo,
  '<< Err. Por favor Validar tabla cob_externos..ex_archivo_alianza >>')
          from   cob_externos..ex_archivo_alianza with (nolock)
          where  aa_id_carga = @w_carga

          -- Proceso de seleccion de datos
          -- Errores

          select
            @w_errores = count(1)--Total Errores 
          from   ca_msv_error with (nolock)
          where  me_id_carga     = @w_carga
             and me_tipo_proceso = 'T'

          select
            @w_procesados = count(1) --Total registros Procesados
          from   cob_credito..cr_msv_proc with (nolock)
          where  mp_id_carga = @w_carga

          /* TOTAL DE REGISTROS */
          select
            @w_total = @w_errores + @w_procesados

          select
            @w_externos = count(1)
          from   cob_externos..ex_msv_tramites_orig with (nolock)
          where  mto_id_carga = @i_carga

          -- Fin proceso de seleccion de datos

          update #cargas
          set    estado = 'P'
          where  carga = @w_carga

          select
            @w_generar_salida = 'S'
        end
      end
    end
  end

  if @i_transaccion = 'C' -- CLIENTES
  begin
    select
      @w_tipo_carga = 'CLIENTES'

    insert into #cargas
      select distinct
        mc_id_carga,mc_id_Alianza,'I',isnull(mc_fecha_estado,
               @w_fecha_proceso)
      from   cob_externos..ex_msv_clientes with (nolock)
      where  convert(varchar(10), mc_fecha_estado, 103) =
                    convert(varchar(10), @w_fecha_proceso, 103)
         and mc_estado in ('P')
         -- Estado de cargas ya procesadas en su totalidad por el Core.
         and mc_id_carga                              = @i_carga
    -- Manejo de una soloa carga.
    if @@rowcount > 0
    begin
      while 1 = 1
      begin
        set rowcount 1
        select
          @w_carga = carga,
          @w_alianza = alianza,
          @w_fecha = fecha
        from   #cargas
        where  carga > @w_carga
        order  by carga asc

        if @@rowcount = 0
        begin
          set rowcount 0
          break
        end

        if exists (select
                     1
                   from   cobis..cl_msv_crear with (nolock)
                   where  mc_id_carga = @w_carga)
        begin
          set rowcount 0
          break
        end
        else
          select
            @w_generar_salida = 'S'

        select
          @w_nom_alianza = al_nom_alianza
        from   cl_alianza with (nolock)
        where  al_alianza in
               (select top 1
                  al_alianza
                from   cobis..cl_ente with (nolock),
                       cob_externos..ex_msv_clientes with (nolock),
                       cobis..cl_alianza with (nolock)
                where  mc_id_Alianza = en_ced_ruc
                   and en_ente       = al_ente
                   and mc_id_Alianza = @w_alianza)

        select
          @w_nombre = isnull(aa_nombre_archivo,
          '<< Err. Por favor Validar tabla cob_externos..ex_archivo_alianza >>')
        from   cob_externos..ex_archivo_alianza with (nolock)
        where  aa_id_carga = @w_carga

        -- Proceso de seleccion de datos
        -- Errores

        select
          @w_errores = count(1)--Total Errores 
        from   ca_msv_error with (nolock)
        where  me_id_carga     = @w_carga
           and me_tipo_proceso = 'C'

        select
          @w_procesados = count(1) --Total registros Procesados
        from   cobis..cl_msv_proc with (nolock)
        where  mp_id_carga = @w_carga

        /* TOTAL DE REGISTROS */
        select
          @w_total = @w_errores + @w_procesados

        select
          @w_externos = count(1)
        from   cob_externos..ex_msv_clientes with (nolock)
        where  mc_id_carga = @i_carga

        -- Fin proceso de seleccion de datos

        update #cargas
        set    estado = 'P'
        where  carga = @w_carga

        select
          @w_generar_salida = 'S'
      end
    end
  end

  if @i_transaccion = 'N'
  -- NOVEDADES (Reajustes, Desembolsos, Renovaciones Originadas por las unificaciones)
  begin
    if @i_tipo_tran is null
    begin
      --return error -- Debe exsitir tipo de Transaccion para una transaccion (N)-novedad.
      select
        @w_error = 801077,
        @w_msg = 'TIPO DE TRANSACCION NO CORRESPONDE'
      goto ERRORFIN
    end

    if @i_tipo_tran in ('D', 'R')
    begin -- Desembolsos / Renovaciones
      select
        @w_tipo_carga = 'RENOVACIONES/DESEMBOLSOS'
      if @i_tipo_tran = 'R'
        select
          @w_tipo_tramite = 'U'
      else
        select
          @w_tipo_tramite = 'O'

      if @w_tipo_tramite = 'U'
      begin
        insert into #cargas
          select distinct
            des_carga = mp_id_carga,des_alianza = tr_alianza,'I',getdate()
          from   cob_credito..cr_tramite with (nolock),
                 cob_credito..cr_msv_proc with (nolock),
                 cob_cartera..ca_operacion with (nolock),
                 cob_externos..ex_msv_tramites_u with (nolock)
          where  mtu_estado in ('P')
                 -- Estado de cargas ya procesadas en su totalidad por el Core
                 and convert(varchar(10), @w_fecha_proceso, 103) =
                     convert(varchar(10), op_fecha_liq, 103)
                 and tr_alianza                                = mp_id_Alianza
                 and tr_tipo                                   = @w_tipo_tramite
                 and op_estado                                 <> 0
                 and op_tramite                                = tr_tramite
                 and mtu_id_carga                              = mp_id_carga
                 and mp_id_carga                               = @i_carga
      -- Manejo de una soloa carga.
      end
      else
      begin
        insert into #cargas
          select distinct
            des_carga = mp_id_carga,des_alianza = tr_alianza,'I',getdate()
          from   cob_credito..cr_tramite,
                 cob_credito..cr_msv_proc with (nolock),
                 cob_cartera..ca_operacion with (nolock),
                 cob_externos..ex_msv_tramites_orig with (nolock)
          where  mto_estado in ('P')
                 -- Estado de cargas ya procesadas en su totalidad por el Core
                 and convert(varchar(10), @w_fecha_proceso) =
                     convert(varchar(10), op_fecha_liq)
                 and tr_alianza                            = mp_id_Alianza
                 and tr_tipo                               = @w_tipo_tramite
                 and op_estado                             <> 0
                 and op_tramite                            = tr_tramite
                 and mto_id_carga                          = mp_id_carga
                 and mp_id_carga                           = @i_carga
      -- Manejo de una soloa carga.
      end

      if @@rowcount > 0
      begin
        while 1 = 1
        begin
          set rowcount 1
          select
            @w_carga = carga,
            @w_alianza = alianza,
            @w_fecha = fecha
          from   #cargas
          where  carga > @w_carga
          order  by carga asc

          if @@rowcount = 0
          begin
            set rowcount 0
            break
          end

          if @w_tipo_tramite = 'U'
          begin
            if exists (select
                         1
                       from   cob_credito..cr_msv_crear_u with (nolock)
                       where  mtu_id_carga = @w_carga)
            begin
              set rowcount 0
              break
            end
          end
          else
          begin
            if exists (select
                         1
                       from   cob_credito..cr_msv_crear_orig with (nolock)
                       where  mto_id_carga = @w_carga)
            begin
              set rowcount 0
              break
            end
          end
          select
            @w_generar_salida = 'S'

          if @w_tipo_tramite = 'U'
          begin
            select
              @w_nom_alianza = al_nom_alianza
            from   cl_alianza with (nolock)
            where  al_alianza in
                   (select top 1
                      al_alianza
                    from   cobis..cl_ente with (nolock),
                           cob_externos..ex_msv_tramites_u with (nolock),
                           cobis..cl_alianza with (nolock)
                    where  mtu_id_Alianza = en_ced_ruc
                       and en_ente        = al_ente
                       and mtu_id_Alianza = @w_alianza)
          end
          else
          begin
            select
              @w_nom_alianza = al_nom_alianza
            from   cl_alianza with (nolock)
            where  al_alianza in
                   (select top 1
                      al_alianza
                    from   cobis..cl_ente with (nolock),
                           cob_externos..ex_msv_tramites_orig with (nolock),
                           cobis..cl_alianza with (nolock)
                    where  mto_id_Alianza = en_ced_ruc
                       and en_ente        = al_ente
                       and mto_id_Alianza = @w_alianza)
          end

          select
            @w_nombre = isnull(aa_nombre_archivo,
  '<< Err. Por favor Validar tabla cob_externos..ex_archivo_alianza >>')
          from   cob_externos..ex_archivo_alianza with (nolock)
          where  aa_id_carga = @w_carga

          -- Proceso de seleccion de datos
          -- Errores

          select
            @w_errores = count(1)--Total Errores 
          from   ca_msv_error with (nolock)
          where  me_id_carga = @w_carga

          select
            @w_procesados = count(1) --Total registros Procesados
          from   cob_credito..cr_msv_proc with (nolock),
                 cob_cartera..ca_operacion with (nolock)
          where  mp_id_carga  = @w_carga
             and mp_tramite   = op_tramite
             and op_estado    <> 0
             and op_fecha_liq = @w_fecha_proceso
             and mp_tipo      = @w_tipo_tramite

          /* TOTAL DE REGISTROS */
          select
            @w_total = @w_errores + @w_procesados

          -- Fin proceso de seleccion de datos

          update #cargas
          set    estado = 'P'
          where  carga = @w_carga

          select
            @w_generar_salida = 'S'
        end
      end

      select
        @w_generar_salida = 'S'
    end

    if @i_tipo_tran = 'E'
    begin -- Reajustes
      -- POR CARGA
      select
        @w_tipo_carga = 'REAJUSTES'
      insert into #cargas
        select distinct
          mtn_id_carga,mtn_id_Alianza,'I',isnull(mtn_fecha_estado,
                 @w_fecha_proceso)
        from   cob_externos..ex_msv_novedades with (nolock)
        where  mtn_estado in ('P')
               -- Estado de cargas ya procesadas en su totalidad por el Core.
               and mtn_id_carga                          = @i_carga
               -- Manejo de una soloa carga.
               and convert(varchar, mtn_fecha_estado, 103) =
                   convert(varchar, @w_fecha_proceso, 103)

      if @@rowcount > 0
      begin
        while 1 = 1
        begin
          set rowcount 1
          select
            @w_carga = carga,
            @w_alianza = alianza,
            @w_fecha = fecha
          from   #cargas
          where  alianza > @w_alianza
          order  by alianza asc

          if @@rowcount = 0
          begin
            set rowcount 0
            break
          end
          else
          begin
            select
              @w_generar_salida = 'S'
          end

          select
            @w_nom_alianza = al_nom_alianza
          from   cl_alianza with (nolock)
          where  al_alianza = @w_alianza

          select
            @w_nombre = isnull(aa_nombre_archivo,
            '<< Mjs. Proceso No depende de un Archivo de Carga'
                        )
          from   cob_externos..ex_archivo_alianza with (nolock)
          where  aa_id_carga = @w_carga

          -- Proceso de seleccion de datos
          -- Errores

          select
            @w_errores = count(1)--Total Errores 
          from   ca_msv_error with (nolock)
          where  me_id_carga                   = @w_carga
             and me_tipo_proceso               = 'E'
             and convert(varchar, me_fecha, 103) =
                 convert(varchar, @w_fecha, 103)

          select
            @w_procesados = count(1) --Total registros Procesados
          from   cob_cartera..ca_msv_proc with (nolock)
          where  mp_id_carga                        = @w_carga
             and mp_tipo_tr                         = 'E'
             and convert(varchar, mp_fecha_proc, 103) =
                 convert(varchar, @w_fecha, 103)

          /* TOTAL DE REGISTROS */
          select
            @w_total = @w_errores + @w_procesados

          select
            @w_externos = count(1)
          from   cob_externos..ex_msv_novedades with (nolock)
          where  mtn_id_carga                           = @i_carga
             and convert(datetime, mtn_fecha_estado, 103) =
                 convert(datetime, @w_fecha, 103)

          -- Fin proceso de seleccion de datos

          update #cargas
          set    estado = 'P'
          where  carga = @w_carga

          select
            @w_generar_salida = 'S'
        end
      end
    end
  end

  if @w_generar_salida = 'S'
  begin -- Generar Salida.
    --print 'por acac'
    /* GENERACION ARCHIVO PLANO */
    select
      @w_fecha_pro_txt = convert(varchar, @w_fecha_proceso, 101),
      @w_fecha_arch = substring(convert(varchar(10), @w_fecha_pro_txt), 1, 2)
                      + substring(convert(varchar(10), @w_fecha_pro_txt), 4, 2)
                      + substring(convert(varchar(10), @w_fecha_pro_txt), 7, 4),
      @w_hora_arch = substring(convert(varchar, getdate(), 108), 1, 2)
                     + substring(convert(varchar, getdate(), 108), 4, 2),
      @w_sp_name_batch = 'cob_credito..sp_reporte_deudores_mora'

    /* RUTA DE DESTINO DEL ARCHIVO A GENERAR */
    select
      @w_path = ba_path_destino
    from   cobis..ba_batch with (nolock)
    where  ba_arch_fuente = @w_sp_name_batch

    if @w_path is null
    begin
      select
        @w_error = 2101084,
        @w_msg = 'ERROR EN LA BUSQUEDA DEL PATH EN LA TABLA ba_batch'
      goto ERRORFIN
    end
    print @w_path

    select
      @w_s_app = pa_char
    from   cobis..cl_parametro with (nolock)
    where  pa_producto = 'ADM'
       and pa_nemonico = 'S_APP'

    if @@rowcount = 0
    begin
      select
        @w_error = 720014,
        @w_msg = 'NO EXISTE RUTA DEL S_APP'
      goto ERRORFIN
    end
    print @w_s_app
    /*GENERACION PLANO DE REGISTROS PROCESADOS*/
    select
      @w_nombre_archivo = @w_path + 'Procesados_masivos' + '_' + @w_fecha_arch +
                          '_'
                          +
                                 @w_hora_arch +
                                 '.txt'

    if @i_transaccion = 'C'
      select
        @w_cmd = ' bcp "select * from cobis..cl_msv_proc where mp_id_carga = '
                 + convert(varchar(10), @w_carga) + '"' + ' queryout '
    if @i_transaccion = 'T'
      select
        @w_cmd =
      ' bcp "select * from cob_credito..cr_msv_proc where mp_id_carga = '
      + convert(varchar(10), @w_carga) + '"' + ' queryout '
    if @i_transaccion = 'N'
      select
        @w_cmd =
      ' bcp "select * from cob_cartera..ca_msv_proc where mp_id_carga = '
      + convert(varchar(10), @w_carga) + '"' + ' queryout '

    print @w_cmd

    select
      @w_comando = @w_cmd + @w_nombre_archivo + ' -b5000 -c -t"|" -T -S' +
                                         @@servername
                   + ' -eProcesados_Masivos.err'

    print @w_comando

    exec @w_error = xp_cmdshell
      @w_comando

    if @w_error <> 0
    begin
      select
        @w_msg = 'Error Generando BCP' + @w_comando
      goto ERRORFIN
    end

    /*GENERACION PLANO DE REGISTROS CON ERROR*/
    select
      @w_nombre_archivo = @w_path + 'Procesados_error' + '_' + @w_fecha_arch +
                          '_'
                          +
                                 @w_hora_arch + '.txt'

    select
      @w_cmd = ' bcp "select * from cobis..ca_msv_error where me_id_carga = '
               + convert(varchar(10), @w_carga) + '"' + ' queryout '

    select
      @w_comando = @w_cmd + @w_nombre_archivo + ' -b5000 -c -t"|" -T -S' +
                   @@servername
                   + ' -eProcesados_error.err'

    exec @w_error = xp_cmdshell
      @w_comando

    if @w_error <> 0
    begin
      select
        @w_msg = 'Error Generando BCP' + @w_comando
      goto ERRORFIN
    end
    --print 'llego a correos'
    /* TRAE LAS DIRECCIONES DE CORREO DESTINO */
    insert into #correos
      select
        en_ente,di_descripcion
      from   cobis..cl_ente with (nolock),
             cobis..cl_direccion with (nolock),
             cobis..cl_tabla a with (nolock),
             cobis..cl_catalogo b with (nolock)
      where  en_ente  = case
                          when isnumeric(b.valor) = 1 then b.valor
                          else 0
                        end
         and a.tabla  = 'cl_cuentas_correo'
         and b.tabla  = a.codigo
         and en_ente  = di_ente
         and b.estado = 'V'
         and di_tipo  = '001'

    select
      @w_correos = '',
      @w_ente = 0,
      @w_email = '',
      @w_user = '',
      @w_dom = ''

    /* VALIDA QUE LA DIRECCIONES DE CORREO SEAN CORRECTAS*/
    while 1 = 1
    begin
      set rowcount 1
      select
        @w_ente = nomente,
        @w_email = nemail
      from   #correos
      where  nomente > @w_ente
      order  by nomente asc

      if @@rowcount = 0
      begin
        set rowcount 0
        break
      end
      set rowcount 0

      select
        @w_email = ltrim(rtrim(@w_email))
      select
        @w_email = replace(@w_email,
                           ',',
                           '.')
      select
        @w_email = replace(@w_email,
                           '@ ',
                           '@')
      select
        @w_email = replace(@w_email,
                           ' @',
                           '@')
      select
        @w_email = replace(@w_email,
                           '. ',
                           '.')
      select
        @w_email = replace(@w_email,
                           ' .',
                           '.')
      select
        @w_email = replace(@w_email,
                           '±',
                           'n')

      --VALIDA ACENTOS, SI ENCUENTRA ACENTO INVALIDA EL EMAIL 
      if charindex('ﬂ',
                   @w_email,
                   1) > 0
          or charindex('⁄',
                       @w_email,
                       1) > 0
          or charindex('›',
                       @w_email,
                       1) > 0
          or charindex('æ',
                       @w_email,
                       1) > 0
          or charindex('∑',
                       @w_email,
                       1) > 0
      begin
        select
          @w_msg = 'Error en la Validacion del Correo Electronico para Env›o, '
                   +
                   @w_email,
          @w_error = 100211

        exec cobis..sp_error_proc_masivos
          @i_id_carga       = @w_carga,
          -- @i_id_alianza      = @w_alianza,      
          @i_referencia     = 'CORREO',
          @i_tipo_proceso   = 'C',
          @i_procedimiento  = @w_sp_name,
          @i_codigo_interno = 0,
          @i_codigo_err     = @w_error,
          @i_descripcion    = @w_msg
      end

      if charindex('”',
                   @w_email,
                   1) > 0
          or charindex('ﬁ',
                       @w_email,
                       1) > 0
          or charindex('˝',
                       @w_email,
                       1) > 0
          or charindex('=',
                       @w_email,
                       1) > 0
          or charindex('®',
                       @w_email,
                       1) > 0
      begin
        select
          @w_msg = 'Error en la Validacion del Correo Electronico para Env›o, '
                   +
                   @w_email,
          @w_error = 100211

        exec cobis..sp_error_proc_masivos
          @i_id_carga       = @w_carga,
          -- @i_id_alianza      = @w_alianza,      
          @i_referencia     = 'CORREO',
          @i_tipo_proceso   = 'C',
          @i_procedimiento  = @w_sp_name,
          @i_codigo_interno = 0,
          @i_codigo_err     = @w_error,
          @i_descripcion    = @w_msg
      end

      if charindex('@',
                   @w_email,
                   1) > 0
         and charindex('.',
                       @w_email,
                       charindex('@',
                                 @w_email)) > 0
      --VALIDA QUE EXISTA ARROBA Y PUNTO DESPUES DEL ARROBA 
      begin
        if charindex('@',
                     @w_email,
                     charindex('@', @w_email, 1) + 1) > 0
        begin
          select
            @w_msg =
          'Error en la Validacion del Correo Electronico para Env›o, '
          +
          @w_email,
            @w_error = 100211

          exec cobis..sp_error_proc_masivos
            @i_id_carga       = @w_carga,
            -- @i_id_alianza      = @w_alianza,      
            @i_referencia     = 'CORREO',
            @i_tipo_proceso   = 'C',
            @i_procedimiento  = @w_sp_name,
            @i_codigo_interno = 0,
            @i_codigo_err     = @w_error,
            @i_descripcion    = @w_msg

        end --ENCUENTRA 2 ARROBAS Y RETORNA NULO    

        select
          @w_user = substring(@w_email,
                              1,
                              charindex('@',
                                        @w_email) - 1)
        select
          @w_dom = substring(@w_email,
                             charindex( '@', @w_email) + 1,
                             100)
        select
          @w_user = ltrim(rtrim(@w_user))
        select
          @w_dom = ltrim(rtrim(@w_dom))

        --VALIDA QUE EL DOMINIO TENGA 2 O TRES CARACTERES
        if left(right(@w_dom,
                      3),
                1) = '.'
            or left(right(@w_dom,
                          4),
                    1) = '.'
        begin
          --REEMPLAZA ESPACIOS POR "_" SOLO EN USUARIO, NO EN DOMINIO 
          if charindex(' ',
                       @w_user) > 0
          begin
            select
              @w_user = replace(@w_user,
                                ' ',
                                '_')
            select
              @w_email = @w_user + '@' + @w_dom
          --RETORNA EMAIL CON ESPACIOS CONVERTIDOS
          end
          else
            select
              @w_email = @w_user + '@' + @w_dom --RETORNA EMAIL 
        end
        else
        begin
          select
            @w_msg =
          'Error en la Validacion del Correo Electronico para Env›o, '
          +
          @w_email,
            @w_error = 100211

          exec cobis..sp_error_proc_masivos
            @i_id_carga       = @w_carga,
            -- @i_id_alianza      = @w_alianza,      
            @i_referencia     = 'CORREO',
            @i_tipo_proceso   = 'C',
            @i_procedimiento  = @w_sp_name,
            @i_codigo_interno = 0,
            @i_codigo_err     = @w_error,
            @i_descripcion    = @w_msg

        end -- RETORNA NULO, EL DOMINIO TENIA MAS DE 3 LETRAS O MENOS DE 2
      end
      else
      begin
        if @w_email <> ''
        begin
          select
            @w_msg =
          'Error en la Validacion del Correo Electronico para Env›o, '
          +
          @w_email,
            @w_error = 100211

          exec cobis..sp_error_proc_masivos
            @i_id_carga       = @w_carga,
            -- @i_id_alianza      = @w_alianza,      
            @i_referencia     = 'CORREO',
            @i_tipo_proceso   = 'C',
            @i_procedimiento  = @w_sp_name,
            @i_codigo_interno = 0,
            @i_codigo_err     = @w_error,
            @i_descripcion    = @w_msg
        end
      end
      select
        @w_correos = @w_correos + @w_email + ' '
    end --end while  
    select
      @w_correos = ltrim(rtrim(@w_correos))
    select
      @w_correos = replace(@w_correos,
                           ' ',
                           ';')

    --select 'CORREOS: ' , @w_correos

    /* CONSULTA Y DESCUENTA EXISTENCIA DE CLIENTES */
    select
      @w_no_cta_reg_error = 0
    if @i_transaccion = 'C' --Clientes
    begin
      select
        @w_no_cta_reg_error = count(1)
      from   cobis..ca_msv_error with (nolock)
      where  me_id_carga     = @w_carga
         and me_tipo_proceso = 'C'
         and me_descripcion like
             'CLIENTE YA EXISTE EN LA BASE DE DATOS DE BANCAMIA,%'
    end

    if @i_transaccion = 'T' --Tramites
    begin
      select
        @w_no_cta_reg_error = count(1)
      from   cobis..ca_msv_error with (nolock)
      where  me_id_carga     = @w_carga
         and me_tipo_proceso = 'T'
         and me_descripcion like '%sp_ruteo%'
    end

    select
      @w_errores_aux = @w_errores
    select
      @w_errores = @w_errores - @w_no_cta_reg_error
    select
      @w_total = @w_externos

    if @w_procesados < 0
      select
        @w_procesados = 0

    if @w_errores < 0
      select
        @w_errores = 0

    --insert into cl_seguimiento_correo (sc_secuencial,sc_id_carga,sc_tipo_carga,sc_correos,sc_tot_registros,sc_procesados,sc_errores,sc_fecha_proc)
    -- values (11,@w_carga,@w_tipo_carga,@w_correos,@w_total,@w_procesados_aux,@w_errores,getdate())

    -- e ajsuta si los totales son mayores a los cuadrados
    if (@w_procesados + @w_errores) - @w_externos > 0
    begin
      select
        @w_errores = @w_externos - @w_procesados
    end

    /*GENERAR EL CUERPO DEL MENSAJE*/
    select
      @w_cuerpo_correo =
'<html><body><b>NOTIFICACION:</b> La carga ha finalizado de manera exitosa, los siguientes datos hacen parte de la informacion de la misma: <br><br>'
  select
    @w_cuerpo_correo = @w_cuerpo_correo + '<b>Secuencial de Carga: </b>'
                       + isnull(convert(varchar, @w_carga), 'Sin Carga') +
                       '<br>'
  select
    @w_cuerpo_correo = @w_cuerpo_correo +
                       '<b>Nombre del Archivo procesado: </b>'
                       + isnull(@w_nombre, 'Sin Nombre') + '<br>'
  select
    @w_cuerpo_correo = @w_cuerpo_correo + '<b>Nombre Alianza: </b>' + isnull(
                       @w_nom_alianza
    ,
                       'Sin Alianza'
    )
                       + '<br>'
  select
    @w_cuerpo_correo =
    @w_cuerpo_correo + '<b>Fecha y Hora de Proceso: </b>'
                       + isnull(convert(varchar, @w_fecha, 100), 'Sin Fecha') +
    '<br>'
  select
    @w_cuerpo_correo = @w_cuerpo_correo + '<b>Tipo de Carga: </b>' + isnull(
                                         @w_tipo_carga,
                                         'Sin Tipo Carga')
                       + '<br>'
  select
    @w_cuerpo_correo = @w_cuerpo_correo + '<b>Total de Registros: </b>'
                       + isnull(convert(varchar, @w_total),
                       'Sin Total Registros')
                       +
                                                              '<br>'
  select
    @w_cuerpo_correo = @w_cuerpo_correo + '<b>Registros Procesados: </b>'
                       + isnull(convert(varchar, @w_procesados),
                       'Sin Procesados')
                       +
    '<br>'
  select
    @w_cuerpo_correo = @w_cuerpo_correo + '<b>Registros Error: </b>'
                       + isnull(convert(varchar, @w_errores), 'Sin Error') +
                                         '<br><br>'
  select
    @w_cuerpo_correo = @w_cuerpo_correo
                       +
'El Detalle de los Registros de la Presente Carga se Encuentran en la Siguiente Ruta: '
                   + isnull(@w_ruta, 'Sin Ruta') + '<br></body></html>'

  /* Ejecuta el SP encargado de Mostrar el mensaje */

  if @w_correos <> ''
     and @w_carga > 0
  begin
    --      insert into cl_seguimiento_correo (sc_secuencial,sc_id_carga,sc_tipo_carga,sc_correos,sc_tot_registros,sc_procesados,sc_errores,sc_fecha_proc)
    --values (1,@w_carga,@w_tipo_carga,@w_correos,@w_total,@w_procesados,@w_errores,getdate())

    if (@w_procesados + @w_errores_aux) >= @w_externos
    begin -- Si se generaron todos los registros.
      insert into cl_seguimiento_correo
                  (sc_secuencial,sc_id_carga,sc_tipo_carga,sc_correos,
                   sc_tot_registros,
                   sc_procesados,sc_errores,sc_fecha_proc)
      values      (2,@w_carga,@w_tipo_carga,@w_correos,@w_total,
                   @w_procesados,@w_errores,getdate())

      exec @w_error = msdb.dbo.sp_send_dbmail
        --@profile_name = @w_archivo,
        @recipients  = @w_correos,
        --@recipients = 'jose.cortes@cobiscorp.com ; jorge.tellez@cobiscorp.com',
        --@recipients = 'pablo.silvera@bancamia.com.co ; juan.suarez@bancamia.com.co ; andrea.fernandez@bancamia.com.co ; jorge.amaya@bancamia.com.co',
        @subject     = 'Informe Cargue Archivo de Alianzas',
        @body        = @w_cuerpo_correo,
        @body_format = 'HTML'

      if @w_error <> 0
      begin
        goto ERRORFIN
      end

    end
  end
end

  return 0

  ERRORFIN:

  exec cobis..sp_error_proc_masivos
    @i_id_carga       = @w_carga,
    -- @i_id_alianza      = @w_alianza,      
    @i_referencia     = 'No_Id',
    @i_tipo_proceso   = 'C',
    @i_procedimiento  = @w_sp_name,
    @i_codigo_interno = 0,
    @i_codigo_err     = @w_error,
    @i_descripcion    = @w_msg

  return 1

go

