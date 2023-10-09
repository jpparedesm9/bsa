/************************************************************************/
/*  Archivo:            creaper.sp                                      */
/*  Stored procedure:   sp_crea_persona                                 */
/*  Base de datos:      cobis                                           */
/*  Producto:           Credito y Cartera                               */
/*  Disenado por:       Sandra Ortiz                                    */
/*  Fecha de escritura: 04-May-1995                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                          PROPOSITO                                   */
/*  Este stored procedure inserta personas con datos incompletos        */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA       AUTOR       RAZON                                       */
/*  04-May-1995 Sandra Ortiz    Emision inicial                         */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
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
           where  name = 'sp_crea_persona')
  drop proc sp_crea_persona
go

create proc sp_crea_persona
(
  @s_ssn          int,
  @s_user         login,
  @s_term         varchar (30),
  @s_date         datetime,
  @s_srv          varchar(30),
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @t_debug        char(1) ='N',
  @t_file         varchar(14) = null,
  @t_from         descripcion = null,
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_nombre       descripcion,
  @i_p_apellido   varchar(16),
  @i_s_apellido   varchar(16),
  @i_filial       tinyint,
  @i_cedula       numero = null,
  @i_pasaporte    varchar(20) = null,
  @i_sexo         catalogo = null
)
as
  declare
    @w_sp_name   descripcion,
    @w_return    int,
    @w_ente      int,
    @w_subtipo   char (1),
    @w_fecha_mod datetime,
    @w_pais      catalogo,
    @w_referido  smallint

  /*  Inicializar nombre del stored procedure  */
  select
    @w_sp_name = 'sp_crea_persona'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_referido = fu_funcionario
  from   cobis..cl_funcionario
  where  fu_login = @s_user

  if @t_trn <> 1266
  begin
    /* Codigo de transaccion invalido */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101147
    return 1
  end

  select
    @w_subtipo = 'P',
    @w_fecha_mod = getdate(),
    @w_pais = y.codigo
  from   cl_tabla x,
         cl_default y
  where  x.tabla   = 'cl_pais'
     and x.codigo  = y.tabla
     and y.oficina = @s_ofi
     and y.srv     = @s_lsrv

  begin tran

  /* verificar que no este previamente insertada la persona */
  if exists (select
               cedula
             from   cl_persona
             where  cedula = @i_cedula)
     and @i_cedula is not null
     and @i_cedula <> '          '
  begin
    /* Dato ya existe'*/
    exec sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from = @w_sp_name,
      @i_num  = 101061
    return 1
  end

  exec sp_cseqnos
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_tabla     = 'cl_ente',
    @o_siguiente = @w_ente out

  /* insertar los parametros de entrada */

  insert into cl_ente
              (en_ente,en_nombre,en_subtipo,en_filial,en_oficina,
               en_fecha_mod,en_pais,en_retencion,en_mala_referencia,en_direccion
               ,
               en_casilla,en_referencia,en_balance,en_actividad,
               en_cont_malas,
               p_p_apellido,p_s_apellido,p_sexo,p_fecha_nac,p_profesion,
               p_pasaporte,p_estado_civil,p_tipo_persona,p_personal,p_propiedad,
               p_trabajo,p_soc_hecho,en_ced_ruc,en_referido)
  values      (@w_ente,@i_nombre,@w_subtipo,@i_filial,@s_ofi,
               @w_fecha_mod,convert(tinyint, @w_pais),'N','N',0,
               0,0,0,'0',0,
               @i_p_apellido,@i_s_apellido,@i_sexo,'01/01/1900','0',
               @i_pasaporte,'ND','ND',0,0,
               0,0,@i_cedula,@w_referido )

  /* si no se pudo insertar, error */
  if @@error <> 0
  begin
    /* Error en insercion de compania */
    exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from = @w_sp_name,
      @i_num  = 105006
    return 1
  end

  insert into ts_persona
              (secuencial,tipo_transaccion,clase,fecha,usuario,
               terminal,srv,lsrv,persona,nombre,
               filial,oficina,p_apellido,s_apellido,sexo,
               cedula,estado_civil,fecha_nac,referido)
  values      (@s_ssn,@t_trn,'E',getdate(),@s_user,
               @s_term,@s_srv,@s_lsrv,@w_ente,@i_nombre,
               @i_filial,@s_ofi,@i_p_apellido,@i_s_apellido,@i_sexo,
               @i_cedula,'ND','01/01/1900',@w_referido)

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

  select
    @w_ente
  return 0

go

