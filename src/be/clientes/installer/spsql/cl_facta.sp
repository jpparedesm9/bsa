/*************************************************************************/
/*   Archivo:             cl_fatca.sp                                    */
/*   Stored procedure:    sp_mantenimiento_fatca                         */
/*   Base de datos:       cobis                                          */
/*   Producto:            Clientes                                       */
/*   Disenado por:        Pedro A. Rojas - Elizabeth Ochoa               */
/*   Fecha de escritura:  Oct. 2014.                                     */
/*************************************************************************/
/*                              IMPORTANTE                               */
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
/*************************************************************************/
/*                              PROPOSITO                                */
/*                                                                       */
/*************************************************************************/
/*                           MODIFICACIONES                              */
/*    FECHA             AUTOR         RAZON                              */
/*    May/02/2016     DFu             Migracion CEN                      */
/*************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_mantenimiento_fatca')
  drop proc sp_mantenimiento_fatca
go

create proc sp_mantenimiento_fatca
  /* VARIABLES DE SESION DE COBIS KERNEL */
  @s_ssn                    int = null,
  @s_user                   login = null,
  @s_sesn                   int = null,
  @s_term                   varchar(30) = null,
  @s_date                   datetime = null,
  @s_srv                    varchar(30) = null,
  @s_lsrv                   varchar(30) = null,
  @s_rol                    smallint = null,
  @s_ofi                    smallint = null,
  @s_org_err                char(1) = null,
  @s_error                  int = null,
  @s_sev                    tinyint = null,
  @s_msg                    descripcion = null,
  @s_org                    char(1) = null,

  /* VARIABLES DE TRANSACCION */
  @t_debug                  char(1) = 'N',
  @t_file                   varchar(14) = null,
  @t_from                   varchar(32) = null,
  @t_trn                    smallint = null,
  @t_show_version           bit = 0,

  /* VARIABLES DE ENTRADA MINIMAS */
  @i_operacion              char(1),
  @i_modo                   smallint = null,
  @i_estado                 varchar(1) = 'V',
  @i_formato_fecha          int = 103,
  @i_fa_tipo_id             char(2) = null,
  @i_fa_num_id              numero = null,
  @i_fa_subtipo_persona     char(1) = null,
  @i_fa_tipo_persona        char(3) = null,
  @i_fa_tipo_id_rep_lg      char(2) = null,
  @i_fa_num_id_rep_lg       numero = null,
  @i_fa_nom_entidad         mensaje = null,
  @i_fa_pais_constitucion   varchar(30) = null,
  @i_fa_direccion_emp       mensaje = null,
  @i_fa_pais_emp            varchar(30) = null,
  @i_fa_ciudad_emp          varchar(30) = null,
  @i_fa_est_provi_emp       varchar(30) = null,
  @i_fa_cod_postal_emp      int = null,
  @i_fa_nombre              varchar(30) = null,
  @i_fa_primer_apellido     varchar(30) = null,
  @i_fa_segundo_apellido    varchar(30) = null,
  @i_fa_pais_nacimiento     varchar(30) = null,
  @i_fa_ciudad_nacimiento   varchar(30) = null,
  @i_fa_direcion_residencia mensaje = null,
  @i_fa_pais_residencia     varchar(30) = null,
  @i_fa_ciudad_residencia   varchar(30) = null,
  @i_fa_est_provi_residen   varchar(30) = null,
  @i_fa_cod_postal          int = null,
  @i_fa_pregunta1           varchar(2) = null,
  @i_fa_pregunta2           varchar(2) = null,
  @i_fa_pregunta3           varchar(2) = null,
  @i_fa_pregunta4           varchar(2) = null,
  @i_fa_pregunta5           varchar(2) = null,
  @i_fa_pregunta6           varchar(2) = null,
  @i_fa_pregunta7           varchar(2) = null,
  @i_fa_pregunta8           varchar(2) = null,
  @i_fa_pregunta9           varchar(2) = null,
  @i_fa_pregunta10          varchar(2) = null,
  @i_fa_pregunta11          varchar(2) = null,
  @i_fa_pregunta12          varchar(2) = null,
  @i_fa_pregunta13          varchar(2) = null,
  @i_fa_pregunta14          varchar(2) = null,
  @i_fa_pregunta15          varchar(2) = null,
  @i_fa_pregunta16          varchar(2) = null,
  @i_fa_pregunta17          varchar(2) = null,
  @i_fa_pregunta18          varchar(2) = null,
  @i_fa_pregunta19          varchar(2) = null,
  @i_fa_marca_doc_comp      varchar(1) = null,
  @i_fa_observaciones1      mensaje = null,
  @i_fa_observaciones2      mensaje = null,
  @i_fa_observaciones3      mensaje = null,
  @i_fa_observaciones4      mensaje = null,
  @i_fa_pais_efe_fiscal1    varchar(30) = null,
  @i_fa_pais_efe_fiscal2    varchar(30) = null,
  @i_fa_pais_efe_fiscal3    varchar(30) = null,
  @i_fa_num_id_fiscal1      varchar(15) = null,
  @i_fa_num_id_fiscal2      varchar(15) = null,
  @i_fa_num_id_fiscal3      varchar(15) = null,
  @i_fa_fec_doc_sup         datetime = null,
  @i_fa_ein_vigen           varchar(15) = null,
  @i_fa_giin_vigen          varchar(15) = null,
  @i_fa_fecha_solici        datetime = null,
  @i_fa_fec_mod             datetime = null,
  @i_fa_calificacion        varchar(2) = null,
  @i_telefono_ppal          varchar(11) = null,
  @i_direccion_ppal         mensaje = null,
  @i_bandera                char(1) = '0',
  @i_prefijo                varchar(3) = null,
  @i_fa_fec_imp             datetime = null,
  @i_fa_ciiu                varchar(10) = null
as
  declare
    @w_error                  int,
    @w_sp_name                varchar(64),
    @w_fecha                  datetime,
    @w_msg                    varchar(255),
    @w_comando                varchar(255),
    @w_cliente                varchar(50),
    @w_user                   varchar(50),
    @w_trn                    int,
    @w_fecha_proceso          datetime,
    ------------------------------------
    @w_fa_tipo_id             char(2),
    @w_fa_num_id              numero,
    @w_fa_tipo_persona        char(3),
    @w_fa_subtipo_persona     char(1),
    @w_fa_tipo_id_rep_lg      char(2),
    @w_fa_num_id_rep_lg       numero,
    @w_fa_nom_entidad         mensaje,
    @w_fa_pais_constitucion   varchar(30),
    @w_fa_direccion_emp       mensaje,
    @w_fa_pais_emp            varchar(30),
    @w_fa_ciudad_emp          varchar(30),
    @w_fa_est_provi_emp       varchar(30),
    @w_fa_cod_postal_emp      int,
    @w_fa_nombre              varchar(30),
    @w_fa_primer_apellido     varchar(30),
    @w_fa_segundo_apellido    varchar(30),
    @w_fa_pais_nacimiento     varchar(30),
    @w_fa_ciudad_nacimiento   varchar(30),
    @w_fa_direcion_residencia mensaje,
    @w_fa_pais_residencia     varchar(30),
    @w_fa_ciudad_residencia   varchar(30),
    @w_fa_est_provi_residen   varchar(30),
    @w_fa_cod_postal          int,
    @w_fa_pregunta1           varchar(2),
    @w_fa_pregunta2           varchar(2),
    @w_fa_pregunta3           varchar(2),
    @w_fa_pregunta4           varchar(2),
    @w_fa_pregunta5           varchar(2),
    @w_fa_pregunta6           varchar(2),
    @w_fa_pregunta7           varchar(2),
    @w_fa_pregunta8           varchar(2),
    @w_fa_pregunta9           varchar(2),
    @w_fa_pregunta10          varchar(2),
    @w_fa_pregunta11          varchar(2),
    @w_fa_pregunta12          varchar(2),
    @w_fa_pregunta13          varchar(2),
    @w_fa_pregunta14          varchar(2),
    @w_fa_pregunta15          varchar(2),
    @w_fa_pregunta16          varchar(2),
    @w_fa_pregunta17          varchar(2),
    @w_fa_pregunta18          varchar(2),
    @w_fa_pregunta19          varchar(2),
    @w_fa_marca_doc_comp      varchar(1),
    @w_fa_observaciones1      mensaje,
    @w_fa_observaciones2      mensaje,
    @w_fa_observaciones3      mensaje,
    @w_fa_observaciones4      mensaje,
    @w_fa_pais_efe_fiscal1    varchar(30),
    @w_fa_pais_efe_fiscal2    varchar(30),
    @w_fa_pais_efe_fiscal3    varchar(30),
    @w_fa_num_id_fiscal1      varchar(15),
    @w_fa_num_id_fiscal2      varchar(15),
    @w_fa_num_id_fiscal3      varchar(15),
    @w_fa_fec_doc_sup         datetime,
    @w_fa_ein_vigen           varchar(15),
    @w_fa_giin_vigen          varchar(15),
    @w_fa_fecha_solici        datetime,
    @w_fa_fec_mod             datetime,
    @w_fa_calificacion        varchar(2),
    @w_fa_telefono_ppal       varchar(11),
    @w_fa_direccion_ppal      mensaje,
    @w_operacion              char(1),
    @w_descri_calif           mensaje,
    @w_of_nombre              mensaje,
    @w_fu_nombre              mensaje,
    @w_fu_cod_cargo           varchar(30),
    @w_fu_cargo               mensaje,
    @w_calificastr            varchar(60),
    @w_fa_fec_imp             datetime,
    @w_pais                   varchar(20),
    @w_aux                    char(2),
    @w_aux1                   char(2),
    @w_catalogo               char(2)

  select
    @w_sp_name = 'sp_mantenimiento_fatca'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_operacion = 'B'
  begin
    select
      @w_fa_tipo_id = fa_tipo_id,
      @w_fa_num_id = fa_num_id,
      @w_fa_tipo_persona = fa_tipo_persona,
      @w_fa_subtipo_persona = fa_subtipo_persona,
      @w_fa_tipo_id_rep_lg = fa_tipo_id_rep_lg,
      @w_fa_num_id_rep_lg = fa_num_id_rep_lg,
      @w_fa_nom_entidad = fa_nom_entidad,
      @w_fa_pais_constitucion = fa_pais_constitucion,
      @w_fa_direccion_emp = fa_direccion_emp,
      @w_fa_pais_emp = fa_pais_emp,
      @w_fa_ciudad_emp = fa_ciudad_emp,
      @w_fa_est_provi_emp = fa_est_provi_emp,
      @w_fa_cod_postal_emp = fa_cod_postal_emp,
      @w_fa_nombre = fa_nombre,
      @w_fa_primer_apellido = fa_primer_apellido,
      @w_fa_segundo_apellido = fa_segundo_apellido,
      @w_fa_pais_nacimiento = fa_pais_nacimiento,
      @w_fa_ciudad_nacimiento = fa_ciudad_nacimiento,
      @w_fa_direcion_residencia = fa_direcion_residencia,
      @w_fa_pais_residencia = fa_pais_residencia,
      @w_fa_ciudad_residencia = fa_ciudad_residencia,
      @w_fa_est_provi_residen = fa_est_provi_residen,
      @w_fa_cod_postal = fa_cod_postal,
      @w_fa_pregunta1 = fa_pregunta1,
      @w_fa_pregunta2 = fa_pregunta2,
      @w_fa_pregunta3 = fa_pregunta3,
      @w_fa_pregunta4 = fa_pregunta4,
      @w_fa_pregunta5 = fa_pregunta5,
      @w_fa_pregunta6 = fa_pregunta6,
      @w_fa_pregunta7 = fa_pregunta7,
      @w_fa_pregunta8 = fa_pregunta8,
      @w_fa_pregunta9 = fa_pregunta9,
      @w_fa_pregunta10 = fa_pregunta10,
      @w_fa_pregunta11 = fa_pregunta11,
      @w_fa_pregunta12 = fa_pregunta12,
      @w_fa_pregunta13 = fa_pregunta13,
      @w_fa_pregunta14 = fa_pregunta14,
      @w_fa_pregunta15 = fa_pregunta15,
      @w_fa_pregunta16 = fa_pregunta16,
      @w_fa_pregunta17 = fa_pregunta17,
      @w_fa_pregunta18 = fa_pregunta18,
      @w_fa_pregunta19 = fa_pregunta19,
      @w_fa_marca_doc_comp = fa_marca_doc_comp,
      @w_fa_observaciones1 = fa_observaciones1,
      @w_fa_observaciones2 = fa_observaciones2,
      @w_fa_observaciones3 = fa_observaciones3,
      @w_fa_observaciones4 = fa_observaciones4,
      @w_fa_pais_efe_fiscal1 = fa_pais_efe_fiscal1,
      @w_fa_pais_efe_fiscal2 = fa_pais_efe_fiscal2,
      @w_fa_pais_efe_fiscal3 = fa_pais_efe_fiscal3,
      @w_fa_num_id_fiscal1 = fa_num_id_fiscal1,
      @w_fa_num_id_fiscal2 = fa_num_id_fiscal2,
      @w_fa_num_id_fiscal3 = fa_num_id_fiscal3,
      @w_fa_fec_doc_sup = fa_fec_doc_sup,
      @w_fa_ein_vigen = fa_ein_vigen,
      @w_fa_giin_vigen = fa_giin_vigen,
      @w_fa_fecha_solici = isnull(fa_fecha_solici,
                                  '01/01/1900'),
      @w_fa_fec_mod = isnull(fa_fec_mod,
                             '01/01/1900'),
      @w_fa_calificacion = fa_calificacion,
      @w_fa_telefono_ppal = fa_telefono_ppal,
      @w_fa_direccion_ppal = fa_direccion_ppal,
      @w_fa_fec_imp = isnull(fa_fec_impresion,
                             '01/01/1900')
    from   cl_fatca
    where  fa_tipo_id         = @i_fa_tipo_id
       and fa_num_id          = @i_fa_num_id
       and fa_subtipo_persona = @i_fa_subtipo_persona

    if @w_fa_subtipo_persona = 'P'
    begin
      select
        @w_descri_calif = A.valor
      from   cobis..cl_catalogo A,
             cobis..cl_tabla B
      where  A.tabla  = B.codigo
         and B.tabla  = 'cl_est_fatca'
         and A.codigo = @w_fa_calificacion
    end
    else
    begin
      select
        @w_descri_calif = A.valor
      from   cobis..cl_catalogo A,
             cobis..cl_tabla B
      where  A.tabla  = B.codigo
         and B.tabla  = 'cl_califica_fatca_pj'
         and A.codigo = @w_fa_calificacion

    end

    select
      @w_calificastr = @w_fa_calificacion + ' - ' + @w_descri_calif

    if @@rowcount = 0
    begin
      select
        @w_error = 105506
      goto ERROR_FIN
    end

    select
      @w_fa_tipo_id,
      @w_fa_num_id,
      @w_fa_tipo_persona,
      @w_fa_subtipo_persona,
      @w_fa_calificacion,
      @w_fa_tipo_id_rep_lg,
      @w_fa_num_id_rep_lg,
      @w_fa_nom_entidad,
      @w_fa_pais_constitucion,
      @w_fa_direccion_emp,
      @w_fa_pais_emp,
      @w_fa_ciudad_emp,
      @w_fa_est_provi_emp,
      @w_fa_cod_postal_emp,
      @w_fa_nombre,
      @w_fa_primer_apellido,
      @w_fa_segundo_apellido,
      @w_fa_pais_nacimiento,
      @w_fa_ciudad_nacimiento,
      @w_fa_direcion_residencia,
      @w_fa_pais_residencia,
      @w_fa_ciudad_residencia,
      @w_fa_est_provi_residen,
      @w_fa_cod_postal,
      @w_fa_pregunta1,
      @w_fa_pregunta2,
      @w_fa_pregunta3,
      @w_fa_pregunta4,
      @w_fa_pregunta5,
      @w_fa_pregunta6,
      @w_fa_pregunta7,
      @w_fa_pregunta8,
      @w_fa_pregunta9,
      @w_fa_pregunta10,
      @w_fa_pregunta11,
      @w_fa_pregunta12,
      @w_fa_pregunta13,
      @w_fa_pregunta14,
      @w_fa_pregunta15,
      @w_fa_pregunta16,
      @w_fa_pregunta17,
      @w_fa_pregunta18,
      @w_fa_pregunta19,
      @w_fa_marca_doc_comp,
      @w_fa_observaciones1,
      @w_fa_observaciones2,
      @w_fa_observaciones3,
      @w_fa_pais_efe_fiscal1,
      @w_fa_pais_efe_fiscal2,
      @w_fa_pais_efe_fiscal3,
      @w_fa_num_id_fiscal1,
      @w_fa_num_id_fiscal2,
      @w_fa_num_id_fiscal3,
      convert(varchar(10), @w_fa_fec_doc_sup, 103),
      @w_fa_ein_vigen,
      @w_fa_giin_vigen,
      @w_fa_fecha_solici,
      @w_fa_fec_mod,
      @w_fa_telefono_ppal,
      @w_fa_direccion_ppal,
      @w_calificastr,
      @w_fa_fec_imp,
      @w_fa_observaciones4

  end --Fin B

  if @i_operacion = 'I'
  begin
    if exists(select
                1
              from   cobis..cl_fatca
              where  fa_tipo_id         = @i_fa_tipo_id
                 and fa_num_id          = @i_fa_num_id
                 and fa_subtipo_persona = @i_fa_subtipo_persona)
    begin
      select
        @w_error = 101260
      goto ERROR_FIN
    end

    insert into cobis..cl_fatca
                (fa_tipo_id,fa_num_id,fa_tipo_persona,fa_subtipo_persona,
                 fa_tipo_id_rep_lg,
                 fa_num_id_rep_lg,fa_pais_constitucion,fa_direccion_emp,
                 fa_pais_emp,
                 fa_ciudad_emp,
                 fa_est_provi_emp,fa_cod_postal_emp,fa_nombre,fa_primer_apellido
                 ,
                 fa_segundo_apellido,
                 fa_pais_nacimiento,fa_ciudad_nacimiento,fa_direcion_residencia,
                 fa_pais_residencia,fa_ciudad_residencia,
                 fa_est_provi_residen,fa_cod_postal,fa_pregunta1,fa_pregunta2,
                 fa_pregunta3,
                 fa_pregunta4,fa_pregunta5,fa_pregunta6,fa_pregunta7,
                 fa_pregunta8,
                 fa_pregunta9,fa_pregunta10,fa_pregunta11,fa_pregunta12,
                 fa_pregunta13,
                 fa_pregunta14,fa_pregunta15,fa_pregunta16,fa_pregunta17,
                 fa_pregunta18,
                 fa_pregunta19,fa_marca_doc_comp,fa_observaciones1,
                 fa_observaciones2
                 ,fa_observaciones3,
                 fa_pais_efe_fiscal1,fa_pais_efe_fiscal2,fa_pais_efe_fiscal3,
                 fa_num_id_fiscal1,fa_num_id_fiscal2,
                 fa_num_id_fiscal3,fa_fec_doc_sup,fa_ein_vigen,fa_giin_vigen,
                 fa_fecha_solici,
                 fa_fec_mod,fa_calificacion,fa_nom_entidad,fa_telefono_ppal,
                 fa_direccion_ppal,
                 fa_fec_impresion,fa_observaciones4,fa_ciiu,fa_login,fa_oficina)
    values      (@i_fa_tipo_id,@i_fa_num_id,@i_fa_tipo_persona,
                 @i_fa_subtipo_persona,
                 @i_fa_tipo_id_rep_lg,
                 @i_fa_num_id_rep_lg,@i_fa_pais_constitucion,@i_fa_direccion_emp
                 ,
                 @i_fa_pais_emp,@i_fa_ciudad_emp,
                 @i_fa_est_provi_emp,@i_fa_cod_postal_emp,@i_fa_nombre,
                 @i_fa_primer_apellido,@i_fa_segundo_apellido,
                 @i_fa_pais_nacimiento,@i_fa_ciudad_nacimiento,
                 @i_fa_direcion_residencia,@i_fa_pais_residencia,
                 @i_fa_ciudad_residencia,
                 @i_fa_est_provi_residen,@i_fa_cod_postal,@i_fa_pregunta1,
                 @i_fa_pregunta2,@i_fa_pregunta3,
                 @i_fa_pregunta4,@i_fa_pregunta5,@i_fa_pregunta6,@i_fa_pregunta7
                 ,
                 @i_fa_pregunta8,
                 @i_fa_pregunta9,@i_fa_pregunta10,@i_fa_pregunta11,
                 @i_fa_pregunta12,
                 @i_fa_pregunta13,
                 @i_fa_pregunta14,@i_fa_pregunta15,@i_fa_pregunta16,
                 @i_fa_pregunta17
                 ,@i_fa_pregunta18,
                 @i_fa_pregunta19,@i_fa_marca_doc_comp,@i_fa_observaciones1,
                 @i_fa_observaciones2,@i_fa_observaciones3,
                 @i_fa_pais_efe_fiscal1,@i_fa_pais_efe_fiscal2,
                 @i_fa_pais_efe_fiscal3,@i_fa_num_id_fiscal1,
                 @i_fa_num_id_fiscal2,
                 @i_fa_num_id_fiscal3,@i_fa_fec_doc_sup,@i_fa_ein_vigen,
                 @i_fa_giin_vigen,getdate(),
                 @i_fa_fec_mod,null,@i_fa_nom_entidad,@i_telefono_ppal,
                 @i_direccion_ppal,
                 null,@i_fa_observaciones4,@i_fa_ciiu,@s_user,@s_ofi)
    if @@error <> 0
    begin
      select
        @w_error = 103136
      goto ERROR_FIN
    end

    insert into cobis..ts_fatca
                (ts_tipo_id,ts_num_id,ts_tipo_persona,ts_subtipo_persona,
                 ts_tipo_id_rep_lg,
                 ts_num_id_rep_lg,ts_pais_constitucion,ts_direccion_emp,
                 ts_pais_emp,
                 ts_ciudad_emp,
                 ts_est_provi_emp,ts_cod_postal_emp,ts_nombre,ts_primer_apellido
                 ,
                 ts_segundo_apellido,
                 ts_pais_nacimiento,ts_ciudad_nacimiento,ts_direcion_residencia,
                 ts_pais_residencia,ts_ciudad_residencia,
                 ts_est_provi_residen,ts_cod_postal,ts_pregunta1,ts_pregunta2,
                 ts_pregunta3,
                 ts_pregunta4,ts_pregunta5,ts_pregunta6,ts_pregunta7,
                 ts_pregunta8,
                 ts_pregunta9,ts_pregunta10,ts_pregunta11,ts_pregunta12,
                 ts_pregunta13,
                 ts_pregunta14,ts_pregunta15,ts_pregunta16,ts_pregunta17,
                 ts_pregunta18,
                 ts_pregunta19,ts_marca_doc_comp,ts_observaciones1,
                 ts_observaciones2
                 ,ts_observaciones3,
                 ts_pais_efe_fiscal1,ts_pais_efe_fiscal2,ts_pais_efe_fiscal3,
                 ts_num_id_fiscal1,ts_num_id_fiscal2,
                 ts_num_id_fiscal3,ts_fec_doc_sup,ts_ein_vigen,ts_giin_vigen,
                 ts_fecha_solici,
                 ts_fec_mod,ts_calificacion,ts_nom_entidad,ts_telefono_ppal,
                 ts_direccion_ppal,
                 ts_usuario,ts_oficina,ts_secuencial,ts_fecha_proceso,
                 ts_operacion
                 ,
                 ts_fec_impresion,ts_observaciones4,ts_ciiu)
    values      (@i_fa_tipo_id,@i_fa_num_id,@i_fa_tipo_persona,
                 @i_fa_subtipo_persona,
                 @i_fa_tipo_id_rep_lg,
                 @i_fa_num_id_rep_lg,@i_fa_pais_constitucion,@i_fa_direccion_emp
                 ,
                 @i_fa_pais_emp,@i_fa_ciudad_emp,
                 @i_fa_est_provi_emp,@i_fa_cod_postal_emp,@i_fa_nombre,
                 @i_fa_primer_apellido,@i_fa_segundo_apellido,
                 @i_fa_pais_nacimiento,@i_fa_ciudad_nacimiento,
                 @i_fa_direcion_residencia,@i_fa_pais_residencia,
                 @i_fa_ciudad_residencia,
                 @i_fa_est_provi_residen,@i_fa_cod_postal,@i_fa_pregunta1,
                 @i_fa_pregunta2,@i_fa_pregunta3,
                 @i_fa_pregunta4,@i_fa_pregunta5,@i_fa_pregunta6,@i_fa_pregunta7
                 ,
                 @i_fa_pregunta8,
                 @i_fa_pregunta9,@i_fa_pregunta10,@i_fa_pregunta11,
                 @i_fa_pregunta12,
                 @i_fa_pregunta13,
                 @i_fa_pregunta14,@i_fa_pregunta15,@i_fa_pregunta16,
                 @i_fa_pregunta17
                 ,@i_fa_pregunta18,
                 @i_fa_pregunta19,@i_fa_marca_doc_comp,@i_fa_observaciones1,
                 @i_fa_observaciones2,@i_fa_observaciones3,
                 @i_fa_pais_efe_fiscal1,@i_fa_pais_efe_fiscal2,
                 @i_fa_pais_efe_fiscal3,@i_fa_num_id_fiscal1,
                 @i_fa_num_id_fiscal2,
                 @i_fa_num_id_fiscal3,null,@i_fa_ein_vigen,@i_fa_giin_vigen,null
                 ,
                 null,null,@i_fa_nom_entidad,@i_telefono_ppal,
                 @i_direccion_ppal,
                 @s_user,@s_ofi,@s_ssn,@s_date,@i_operacion,
                 null,@i_fa_observaciones4,@i_fa_ciiu)

    if @@error <> 0
    begin
      select
        @w_error = 103005
      goto ERROR_FIN
    end
  end

  if @i_operacion = 'A'
  begin
    if not exists(select
                    1
                  from   cobis..cl_fatca
                  where  fa_tipo_id         = @i_fa_tipo_id
                     and fa_num_id          = @i_fa_num_id
                     and fa_subtipo_persona = @i_fa_subtipo_persona)
    begin
      select
        @w_error = 101261
      goto ERROR_FIN
    end

    --Actualiza tabla transervicio -Estado antes
    insert into cobis..ts_fatca
      select
        *,@s_ssn,@s_date,'P'
      from   cl_fatca
      where  fa_tipo_id         = @i_fa_tipo_id
         and fa_num_id          = @i_fa_num_id
         and fa_subtipo_persona = @i_fa_subtipo_persona

    if @@error <> 0
    begin
      select
        @w_error = 145005
      goto ERROR_FIN
    end

    ----Actualiza registro Fatca
    update cobis..cl_fatca
    set    fa_tipo_persona = @i_fa_tipo_persona,
           fa_tipo_id_rep_lg = @i_fa_tipo_id_rep_lg,
           fa_num_id_rep_lg = @i_fa_num_id_rep_lg,
           fa_nom_entidad = @i_fa_nom_entidad,
           fa_pais_constitucion = @i_fa_pais_constitucion,
           fa_direccion_emp = @i_fa_direccion_emp,
           fa_pais_emp = @i_fa_pais_emp,
           fa_ciudad_emp = @i_fa_ciudad_emp,
           fa_est_provi_emp = @i_fa_est_provi_emp,
           fa_cod_postal_emp = @i_fa_cod_postal_emp,
           fa_nombre = @i_fa_nombre,
           fa_primer_apellido = @i_fa_primer_apellido,
           fa_segundo_apellido = @i_fa_segundo_apellido,
           fa_pais_nacimiento = @i_fa_pais_nacimiento,
           fa_ciudad_nacimiento = @i_fa_ciudad_nacimiento,
           fa_direcion_residencia = @i_fa_direcion_residencia,
           fa_pais_residencia = @i_fa_pais_residencia,
           fa_ciudad_residencia = @i_fa_ciudad_residencia,
           fa_est_provi_residen = @i_fa_est_provi_residen,
           fa_cod_postal = @i_fa_cod_postal,
           fa_pregunta1 = @i_fa_pregunta1,
           fa_pregunta2 = @i_fa_pregunta2,
           fa_pregunta3 = @i_fa_pregunta3,
           fa_pregunta4 = @i_fa_pregunta4,
           fa_pregunta5 = @i_fa_pregunta5,
           fa_pregunta6 = @i_fa_pregunta6,
           fa_pregunta7 = @i_fa_pregunta7,
           fa_pregunta8 = @i_fa_pregunta8,
           fa_pregunta9 = @i_fa_pregunta9,
           fa_pregunta10 = @i_fa_pregunta10,
           fa_pregunta11 = @i_fa_pregunta11,
           fa_pregunta12 = @i_fa_pregunta12,
           fa_pregunta13 = @i_fa_pregunta13,
           fa_pregunta14 = @i_fa_pregunta14,
           fa_pregunta15 = @i_fa_pregunta15,
           fa_pregunta16 = @i_fa_pregunta16,
           fa_pregunta17 = @i_fa_pregunta17,
           fa_pregunta18 = @i_fa_pregunta18,
           fa_pregunta19 = @i_fa_pregunta19,
           fa_marca_doc_comp = @i_fa_marca_doc_comp,
           fa_observaciones1 = @i_fa_observaciones1,
           fa_observaciones2 = @i_fa_observaciones2,
           fa_observaciones3 = @i_fa_observaciones3,
           fa_observaciones4 = @i_fa_observaciones4,
           fa_pais_efe_fiscal1 = @i_fa_pais_efe_fiscal1,
           fa_pais_efe_fiscal2 = @i_fa_pais_efe_fiscal2,
           fa_pais_efe_fiscal3 = @i_fa_pais_efe_fiscal3,
           fa_num_id_fiscal1 = @i_fa_num_id_fiscal1,
           fa_num_id_fiscal2 = @i_fa_num_id_fiscal2,
           fa_num_id_fiscal3 = @i_fa_num_id_fiscal3,
           fa_fec_doc_sup = @i_fa_fec_doc_sup,
           fa_ein_vigen = @i_fa_ein_vigen,
           fa_giin_vigen = @i_fa_giin_vigen,
           fa_fec_mod = getdate(),
           fa_telefono_ppal = @i_telefono_ppal,
           fa_direccion_ppal = @i_direccion_ppal,
           fa_ciiu = @i_fa_ciiu,
           fa_login = @s_user,
           fa_oficina = @s_ofi
    where  fa_tipo_id         = @i_fa_tipo_id
       and fa_num_id          = @i_fa_num_id
       and fa_subtipo_persona = @i_fa_subtipo_persona

    if @@error <> 0
    begin
      select
        @w_error = 145005
      goto ERROR_FIN
    end

    --Actualiza tabla transervicio -Estado despues
    insert into cobis..ts_fatca
      select
        *,@s_ssn,@s_date,'U'
      from   cl_fatca
      where  fa_tipo_id         = @i_fa_tipo_id
         and fa_num_id          = @i_fa_num_id
         and fa_subtipo_persona = @i_fa_subtipo_persona

    if @@error <> 0
    begin
      select
        @w_error = 145005
      goto ERROR_FIN
    end
  end

  if @i_operacion = 'P'
  begin
    select
      @w_of_nombre = of_nombre
    from   cobis..cl_oficina
    where  of_oficina = @s_ofi

    select
      @w_fu_nombre = fu_nombre,
      @w_fu_cod_cargo = fu_cargo
    from   cobis..cl_funcionario
    where  fu_login = @s_user

    select
      @w_fu_cargo = ca.valor
    from   cobis..cl_catalogo ca
    where  tabla     = (select
                          tb.codigo
                        from   cobis..cl_tabla tb
                        where  tabla = 'cl_cargo')
       and ca.codigo = @w_fu_cod_cargo

    select
      @w_of_nombre,
      @w_fu_nombre,
      @w_fu_cargo
  end

  --BUSQUEDA DESDE PANTALLA "Registro de Informaci¾n FATCA."
  if @i_operacion = 'R'
  begin
    select
      'SUB TIPO PERSONA' = fa_subtipo_persona,
      'TIPO DOCUMENTO' = fa_tipo_id,
      'NUMERO DE DOCUMENTO' = fa_num_id,
      'NOMBRE' = fa_nombre,
      'PRIMER APELIIDO' = fa_primer_apellido,
      'SEGUNDO APELLIDO' = fa_segundo_apellido,
      'CALIFICACION' = fa_calificacion
    from   cobis..cl_fatca
    where  fa_num_id = @i_fa_num_id
  end

  if @i_operacion = 'V'
  begin
    if not exists(select
                    1
                  from   cobis..cl_tabla t,
                         cobis..cl_catalogo c
                  where  t.codigo = c.tabla
                     and t.tabla  = 'cl_pref_tel_eeuu'
                     and c.codigo = @i_prefijo)
    begin
      select
        @w_error = 101259
      goto ERROR_FIN
    end
  end

  if @i_operacion = 'C'
  begin
    --CLASIFICACION FATCA
    select
      @w_fa_tipo_id = fa_tipo_id,
      @w_fa_num_id = fa_num_id,
      @w_fa_tipo_persona = fa_tipo_persona,
      @w_fa_subtipo_persona = fa_subtipo_persona,
      @w_fa_tipo_id_rep_lg = fa_tipo_id_rep_lg,
      @w_fa_num_id_rep_lg = fa_num_id_rep_lg,
      @w_fa_nom_entidad = fa_nom_entidad,
      @w_fa_pais_constitucion = fa_pais_constitucion,
      @w_fa_direccion_emp = fa_direccion_emp,
      @w_fa_pais_emp = fa_pais_emp,
      @w_fa_ciudad_emp = fa_ciudad_emp,
      @w_fa_est_provi_emp = fa_est_provi_emp,
      @w_fa_cod_postal_emp = fa_cod_postal_emp,
      @w_fa_nombre = fa_nombre,
      @w_fa_primer_apellido = fa_primer_apellido,
      @w_fa_segundo_apellido = fa_segundo_apellido,
      @w_fa_pais_nacimiento = fa_pais_nacimiento,
      @w_fa_ciudad_nacimiento = fa_ciudad_nacimiento,
      @w_fa_direcion_residencia = fa_direcion_residencia,
      @w_fa_pais_residencia = fa_pais_residencia,
      @w_fa_ciudad_residencia = fa_ciudad_residencia,
      @w_fa_est_provi_residen = fa_est_provi_residen,
      @w_fa_cod_postal = fa_cod_postal,
      @w_fa_pregunta1 = fa_pregunta1,
      @w_fa_pregunta2 = fa_pregunta2,
      @w_fa_pregunta3 = fa_pregunta3,
      @w_fa_pregunta4 = fa_pregunta4,
      @w_fa_pregunta5 = fa_pregunta5,
      @w_fa_pregunta6 = fa_pregunta6,
      @w_fa_pregunta7 = fa_pregunta7,
      @w_fa_pregunta8 = fa_pregunta8,
      @w_fa_pregunta9 = fa_pregunta9,
      @w_fa_pregunta10 = fa_pregunta10,
      @w_fa_pregunta11 = fa_pregunta11,
      @w_fa_pregunta12 = fa_pregunta12,
      @w_fa_pregunta13 = fa_pregunta13,
      @w_fa_pregunta14 = fa_pregunta14,
      @w_fa_pregunta15 = fa_pregunta15,
      @w_fa_pregunta16 = fa_pregunta16,
      @w_fa_pregunta17 = fa_pregunta17,
      @w_fa_pregunta18 = fa_pregunta18,
      @w_fa_pregunta19 = fa_pregunta19,
      @w_fa_marca_doc_comp = fa_marca_doc_comp,
      @w_fa_observaciones1 = fa_observaciones1,
      @w_fa_observaciones2 = fa_observaciones2,
      @w_fa_observaciones3 = fa_observaciones3,
      @w_fa_pais_efe_fiscal1 = fa_pais_efe_fiscal1,
      @w_fa_pais_efe_fiscal2 = fa_pais_efe_fiscal2,
      @w_fa_pais_efe_fiscal3 = fa_pais_efe_fiscal3,
      @w_fa_num_id_fiscal1 = fa_num_id_fiscal1,
      @w_fa_num_id_fiscal2 = fa_num_id_fiscal2,
      @w_fa_num_id_fiscal3 = fa_num_id_fiscal3,
      @w_fa_fec_doc_sup = fa_fec_doc_sup,
      @w_fa_ein_vigen = fa_ein_vigen,
      @w_fa_giin_vigen = fa_giin_vigen,
      @w_fa_fecha_solici = fa_fecha_solici,
      @w_fa_fec_mod = fa_fec_mod,
      @w_fa_calificacion = fa_calificacion,
      @w_fa_telefono_ppal = fa_telefono_ppal,
      @w_fa_direccion_ppal = fa_direccion_ppal
    from   cl_fatca
    where  fa_tipo_id         = @i_fa_tipo_id
       and fa_num_id          = @i_fa_num_id
       and fa_subtipo_persona = @i_fa_subtipo_persona

    select
      @w_pais = c.valor
    from   cobis..cl_tabla t,
           cobis..cl_catalogo c
    where  t.codigo = c.tabla
       and c.estado = 'V'
       and t.tabla  = 'cl_pais'
       and c.codigo = '43'

    if @w_fa_subtipo_persona = 'P'
    -- OJO CHARLIE QUE ESTO ME SACO LOS OJOS, RESTRINGELE POR TIPO DE PERSONA NATURAL PARA TU CALIFICACION
    begin
      --Calificacion  ô01 - NON US PERSON - SIN OBLIGACIËN DE REPORTARö.
      if (@w_fa_pregunta1 = 'NO'
          and @w_fa_pregunta2 = 'NO'
          and @w_fa_pregunta3 = 'NO'
          and @w_fa_pregunta4 = 'NO'
          and @w_fa_pregunta5 = 'NO'
          and @w_fa_pregunta6 = 'NO')
      begin
        select
          @w_fa_calificacion = '01'
      end
      else
      begin
        if @w_fa_calificacion <> '03'
            or @w_fa_calificacion is null
        begin
          if @w_fa_pregunta1 = 'SI'
             and @w_fa_pregunta2 = 'NO'
             and @w_fa_pregunta3 = 'NO'
             and @w_fa_pregunta4 = 'NO'
             and @w_fa_pregunta5 = 'NO'
            select
              @w_fa_calificacion = '02'

          if @w_fa_pregunta1 = 'SI'
             and @w_fa_pregunta2 = 'NO'
             and @w_fa_pregunta3 = 'NO'
             and @w_fa_pregunta4 = 'NO'
             and @w_fa_pregunta5 = 'NO'
             and @w_fa_pregunta15 = 'SI'
            select
              @w_fa_calificacion = '01'

          if @w_fa_pregunta1 = 'SI'
             and @w_fa_pregunta2 = 'NO'
             and @w_fa_pregunta3 = 'NO'
             and @w_fa_pregunta4 = 'NO'
             and @w_fa_pregunta5 = 'NO'
             and @w_fa_pregunta13 = 'SI'
             and @w_fa_pais_efe_fiscal1 <> @w_pais
            select
              @w_fa_calificacion = '02'

          if @w_fa_pregunta1 = 'SI'
             and @w_fa_pregunta2 = 'NO'
             and @w_fa_pregunta3 = 'NO'
             and @w_fa_pregunta4 = 'NO'
             and @w_fa_pregunta5 = 'NO'
             and @w_fa_pregunta7 = 'SI'
             and @w_fa_pregunta13 = 'SI'
             and @w_fa_pais_efe_fiscal1 <> @w_pais
            select
              @w_fa_calificacion = '01'
        end

        if @w_fa_calificacion <> '03'
            or @w_fa_calificacion is null
        begin
          if(@w_fa_pais_efe_fiscal1 = @w_pais)
          begin
            if(@w_fa_num_id_fiscal1 is null)
            begin
              select
                @w_fa_calificacion = '02',
                @w_aux1 = '02'
            end
            else
            begin
              select
                @w_fa_calificacion = '04',
                @w_aux1 = '04'
            end
          end
          else
          begin
            if(@w_fa_pais_efe_fiscal2 = @w_pais)
            begin
              if(@w_fa_num_id_fiscal2 is null)
              begin
                select
                  @w_fa_calificacion = '02',
                  @w_aux1 = '02'
              end
              else
              begin
                select
                  @w_fa_calificacion = '04',
                  @w_aux1 = '04'
              end
            end
            else
            begin
              if(@w_fa_pais_efe_fiscal3 = @w_pais)
              begin
                if(@w_fa_num_id_fiscal3 is null)
                begin
                  select
                    @w_fa_calificacion = '02',
                    @w_aux1 = '02'
                end
                else
                begin
                  select
                    @w_fa_calificacion = '04',
                    @w_aux1 = '04'
                end
              end
            end
          end
        end
        else
        begin
          if(@w_fa_pais_efe_fiscal1 = @w_pais)
          begin
            if(@w_fa_marca_doc_comp = 'V')
              select
                @w_fa_calificacion = '04'
            else
              select
                @w_fa_calificacion = '03'
          end
          else
          begin
            if(@w_fa_pais_efe_fiscal2 = @w_pais)
            begin
              if(@i_fa_marca_doc_comp = 'V')
                select
                  @w_fa_calificacion = '04'
              else
              begin
                select
                  @w_fa_calificacion = '04',
                  @w_aux = '04'
              end
            end
            else
            begin
              if(@w_fa_pais_efe_fiscal3 = @w_pais)
              begin
                if(@i_fa_marca_doc_comp = 'V')
                  select
                    @w_fa_calificacion = '04'
                else
                  select
                    @w_fa_calificacion = '03'
              end
            end
          end
        end

        if @w_fa_pregunta2 = 'SI'
            or @w_fa_pregunta3 = 'SI'
        begin
          if @w_fa_calificacion <> '03'
              or @w_fa_calificacion is null
          begin
            if(@w_fa_observaciones1 is null)
            begin
              select
                @w_fa_calificacion = '02',
                @w_aux = '02'
            end
            else
            begin
              select
                @w_catalogo = c.codigo
              from   cobis..cl_tabla t,
                     cobis..cl_catalogo c
              where  t.codigo = c.tabla
                 and c.estado = 'V'
                 and t.tabla  = 'cl_obs_celdir'
                 and c.valor  = @w_fa_observaciones1

              if exists(select
                          1
                        from   cobis..cl_tabla t,
                               cobis..cl_catalogo c
                        where  t.codigo = c.tabla
                           and c.estado = 'V'
                           and t.tabla  = 'cl_obs_celdir_val'
                           and c.codigo = @w_catalogo)
                select
                  @w_fa_calificacion = '01'
              else
              begin
                select
                  @w_fa_calificacion = '02',
                  @w_aux = '02'
              end
            end
          end
          else
          begin
            if(@w_fa_observaciones1 is null)
              select
                @w_fa_calificacion = '03'
            else
            begin
              select
                @w_catalogo = c.codigo
              from   cobis..cl_tabla t,
                     cobis..cl_catalogo c
              where  t.codigo = c.tabla
                 and c.estado = 'V'
                 and t.tabla  = 'cl_obs_celdir'
                 and c.valor  = @w_fa_observaciones1

              if exists(select
                          1
                        from   cobis..cl_tabla t,
                               cobis..cl_catalogo c
                        where  t.codigo = c.tabla
                           and c.estado = 'V'
                           and t.tabla  = 'cl_obs_celdir_val'
                           and c.codigo = @w_catalogo)
                select
                  @w_fa_calificacion = '01'
              else
                select
                  @w_fa_calificacion = '03'
            end
          end
        end

        if @w_fa_pregunta4 = 'SI'
        begin
          if @w_fa_calificacion <> '03'
              or @w_fa_calificacion is null
          begin
            if(@w_fa_observaciones2 is null)
            begin
              select
                @w_fa_calificacion = '02',
                @w_aux = '02'
            end
            else
            begin
              select
                @w_catalogo = c.codigo
              from   cobis..cl_tabla t,
                     cobis..cl_catalogo c
              where  t.codigo = c.tabla
                 and c.estado = 'V'
                 and t.tabla  = 'cl_obs_tertrans'
                 and c.valor  = @w_fa_observaciones2
              if exists(select
                          1
                        from   cobis..cl_tabla t,
                               cobis..cl_catalogo c
                        where  t.codigo = c.tabla
                           and c.estado = 'V'
                           and t.tabla  = 'cl_obs_tertrans_val'
                           and c.codigo = @w_catalogo)
                select
                  @w_fa_calificacion = '01'
              else
              begin
                select
                  @w_fa_calificacion = '02',
                  @w_aux = '02'
              end
            end
          end
          else
          begin
            if(@w_fa_observaciones2 is null)
              select
                @w_fa_calificacion = '03'
            else
            begin
              select
                @w_catalogo = c.codigo
              from   cobis..cl_tabla t,
                     cobis..cl_catalogo c
              where  t.codigo = c.tabla
                 and c.estado = 'V'
                 and t.tabla  = 'cl_obs_tertrans'
                 and c.valor  = @w_fa_observaciones2

              if exists(select
                          1
                        from   cobis..cl_tabla t,
                               cobis..cl_catalogo c
                        where  t.codigo = c.tabla
                           and c.estado = 'V'
                           and t.tabla  = 'cl_obs_tertrans_val'
                           and c.codigo = @w_catalogo)
                select
                  @w_fa_calificacion = '01'
              else
                select
                  @w_fa_calificacion = '03'
            end
          end
        end

        if @w_fa_pregunta5 = 'SI'
        begin
          if @w_fa_calificacion <> '03'
              or @w_fa_calificacion is null
          begin
            if(@w_fa_observaciones3 is null)
            begin
              select
                @w_fa_calificacion = '02',
                @w_aux = '02'
            end
            else
            begin
              select
                @w_catalogo = c.codigo
              from   cobis..cl_tabla t,
                     cobis..cl_catalogo c
              where  t.codigo = c.tabla
                 and c.estado = 'V'
                 and t.tabla  = 'cl_obs_poder'
                 and c.valor  = @w_fa_observaciones3

              if exists(select
                          1
                        from   cobis..cl_tabla t,
                               cobis..cl_catalogo c
                        where  t.codigo = c.tabla
                           and c.estado = 'V'
                           and t.tabla  = 'cl_obs_poder_val'
                           and c.codigo = @w_catalogo)
                select
                  @w_fa_calificacion = '01'
              else
              begin
                select
                  @w_fa_calificacion = '02',
                  @w_aux = '02'
              end
            end
          end
          else
          begin
            if(@w_fa_observaciones3 is null)
              select
                @w_fa_calificacion = '03'
            else
            begin
              select
                @w_catalogo = c.codigo
              from   cobis..cl_tabla t,
                     cobis..cl_catalogo c
              where  t.codigo = c.tabla
                 and c.estado = 'V'
                 and t.tabla  = 'cl_obs_poder'
                 and c.valor  = @w_fa_observaciones3

              if exists(select
                          1
                        from   cobis..cl_tabla t,
                               cobis..cl_catalogo c
                        where  t.codigo = c.tabla
                           and c.estado = 'V'
                           and t.tabla  = 'cl_obs_poder_val'
                           and c.codigo = @w_catalogo)
                select
                  @w_fa_calificacion = '01'
              else
                select
                  @w_fa_calificacion = '03'
            end
          end
        end
      end

      if @w_aux = '02'
        select
          @w_fa_calificacion = @w_aux

      if @w_aux1 = '04'
          or @w_aux1 = '02'
        select
          @w_fa_calificacion = @w_aux1

      if @w_fa_calificacion = '01'
        select
          @w_fa_pregunta15 = 'SI'
      else
        select
          @w_fa_pregunta15 = 'NO'

    end -- END SUBTIPO PERSONA NATURAL
    if @i_fa_subtipo_persona = 'C'
    begin
      -- CALIFICACION PERSONA JURIDICA
      if @w_fa_pregunta9 = 'SI'
        select
          @w_fa_calificacion = '01'

      if @w_fa_pregunta9 = 'NO'
        select
          @w_fa_calificacion = '02'

      if @w_fa_pregunta10 = 'SI'
      begin
        if @w_fa_giin_vigen is not null
          select
            @w_fa_calificacion = '03'
        else
          select
            @w_fa_calificacion = '04'
      end

      if @w_fa_pregunta10 = 'NO'
        select
          @w_fa_calificacion = '04'

      if @w_fa_pregunta11 = 'SI'
      begin
        if @w_fa_pregunta10 = 'SI'
          select
            @w_fa_calificacion = '07'
        else
          select
            @w_fa_calificacion = '08'
      end

      if @w_fa_pregunta11 = 'NO'
        select
          @w_fa_calificacion = '06'

      if @w_fa_pregunta12 = 'SI'
         and (@w_fa_nombre is null
               or @w_fa_primer_apellido is null
               or @w_fa_pais_nacimiento is null
               or @w_fa_ciudad_nacimiento is null)
        select
          @w_fa_calificacion = '09'
    end

    --Actualiza calificaci¾n
    update cobis..cl_fatca
    set    fa_calificacion = @w_fa_calificacion,
           fa_pregunta15 = @w_fa_pregunta15
    where  fa_tipo_id         = @i_fa_tipo_id
       and fa_num_id          = @i_fa_num_id
       and fa_subtipo_persona = @i_fa_subtipo_persona

    if @@error <> 0
    begin
      select
        @w_error = 145005
      goto ERROR_FIN
    end
  end

  -- VALIDACION DE CODIGOS CIIU PARA PERSONA JURIDICA
  if @i_operacion = 'X'
  begin
    if not exists(select
                    1
                  from   cobis..cl_tabla t,
                         cobis..cl_catalogo c
                  where  t.codigo = c.tabla
                     and t.tabla  = 'cl_ciiu_fatca'
                     and c.codigo = @i_fa_ciiu
                     and c.estado = 'V')
    begin
      select
        @w_error = 101259,
        @i_bandera = '1'
      select
        @w_error
      goto ERROR_FIN
    end
  end

  if @i_operacion = 'Z'
  begin
    if exists(select
                1
              from   cobis..cl_fatca
              where  fa_tipo_id         = @i_fa_tipo_id
                 and fa_num_id          = @i_fa_num_id
                 and fa_subtipo_persona = @i_fa_subtipo_persona)
    begin
      update cobis..cl_fatca
      set    fa_fec_impresion = getdate()
      where  fa_tipo_id         = @i_fa_tipo_id
         and fa_num_id          = @i_fa_num_id
         and fa_subtipo_persona = @i_fa_subtipo_persona

      if @@error <> 0
      begin
        select
          @w_error = 145005,
          @i_bandera = '1'-- NO EXISTE REGISTRO FATCA
        select
          @w_error
        goto ERROR_FIN
      end
    end
    else
    begin
      select
        @w_error = 101261,
        @i_bandera = '1'-- NO EXISTE REGISTRO FATCA
      select
        @w_error
      goto ERROR_FIN
    end
  end

  -- VALIDACION DE IMPRESION DE 
  if @i_operacion = 'Y'
  begin
    select
      @w_fa_fec_imp = fa_fec_impresion,
      @w_fa_fec_mod = fa_fec_mod
    from   cobis..cl_fatca
    where  fa_tipo_id         = @i_fa_tipo_id
       and fa_num_id          = @i_fa_num_id
       and fa_subtipo_persona = @i_fa_subtipo_persona
    if @@rowcount = 0
    begin
      select
        @w_error = 101261,
        @i_bandera = '1'-- NO EXISTE REGISTRO FATCA
      select
        @w_error
      goto ERROR_FIN
    end

    if isnull(@w_fa_fec_imp,
              '01/01/1900') <= isnull(@w_fa_fec_mod,
                                      '01/01/1900')
    begin
      select
        @w_error = 101140,
        @i_bandera = '1' -- FECHA DE IMPRESION MENOR A FECHA DE ACTUALIZACION
      select
        @w_error
      goto ERROR_FIN
    end
  end

  return 0

  ERROR_FIN:

  if @i_bandera = '0'
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_error
  end
  return @w_error

go

