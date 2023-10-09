/************************************************************************/
/* Archivo:                clcnmdcriesgo.sp                             */
/* Stored procedure:       sp_cons_modcentral_riesgo                    */
/* Base de datos:          cobis                                        */
/* Producto:               Clientes                                     */
/* Disenado por:           M.Bernal                                     */
/* Fecha de escritura:     09-09-2008                                   */
/************************************************************************/
/*                         IMPORTANTE                                   */
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
/*                         PROPOSITO                                    */
/* Este programa procesa la informacion que se carga en la pantalla     */
/* de consulta de Datacredito                                           */
/************************************************************************/
/*                         MODIFICACIONES                               */
/* FECHA           AUTOR              RAZON                             */
/* 09-09-2008      M.bernal           Emision inicial                   */
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
           where  name = 'sp_cons_modcentral_riesgo')
  drop proc sp_cons_modcentral_riesgo
go

create proc sp_cons_modcentral_riesgo
(
  @t_show_version bit = 0,
  @i_fec_ini      datetime,
  @i_fec_fin      datetime,
  @i_operacion    char(1),
  @i_secuencial   int = 0,
  @i_tipo_per     char(1) = null,
  @i_formato_f    tinyint = 101
)
as
  declare
    @w_sp_name varchar(32),
    @w_estado  char(1)

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_sp_name = 'sp_cons_modcentral_riesgo'

  if @i_operacion = 'S'
  begin --operacion'S'
    if @i_tipo_per is null
      select
        @i_tipo_per = 'P'

    set rowcount 5
    if @i_tipo_per = 'P' --Subtipo persona
    begin
      select
        'Fecha modificacion' = convert(varchar(10), cr_fec_modifi, @i_formato_f)
        ,
        'Secuencial' = cr_secuencial,
        'Ente      ' = cr_ente,
        'Tipo Doc  ' = cr_tipo_docu,
        'No. Documento' = substring(cr_num_docu,
                                    1,
                                    16),
        'Nombre       ' = substring(cr_nombre,
                                    1,
                                    30),
        'Primer apellido' = cr_p_apellido,
        'Segundo apellido' = cr_s_apellido,
        'Sexo         ' = cr_sexo,
        'Estado Civil ' = cr_est_civil,
        'Dpto Nacimiento' = cr_dpto_nac,
        'Ciudad Nacimiento' = cr_ciudad_nac,
        'Dpto Emisión ' = cr_dpto_emi,
        'Ciudad Emision' = cr_ciudad_emi,
        'Fecha Emision' = convert(varchar(10), cr_fec_emi, @i_formato_f)
      from   cobis..cl_mod_central_riesgo
      where  cr_estado     = 'I'
         and cr_tipo_regis = 'N'
         and cr_tipo_per   = @i_tipo_per
         and cr_fec_modifi between @i_fec_ini and @i_fec_fin
         and cr_secuencial > @i_secuencial
      order  by cr_secuencial
    end
    if @i_tipo_per = 'C' --Subtipo compañia
    begin
      select
        'F. Modificacion' = convert(varchar(10), cr_fec_modifi, @i_formato_f),
        'Secuencial' = cr_secuencial,
        'Ente    ' = cr_ente,
        'Tipo Doc' = cr_tipo_docu,
        'No. Doc.' = substring(cr_num_docu,
                               1,
                               16),
        'Nombre  ' = cr_nombre
      from   cobis..cl_mod_central_riesgo
      where  cr_estado     = 'I'
         and cr_tipo_regis = 'N'
         and cr_tipo_per   = @i_tipo_per
         and cr_fec_modifi between @i_fec_ini and @i_fec_fin
         and cr_secuencial > @i_secuencial
      order  by cr_secuencial
    end
    set rowcount 0
  end --operacion'S'

  if @i_operacion = 'Q'
  begin --operacion'Q'
    if @i_tipo_per = 'P' --Subtipo persona
    begin
      select
        'Fecha modificacion' = convert(varchar(10), cr_fec_modifi, @i_formato_f)
        ,
        'Secuencial   ' = cr_secuencial,
        'Ente         ' = cr_ente,
        'Tipo Doc     ' = cr_tipo_docu,
        'No. Documento' = substring(cr_num_docu,
                                    1,
                                    16),
        'Nombre       ' = substring(cr_nombre,
                                    1,
                                    30),
        'Primer apellido' = cr_p_apellido,
        'Segundo apellido' = cr_s_apellido,
        'Sexo         ' = cr_sexo,
        'Estado Civil ' = cr_est_civil,
        'Dpto Nacimiento' = cr_dpto_nac,
        'Ciudad Nacimiento' = cr_ciudad_nac,
        'Dpto Emisión ' = cr_dpto_emi,
        'Ciudad Emision' = cr_ciudad_emi,
        'Fecha Emision' = cr_fec_emi
      from   cobis..cl_mod_central_riesgo
      where  cr_estado     = 'I'
         and cr_tipo_regis = 'A'
         and cr_secuencial = @i_secuencial
         and cr_tipo_per   = @i_tipo_per
         and cr_fec_modifi between @i_fec_ini and @i_fec_fin
      order  by cr_secuencial
    end
    if @i_tipo_per = 'C' --Subtipo compañia
    begin
      select
        'Fecha modificacion' = convert(varchar(10), cr_fec_modifi, @i_formato_f)
        ,
        'Secuencial   ' = cr_secuencial,
        'Ente         ' = cr_ente,
        'Tipo Doc     ' = cr_tipo_docu,
        'No. Documento' = substring(cr_num_docu,
                                    1,
                                    16),
        'Nombre       ' = cr_nombre
      from   cobis..cl_mod_central_riesgo
      where  cr_estado     = 'I'
         and cr_tipo_regis = 'A'
         and cr_secuencial = @i_secuencial
         and cr_tipo_per   = @i_tipo_per
         and cr_fec_modifi between @i_fec_ini and @i_fec_fin
      order  by cr_secuencial
    end
  end --operacion'Q'

  if @i_operacion = 'U'
  begin
    update cobis..cl_mod_central_riesgo
    set    cr_estado = 'P'
    where  cr_estado     = 'I'
       and cr_secuencial = @i_secuencial
       and cr_fec_modifi between @i_fec_ini and @i_fec_fin

    if @@error <> 0
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 105514
      /*'No Existen Registros'*/
      return 105514
    end
  end
  return 0

go

