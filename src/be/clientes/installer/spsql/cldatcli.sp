/************************************************************************/
/*  Archivo:          cldatcli.sp                                       */
/*  Stored procedure: sp_datos_cliente                                  */
/*  Base de datos:    cobis                                             */
/*  Producto:         Clientes                                          */
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
/*                           PROPOSITO                                  */
/*  Este Stored Procedure permite consultar datos cliente y dir         */
/*  del cliente seg£n tipo enviado                                      */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA            AUTOR          RAZON                             */
/*  16-May-08        A Correa     Emision Inicial                       */
/*  30-May-08        A Correa     Campos adicionales para microseguros  */
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
           where  id = object_id('sp_datos_cliente'))
  drop procedure sp_datos_cliente
go

create proc sp_datos_cliente
(
  @t_show_version bit = 0,
  @i_ente         int = null,
  @i_cedruc       numero = null,
  @i_tipo         varchar(10) = null,
  @i_formato_f    tinyint = 103,
  @i_frontend     char(1) = 'N',
  @i_con_ente     char(1) = 'S',
  @o_descripcion  varchar(80) = null out,
  @o_ciudad       int = null out,
  @o_parroquia    smallint = null out,
  @o_provincia    smallint = null out,
  @o_pais         smallint = null out,
  @o_telefono     varchar(16) = null out,
  @o_desciudad    varchar(40) = null out,
  @o_desparroquia varchar(40) = null out,
  @o_desprovincia varchar(40) = null out,
  @o_despais      varchar(20) = null out,
  @o_tipoced      varchar(10) = null out,
  @o_cedruc       varchar(30) = null out,
  @o_ciudadexp    int = null out,
  @o_desciuexp    varchar(60) = null out,
  @o_fecha_exp    varchar(10) = null out,
  @o_fecha_nac    varchar(10) = null out,
  @o_tipodir      varchar(20) = null out,
  @o_nombre       varchar(20) = null out,
  @o_papellido    varchar(20) = null out,
  @o_sapellido    varchar(20) = null out,
  @o_ofiprod      smallint = null out,
  @o_tel_cel      varchar(16) = null out,
  @o_inddir       char(1) = null out,
  @o_ciudadnac    int = null out,
  @o_desciunac    varchar(60) = null out,
  @o_genero       sexo = null out,
  @o_ocupacion    varchar(10) = null out,
  @o_descocupa    varchar(20) = null out,
  @o_ecivil       varchar(10) = null out,
  @o_descecivil   varchar(20) = null out,
  @o_barrio       varchar(40) = null out,
  @o_tvivienda    varchar(10) = null out,
  @o_desctviv     varchar(20) = null out,
  @o_nivelest     varchar(10) = null out,
  @o_descnest     varchar(20) = null out,
  @o_fch_neg      varchar(10) = null out,
  @o_desgenero    varchar(20) = null out,
  @o_des_tipo     varchar(20) = null out,

  --Variables de salida agregadas Req. 363
  @o_ind_ciudad   char(1) = null out,
  @o_email        varchar(80) = null out,
  @o_actividad    varchar(10) = null out
)
as
  declare
    @w_sp_name      varchar(20),
    @w_direccion    tinyint,
    @w_descripcion  varchar(80),
    @w_ciudad       int,
    @w_parroquia    smallint,
    @w_provincia    smallint,
    @w_pais         smallint,
    @w_telefono     varchar(16),
    @w_desciudad    varchar(40),
    @w_desparroquia varchar(40),
    @w_desprovincia varchar(40),
    @w_despais      varchar(20),
    @w_tipoced      varchar(10),
    @w_cedruc       varchar(30),
    @w_ciudadexp    int,
    @w_desciuexp    varchar(60),
    @w_fecha_exp    varchar(10),
    @w_fecha_nac    varchar(10),
    @w_tipodir      varchar(20),
    @w_nombre       varchar(20),
    @w_papellido    varchar(20),
    @w_sapellido    varchar(20),
    @w_ofiprod      smallint,
    @w_tel_cel      varchar(16),
    @w_ciudadnac    int,
    @w_desciunac    varchar(60),
    @w_genero       sexo,
    @w_ocupacion    varchar(10),
    @w_descocupa    varchar(20),
    @w_ecivil       varchar(10),
    @w_descecivil   varchar(20),
    @w_barrio       varchar(40),
    @w_rural_urb    char(1),
    @w_tvivienda    varchar(10),
    @w_desctviv     varchar(20),
    @w_nivelest     varchar(10),
    @w_descnest     varchar(20),
    @w_fch_neg      varchar(10),
    @w_desgenero    varchar(20),
    @w_des_tipo     varchar(20),
    --Variables agregadas 363
    @w_ind_ciudad   char(1),
    @w_email        varchar(80),
    @w_actividad    varchar(10)

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_sp_name = 'sp_datos_cliente'

  --VERSION Agosto 11/2009

  if @i_ente is null
     and @i_cedruc is null
  begin
    -- No existe el cliente indicado
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 101129,
      @i_sev  = 0,
      @i_msg  = 'Código del ente o Numero de Documento es Requerido'
    return 101129
  end

  if @i_con_ente = 'N'
  begin
    if @i_ente is null
    begin
      select
        @i_ente = en_ente
      from   cobis..cl_ente
      where  en_ced_ruc = @i_cedruc

      if @@rowcount = 0
      begin
        -- No existe el cliente indicado
        exec cobis..sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 101129
        return 101129
      end
    end
    goto DIRECCION
  end

  if @i_ente is null
    select
      @w_tipoced = en_tipo_ced,
      @w_cedruc = en_ced_ruc,
      @w_nombre = en_nombre,
      @w_papellido = p_p_apellido,
      @w_sapellido = p_s_apellido,
      @w_ciudadexp = p_lugar_doc,
      @w_desciuexp = (select
                        ci_descripcion
                      from   cobis..cl_ciudad
                      where  ci_ciudad = X.p_lugar_doc),
      @w_fecha_exp = convert(varchar(10), p_fecha_emision, @i_formato_f),
      @w_ofiprod = en_oficina_prod,
      @w_fecha_nac = convert(varchar(10), p_fecha_nac, @i_formato_f),
      @i_ente = en_ente,
      @w_ciudadnac = p_ciudad_nac,
      @w_desciunac = (select
                        ci_descripcion
                      from   cobis..cl_ciudad
                      where  ci_ciudad = X.p_ciudad_nac),
      @w_genero = p_sexo,
      @w_ocupacion = en_concordato,
      @w_descocupa = (select
                        c.valor
                      from   cobis..cl_catalogo c,
                             cobis..cl_tabla t
                      where  c.tabla  = t.codigo
                         and t.tabla  = 'cl_tipo_empleo'
                         and c.codigo = X.en_concordato),
      @w_ecivil = p_estado_civil,
      @w_descecivil = (select
                         c.valor
                       from   cobis..cl_catalogo c,
                              cobis..cl_tabla t
                       where  c.tabla  = t.codigo
                          and t.tabla  = 'cl_ecivil'
                          and c.codigo = X.p_estado_civil),
      @w_tvivienda = p_tipo_vivienda,
      @w_desctviv = (select
                       c.valor
                     from   cobis..cl_catalogo c,
                            cobis..cl_tabla t
                     where  c.tabla  = t.codigo
                        and t.tabla  = 'cl_tipo_vivienda'
                        and c.codigo = X.p_tipo_vivienda),
      @w_nivelest = p_nivel_estudio,
      @w_descnest = (select
                       c.valor
                     from   cobis..cl_catalogo c,
                            cobis..cl_tabla t
                     where  c.tabla  = t.codigo
                        and t.tabla  = 'cl_nivel_estudio'
                        and c.codigo = X.p_nivel_estudio),
      @w_fch_neg = convert(varchar(10), en_fecha_negocio, @i_formato_f),
      @w_desgenero = (select
                        c.valor
                      from   cobis..cl_catalogo c,
                             cobis..cl_tabla t
                      where  c.tabla  = t.codigo
                         and t.tabla  = 'cl_sexo'
                         and c.codigo = X.p_sexo),
      @w_des_tipo = (select
                       c.valor
                     from   cobis..cl_catalogo c,
                            cobis..cl_tabla t
                     where  c.tabla  = t.codigo
                        and t.tabla  = 'cl_tipo_documento'
                        and c.codigo = X.en_tipo_ced),
      @w_actividad = en_actividad --Agregada actividad economica Req. 363
    from   cobis..cl_ente X
    where  en_ced_ruc = @i_cedruc
  else
    select
      @w_tipoced = en_tipo_ced,
      @w_cedruc = en_ced_ruc,
      @w_nombre = en_nombre,
      @w_papellido = p_p_apellido,
      @w_sapellido = p_s_apellido,
      @w_ciudadexp = p_lugar_doc,
      @w_desciuexp = (select
                        ci_descripcion
                      from   cobis..cl_ciudad
                      where  ci_ciudad = X.p_lugar_doc),
      @w_fecha_exp = convert(varchar(10), p_fecha_emision, @i_formato_f),
      @w_ofiprod = en_oficina_prod,
      @w_fecha_nac = convert(varchar(10), p_fecha_nac, @i_formato_f),
      @w_ciudadnac = p_ciudad_nac,
      @w_desciunac = (select
                        ci_descripcion
                      from   cobis..cl_ciudad
                      where  ci_ciudad = X.p_ciudad_nac),
      @w_genero = p_sexo,
      @w_ocupacion = en_concordato,
      @w_descocupa = (select
                        c.valor
                      from   cobis..cl_catalogo c,
                             cobis..cl_tabla t
                      where  c.tabla  = t.codigo
                         and t.tabla  = 'cl_tipo_empleo'
                         and c.codigo = X.en_concordato),
      @w_ecivil = p_estado_civil,
      @w_descecivil = (select
                         c.valor
                       from   cobis..cl_catalogo c,
                              cobis..cl_tabla t
                       where  c.tabla  = t.codigo
                          and t.tabla  = 'cl_ecivil'
                          and c.codigo = X.p_estado_civil),
      @w_tvivienda = p_tipo_vivienda,
      @w_desctviv = (select
                       c.valor
                     from   cobis..cl_catalogo c,
                            cobis..cl_tabla t
                     where  c.tabla  = t.codigo
                        and t.tabla  = 'cl_tipo_vivienda'
                        and c.codigo = X.p_tipo_vivienda),
      @w_nivelest = p_nivel_estudio,
      @w_descnest = (select
                       c.valor
                     from   cobis..cl_catalogo c,
                            cobis..cl_tabla t
                     where  c.tabla  = t.codigo
                        and t.tabla  = 'cl_nivel_estudio'
                        and c.codigo = X.p_nivel_estudio),
      @w_fch_neg = convert(varchar(10), en_fecha_negocio, @i_formato_f),
      @w_desgenero = (select
                        c.valor
                      from   cobis..cl_catalogo c,
                             cobis..cl_tabla t
                      where  c.tabla  = t.codigo
                         and t.tabla  = 'cl_sexo'
                         and c.codigo = X.p_sexo),
      @w_des_tipo = (select
                       c.valor
                     from   cobis..cl_catalogo c,
                            cobis..cl_tabla t
                     where  c.tabla  = t.codigo
                        and t.tabla  = 'cl_tipo_documento'
                        and c.codigo = X.en_tipo_ced),
      @w_actividad = en_actividad --Agregada actividad economica Req. 363
    from   cobis..cl_ente X
    where  en_ente = @i_ente

  if @@rowcount = 0
  begin
    -- No existe el cliente indicado
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 101129
    return 101129
  end

  DIRECCION:
  if @i_tipo is null
  begin
    select
      @w_direccion = di_direccion,
      @w_descripcion = di_descripcion,
      @w_ciudad = di_ciudad,
      @w_parroquia = di_parroquia,
      @w_provincia = di_provincia,
      @w_desciudad = (select
                        ci_descripcion
                      from   cobis..cl_ciudad
                      where  ci_ciudad = X.di_ciudad),
      @w_desparroquia = (select
                           pq_descripcion
                         from   cobis..cl_parroquia
                         where  pq_parroquia = X.di_parroquia
                            and pq_ciudad    = X.di_ciudad),
      @w_desprovincia = (select
                           pv_descripcion
                         from   cobis..cl_provincia J
                         where  pv_provincia = X.di_provincia),
      @w_tipodir = c.valor,
      @w_rural_urb = di_rural_urb,
      @w_barrio = di_barrio
    from   cobis..cl_direccion X,
           cobis..cl_catalogo c,
           cobis..cl_tabla t
    where  t.codigo     = c.tabla
       and c.codigo     = X.di_tipo
       and t.tabla      = 'cl_tdireccion'
       and di_ente      = @i_ente
       and di_principal = 'S'
  end
  else
  begin
    select
      @w_direccion = di_direccion,
      @w_descripcion = di_descripcion,
      @w_ciudad = di_ciudad,
      @w_parroquia = di_parroquia,
      @w_provincia = di_provincia,
      @w_desciudad = (select
                        ci_descripcion
                      from   cobis..cl_ciudad
                      where  ci_ciudad = X.di_ciudad),
      @w_desparroquia = (select
                           pq_descripcion
                         from   cobis..cl_parroquia
                         where  pq_parroquia = X.di_parroquia
                            and pq_ciudad    = X.di_ciudad),
      @w_desprovincia = (select
                           pv_descripcion
                         from   cobis..cl_provincia J
                         where  pv_provincia = X.di_provincia),
      @w_tipodir = c.valor,
      @w_rural_urb = di_rural_urb,
      @w_barrio = di_barrio
    from   cobis..cl_direccion X,
           cobis..cl_catalogo c,
           cobis..cl_tabla t
    where  t.codigo = c.tabla
       and c.codigo = X.di_tipo
       and t.tabla  = 'cl_tdireccion'
       and di_ente  = @i_ente
       and di_tipo  = @i_tipo
  end

  if @@rowcount = 0
    select
      @o_inddir = 'N'
  else
    select
      @o_inddir = 'S'

  if @o_inddir = 'S'
  begin
    select
      @w_pais = pa_pais,
      @w_despais = pa_descripcion
    from   cobis..cl_pais,
           cobis..cl_provincia
    where  pv_provincia = @w_provincia
       and pa_pais      = pv_pais

    select
      @w_telefono = case te_tipo_telefono
                      when 'C' then ltrim(rtrim(te_prefijo)) + '-' + ltrim(rtrim
                                    (
                                    te_valor))
                      else te_valor
                    end,
      @w_ind_ciudad = isnull(te_prefijo,
                             '0')
    from   cobis..cl_telefono
    where  te_ente      = @i_ente
       and te_direccion = @w_direccion

    select
      @w_tel_cel = ltrim(rtrim(te_prefijo)) + '-' + ltrim(rtrim(te_valor))
    from   cobis..cl_telefono
    where  te_ente          = @i_ente
       and te_tipo_telefono = 'C'

    --Obteniendo el email 363
    select
      @w_email = di_descripcion
    from   cobis..cl_direccion
    where  di_tipo = '001'
       and di_ente = @i_ente

    if @w_rural_urb = 'U'
      select
        @w_barrio = pq_descripcion
      from   cobis..cl_parroquia
      where  pq_parroquia = @w_parroquia
  end

  if @i_frontend = 'S'
  begin
    --Datos del cliente
    select
      @w_tipoced,--1
      @w_cedruc,--2
      @w_nombre,--3
      @w_papellido,--4
      @w_sapellido,--5
      @w_ciudadexp,--6
      @w_desciuexp,--7
      @w_fecha_exp,--8
      @w_ofiprod,--9
      @w_fecha_nac,--10
      @w_ciudadnac,--11
      @w_desciunac,--12
      @w_genero,--13
      @w_ocupacion,--14
      @w_descocupa,--15
      @w_ecivil,--16
      @w_descecivil,--17
      @w_tvivienda,--18
      @w_desctviv,--19
      @w_nivelest,--20
      @w_descnest,--21
      @w_fch_neg,--22
      @w_desgenero,--23
      @w_des_tipo --22

    --Datos Direccion
    select
      @w_tipodir,--1
      @w_pais,--2
      @w_despais,--3
      @w_provincia,--4
      @w_desprovincia,--5
      @w_ciudad,--6
      @w_desciudad,--7
      @w_parroquia,--8
      @w_desparroquia,--9
      @w_descripcion,--10
      @w_telefono,--11
      @w_tel_cel,--12
      @w_barrio --13
  end
  else
  begin
    --Datos del cliente
    select
      @o_tipoced = @w_tipoced,--1
      @o_cedruc = @w_cedruc,--2
      @o_nombre = @w_nombre,--3
      @o_papellido = @w_papellido,--4
      @o_sapellido = @w_sapellido,--5
      @o_ciudadexp = @w_ciudadexp,--6
      @o_desciuexp = @w_desciuexp,--7
      @o_fecha_exp = @w_fecha_exp,--8
      @o_ofiprod = @w_ofiprod,--9
      @o_fecha_nac = @w_fecha_nac,--10
      @o_ciudadnac = @w_ciudadnac,--11
      @o_desciunac = @w_desciunac,--12
      @o_genero = @w_genero,--13
      @o_ocupacion = @w_ocupacion,--14
      @o_descocupa = @w_descocupa,--15
      @o_ecivil = @w_ecivil,--16
      @o_descecivil = @w_descecivil,--17
      @o_tvivienda = @w_tvivienda,--18
      @o_desctviv = @w_desctviv,--19
      @o_nivelest = @w_nivelest,--20
      @o_descnest = @w_descnest,--21
      @o_fch_neg = @w_fch_neg,--22
      @o_desgenero = @w_desgenero,--23
      @o_des_tipo = @w_des_tipo,--24
      @o_actividad = @w_actividad --25 Req. 363

    --Datos Direccion
    select
      @o_tipodir = @w_tipodir,--1
      @o_pais = @w_pais,--2
      @o_despais = @w_despais,--3
      @o_provincia = @w_provincia,--4
      @o_desprovincia = @w_desprovincia,--5
      @o_ciudad = @w_ciudad,--6
      @o_desciudad = @w_desciudad,--7
      @o_parroquia = @w_parroquia,--8
      @o_desparroquia = @w_desparroquia,--9
      @o_descripcion = @w_descripcion,--10
      @o_telefono = @w_telefono,--11
      @o_tel_cel = @w_tel_cel,--12
      @o_barrio = @w_barrio,--13
      @o_ind_ciudad = @w_ind_ciudad,--14 Req 363
      @o_email = @w_email --15 Req. 363

  end
  return 0

go

