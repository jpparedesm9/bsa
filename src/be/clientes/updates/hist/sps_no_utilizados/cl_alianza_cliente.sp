/* ***********************************************************************/
/*      Archivo:                cl_alianza_cliente.sp                    */
/*      Base de datos:          cobis                                    */
/*      Producto:               Clientes                                 */
/*      Disenado por:           j.molano                                 */
/*      Fecha de escritura:     Abril-2013                               */
/* ***********************************************************************/
/*              IMPORTANTE                                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de COBISCorp.                                                        */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/* ***********************************************************************/
/*              PROPOSITO                                                */
/*  Permite consultar los clientes asociados a las alianzas comerciales  */
/*  existentes.                                                          */
/* ***********************************************************************/
/*                 MODIFICACIONES                                        */
/*  FECHA          AUTOR            RAZON                                */
/*  May/02/2016    DFu              Migracion CEN                        */
/*************************************************************************/
use cobis
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_alianza_cliente')
  drop proc sp_alianza_cliente
go

create proc sp_alianza_cliente
(
  @t_trn          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @i_alianza      int = null,
  @i_operacion    char(1) = null,
  @i_modo         tinyint = 0,
  @i_ente         int = 0,
  @i_formato      int = null
)
as
  declare
    @w_sp_name      varchar(64),
    @w_alianza      int,
    @w_existe       tinyint,
    @w_cant_alianza int,
    @w_id           int,
    @w_cedula       varchar(13),
    @w_tipo_ced     char(2),
    @w_estdo        char(1)

  select
    @w_sp_name = 'sp_alianza_cliente'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_operacion = 'Q'
  begin
    select
      ente = ac_ente,
      fecha = max(ac_fecha_asociacion)
    into   #clientes
    from   cl_alianza_cliente
    where  ac_alianza = @i_alianza
       and ac_estado  = 'V'
    group  by ac_ente

    if @i_modo = 0
    begin
      select top 20
        'CLIENTE' = ac_ente,
        'IDENTIFICACION' = (select
                              en_ced_ruc
                            from   cobis..cl_ente
                            where  en_ente = ac_ente),
        'NOMBRE' = (select
                      en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido
                    from   cobis..cl_ente
                    where  en_ente = ac_ente),
        'FECHA ASOCIACION' = convert(varchar(10), ac_fecha_asociacion,
                             @i_formato)
        ,
        'FECHA DESASOCIACION' = convert(varchar(10), ac_fecha_desasociacion
                                ,
                                @i_formato)
      from   cl_alianza_cliente,
             #clientes
      where  ac_alianza          = @i_alianza
         and ac_ente             = ente
         and ac_fecha_asociacion = fecha
      order  by ac_ente

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103121
        -- LA ALIANZA SELECCIONADA NO TIENE CLIENTES ASOCIADOS
        return 103121
      end
    end
    else
    begin
      select top 20
        'Cliente' = ac_ente,
        'Identificaci¾n' = (select
                              en_ced_ruc
                            from   cobis..cl_ente
                            where  en_ente = ac_ente),
        'Nombre' = (select
                      en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido
                    from   cobis..cl_ente
                    where  en_ente = ac_ente),
        'Fecha Asociacion' = convert(varchar(10), ac_fecha_asociacion,
                             @i_formato)
        ,
        'Fecha Desasociacion' = convert(varchar(10), ac_fecha_desasociacion
                                ,
                                @i_formato)
      from   cl_alianza_cliente,
             #clientes
      where  ac_alianza          = @i_alianza
         and ac_ente             = ente
         and ac_fecha_asociacion = fecha
         and ac_ente             > @i_ente
      order  by ac_ente
    end

  end

  if @i_operacion = 'V'
  begin
    -- update cobis..cl_alianza  set al_estado = 'C' where al_alianza = 37 
    select
      ac_ente,
      (select
         en_ced_ruc
       from   cobis..cl_ente
       where  en_ente = ac_ente),
      (select
         en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido
       from   cobis..cl_ente
       where  en_ente = ac_ente),
      convert(varchar(10), ac_fecha_asociacion, @i_formato),
      convert(varchar(10), ac_fecha_desasociacion, @i_formato),
      case
        when ac_estado = 'V' then 'V:Vigente'
        when ac_estado = 'C' then 'C:Cancelado'
      end
    from   cl_alianza_cliente
    where  ac_ente   = @i_ente
       and ac_estado = 'V'

  end
  if @i_operacion = 'C'
  begin
    select
      ente = ac_ente,
      fecha = max(ac_fecha_desasociacion)
    into   #cliente
    from   cl_alianza_cliente
    where  ac_ente = @i_ente
    group  by ac_ente

    select
      ac_ente,
      (select
         en_ced_ruc
       from   cobis..cl_ente
       where  en_ente = ac_ente),
      (select
         en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido
       from   cobis..cl_ente
       where  en_ente = ac_ente),
      convert(varchar(10), ac_fecha_asociacion, @i_formato),
      convert(varchar(10), ac_fecha_desasociacion, @i_formato),
      ac_estado
    from   cl_alianza_cliente,
           #cliente
    where  ac_alianza = @i_alianza
       and ac_ente    = @i_ente
  end

  if @i_operacion = 'T'
  begin
    if not exists (select
                     1
                   from   cobis..cl_ente,
                          cobis..cl_tipo_documento
                   where  en_ente     = @i_ente
                      and en_tipo_ced = ct_codigo
                      and ct_subtipo  = 'P'
                      and ct_estado   = 'V')
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103125 -- TIPO DE DOCUMENTO DEBE SER DE PERSONA NATURAL.
      return 103125

    end

    if exists (select
                 1
               from   cobis..cl_ente with (nolock),
                      cobis..cl_alianza with (nolock),
                      cobis..cl_alianza_cliente with (nolock)
               where  en_ente    = @i_ente
                  and en_ente    = ac_ente
                  and ac_alianza = al_alianza
                  and ac_estado  = 'V'
                  and al_estado  = 'V')
    begin
      print 'CLIENTE YA PERTENECE A UNA ALIANZA COMERCIAL'
    end

    select
      en_subtipo,
      en_nombre,
      p_p_apellido,
      p_s_apellido
    from   cobis..cl_ente
    where  en_ente = @i_ente

    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101146 -- CLIENTE NO EXISTE
      return 101146
    end

  end

  if @i_operacion = 'A'
  begin
    select
      en_subtipo,
      en_nombre,
      p_p_apellido,
      p_s_apellido
    from   cobis..cl_ente
    where  en_ente    = @i_ente
       and en_subtipo = 'C'

    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103122 -- DEBE INGRESAR UNA COMPAÑIA
      return 103122
    end

  end

  if @i_operacion = 'X'
  begin
    if @i_modo = 0
    begin
      select
        @w_estdo = ac_estado
      from   cobis..cl_alianza_cliente
      where  ac_alianza = @i_alianza
         and ac_ente    = @i_ente

      select
        @w_estdo
    end
    if @i_modo = 1
    begin
      select
        @w_cedula = en_ced_ruc,
        @w_tipo_ced = en_tipo_ced
      from   cobis..cl_ente
      where  en_ente = @i_ente

      begin tran
      delete cob_externos..ex_msv_novedades
      where  mtn_id_carga   = 0
         and mtn_id_Alianza = @i_alianza
         and mtn_cedula     = @w_cedula
         and mtn_tipo_ced   = @w_tipo_ced
      if @@error <> 0
      begin
        print 'Error en borrado de novedad'
        rollback tran
        return 1
      end

      update cobis..cl_alianza_cliente
      set    ac_estado = 'V'
      where  ac_alianza = @i_alianza
         and ac_ente    = @i_ente
         and ac_estado  = 'X'
      if @@error <> 0
      begin
        print 'Error en cambio de estado'
        rollback tran
        return 1
      end
      commit tran
    end
  end

  if @i_operacion = 'D'
  begin
    select
      @w_cedula = en_ced_ruc,
      @w_tipo_ced = en_tipo_ced
    from   cobis..cl_ente
    where  en_ente = @i_ente

    if exists(select
                1
              from   cobis..cl_alianza_cliente
              where  ac_alianza = @i_alianza
                 and ac_ente    = @i_ente
                 and ac_estado  = 'V')
    begin
      begin tran
      if not exists (select
                       1
                     from   cob_externos..ex_msv_novedades
                     where  mtn_id_Alianza = @i_alianza
                        and mtn_cedula     = @w_cedula
                        and mtn_id_carga   = 0)
      begin
        insert into cob_externos..ex_msv_novedades
                    (mtn_id_carga,mtn_id_Alianza,mtn_cedula,mtn_tipo_ced,
                     mtn_estado,
                     mtn_fecha_estado)
        values      ( 0,@i_alianza,@w_cedula,@w_tipo_ced,'E',
                      getdate())
        if @@error <> 0
        begin
          rollback tran
          print 'Error en cambio de  estado.'
          return 1
        end
      end
      else
      begin
        update cob_externos..ex_msv_novedades
        set    mtn_estado = 'E',
               mtn_fecha_estado = getdate()
        where  mtn_id_Alianza = @i_alianza
           and mtn_cedula     = @w_cedula
           and mtn_id_carga   = 0

        if @@error <> 0
        begin
          rollback tran
          print 'Error en cambio de estado.'
          return 1
        end
      end
      update cobis..cl_alianza_cliente
      set    ac_estado = 'X'
      where  ac_alianza = @i_alianza
         and ac_ente    = @i_ente
         and ac_estado  = 'V'
      if @@error <> 0
      begin
        rollback tran
        print 'Error en cambio de estado'
        return 1
      end
      commit tran
    end
  end
  return 0

go

