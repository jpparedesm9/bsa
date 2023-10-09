/************************************************************************/
/*  Archivo:            compnombs.sp                                    */
/*  Stored procedure:   sp_compara_nomsipla                             */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Cristhian Herrera. SIPLA.                       */
/*  Fecha de escritura: 21-May-2001                                     */
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
/*                             PROPOSITO                                */
/*  Realiza comparacion de nombres de los Clientes con referencias      */
/*  Inhibitorias, usado para procesos Sipla                             */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA       AUTOR             RAZON                                 */
/*  21/May/2001 Cristhian Herrera  Emision Inicial. SIPLA.              */
/*  19/Abr/2004 Etna Laguna        Tunning                              */
/*  04/Nov/2008 Santiago Alban     Exoneracion de Hom•nimos             */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
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
           where  name = 'sp_compara_nomsipla')
  drop proc sp_compara_nomsipla
go

create proc sp_compara_nomsipla
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = 1378,
  @t_show_version bit = 0,
  @i_modo         tinyint = 3,
  @i_cod_ente     int = null,
  @i_cod_ref      int = null,
  @i_nomlar       varchar(64) = null,
  @i_tipo_cli     char(1) = null
)
as
  declare
    @w_today       datetime,
    @w_sp_name     varchar(32),
    @w_return      int,
    @w_nomlar      varchar (64),
    @w_p_nombre    varchar(16),
    @w_s_nombre    varchar(16),
    @w_codigo      int,
    @w_cuenta      int,
    @w_ente        int,
    @w_ced_ruc     varchar(12),
    @w_cont        int,
    @w_tipo_ced    varchar(13),
    @w_nombre      varchar(35),
    @w_sec         int,
    @w_lsrv        varchar(10),
    @w_min         int,
    @w_max         int,
    @w_cantidad    int,
    @w_p_apellido  varchar(16),
    @w_s_apellido  varchar(16),
    @w_parlista    varchar(10),
    @w_origen      varchar(10),
    @w_subtipo     char(1),
    @w_estado      varchar(10),
    @w_sexo        varchar(10),
    @w_observacion varchar(60),
    @w_codlista    int

  select
    @w_today = getdate()
  select
    @w_sp_name = 'sp_compara_nomsipla'
  --Version Ago262010
/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1378
  begin
    if (@i_tipo_cli != 'C'
        and @i_tipo_cli != 'P')
       and (@i_modo = 2)
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101114
      /* parametro invalido */
      return 1
    end

    set rowcount 1
    select
      @w_nomlar = @i_nomlar

    --identificar parametro listas restrictivas
    select
      @w_parlista = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'MIS'
       and pa_nemonico = 'LRES'

    if @i_modo = 1 /** EVALUA CLIENTES CONTRA REFERENCIAS INHIBITORIAS **/
    begin
      insert into cl_lista_clinton
        select
          @i_cod_ente,@i_nomlar,in_codigo,upper(in_nomlar),'NOMBRE COMPLETO'
        from   cobis..cl_refinh,
               cobis..cl_manejo_sarlaft
        where  ms_origen        = in_origen
           and ms_estado        = in_estado
           and ms_restrictiva   = @w_parlista
           and (upper(in_nombre) = @w_nomlar
                 or upper(in_nomlar) = @w_nomlar)
           and in_codigo        > 0

    end

    if @i_modo = 2 /** EVALUA REFERENCIAS INHIBITORIAS CONTRA CLIENTES**/
    begin
      select
        @w_nomlar = @i_nomlar
      insert into cl_lista_clinton
        select
          en_ente,en_nomlar,@i_cod_ref,@i_nomlar,'NOMBRE COMPLETO'
        from   cobis..cl_ente,
               cobis..cl_refinh,
               cobis..cl_manejo_sarlaft
        where  ms_origen      = in_origen
           and ms_estado      = in_estado
           and ms_restrictiva = @w_parlista
           and en_subtipo     = @i_tipo_cli
           and en_nomlar      = @w_nomlar

    end

    if @i_modo = 3
    begin
      update cobis..cl_ente
      set    en_mala_referencia = 'S'
      from   cobis..cl_refinh,
             cobis..cl_ente
      where  en_ced_ruc         = in_ced_ruc
         and en_mala_referencia <> 'S'

      select
        @w_sec = se_numero
      from   cobis..ba_secuencial

      update cobis..ba_secuencial
      set    se_numero = @w_sec + 100

      select
        @w_lsrv = pa_char
      from   cl_parametro
      where  pa_nemonico = 'SRVR'
         and pa_producto = 'ADM'

      set rowcount 0
      select distinct
        (in_nomlar),
        'cantidad' = count(0),
        'ente' = en_ente,
        'origen' = in_origen,
        'estado' = in_estado,
        'codlista' = in_entid
      into   #unicos
      from   cobis..cl_ente,
             cobis..cl_refinh,
             cobis..cl_manejo_sarlaft
      where  ms_origen      = in_origen
         and ms_estado      = in_estado
         and ms_restrictiva = @w_parlista
         and en_nomlar      = upper(in_nomlar)
         and en_ente not in(select
                              le_ente
                            from   cobis..cl_lista_exonerados)
      group  by in_nomlar,
                en_ente,
                in_origen,
                in_estado,
                in_entid

      declare cursor_homonimos cursor for
        select
          ente,
          cantidad,
          in_nomlar,
          origen,
          estado,
          codlista
        from   #unicos
        order  by ente

      open cursor_homonimos

      fetch cursor_homonimos into @w_ente,
                                  @w_cantidad,
                                  @w_nomlar,
                                  @w_origen,
                                  @w_estado,
                                  @w_codlista
      while (@@fetch_status != -1)
      begin
        -- Control del estado del cursor
        if @@fetch_status = -2
        begin
          close cursor_homonimos
          deallocate cursor_homonimos
          print 'Aborta ... cursor_homonimos'
          return 2
        end

        if @w_ente > 0
           and @w_cantidad > 0
        begin
          print 'ente  a actualizar'
          print @w_ente
          print @w_cantidad

          exec @w_return = sp_cseqnos
            @t_debug     = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            @i_tabla     = 'cl_refinh',
            @o_siguiente = @w_codigo out

          if @w_return <> 0
          begin
            return @w_return
          end

          set rowcount 1

          --print 'ente  actualizado ' + @w_ente + @w_documento + @w_cadena_nueva
          update cobis..cl_ente
          set    en_mala_referencia = 'S',
                 en_cont_malas = @w_cantidad
          from   cl_ente
          where  en_ente = @w_ente

          if @@error != 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 105026
            /* 'Error en actualizacion de persona'*/
            return 1
          end

          select
            @w_sec = @w_sec + 1

          select
            @w_tipo_ced = en_tipo_ced,
            @w_ced_ruc = en_ced_ruc,
            @w_p_apellido = p_p_apellido,
            @w_s_apellido = p_s_apellido,
            @w_nombre = en_nombre,
            @w_nomlar = en_nomlar,
            @w_subtipo = en_subtipo,
            @w_sexo = p_sexo
          from   cobis..cl_ente
          where  en_ente = @w_ente

          if not exists (select
                           1
                         from   cobis..cl_refinh
                         where  in_observacion like '%HOMONIM%'
                            and in_categoria = @w_ced_ruc) --Vigente
          begin
            select
              @w_observacion = 'INGRESO POR HOMONIMIA-AUTOMATICO - ' +
                               @w_ced_ruc

            /* si no xiste un rgistro vigente ingresar el actul cliente */

            insert into cobis..cl_refinh
                        (in_codigo,in_documento,in_ced_ruc,in_nombre,
                         in_fecha_ref,
                         in_origen,in_observacion,in_fecha_mod,in_subtipo,
                         in_p_p_apellido,
                         in_p_s_apellido,in_tipo_ced,in_nomlar,in_estado,in_sexo
                         ,
                         in_usuario,in_aka,
                         in_categoria,in_subcategoria,in_fuente,
                         in_otroid,in_pasaporte,in_concepto,in_entid)
            values      ( @w_codigo,0,null,upper(@w_nombre),@w_today,
                          @w_origen,@w_observacion,@w_today,@w_subtipo,upper(
                          @w_p_apellido
                          ),
                          upper(@w_s_apellido),@w_tipo_ced,upper(@w_nomlar),
                          @w_estado,
                          @w_sexo,
                          'opbatch',null,@w_ced_ruc,null,null,
                          null,null,null,@w_codlista )

            if @@error != 0
            begin
              /* Error inserci½n de regisros */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 203042
              return 1
            end
          end

          -- MIRAR LA TRX DE SERVICIO FSAPITO
          insert into ts_refinh
                      (secuencial,tipo_transaccion,clase,fecha,usuario,
                       terminal,srv,lsrv,ced_ruc,nombre,
                       fecha_ref,origen,observacion,codigo,documento,
                       fecha_mod,p_apellido,s_apellido,tipo_ced,ref_estado)
          values      ( @w_sec,1280,'P',@w_today,'operador',
                        'consola',@w_lsrv,@w_lsrv,@w_ced_ruc,@w_nombre,
                        null,'S','INGRESO POR HOMONIMIA',@w_ente,0,
                        @w_today,@w_p_apellido,@w_s_apellido,@w_tipo_ced,'I')

          if @@error != 0
          begin
            /* Error en creacion de transaccion de servicios  covinco*/
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 903002
            return 1
          end
          goto SIGUIENTE

        end --@w_ente > 0 and @w_hijo > 0

        ------
        SIGUIENTE:
        fetch cursor_homonimos into @w_ente,
                                    @w_cantidad,
                                    @w_nomlar,
                                    @w_origen,
                                    @w_estado,
                                    @w_codlista
      end -- while
      close cursor_homonimos
      deallocate cursor_homonimos
    end --modo 5
  end --trn

  return 0

go

