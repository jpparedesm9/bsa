/************************************************************************/
/*  Archivo:            cl_actmc012.sp                                  */
/*  Stored procedure:   sp_actmasc012                                   */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Nini Salazar                                    */
/*  Fecha de escritura: 18-Feb-2013                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este stored procedure procesa:                                      */
/*  Actualizar Masivamente datos de clientes, direcciones y telefonos,  */
/*  para cumplimiento circular 012                                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR                      RAZON                      */
/*  18/Feb/2013   Nini Salazar               Emision Inicial            */
/*  31/OCT/2013   Andres Muñoz               CCA 364 COMPLEMENTO C012   */
/*  02/May/2016   DFu                        Migracion CEN              */
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
           where  name = 'sp_actmasc012')
  drop proc sp_actmasc012
go

create proc sp_actmasc012
(
  --@i_param1            varchar(20),
  @i_param1       varchar(50),
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name               char(30),
    @w_int                   int,
    @w_total                 int,
    @w_error                 int,
    @w_return                int,
    @w_dct_fec_formulario    datetime,--varchar(10)    , 
    @w_dct_oficina           smallint,
    @w_dct_funcionario       int,
    @w_dct_ciudad_oficina    int,
    @w_dct_nombres           varchar(64),
    @w_dct_pri_ape           varchar(64),
    @w_dct_seg_ape           varchar(64),
    @w_dct_tip_doc           char(2),
    @w_dct_num_doc           varchar(30),
    @w_dct_ciu_exp           int,
    @w_dct_tipo_dirres       char (1),
    @w_dct_des_dirres        varchar (254),
    @w_dct_tel_res           varchar (16),
    @w_dct_dep_dirres        smallint,
    @w_dct_ciu_dirres        int,
    @w_dct_bar_dirres        varchar (150),
    @w_dct_tipo_dirneg       char (1),
    @w_dct_des_dirneg        varchar (254),
    @w_dct_tel_neg           varchar (16),
    @w_dct_dep_dirneg        smallint,
    @w_dct_ciu_dirneg        int,
    @w_dct_bar_dirneg        varchar (150),
    @w_dct_correo            varchar (64),
    @w_dct_prefijo1          varchar (16),
    @w_dct_cel1              varchar (16),
    @w_dct_prefijo2          varchar (16),
    @w_dct_cel2              varchar (16),
    @w_dct_ocupacion         char (10),
    @w_dct_est_civil         varchar (10),
    @w_dct_num_hijos         tinyint,
    @w_dct_medio_ext         char (1),
    @w_dct_ente              int,
    @w_dct_login_funcionario varchar (14),
    @w_dct_dir_principal     tinyint,
    @w_resultado             varchar (80),
    @w_prefijo               varchar (10),
    @w_dato                  tinyint,
    @w_dir_siguiente         int,
    @w_prin                  char(1),
    @w_msg                   varchar(254),
    @w_msg_aux               varchar(1000),
    @w_msg_exito             varchar(1000),
    @w_secuencial            tinyint,
    @w_tabla                 int,
    @w_s_app                 varchar(30),
    @w_path                  varchar(255),
    @w_archivo               varchar(64),
    @w_comando               varchar(1000),
    @w_ssn                   int,
    @w_fec_formulario        datetime,
    @w_tres                  varchar(10),
    @w_tneg                  varchar(10),
    @w_tmail                 varchar(10),
    @w_consec_ext            int,
    @w_forma_ext             char(1),
    @w_ofi                   smallint,
    @w_operacion             char(1)

  select
    @w_sp_name = 'sp_actmasc012'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  print 'INICIA PROCESO con archivo ..' + @i_param1

  select
    @w_tneg = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'TDN' --Negocio
  if @w_tneg is null
  begin
    select
      @w_error = 103115,
      @w_msg = 'Error al Consultar el parametro TDN. '
    goto ERROR_FIN
  end

  select
    @w_tres = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'TDR' --Residencia
  if @w_tres is null
  begin
    select
      @w_error = 103115,
      @w_msg = 'Error al Consultar el parametro TDR. '
    goto ERROR_FIN

  end

  select
    @w_tmail = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'TDW' --Correo
  if @w_tmail is null
  begin
    select
      @w_error = 103115,
      @w_msg = 'Error al Consultar el parametro TDW. '
    goto ERROR_FIN
  end

  /***********INICIALIZACION DE VARIABLES *************/

  select
    @w_dct_fec_formulario = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @w_int = 1,
    @w_fec_formulario = @w_dct_fec_formulario
/****************************************************/
  /*******Truncar la tabla cl_datos_clientes_tmp*******/
  truncate table cl_datos_clientes_tmp

/*********SE CARGA LA INFORMACION DESDE EL ARCHIVO PLANO***********/
  /*******OBTIENE LA RUTA DEL S_APP*************/
  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'S_APP'

  if @@rowcount = 0
  begin
    select
      @w_error = 103115,
      @w_msg = 'NO SE ENCONTRO EL PARAMETRO S_APP. '
    goto ERROR_FIN
  end

  /*********OBTIENE LA RUTA DONDE SE CARGA EL ARCHIVO PLANO********/
  select
    @w_path = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 2

  if @@rowcount = 0
  begin
    select
      @w_error = 103115,
      @w_msg = 'NO SE ENCONTRO LA RUTA DONDE SE CARGA EL ARCHIVO PLANO. '
    goto ERROR_FIN
  end

  /*******CARGA EN VARIABLE @W_COMANDO********/
  select
    @w_comando = @w_s_app + 's_app' +
                        ' bcp -auto -login cobis..cl_datos_clientes_tmp  in ' +
                        @w_path
                 + @i_param1 + ' -b100 -t"&&" -c -e' + @w_path + @i_param1 +
                 '.err'
                        + ' -config ' + @w_s_app
                 + 's_app.ini'

  /*********SE EJECUTA CON CMDSHELL*******/
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR AL GENERAR ARCHIVO. ' + @i_param1 + ' ' + convert(varchar,
                      @w_error)
    goto ERROR_FIN
  end
  else
  begin
    /* Solamente deja el archivo definitivo, se eliminan los archivos temporales */
    select
      @w_comando = 'del ' + @w_path + @i_param1 + '.err'
    exec @w_error = xp_cmdshell
      @w_comando
    if @w_error <> 0
    begin
      select
        @w_error = 808022,
        @w_msg = 'ERROR AL ELIMINAR ARCHIVOS TEMPORALES DE TRABAJO.'
      print @w_comando
      goto ERROR_FIN
    end
  end

  /*********ACTUALIZA LOS ULTIMOS 5 CAMPOS DE LA TABLA EN NULL*******/
  update cl_datos_clientes_tmp
  set    dct_ente = null,
         dct_login_funcionario = null,
         dct_dir_principal = null,
         dct_estado = null,
         dct_msg = ''

/**********VALIDACION DE DIA/MES/ A¾O A MES/DIA/A¾O**********/
/*
update cl_datos_clientes_tmp
set    dct_fec_formulario = substring(dct_fec_formulario,4,2) + '/' + substring(dct_fec_formulario,1,2) + '/' + substring(dct_fec_formulario,7,4)

if @@error <> 0
begin
   select @w_error = 103115,
   @w_msg = 'NO SE PUEDE ACTUALIZAR LA TABLA DEL DIA/MES/A¾O A MES/DIA/A¾O. '
   goto ERROR_FIN
end
*/
  /**********VALIDACION DE FECHA INVALIDA MES/DIA/A¾O**********/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg + ' Error Fecha Invalida. '
  where  (isdate(dct_fec_formulario) = 0
       or dct_fec_formulario is null)
  --and   dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
    'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR VALIDACION DE FECHA. '
    goto ERROR_FIN
  end

/**********VALIDACION QUE LA OFICINA EXISTA**********/
/*
update cl_datos_clientes_tmp
set dct_estado   = 'E',
    dct_msg      = dct_msg + ' Error Oficina no Existe. '
where    dct_oficina is null
--and   dct_estado is null

if @@error <> 0
begin
   select @w_error = 103115,
   @w_msg = 'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR VALIDACIONES DE PERSONA. '
   goto ERROR_FIN
end

*/
  /**********VALIDA EXISTENCIA DE CATALOGO TIPO DE ID **********/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg + 'Error Tipo de dto invalido. '
  where  not exists (select
                       1
                     from   cl_catalogo,
                            cl_tabla
                     where  cl_catalogo.codigo = dct_tip_doc
                        and cl_catalogo.estado = 'V'
                        and cl_catalogo.tabla  = cl_tabla.codigo
                        and cl_tabla.tabla     = 'cl_tipo_documento')
      or dct_tip_doc is null
  --and dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg = 'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR TIPO ID. '
    goto ERROR_FIN
  end

  /**********VALIDACION QUE LA PN EXISTA**********/

  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg + ' Error Persona Nat.no existe. '
  where  (not exists (select
                        1
                      from   cobis..cl_ente
                      where  en_tipo_ced = isnull(dct_tip_doc,
                                                  '')
                         and en_ced_ruc  = isnull(dct_num_doc,
                                                  '')
                         and en_subtipo  = 'P'))
      or dct_tip_doc is null
      or dct_num_doc is null
  --and   dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
      'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR VALIDACIONES DE PERSONA. '
    goto ERROR_FIN
  end

  /*****************ACTUALIZA FUNCIONARIO*****************/
  update cl_datos_clientes_tmp
  set    dct_login_funcionario = fu_login
  from   cobis..cl_funcionario
  where  fu_nomina = dct_funcionario
     and dct_estado is null
     and dct_funcionario is not null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg = 'NO SE PUEDE ACTUALIZAR EL FUNCIONARIO EN LA TABLA TEMPORAL. '
    goto ERROR_FIN
  end

  /**********VALIDACION QUE EL FUNCIONARIO EXISTA**********/
  update cl_datos_clientes_tmp
  set    dct_login_funcionario = 'operador'
  where  not exists (select
                       1
                     from   cobis..cl_funcionario
                     where  fu_nomina = dct_funcionario)
      or dct_funcionario is null
  --and  dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR VALIDACIONES DE FUNCIONARIO. '
goto ERROR_FIN
end

  /**********VALIDA EXISTENCIA DE CATALOGO ESTADO CIVIL**********/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg + ' Error Estado Civil no Existe. '
  where  not exists (select
                       1
                     from   cl_catalogo,
                            cl_tabla
                     where  cl_catalogo.codigo = dct_est_civil
                        and cl_catalogo.estado = 'V'
                        and cl_catalogo.tabla  = cl_tabla.codigo
                        and cl_tabla.tabla     = 'cl_ecivil')
     and dct_est_civil is not null
  --and dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg = 'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR ESTADO CIVIL. '
    goto ERROR_FIN
  end

  /**********VALIDA EXISTENCIA DE CATALOGO OCUPACION************/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg + ' Error Ocupacion no existe. '
  where  not exists (select
                       1
                     from   cl_catalogo,
                            cl_tabla
                     where  cl_catalogo.codigo = dct_ocupacion
                        and cl_catalogo.estado = 'V'
                        and cl_catalogo.tabla  = cl_tabla.codigo
                        and cl_tabla.tabla     = 'cl_tipo_empleo')
     and dct_ocupacion is not null
  --and dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg = 'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR OCUPACION. '
    goto ERROR_FIN
  end

  /**********VALIDA EXISTENCIA DE CATALOGO DPTO DIR. NEGOCIO***********/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg + ' Error Depto Dir Negocio no existe. '
  where  not exists (select
                       pv_provincia
                     from   cl_provincia
                     where  pv_provincia = isnull(dct_dep_dirneg,
                                                  0))
  --and  dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
  'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR DEPARTAMENTO DIR. DE NEGOCIO. '
    goto ERROR_FIN
  end

  /**********VALIDA EXISTENCIA DE CATALOGO DPTO DIR. RESIDENCIA**********/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg + ' Error Depto Dir Res no Existe. '
  where  not exists (select
                       pv_provincia
                     from   cl_provincia
                     where  pv_provincia = isnull(dct_dep_dirres,
                                                  0))
  --and  dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR DEPARTAMENTO DIR. DE RESIDENCIA. '
  goto ERROR_FIN
end

  /**********VALIDA EXISTENCIA DE CATALOGO CIUDAD DIR. NEGOCIO**********/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg + 'Error Ciudad Dir Neg no Existe. '
  where  not exists (select
                       ci_ciudad
                     from   cl_ciudad
                     where  ci_ciudad = isnull(dct_ciu_dirneg,
                                               0))
  --and  dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
    'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR CIUDAD DIR. DE NEGOCIO. '
    goto ERROR_FIN
  end

  /**********VALIDA EXISTENCIA DE CATALOGO CIUDAD DIR. RESIDENCIA*********/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg + 'Error Ciudad Dir Res no Existe. '
  where  not exists (select
                       ci_ciudad
                     from   cl_ciudad
                     where  ci_ciudad = isnull(dct_ciu_dirres,
                                               0))
  --and  dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
      'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR CIUDAD DIR. DE RESIDENCIA. '
    goto ERROR_FIN
  end

  /**************VALIDA EXISTENCIA DE CATALOGO POR OFICINA*************/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg + ' Error Oficina no Existe. '
  where  not exists (select
                       of_oficina
                     from   cl_oficina
                     where  of_oficina = isnull(dct_oficina,
                                                0))
     and dct_oficina is not null
  --and  dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg = 'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR OFICINA. '
    goto ERROR_FIN
  end

  /**************VALIDA EXISTENCIA DE CIUDAD - DPTO  DIR NEG*************/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg +
                   ' Error  Ciudad - Dpto en Dir. Negocio no Existe.  '
  where  not exists (select
                       1
                     from   cl_ciudad
                     where  ci_ciudad    = dct_ciu_dirneg
                        and ci_provincia = dct_dep_dirneg)
     and dct_ciu_dirneg is not null
     and dct_dep_dirneg is not null
  --and dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
      'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR CIUDA-DPTO NEG INVALIDO. '
    goto ERROR_FIN
  end

  /**************VALIDA EXISTENCIA DE CIUDAD - DPTO  DIR RES*************/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg +
                   ' Error Ciudad - Dpto en Dir Residencia no Existe. '
  where  not exists (select
                       1
                     from   cl_ciudad
                     where  ci_ciudad    = dct_ciu_dirres
                        and ci_provincia = dct_dep_dirres)
     and dct_ciu_dirres is not null
     and dct_dep_dirres is not null
  --and dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
      'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR CIUDA-DPTO RES INVALIDO. '
    goto ERROR_FIN
  end

  /**************VALIDA EXISTENCIA DE CATALOGO BARRIO DIR NEG*************/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg + ' Error Barrio Dir Urbana de Negocio no Existe'
  where  not exists (select
                       1
                     from   cl_parroquia
                     where  pq_ciudad                     = dct_ciu_dirneg
                        and convert(varchar, pq_parroquia) = dct_bar_dirneg)
     and dct_tipo_dirneg = 'U'
     and dct_bar_dirneg is not null
  --and  dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
    'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR BARRIO NEG INVALIDO. '
    goto ERROR_FIN
  end

  /**************VALIDA EXISTENCIA DE CATALOGO BARRIO DIR RES************/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg + ' Error Barrio Dir Urbana de Residencia no Existe'
  where  not exists (select
                       1
                     from   cl_parroquia
                     where  pq_ciudad                     = dct_ciu_dirres
                        and convert(varchar, pq_parroquia) = dct_bar_dirres)
     and dct_tipo_dirres = 'U'
     and dct_bar_dirres is not null
  --and  dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
    'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR BARRIO RES INVALIDO. '
    goto ERROR_FIN
  end

  /*********VALIDA EXISTENCIA DE CATALOGO TIPO DE DIRECCIONES PARA RESIDENCIA**********/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg +
         ' Error Tipo de Dir Res. Invalido o Barrio no corresponde al Tipo. '
  where  ((dct_tipo_dirres           = 'R'
       and isnumeric(dct_bar_dirres) = 1)
       or (dct_tipo_dirres           = 'U'
           and isnumeric(dct_bar_dirres) <> 1)
       or (dct_tipo_dirres not in ('U', 'R')))
  --and    dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR VALIDACION DE TIPOS DE DIRECCIONES PARA RES. '
  goto ERROR_FIN
end

  /*********VALIDA EXISTENCIA DE CATALOGO TIPO DE DIRECCIONES PARA NEGOCIO **********/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg +
         ' Error Tipo de Dir. Neg.Invalido o Barrio no corresponde al Tipo. '
  where  ((dct_tipo_dirneg           = 'R'
       and isnumeric(dct_bar_dirneg) = 1)
       or (dct_tipo_dirneg           = 'U'
           and isnumeric(dct_bar_dirneg) <> 1)
       or (dct_tipo_dirneg not in ('U', 'R'))
       or (dct_tipo_dirneg not in ('U', 'R')))
  --and    dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR VALIDACION DE TIPOS DE DIRECCIONES PARA NEG. '
  goto ERROR_FIN
end

  /**********VALIDACION DE LA MARCA ENVIO DE EXTRACTO **********/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg +
         ' No Existe Forma de envio extracto o No se encuentra vigente. '
  where  (case dct_medio_ext
            when 'R' then 'D'
            when 'N' then 'D'
            when 'O' then 'R'
            else dct_medio_ext
          end) not in (select
                         c.codigo
                       from   cobis..cl_catalogo c,
                              cobis..cl_tabla t
                       where  t.tabla  = 'cl_forma_extractos'
                          and t.codigo = c.tabla
                          and c.estado = 'V')

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR VALIDACION DEL CATALOGO DE LAS FORMAS DE ENVIO EXTRACTO. '
  goto ERROR_FIN
end

  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg
                   +
' No Existe Direccion para la marca de envio o No estan Diligenciados todos los campos de acuerdo a la marca de envio. '
where  ((dct_medio_ext       = 'N'
     and ((dct_des_dirneg is null
            or len(dct_des_dirneg) = 0)
           or dct_tipo_dirneg is null
           or dct_tel_neg is null
           or dct_dep_dirneg is null
           or dct_ciu_dirneg is null
           or dct_bar_dirneg is null))
     or (dct_medio_ext       = 'R'
         and ((dct_des_dirres is null
                or len(dct_des_dirres) = 0)
               or dct_tipo_dirres is null
               or dct_tel_res is null
               or dct_dep_dirres is null
               or dct_ciu_dirres is null
               or dct_bar_dirres is null))
     or (dct_medio_ext       = 'C'
         and dct_correo is null)
     or (dct_medio_ext       = 'O'
         and dct_oficina is null))
  --and    dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR VALIDACION DE LA MARCA ENVIO DE EXTRACTO. '
  goto ERROR_FIN
end

  /*************VALIDA EL CORREO CON @****************/
  update cl_datos_clientes_tmp
  set    dct_estado = 'E',
         dct_msg = dct_msg + ' Error en el campo de Correo sin @. '
  where  dct_correo is not null
         --and    dct_estado is null
         and charindex('@',
                       dct_correo) = 0

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
'NO SE PUEDE ACTUALIZAR LA TABLA TEMPORAL POR  VALIDACION DEL CORREO ELECTRONICO SIN @. '
  goto ERROR_FIN
end

  /**************ACTUALIZA EL ENTE********************/
  update cl_datos_clientes_tmp
  set    dct_ente = en_ente
  from   cobis..cl_ente
  where  en_tipo_ced = dct_tip_doc
     and en_ced_ruc  = dct_num_doc
     and en_subtipo  = 'P'
     and dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg = 'NO SE PUEDE ACTUALIZAR EL ENTE EN LA TABLA TEMPORAL. '
    goto ERROR_FIN
  end

  /*****ACTUALIZA CUAL ES LA DIRECCION PRINCIPAL*****/
  update cl_datos_clientes_tmp
  set    dct_dir_principal = di_direccion
  from   cobis..cl_ente,
         cobis..cl_direccion
  where  en_tipo_ced  = dct_tip_doc
     and en_ced_ruc   = dct_num_doc
     and en_ente      = di_ente
     and di_principal = 'S'
     and dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg =
    'NO SE PUEDE ACTUALIZAR LA DIRECCION PRINCIPAL EN LA TABLA TEMPORAL. '
    goto ERROR_FIN
  end

/****ACTUALIZA CIUDAD DE LA OFICINA ****/
/*update cl_datos_clientes_tmp
set    dct_ciudad_oficina = of_ciudad
from   cobis..cl_oficina
where  dct_oficina = of_oficina
and    dct_estado is null
and    dct_ciudad_oficina is null 

if @@error <> 0
begin
   select @w_error = 103115,
   @w_msg = 'NO SE PUEDE ACTUALIZAR LA CIUDAD DE LA OFICINA EN LA TABLA TEMPORAL. '
   goto ERROR_FIN
end
*/
  /*********INICIALIZACION DE TABLA CL_CLIENTES_TMP*********/
  truncate table cl_clientes_tmp

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg = 'ERROR AL TRUNCAR cl_clientes_tmp. '
    goto ERROR_FIN
  end

  /*********INSERTA EL ENCABEZADO DE LA TABLA cl_clientes_tmp************/
  insert into cl_clientes_tmp
              (ct_datos)
  values      (
'Oficina|Tipo de documento|Numero de documento|Nombre|Primer apellido|Segundo apellido|Estado Carga|Mensaje'
  )

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg = 'ERROR AL INSERTAR EL ENCABEZADO EN LA TABLA cl_clientes_tmp. '
    goto ERROR_FIN
  end

  /*********TABLA TEMPORAL PARA CONTROLAR EL WHILE***********/
  create table #apoyo
  (
    sec  int identity(1, 1),
    ente int
  )

  /********OBTENER DATOS PARA PROCESAMIENTO************/
  insert into #apoyo
    select
      ente = dct_ente
    from   cl_datos_clientes_tmp
    where  dct_estado is null

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg = 'ERROR EN LA INSERCION DE LA TABLA #apoyo. '
    goto ERROR_FIN
  end

  /*********OBTENER EL SECUENCIAL MAXIMO DE LA TABLA #apoyo**********/
  select
    @w_total = max(sec)
  from   #apoyo

  if @@error <> 0
  begin
    select
      @w_error = 103115,
      @w_msg = 'ERROR LA TABLA #apoyo ESTA VACIA. '
    goto ERROR_FIN
  end

  /********INICIALIZA EL WHILE************/
  while (@w_int <= @w_total)
  begin
    /*CICLO DE LECTURA DE LOS REGISTROS DE LA TABLA cl_datos_clientes_tmp*/
    select
      @w_msg_aux = ''
    select
      @w_msg_exito = ''

    select
      @w_dct_fec_formulario = dct_fec_formulario,
      @w_dct_oficina = dct_oficina,
      @w_dct_funcionario = dct_funcionario,
      @w_dct_ciudad_oficina = dct_ciudad_oficina,
      @w_dct_nombres = dct_nombres,
      @w_dct_pri_ape = dct_pri_ape,
      @w_dct_seg_ape = dct_seg_ape,
      @w_dct_tip_doc = dct_tip_doc,
      @w_dct_num_doc = dct_num_doc,
      @w_dct_ciu_exp = dct_ciu_exp,
      @w_dct_tipo_dirres = dct_tipo_dirres,
      @w_dct_des_dirres = dct_des_dirres,
      @w_dct_tel_res = dct_tel_res,
      @w_dct_dep_dirres = dct_dep_dirres,
      @w_dct_ciu_dirres = dct_ciu_dirres,
      @w_dct_bar_dirres = dct_bar_dirres,
      @w_dct_tipo_dirneg = dct_tipo_dirneg,
      @w_dct_des_dirneg = dct_des_dirneg,
      @w_dct_tel_neg = dct_tel_neg,
      @w_dct_dep_dirneg = dct_dep_dirneg,
      @w_dct_ciu_dirneg = dct_ciu_dirneg,
      @w_dct_bar_dirneg = dct_bar_dirneg,
      @w_dct_correo = dct_correo,
      @w_dct_prefijo1 = dct_prefijo1,
      @w_dct_cel1 = dct_cel1,
      @w_dct_prefijo2 = dct_prefijo2,
      @w_dct_cel2 = dct_cel2,
      @w_dct_ocupacion = dct_ocupacion,
      @w_dct_est_civil = dct_est_civil,
      @w_dct_num_hijos = dct_num_hijos,
      @w_dct_medio_ext = dct_medio_ext,
      @w_dct_ente = dct_ente,
      @w_dct_login_funcionario = dct_login_funcionario,
      @w_dct_dir_principal = dct_dir_principal
    from   cl_datos_clientes_tmp,
           #apoyo
    where  dct_ente = ente
       and sec      = @w_int

    if @@error <> 0
    begin
      select
        @w_msg = 'ERROR AL LEER EL REGISTRO DE LA TABLA cl_datos_clientes_tmp. '
      goto AUDITORIA
    end

    /************VALIDA CAMPOS ESTADO CIVIL, OCUPACION Y NUMERO DE HIJOS NO PUEDEN VENIR VACIOS*****/
    if (@w_dct_est_civil is not null
         or @w_dct_ocupacion is not null
         or @w_dct_num_hijos is not null)
    begin
      /*****LLAMADO A SP sp_persona_upd PARA LA ACTUALIZACION DE DATOS DE CLIENTES EN cobis..cl_ente*****/
      exec @w_return = sp_persona_upd
        @s_ssn             = 1,
        @s_user            = @w_dct_login_funcionario,
        @s_date            = @w_fec_formulario,
        @s_srv             = 'batch',
        @s_lsrv            = 'batch',
        @s_ofi             = @w_dct_oficina,
        @t_debug           = 'N',
        @t_trn             = 104,
        @i_linea           = 'N',
        @i_operacion       = 'U',
        @i_persona         = @w_dct_ente,
        @i_tipo_ced        = @w_dct_tip_doc,
        @i_cedula          = @w_dct_num_doc,
        @i_estado_civil    = @w_dct_est_civil,
        @i_tipo_empleo     = @w_dct_ocupacion,
        @i_num_hijos       = @w_dct_num_hijos,
        @o_mensaje_retorno = @w_resultado out

      if @w_return <> 0
      begin
        select
          @w_msg = ' Error en la actualizacion de datos de cliente. ' +
                   @w_resultado
        goto AUDITORIA
      end
      else
        select
          @w_msg_exito = @w_msg_exito + 'Actualiza Datos Clientes. '
    end

    /************DIRECCION DE NEGOCIO*************/
    if (((@w_dct_des_dirneg is not null)
         and (len(@w_dct_des_dirneg) <> 0))
        and @w_dct_tipo_dirneg is not null
        and len(@w_dct_tel_neg) = 7
        and @w_dct_dep_dirneg is not null
        and @w_dct_ciu_dirneg is not null
        and @w_dct_bar_dirneg is not null)
    begin
      /***********PREFIJO DE NEGOCIO************/
      select
        @w_prefijo = ip_indicativo
      from   cobis..cl_ind_prv
      where  ip_ciudad = @w_dct_ciu_dirneg

      if @@rowcount = 0
      begin
        select
          @w_msg_aux = ' INDICATIVO NO EXISTE PARA LA CIUDAD DE NEGOCIO. '
        goto AUDITORIA
      end

      /*****VARIABLE DE TRABAJO DIRECCION PRINCIPAL******/
      if @w_dct_dir_principal is null
        set @w_prin = 'S'
      else
        set @w_prin = 'N'

      /***********UBICA LA ULTIMA DIRECCION de negocio********/
      select
        @w_dato = di_direccion
      from   cobis..cl_direccion
      where  di_ente               = @w_dct_ente
         and di_tipo               = @w_tneg
         and di_fecha_modificacion = (select
                                        max(di_fecha_modificacion)
                                      from   cobis..cl_direccion
                                      where  di_ente = @w_dct_ente
                                         and di_tipo = @w_tneg)

      if @@rowcount = 0
      begin
        /************INSERTA DIRECCION DE NEGOCIO*************/
        exec @w_return = sp_direccion_dml
          @s_ssn                 = 1,
          @s_user                = @w_dct_login_funcionario,
          @s_date                = @w_fec_formulario,
          @s_srv                 = 'batch',
          @s_lsrv                = 'batch',
          @s_ofi                 = @w_dct_oficina,
          @t_trn                 = 109,
          @i_linea               = 'N',
          @i_operacion           = 'I',
          @i_ente                = @w_dct_ente,
          @i_descripcion         = @w_dct_des_dirneg,
          @i_tipo                = @w_tneg,
          @i_zona                = @w_dct_oficina,
          @i_barrio              = @w_dct_bar_dirneg,
          @i_ciudad              = @w_dct_ciu_dirneg,
          @i_oficina             = @w_dct_oficina,
          @i_provincia           = @w_dct_dep_dirneg,
          @i_rural_urb           = @w_dct_tipo_dirneg,
          @i_principal           = @w_prin,
          @o_mensaje_retorno     = @w_resultado out,
          @o_siguiente_direccion = @w_dir_siguiente out

        if @w_return <> 0
        begin
          select
            @w_msg = ' Error Insercion Dir Negocio. ' + @w_resultado
          goto AUDITORIA
        end
        else
          select
            @w_msg_exito = @w_msg_exito + 'Crea Dir. Negocio. '

        select
          @w_dato = @w_dir_siguiente

        /*****DIRECCION PRINCIPAL ES LA DE NEGOCIO*****/
        if (@w_dct_dir_principal is null)
          select
            @w_dct_dir_principal = @w_dir_siguiente

        /************INSERTA TELEFONO******************/
        exec @w_return = sp_telefono
          @s_ssn             = 1,
          @s_user            = @w_dct_login_funcionario,
          @s_date            = @w_fec_formulario,
          @s_srv             ='batch',
          @s_lsrv            ='batch',
          @s_ofi             = @w_dct_oficina,
          @t_debug           = 'N',
          @t_trn             = 111,
          @i_operacion       = 'I',
          @i_ente            = @w_dct_ente,
          @i_secuencial      = 1,
          @i_direccion       = @w_dir_siguiente,
          @i_valor           = @w_dct_tel_neg,
          @i_tipo_telefono   = 'D',
          @i_prefijo         = @w_prefijo,
          @i_linea           = 'N',
          @o_mensaje_retorno = @w_resultado out

        if @w_return <> 0
        begin
          select
            @w_msg = 'Error Insercion de telefono. ' + @w_resultado
          goto AUDITORIA
        end
        else
          select
            @w_msg_exito = @w_msg_exito + 'Crea Tel. Negocio. '

      end /* Fin rowcount de Negocio*/
      else
      begin
        if (isnull(@w_dct_dir_principal,
                   0) = @w_dato
            and @w_dct_dir_principal is not null)
          select
            @w_prin = 'S'

        /************ACTUALIZA DIRECCION DE NEGOCIO*************/
        exec @w_return = sp_direccion_dml
          @s_ssn             = 1,
          @s_user            = @w_dct_login_funcionario,
          @s_date            = @w_fec_formulario,
          @s_srv             = 'batch',
          @s_lsrv            = 'batch',
          @s_ofi             = @w_dct_oficina,
          @t_trn             = 110,
          @i_linea           = 'N',
          @i_operacion       = 'U',
          @i_ente            = @w_dct_ente,
          @i_direccion       = @w_dato,
          @i_descripcion     = @w_dct_des_dirneg,
          @i_tipo            = @w_tneg,
          @i_zona            = @w_dct_oficina,
          @i_barrio          = @w_dct_bar_dirneg,
          @i_ciudad          = @w_dct_ciu_dirneg,
          @i_oficina         = @w_dct_oficina,
          @i_provincia       = @w_dct_dep_dirneg,
          @i_rural_urb       = @w_dct_tipo_dirneg,
          @i_principal       = @w_prin,
          @o_mensaje_retorno = @w_resultado out

        if @w_return <> 0
        begin
          select
            @w_msg = 'Error en actualizacion de Direccion de negocio. ' +
                     @w_resultado
          goto AUDITORIA
        end
        else
          select
            @w_msg_exito = @w_msg_exito + 'Actualiza Dir. Negocio. '

        /*****DIRECCION PRINCIPAL ES LA ULTIMA DE NEGOCIO*****/
        if (@w_dct_dir_principal is null)
          select
            @w_dct_dir_principal = @w_dato

        /*****EXISTENCIA DEL TELEFONO FIJO*****/
        if not exists(select
                        1
                      from   cl_telefono
                      where  te_ente          = @w_dct_ente
                         and te_valor         = @w_dct_tel_neg
                         -- and   te_prefijo     = @w_prefijo
                         and te_tipo_telefono = 'D')
        begin
          /*****OBTIENE SECUENCIAL DEL TELEFONO FIJO*****/
          select
            @w_secuencial = isnull(max (te_secuencial), 0) + 1
          from   cobis..cl_telefono
          where  te_ente      = @w_dct_ente
             and te_direccion = @w_dato

          if @@rowcount = 0
          begin
            select
              @w_msg = 'SECUENCIAL DE TELEFONO NO EXISTENTE. '
            goto AUDITORIA
          end

          /************INSERTA TELEFONO******************/
          exec @w_return = sp_telefono
            @s_ssn             = 1,
            @s_user            = @w_dct_login_funcionario,
            @s_date            = @w_fec_formulario,
            @s_srv             = 'batch',
            @s_lsrv            = 'batch',
            @s_ofi             = @w_dct_oficina,
            @t_debug           = 'N',
            @t_trn             = 111,
            @i_operacion       = 'I',
            @i_ente            = @w_dct_ente,
            @i_secuencial      = @w_secuencial,
            @i_direccion       = @w_dato,
            @i_valor           = @w_dct_tel_neg,
            @i_tipo_telefono   = 'D',
            @i_prefijo         = @w_prefijo,
            @i_linea           = 'N',
            @o_mensaje_retorno = @w_resultado out

          if @w_return <> 0
          begin
            select
              @w_msg = 'Error en insertar telefono. ' + @w_resultado
            goto AUDITORIA
          end
          else
            select
              @w_msg_exito = @w_msg_exito + 'Crea Tel. Negocio. '

        end /*Fin no existe telefono */
      end /*Fin else*/
    end /*Fin Direccion de Negocio*/
    else
    begin
      select
        @w_msg_aux = @w_msg_aux + 'Dir.Neg. o Tel de Negocio Incompletos. '

    end

    if @w_dct_medio_ext = 'N'
    begin
      select
        @w_consec_ext = @w_dato,
        @w_forma_ext = 'D'
    end

    /************DIRECCION DE RESIDENCIA*************/
    if (((@w_dct_des_dirres is not null)
         and (len(@w_dct_des_dirres) <> 0))
        and @w_dct_tipo_dirres is not null
        and len(@w_dct_tel_res) = 7
        and @w_dct_dep_dirres is not null
        and @w_dct_ciu_dirres is not null
        and @w_dct_bar_dirres is not null)
    begin
      /***********PREFIJO DE RESIDENCIA************/
      select
        @w_prefijo = ip_indicativo
      from   cobis..cl_ind_prv
      where  ip_ciudad = @w_dct_ciu_dirres

      if @@rowcount = 0
      begin
        select
          @w_msg = 'INDICATIVO NO EXISTE PARA LA CIUDAD DE RESIDENCIA. '
        goto AUDITORIA
      end

      /***********UBICA LA ULTIMA DIRECCION********/
      select
        @w_dato = di_direccion
      from   cobis..cl_direccion
      where  di_ente               = @w_dct_ente
         and di_tipo               = @w_tres
         and di_fecha_modificacion = (select
                                        max(di_fecha_modificacion)
                                      from   cobis..cl_direccion
                                      where  di_ente = @w_dct_ente
                                         and di_tipo = @w_tres)

      if @@rowcount = 0
      begin
        /************INSERTA DIRECCION DE RESIDENCIA*************/
        exec @w_return = sp_direccion_dml
          @s_ssn                 = 1,
          @s_user                = @w_dct_login_funcionario,
          @s_date                = @w_fec_formulario,
          @s_srv                 = 'batch',
          @s_lsrv                = 'batch',
          @s_ofi                 = @w_dct_oficina,
          @t_trn                 = 109,
          @i_linea               = 'N',
          @i_operacion           = 'I',
          @i_ente                = @w_dct_ente,
          @i_descripcion         = @w_dct_des_dirres,
          @i_tipo                = @w_tres,
          @i_zona                = @w_dct_oficina,
          @i_barrio              = @w_dct_bar_dirres,
          @i_ciudad              = @w_dct_ciu_dirres,
          @i_oficina             = @w_dct_oficina,
          @i_provincia           = @w_dct_dep_dirres,
          @i_rural_urb           = @w_dct_tipo_dirres,
          @o_mensaje_retorno     = @w_resultado out,
          @o_siguiente_direccion = @w_dir_siguiente out

        if @w_return <> 0
        begin
          select
            @w_msg = 'Error en insercion direccion de residencia. ' +
                     @w_resultado
          goto AUDITORIA
        end
        else
          select
            @w_msg_exito = @w_msg_exito + 'Crea Dir. Residencia. '

        select
          @w_dato = @w_dir_siguiente

        /************INSERTA TELEFONO******************/
        exec @w_return = sp_telefono
          @s_ssn             = 1,
          @s_user            = @w_dct_login_funcionario,
          @s_date            = @w_fec_formulario,
          @s_srv             = 'batch',
          @s_lsrv            = 'batch',
          @s_ofi             = @w_dct_oficina,
          @t_debug           = 'N',
          @t_trn             = 111,
          @i_operacion       = 'I',
          @i_ente            = @w_dct_ente,
          @i_direccion       = @w_dir_siguiente,
          @i_valor           = @w_dct_tel_res,
          @i_tipo_telefono   = 'D',
          @i_prefijo         = @w_prefijo,
          @i_linea           = 'N',
          @o_mensaje_retorno = @w_resultado out

        if @w_return <> 0
        begin
          select
            @w_msg = 'Error en insertar telefono. ' + @w_resultado
          goto AUDITORIA
        end
        else
          select
            @w_msg_exito = @w_msg_exito + 'Crea Tel. Residencia. '

      end/*Fin del if de residencia*/
      else
      begin
        /************ACTUALIZA DIRECCION DE RESIDENCIA*************/
        exec @w_return = sp_direccion_dml
          @s_ssn             = 1,
          @s_user            = @w_dct_login_funcionario,
          @s_date            = @w_fec_formulario,
          @s_srv             = 'batch',
          @s_lsrv            = 'batch',
          @s_ofi             = @w_dct_oficina,
          @t_trn             = 110,
          @i_linea           = 'N',
          @i_operacion       = 'U',
          @i_ente            = @w_dct_ente,
          @i_direccion       = @w_dato,
          @i_descripcion     = @w_dct_des_dirres,
          @i_tipo            = @w_tres,
          @i_zona            = @w_dct_oficina,
          @i_barrio          = @w_dct_bar_dirres,
          @i_ciudad          = @w_dct_ciu_dirres,
          @i_oficina         = @w_dct_oficina,
          @i_provincia       = @w_dct_dep_dirres,
          @i_rural_urb       = @w_dct_tipo_dirres,
          @o_mensaje_retorno = @w_resultado out

        if @w_return <> 0
        begin
          select
            @w_msg = 'Error Actualizacion direccion de residencia. ' +
                     @w_resultado
          goto AUDITORIA
        end
        else
          select
            @w_msg_exito = @w_msg_exito + 'Actualiza Dir. Residencia. '

        /*****VERIFICA TELEFONO FIJO DE RESIDENCIA*****/
        if not exists(select
                        1
                      from   cl_telefono
                      where  te_ente          = @w_dct_ente
                         and te_valor         = @w_dct_tel_res
                         --  and   te_prefijo     = @w_prefijo
                         and te_tipo_telefono = 'D')
        begin
          /*****OBTIENE SECUENCIAL DEL TELEFONO*****/
          select
            @w_secuencial = isnull(max (te_secuencial), 0) + 1
          from   cobis..cl_telefono
          where  te_ente      = @w_dct_ente
             and te_direccion = @w_dato

          if @@rowcount = 0
          begin
            select
              @w_msg = 'SECUENCIAL NO EXISTENTE. '
            goto AUDITORIA
          end

          /************ACTUALIZA TELEFONO******************/
          exec @w_return = sp_telefono
            @s_ssn             = 1,
            @s_user            = @w_dct_login_funcionario,
            @s_date            = @w_fec_formulario,
            @s_srv             = 'batch',
            @s_lsrv            = 'batch',
            @s_ofi             = @w_dct_oficina,
            @t_debug           = 'N',
            @t_trn             = 111,
            @i_operacion       = 'I',
            @i_ente            = @w_dct_ente,
            @i_secuencial      = @w_secuencial,
            @i_direccion       = @w_dato,
            @i_valor           = @w_dct_tel_res,
            @i_tipo_telefono   = 'D',
            @i_prefijo         = @w_prefijo,
            @i_linea           = 'N',
            @o_mensaje_retorno = @w_resultado out

          if @w_return <> 0
          begin
            select
              @w_msg = 'Error en actualizacion telefono. ' + @w_resultado
            goto AUDITORIA
          end
          else
            select
              @w_msg_exito = @w_msg_exito + 'Crea Tel Residencia. '

        end -- fin de no existe telefono residencia
      end --fin del else 
    end /*Fin de direccion de residencia*/
    else
    begin
      select
        @w_msg_aux = @w_msg_aux + 'Dir.Res o Telefono Residencia Incompletos. '
    end

    if @w_dct_medio_ext = 'R'
    begin
      select
        @w_consec_ext = @w_dato,
        @w_forma_ext = 'D'
    end

    /***** CELULAR 1 ***/
    if (not exists(select
                     1
                   from   cl_telefono
                   where  te_ente          = @w_dct_ente
                      and te_valor         = @w_dct_cel1
                      and te_tipo_telefono = 'C'))
    begin
      if len(@w_dct_cel1) = 7
         and exists (select
                       1
                     from   cl_catalogo,
                            cl_tabla
                     where  cl_catalogo.codigo = @w_dct_prefijo1
                        and cl_catalogo.estado = 'V'
                        and cl_catalogo.tabla  = cl_tabla.codigo
                        and cl_tabla.tabla     = 'cl_prefijo_telefono')
      begin
        /*****OBTIENE SECUENCIAL DEL TELEFONO CELULAR*****/
        select
          @w_secuencial = isnull(max (te_secuencial), 0) + 1
        from   cobis..cl_telefono
        where  te_ente      = @w_dct_ente
           and te_direccion = @w_dct_dir_principal

        if @@rowcount = 0
        begin
          select
            @w_msg = 'SECUENCIAL NO EXISTENTE. '
          goto AUDITORIA
        end

        /************ACTUALIZA CELULAR1******************/
        exec @w_return = sp_telefono
          @s_ssn             = 1,
          @s_user            = @w_dct_login_funcionario,
          @s_date            = @w_fec_formulario,
          @s_srv             = 'batch',
          @s_lsrv            = 'batch',
          @s_ofi             = @w_dct_oficina,
          @t_debug           = 'N',
          @t_trn             = 111,
          @i_operacion       = 'I',
          @i_ente            = @w_dct_ente,
          @i_direccion       = @w_dct_dir_principal,
          @i_valor           = @w_dct_cel1,
          @i_tipo_telefono   = 'C',
          @i_prefijo         = @w_dct_prefijo1,
          @i_secuencial      = @w_secuencial,
          @i_linea           = 'N',
          @o_mensaje_retorno = @w_resultado out

        if @w_return <> 0
        begin
          select
            @w_msg = 'Error en actualizacion de cel1. ' + @w_resultado
          goto AUDITORIA
        end
        else
          select
            @w_msg_exito = @w_msg_exito + 'Inserta Cel 1. '

      end /*not existe celu1*/
      else
      begin
        if (@w_dct_cel1 is not null
             or @w_dct_prefijo1 is not null)
          select
            @w_msg_aux = @w_msg_aux + ' Error Cel1 Invalido. '
      end
    end
    /*********************CELULAR 2**********************/
    if (not exists(select
                     1
                   from   cl_telefono
                   where  te_ente          = @w_dct_ente
                      and te_valor         = @w_dct_cel2
                      and te_tipo_telefono = 'C'))
    begin
      if len(@w_dct_cel2) = 7
         and exists (select
                       1
                     from   cl_catalogo,
                            cl_tabla
                     where  cl_catalogo.codigo = @w_dct_prefijo2
                        and cl_catalogo.estado = 'V'
                        and cl_catalogo.tabla  = cl_tabla.codigo
                        and cl_tabla.tabla     = 'cl_prefijo_telefono')
      begin
        /*****OBTIENE SECUENCIAL DEL TELEFONO CELULAR*****/
        select
          @w_secuencial = isnull(max (te_secuencial), 0) + 1
        from   cobis..cl_telefono
        where  te_ente      = @w_dct_ente
           and te_direccion = @w_dct_dir_principal

        if @@rowcount = 0
        begin
          select
            @w_msg = 'SECUENCIAL NO EXISTENTE. '
          goto AUDITORIA
        end

        /************ACTUALIZA CELULAR2******************/
        exec @w_return = sp_telefono
          @s_ssn             = 1,
          @s_user            = @w_dct_login_funcionario,
          @s_date            = @w_fec_formulario,
          @s_srv             = 'batch',
          @s_lsrv            = 'batch',
          @s_ofi             = @w_dct_oficina,
          @t_debug           = 'N',
          @t_trn             = 111,
          @i_operacion       = 'I',
          @i_ente            = @w_dct_ente,
          @i_direccion       = @w_dct_dir_principal,
          @i_valor           = @w_dct_cel2,
          @i_tipo_telefono   = 'C',
          @i_prefijo         = @w_dct_prefijo2,
          @i_secuencial      = @w_secuencial,
          @i_linea           = 'N',
          @o_mensaje_retorno = @w_resultado out

        if @w_return <> 0
        begin
          select
            @w_msg = 'Error en actualizacion cel2. ' + @w_resultado
          goto AUDITORIA
        end
        else
          select
            @w_msg_exito = @w_msg_exito + 'Inserta Cel 2. '

      end/*fin del not existe celu2*/
      else
      begin
        if (@w_dct_cel2 is not null
             or @w_dct_prefijo2 is not null)
          select
            @w_msg_aux = @w_msg_aux + 'Error Cel2 Invalido. '
      end
    end

    /************INSERCION DEL CORREO******************/
    if (not exists (select
                      1
                    from   cl_direccion
                    where  di_ente        = @w_dct_ente
                       and di_tipo        = @w_tmail
                       and di_descripcion = @w_dct_correo)
        and @w_dct_correo is not null)
    begin
      /*******ACTUALIZA DIRECCION DE CORREO***********/
      exec @w_return = sp_direccion_dml
        @s_ssn                 = 1,
        @s_user                = @w_dct_login_funcionario,
        @s_date                = @w_fec_formulario,
        @s_srv                 = 'batch',
        @s_lsrv                = 'batch',
        @s_ofi                 = @w_dct_oficina,
        @t_trn                 = 109,
        @i_linea               = 'N',
        @i_operacion           = 'I',
        @i_ente                = @w_dct_ente,
        @i_descripcion         = @w_dct_correo,
        @i_tipo                = @w_tmail,
        @i_oficina             = @w_dct_oficina,
        @o_mensaje_retorno     = @w_resultado out,
        @o_siguiente_direccion = @w_dir_siguiente out

      if @w_return <> 0
      begin
        select
          @w_msg = 'Error en insercion del correo. ' + @w_resultado
        goto AUDITORIA
      end
      else
        select
          @w_msg_exito = @w_msg_exito + 'Inserta Correo. '

      select
        @w_dato = @w_dir_siguiente

    end /****correo existe****/

    if @w_dct_medio_ext = 'C'
    begin
      select
        @w_consec_ext = @w_dato,
        @w_forma_ext = 'C'
    end

    if @w_dct_medio_ext = 'O'
    begin
      select
        @w_ofi = null

      /*** BUSCA OFICINA MAS RECIENTE CON PRODUCTOS DEL CLIENTE ***/
      select top 1
        @w_ofi = dp_oficina
      from   cobis..cl_det_producto
      where  dp_cliente_ec = @w_dct_ente
      order  by dp_fecha desc

      if @w_ofi is null
      begin
        /*** BUSCA OFICINA DE CREACION DEL CLIENTE ***/
        select
          @w_ofi = case
                     when en_oficina_prod is null then en_oficina
                     else en_oficina_prod
                   end
        from   cobis..cl_ente
        where  en_ente = @w_dct_ente

        if @w_ofi is null
          select
            @w_ofi = @w_dct_oficina
      end

      select
        @w_consec_ext = @w_ofi,
        @w_forma_ext = 'R'
    end

    if exists (select
                 1
               from   cobis..cl_forma_extractos
               where  fe_cliente = @w_dct_ente)
      select
        @w_operacion = 'U'
    else
      select
        @w_operacion = 'I'

    exec @w_return = cobis..sp_forma_extracto
      @s_ssn         = 1,
      @s_date        = @w_fec_formulario,
      @s_user        = @w_dct_login_funcionario,
      @s_srv         = 'batch',
      @s_lsrv        = 'batch',
      @s_term        = 'KERNELPROD',
      @s_ofi         = @w_dct_oficina,
      @t_trn         = 1609,
      @i_operacion   = @w_operacion,
      @i_cliente     = @w_dct_ente,
      @i_codigo      = @w_consec_ext,
      @i_forma_ext   = @w_forma_ext,
      @i_linea       = 'N',
      @o_msg_retorno = @w_msg out

    if @w_return <> 0
      goto AUDITORIA
    else
      select
        @w_msg_exito = @w_msg_exito + 'Actualizacion marcacion extracto OK. '

    /************ACTUALIZA REGISTRO EXITOSO******************/

    if (@w_msg_aux = '')
    begin
      update cl_datos_clientes_tmp
      set    dct_estado = 'A',
             dct_msg = 'Proceso Terminado con Exito. ' + @w_msg_exito
      where  dct_ente = @w_dct_ente
    end
    else
    begin
      update cl_datos_clientes_tmp
      set    dct_estado = 'E',
             dct_msg = 'Proceso Terminado con Errores. ' + @w_msg_aux
      where  dct_ente = @w_dct_ente
    end
    if @@error <> 0
    begin
      select
        @w_error = 103115,
        @w_msg = 'NO SE PUDO ACTUALIZAR ESTADO DEL REGISTRO EXITOSO. '
      goto ERROR_FIN
    end

    goto SIGA

    /************GENERAR REGISTRO DE AUDITORIA DEL PROCESO******************/
    AUDITORIA:
    /************ACTUALIZA REGISTRO ERRORES*****************/
    update cl_datos_clientes_tmp
    set    dct_estado = 'P',
           dct_msg = 'Actualizacion con Errores. ' + cast(@w_msg as varchar(50))
                     +
                     ', '
                     + cast(@w_return as varchar)
    where  dct_ente = @w_dct_ente

    if @@error <> 0
    begin
      select
        @w_error = 103115,
        @w_msg = 'NO SE PUDO ACTUALIZAR ESTADO DEL REGISTRO DE ERROR. '
      goto ERROR_FIN
    end

    SIGA:
    set @w_int = @w_int + 1

  end /*Fin while*/

  /************TRUNCAR LA TABLA TEMPORAL #apoyo*****************/
  truncate table #apoyo

  /************INSERTAR cl_datos_clientes_tmp en cl_clientes_tmp*****************/
  insert into cl_clientes_tmp
              (ct_datos)
    select
      isnull(convert(varchar(10), dct_oficina), '') + '|' + isnull(dct_tip_doc,
      ''
      )
      +
      '|'
      + isnull(dct_num_doc, '') + '|' + isnull(dct_nombres, '') + '|' + isnull(
      dct_pri_ape, '') + '|'
      + isnull(dct_seg_ape, '') + '|' + isnull(dct_estado, '') + '|' + isnull(
      dct_msg
      , '')
    from   cl_datos_clientes_tmp

/************CREACION ARCHIVO DE SALIDA**************************************************/
  /*CARGA EN VARIABLE @W_COMANDO*/
  select
    @w_comando = @w_s_app + 's_app' +
                        ' bcp -auto -login cobis..cl_clientes_tmp out ' +
                 @w_path
                 +
                        'Salida_'
                 + @i_param1 + ' -b100 -t"&&" -c -e' + @w_path + + 'Salida_' +
                        @i_param1 + '.err -config ' + @w_s_app
                 + 's_app.ini'

  /*SE EJECUTA CON CMDSHELL*/
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @i_param1 + ' ' + convert(varchar,
                      @w_error)
    goto ERROR_FIN
  end
  else
  begin
    /* Solamente deja el archivo definitivo, se eliminan los archivos temporales */
    select
      @w_comando = 'del ' + @w_path + 'Salida_' + @i_param1 + '.err'
    exec @w_error = xp_cmdshell
      @w_comando
    if @w_error <> 0
    begin
      select
        @w_error = 808022,
        @w_msg = 'ERROR AL ELIMINAR ARCHIVOS TEMPORALES DE TRABAJO.'
      print @w_comando
      goto ERROR_FIN
    end
  end

  return 0
  
  ERROR_FIN:

  exec sp_errorlog
    @i_fecha       = @w_fec_formulario,
    @i_error       = @w_error,
    @i_usuario     = 'operador',
    @i_tran        = @w_error,
    @i_tran_name   = 'sp_act_mas_dirext',
    @i_cuenta      = '',
    @i_rollback    = 'N',
    @i_descripcion = @w_msg
--return 1   

go

