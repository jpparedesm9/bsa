/************************************************************************/
/*      Archivo:                atrib.sp                                */
/*      Stored procedure:       sp_atributo                             */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Sandra Ortiz/Mauricio Bayas             */
/*      Fecha de escritura:     06-May-94                               */
/************************************************************************/
/*                            IMPORTANTE                                */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'MACOSA', representantes  exclusivos  para el  Ecuador  de la     */
/*    'NCR CORPORATION'.                                                */
/*    Su  uso no autorizado  queda expresamente  prohibido asi como     */
/*    cualquier   alteracion  o  agregado  hecho por  alguno de sus     */
/*    usuarios   sin el debido  consentimiento  por  escrito  de la     */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                             PROPOSITO                                */
/*    Este programa procesa las transacciones del stored procedure      */
/*    de los atributos de una relacion, sobre la tabla cl_at_relacion   */
/*    Insercion, Modificacion, Borrado y Busqueda de cl_at_relacion     */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR            RAZON                            */
/*    06-May-94       R. Minga V.      Emision Inicial                  */
/*    May/02/2016     DFu             Migracion CEN                     */
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
           where  name = 'sp_atributo')
  drop proc sp_atributo
go

create proc sp_atributo
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_rol          smallint = null,
  @s_ofi          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_filial       tinyint = null,
  @i_servicio     smallint = null,
  @i_perfil       smallint = nul,
  @i_atributo     varchar(30) = null,
  @i_minimo       descripcion = null,
  @i_maximo       descripcion = null
)
as
  declare
    @w_siguiente tinyint,
    @w_sp_name   varchar(32),
    @w_minimo    descripcion,
    @w_maximo    descripcion

  select
    @w_sp_name = 'sp_atributo'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Insercion de atributo  */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1165
    begin
      begin tran
      insert into cl_atributo
                  (at_filial,at_servicio,at_perfil,at_atributo,at_maximo,
                   at_minimo)
      values      (@i_filial,@i_servicio,@i_perfil,@i_atributo,@i_minimo,
                   @i_maximo)
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103059
        /*'Error en insercion de atributo'*/
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_atributo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,filial,servicio,
                   perfil,atributo,minimo,maximo)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_filial,@i_servicio,
                   @i_perfil,@i_atributo,@i_minimo,@i_maximo)

      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
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

  /*  Actualizacion de atributo  */
  if @i_operacion = 'U'
  begin
    if @t_trn = 1204
    begin
      /*Datos transaccion de servicio*/

      select
        @w_minimo = at_minimo,
        @w_maximo = at_maximo
      from   cl_atributo
      where  at_filial   = @i_filial
         and at_servicio = @i_servicio
         and at_perfil   = @i_perfil
         and at_atributo = @i_atributo

      begin tran
      update cl_atributo
      set    at_minimo = @i_minimo,
             at_maximo = @i_maximo
      where  at_filial   = @i_filial
         and at_servicio = @i_servicio
         and at_perfil   = @i_perfil
         and at_atributo = @i_atributo
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105050
        /*'Error en actualizacion de atributo'*/
        return 1
      end
      /*  Transaccion de Servicio Registro Previo */
      insert into ts_atributo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,filial,servicio,
                   perfil,atributo,minimo,maximo)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_filial,@i_servicio,
                   @i_perfil,@i_atributo,@w_minimo,@w_maximo)

      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end

      /*  Transaccion de Servicio Registro Actual */
      insert into ts_atributo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,filial,servicio,
                   perfil,atributo,minimo,maximo)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_filial,@i_servicio,
                   @i_perfil,@i_atributo,@i_minimo,@i_maximo)

      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
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

  /*  Consulta de atributos de un perfil  */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1205
    begin
      select
        'Atributo' = substring(at_atributo,
                               1,
                               20),
        'Valor Minimo' = substring(at_minimo,
                                   1,
                                   10),
        'Valor Maximo' = substring(at_maximo,
                                   1,
                                   10)
      from   cl_atributo
      where  at_filial   = @i_filial
         and at_servicio = @i_servicio
         and at_perfil   = @i_perfil
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101059
        /* 'No existen datos de perfil' */
        return 1
      end

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

