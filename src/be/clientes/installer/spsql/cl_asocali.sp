/************************************************************************/
/*    Archivo:                cl_asocali.sp                             */
/*    Stored Procedure:       sp_asociacion_alianza                     */
/*    Base de datos:          cobis                                     */
/*    Disenado por:           Jose Julian Cortes                        */
/*    Fecha de escritura:     27/03/2013                                */
/*    Producto:               Clientes                                  */
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
/*   Recolectar los registros de clientes creados masivamente para      */
/*   efectuar las validaciones pertinentes a la alianza asociada o no   */
/*   al cliente                                                         */
/*                                                                      */
/************************************************************************/
/*                           MODIFICACION                               */
/*    FECHA                    AUTOR               RAZON                */
/*  27/03/2013                 Jose Cortes       Emision Inicial        */
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
           where  name = 'sp_asociacion_alianza')
  drop proc sp_asociacion_alianza
go

create proc sp_asociacion_alianza
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_sesn         int = null,
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
  @t_trn          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @i_operacion    char(1) = null,
  @i_crea_ext     char(1) = null,
  @i_carga        int = null,
  @i_cliente      int,
  @i_alianza      int,
  @o_msg_msv      varchar(255) = null out
)
as
  declare
    @w_sp_name    varchar(32),/* NOMBRE STORED PROC*/
    @w_alianza    int,
    @w_msg        varchar(124),
    @w_count      int,
    @w_par_numali int,
    @w_referencia varchar(24),
    @w_fecha      datetime,
    @w_fecha_fija char(1)

  select
    @w_sp_name = 'sp_asociacion_alianza'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  ------------------------------
/* CODIGOS DE TRANSACCIONES */
  ------------------------------
  if isnull(@i_crea_ext,
            'N') = 'N' --Frontend
  begin
    if @t_trn <> 1365
    begin
      --TIPO DE TRANSACCION NO CORRESPONDE
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105504

      return 105504
    end
  end

  select
    @w_par_numali = pa_int
  from   cl_parametro
  where  pa_nemonico = 'NUMALI'
     and pa_producto = 'CRE'

  select
    @w_referencia = en_ced_ruc + '-' + en_tipo_ced
  from   cobis..cl_ente with (nolock)
  where  en_ente = @i_cliente

  if @w_referencia is null
  begin
    select
      @o_msg_msv = 'CODIGO DEL CLIENTE: ' + convert(varchar(25), @i_cliente) +
                          ' NO EXISTE, ' +
                          @w_sp_name

    if isnull(@i_crea_ext,
              'N') = 'N'
      print @o_msg_msv

    return 101129
  end

  /* VALIDA SI EXISTE ALIANZA COMERCIAL */

  select
    @w_alianza = al_alianza,
    @w_fecha_fija = al_fecha_fija
  from   cobis..cl_alianza with (nolock)
  where  al_alianza = @i_alianza
     and al_estado  = 'V'

  if @w_alianza is null
  begin
    select
      @w_msg = 'ALIANZA COMERCIAL NO EXISTE O NO ESTA VIGENTE'
    if isnull(@i_crea_ext,
              'N') = 'S' --Batch
    begin
      select
        @o_msg_msv = @w_msg + ', ' + @w_sp_name
      return 2805078
    end
    else
    begin
      print @w_msg
    end
    return 0
  end

  /* VALIDA: FECHA DE ASOCIACION FUERA DE FECHAS DE VIGENCIA DE LA ALIANZA */
  select
    @w_fecha = getdate()
  -- Se toma esta fecha porque es la fecha con que asocia el cliente a la alianza

  if not exists (select
                   '1'
                 from   cobis..cl_alianza
                 where  al_alianza                            = @w_alianza
                    and datediff(dd,
                                 @w_fecha,
                                 al_fecha_inicio) <= 0
                    and datediff(dd,
                                 @w_fecha,
                                 al_fecha_fin)    >= 0)
     and @w_fecha_fija = 'S'
  begin
    select
      @w_msg =
'FECHA DE ASOCIACION FUERA DE RANGO DE FECHAS DE VIGENCIA DE LA ALIANZA. FechaActual(dd/mm/yyyy): '
         + convert( varchar(20), @w_fecha, 103 )
  if isnull(@i_crea_ext,
            'N') = 'S' --Batch
  begin
    select
      @o_msg_msv = @w_msg + ', ' + @w_sp_name
    return 2805072
  -- select * from cobis..cl_errores where upper(mensaje)  like '%ASOCIA%' --numero = 2805072
  end
  else
  begin
    print @w_msg
  end
  return 0
end

  /* VALIDA SI EL CLIENTE EXISTE Y TIENE ASOCIADA UNA ALIANZA */
  if exists (select
               1
             from   cobis..cl_ente with (nolock),
                    cobis..cl_alianza with (nolock),
                    cobis..cl_alianza_cliente with (nolock)
             where  en_ente    = @i_cliente
                and en_ente    = ac_ente
                and ac_alianza = al_alianza
                and al_alianza <> @w_alianza
                and ac_estado  = 'V'
                and al_estado  = 'V')
  begin
    select
      @w_msg = 'CLIENTE YA PERTENECE A UNA ALIANZA COMERCIAL'
    if isnull(@i_crea_ext,
              'N') = 'S' --Batch
    begin
      select
        @o_msg_msv = @w_msg + ', ' + @w_sp_name
      return 2805072
    end
    else
    begin
      print @w_msg
    end
    return 0
  end

  /* VALIDA SI EL CLIENTE TIENE ASOCIADA MAS DE UNA ALIANZA */
  select
    @w_count = count(1)
  from   cobis..cl_alianza_cliente with (nolock),
         cobis..cl_alianza with (nolock)
  where  ac_ente    = @i_cliente
     and ac_alianza = al_alianza
     and ac_estado  = 'V'
     and al_estado  = 'V'

  if @w_count > @w_par_numali
  begin
    select
      @w_msg =
    'CLIENTE TIENE ASOCIADAS MAS ALIANZAS COMERCIALES DE LAS PERMITIDAS'
    if isnull(@i_crea_ext,
              'N') = 'S' --Batch
    begin
      select
        @o_msg_msv = @w_msg + ', ' + @w_sp_name
      return 2805072
    end
    else
    begin
      print @w_msg
    end
    return 0
  end

/* VALIDA SI EL CLIENTE EXISTE Y TIENE ASOCIADA UNA ALIANZA */
  --  if exists (select 1
  --		  from cobis..cl_ente with (nolock), cobis..cl_alianza with (nolock) , cobis..cl_alianza_cliente with (nolock)
  --             where en_ente = @i_cliente
  --             and en_ente   <> ac_ente
  --             and ac_alianza <> al_alianza)
  --  begin
  --select @w_msg = 'CLIENTE YA EXISTIA SIN PERTENECER A UNA ALIANZA COMERCIAL'
  --if @i_crea_ext = 'N' --Frontend
  --begin
  --	print @w_msg
  --end
  --  end

  /*** SE VALIDA QUE EL CLIENTE A ASOIAR SEA UNA PERSONA ***/
  if not exists (select
                   '1'
                 from   cobis..cl_ente
                 where  en_ente    = @i_cliente
                    and en_subtipo = 'P')
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 103124 -- DEBE INGRESAR UNA PERSONA
    return 103124
  end

  /*ASOCIA EL CLIENTE A LA ALIANZA SEÐALADA*/
  if not exists (select
                   1
                 from   cobis..cl_alianza_cliente with (nolock)
                 where  ac_alianza = @i_alianza
                    and ac_ente    = @i_cliente
                    and ac_estado  = 'V')
  begin
    insert into cobis..cl_alianza_cliente
                (ac_alianza,ac_ente,ac_estado,ac_fecha_asociacion,
                 ac_fecha_creacion,
                 ac_usuario_creador)
    values      ( @i_alianza,@i_cliente,'V',getdate(),getdate(),
                  @s_user)

    if @@error <> 0
    begin
      /* ERROR EN INSERCION DE ASOCIACION DE ALIANZA */
      select
        @w_msg = 'ERROR EN INSERCION DE ASOCIACION DE ALIANZA/CLIENTE'
      if isnull(@i_crea_ext,
                'N') = 'S' --Batch
      begin
        select
          @o_msg_msv = @w_msg + ', ' + @w_sp_name
        return 107100
      end
      else
      begin
        print @w_msg
      end
      return 0
    end
  end

  if isnull(@i_crea_ext,
            'N') = 'N' --Frontend
  begin
    select
      @w_msg = 'ASOCIACION DE ALIANZA CREADA SATISFACTORIAMENTE'
    print @w_msg
  end

  return 0

go

