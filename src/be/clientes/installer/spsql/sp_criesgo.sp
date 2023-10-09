/************************************************************************/
/* Archivo:                sp_criesgo.sp                                */
/* Stored procedure:       sp_cent_riesgo                               */
/* Base de datos:          cobis                                        */
/* Producto:               Clientes                                     */
/* Disenado por:           M.Bernal                                     */
/* Fecha de escritura:     09-09-2008                                   */
/*                         IMPORTANTE                                   */
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
/*                         PROPOSITO                                    */
/* Este programa procesa la informacion que se carga en la pantalla     */
/* de consulta de Datacredito                                           */
/************************************************************************/
/*                         MODIFICACIONES                               */
/* FECHA           AUTOR              RAZON                             */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
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
           where  name = 'sp_cent_riesgo')
           drop proc sp_cent_riesgo
go

create proc sp_cent_riesgo
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
  @t_trn          int,
  @t_show_version bit = 0,
  @i_operacion    char(1) = null,
  @i_secuencial   int = 0,
  @i_tipo_per     char(1) = null,
  @i_formato_f    tinyint = 101,
  @i_ente         int = null,
  @i_ced_ruc      numero = null,
  @i_tipo_ced     char(2) = null,
  @i_siguiente    int = 0,
  @i_oficial      smallint = null,
  @i_oficina      int = null,
  @i_subtipo      char(1) = null,
  @i_nombre       varchar(60) = null,
  @i_p_apellido   varchar(30) = null,
  @i_s_apellido   varchar(30) = null,
  @i_validado     char(1) = null,
  @i_central      varchar(10) = null -- GAL 19/AGO/2010 - REQ 108: CIFIN
)
as
  set nocount on
  declare
    @w_return   int,
    @w_sp_name  varchar(32),
    @w_estado   char(1),
    @w_fecha    datetime,
    @w_tservice varchar(10)

  select
    @w_sp_name = 'sp_cent_riesgo'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha = getdate()

  declare @novedad_ente_tmp table
  (
     ne_secuencial  smallint identity,
     ne_central     varchar(10) null,
     ne_ente        int null,
     ne_tipo        varchar(10) null,
     ne_descripcion varchar(255) null,
     ne_cobis       varchar(30) null,
     ne_datac       varchar(30) null,
     ne_aplicado    char(1) null,
     ne_fec_aplica  datetime null,
     ne_user_aplica login null
  )

  if @i_operacion = 'Q'
  begin
    insert into @novedad_ente_tmp
      select
        ne_central,ne_ente,ne_tipo,ne_descripcion,ne_cobis,
        ne_datac,ne_aplicado,ne_fec_aplica,ne_user_aplica
      from   cobis..cl_novedad_ente with(nolock)
      where  ne_ente = @i_ente
    set rowcount 20
    select
      'SECUENCIAL' = ne_secuencial,
      'CENTRAL   ' = ne_central,
      'ENTE      ' = ne_ente,
      'TIPO ERROR' = ne_tipo,
      'DESCRIPCION'= ne_descripcion,
      'EN COBIS   '= ne_cobis,
      'EN CENTRAL '= ne_datac,
      'TIPO ID    '= en_tipo_ced,
      'NUMERO ID  '= en_ced_ruc
    from   @novedad_ente_tmp,
           cobis..cl_ente
    where  ne_ente       = en_ente
       and ne_secuencial > @i_siguiente
    set rowcount 0
  end

  if @i_operacion = 'C'
  begin
    set rowcount 20
    select
      'ENTE' = en_ente,
      'SUBTIPO' = en_subtipo,
      'NUMERO_ID' = en_ced_ruc,
      'TIPO_DOC' = en_tipo_ced,
      'NOMBRES' = en_nomlar,
      'P_APELLIDO' = p_p_apellido,
      'S_APELLIDO' = p_s_apellido,
      'OFICINA' = en_oficina,
      'OFICIAL' = en_oficial
    from   cobis..cl_ente en,
           cl_novedad_ente
    where  en_ente    = isnull(@i_ente,
                               en_ente)
       and en_ente    = ne_ente
       and ne_aplicado is null
       and en_oficial = isnull(@i_oficial,
                               en_oficial)
       and en_oficina = isnull(@i_oficina,
                               en_oficina)
       and exists(select
                    1
                  from   cobis..cl_novedad_ente with(nolock)
                  where  ne_ente = en.en_ente)
       and en_ente    > @i_siguiente
    group  by en_ente,
              en_subtipo,
              en_ced_ruc,
              en_tipo_ced,
              en_nomlar,
              p_p_apellido,
              p_s_apellido,
              en_oficina,
              en_oficial
    order  by en_ente
    set rowcount 0
  end

  if @i_operacion = 'A'
  begin
    if @i_central = '1'
      select
        @w_tservice = '04'

    if @i_central = '2'
      select
        @w_tservice = '02'

    exec cobis..sp_validar_datext
      @i_ente      = @i_ente,
      @i_num_doc   = @i_ced_ruc,
      @i_type_doc  = @i_tipo_ced,
      @i_tservice  = @w_tservice,-- GAL 16/SEP/2010 - REQ 108: CIFIN
      @i_central   = @i_central,-- GAL 19/AGO/2010 - REQ 108: CIFIN
      @i_operation = 'Q',
      @i_formato   = 101
  end

  if @i_operacion = 'U'
  begin
    exec @w_return = cobis..sp_actualizacion_critica
      @s_ssn        = @s_ssn,
      @s_date       = @s_date,
      @s_ofi        = @s_ofi,
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_trn        = 186,
      @i_operacion  = 'U',
      @i_ente       = @i_ente,
      @i_subtipo    = @i_subtipo,
      @i_tipo_ced   = @i_tipo_ced,
      @i_cedula     = @i_ced_ruc,
      @i_nombre     = @i_nombre,
      @i_p_apellido = @i_p_apellido,
      @i_s_apellido = @i_s_apellido,
      @i_validado   = @i_validado,
      @i_comentario = 'ACEPTADO X VALIDACION DATACREDITO'

    if @w_return <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_return
      /*'PROBLEMAS AL HACER LA ACTUALIZACION CRITICA'*/
      return @w_return
    end

    update cobis..cl_novedad_ente
    set    ne_aplicado = 'S',
           ne_fec_aplica = @w_fecha,
           ne_user_aplica = @s_user
    where  ne_ente = @i_ente

    if @@error <> 0
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 105514
      --'No Existen Registros'
      return 105514
    end
  end

  if @i_operacion = 'D'
  begin
    update cobis..cl_ente
    set    en_doc_validado = @i_validado,
           en_comentario = 'RECHAZADO X VALIDACION DATACREDITO'
    where  en_ente = @i_ente

    if @@error != 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_return
      /*'PROBLEMAS AL HACER LA ACTUALIZACION CRITICA-rechazar'*/
      return @w_return
    end

    update cobis..cl_novedad_ente
    set    ne_aplicado = 'N',
           ne_fec_aplica = @w_fecha,
           ne_user_aplica = @s_user
    where  ne_ente = @i_ente

    if @@error != 0
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 105514
      --'No Existen Registros'
      return 105514
    end
  end
  return 0

go

