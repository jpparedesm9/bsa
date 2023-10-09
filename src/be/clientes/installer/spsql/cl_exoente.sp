/************************************************************************/
/*  Archivo:            cl_exoente.sp                                   */
/*  Stored procedure:   sp_exonera_ente                                 */
/*  Base de datos:      Cobis                                           */
/*  Producto:           M.I.S.                                          */
/*  Disenado por:       Santiago Alban P.                               */
/*  Fecha de escritura: 03-Nov-2008                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                          PROPOSITO                                   */
/*  Este programa procesa las transacciones del store procedure         */
/*  Busqueda de Historia de Relaciones                                  */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*  FECHA       AUTOR               RAZON                               */
/*  03-Nov-2008 Santiago Alban P.   Emision Inicial                     */
/*  02-May-2016 DFu                 Migracion CEN                       */
/************************************************************************/
use cobis
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_exonera_ente')
  drop proc sp_exonera_ente
go

create proc sp_exonera_ente
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_modo         tinyint = null,
  @i_ente_i       int = null,
  @i_relacion     smallint = null,
  @i_ente_d       int = null,
  @i_fecha        datetime = null,
  @i_estado       char(1) = null,
  @i_observacion  descripcion = null
)
as
  declare
    @w_return   int,
    @w_sp_name  varchar(32),
    @w_ced_ruc  varchar(12),
    @w_tipo_ced varchar(13),
    @w_nombre   varchar(35),
    @w_contador smallint,
    @w_malas    char(1)

  select
    @w_sp_name = 'sp_exonera_ente'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --VERSION AGOSTO 10/2009
  if @t_trn = 1027
  begin
    set rowcount 20
    if @i_modo = 0
      select
        'Ente' = le_ente,
        'TipoDoc' = le_tipo_ced,
        'Documento' = le_ced_ruc,
        'Nombre' = le_nombre,
        'Estado' = le_estado,
        'Fecha_Marca' = le_fecha_marc,
        'Fecha_Desmarque' = le_fecha_desm,
        'Observacion_del_desmarque' = le_observacion,
        'Modo_Ingreso' = le_modo_origen,
        'Observacion_Exoneracion' = isnull(le_obs_exoneracion,
                                           '    ')
      from   cl_lista_exonerados
      where  le_ente = isnull(@i_ente_i,
                              le_ente)
      order  by le_ente,
                le_fecha_marc

    if @i_modo = 1
    begin
      if @i_fecha is null
        select
          @i_fecha = fp_fecha
        from   cobis..ba_fecha_proceso

      select
        'Ente' = le_ente,
        'TipoDoc' = le_tipo_ced,
        'Documento' = le_ced_ruc,
        'Nombre' = le_nombre,
        'Estado' = le_estado,
        'Fecha_Marca' = le_fecha_marc,
        'Fecha_Desmarque' = le_fecha_desm,
        'Observacion_Lista_Clinton' = le_observacion,
        'Modo_Ingreso' = le_modo_origen,
        'Observacion_Exoneracion' = isnull(le_obs_exoneracion,
                                           '  ss  ')
      from   cl_lista_exonerados
      where  le_ente       = isnull(@i_ente_d,
                                    le_ente)
         and (le_ente       > @i_ente_d
               or (le_ente       = @i_ente_d
                   and le_fecha_marc > @i_fecha))
      order  by le_ente,
                le_fecha_marc,
                le_estado
    end
    set rowcount 0
    return 0

  end
  else if @t_trn = 1028
  begin
    begin tran
    update cl_lista_exonerados
    set    le_estado = @i_estado,
           le_fecha_desm = getdate(),
           le_obs_exoneracion = isnull(@i_observacion,
                                       le_obs_exoneracion)
    where  le_ente       = @i_ente_i
       and le_estado     = 'V'
       and (le_fecha_desm is null
             or le_fecha_desm = '')

    if @@error <> 0
    begin
      /* Error en actualizacion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 150001
      return 1
    end

    select
      @w_ced_ruc = en_ced_ruc,
      @w_nombre = en_nomlar,
      @w_tipo_ced = en_tipo_ced
    from   cobis..cl_ente
    where  en_ente = @i_ente_i

    select
      @w_contador = isnull(count(0),
                           0)
    from   cobis..cl_refinh
    where  in_tipo_ced = @w_tipo_ced
       and in_ced_ruc  = @w_ced_ruc

    if @w_contador = 0
      select
        @w_malas = 'N'
    if @w_contador > 0
      select
        @w_malas = 'S'

    update cobis..cl_ente
    set    en_mala_referencia = @w_malas,
           en_cont_malas = @w_contador
    from   cobis..cl_ente
    where  en_ente = @i_ente_i

    if @@error <> 0
    begin
      /* Error en actualizacion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 150001
      return 1
    end

    if @s_ssn is null
      exec @s_ssn = ADMIN...rp_ssn

    -- MIRAR LA TRX: Falta definicion de A.C 
    insert into ts_refinh
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,ced_ruc,nombre,
                 fecha_ref,origen,observacion,codigo,documento,
                 fecha_mod,p_apellido,s_apellido,tipo_ced,ref_estado)
    values      ( @s_ssn,1028,'N',getdate(),
                  --@t_trn = 1280 'I'     -- la trx 444 ??
                  @s_user,
                  @s_term,@s_srv,@s_lsrv,@w_ced_ruc,@w_nombre,
                  null,'S','EXONERACION POR HOMONIMIA',@i_ente_i,@w_ced_ruc,
                  getdate(),@w_nombre,@w_nombre,@w_tipo_ced,'I')

    if @@error <> 0
    begin
      /* Error en creacion de transaccion de servicios  covinco*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 903002
      return 1
    end
    commit tran
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

