/************************************************************************/
/*      Archivo:                cl_verifhom.sp                          */
/*      Stored procedure:       sp_verifhom                             */
/*      Base de datos:          COBIS                                   */
/*      Producto:               CLIENTES                                */
/*      Fecha de escritura:     02/16/2010                              */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*                             PROPOSITO                                */
/*    Este programa carga los archivos de world complice validando los  */
/*    casos en que se presente coincidencias por homonimia y documento  */
/*    y passaporte.                                                     */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*    FECHA        AUTOR               RAZON                            */
/*    22/08/2013   Oscar Saavedra      Log de Errrores                  */
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
           where  name = 'sp_verifhom')
  drop proc sp_verifhom
go

create proc sp_verifhom
(
  @t_show_version bit = 0,
  @i_param1       varchar(255) = null,--ARCHIVO
  @i_param2       varchar(255) = null,--OPERACION
  @i_param3       varchar(255) = null --PATH
)
as
  declare
    @w_sp_name       varchar(32),
    @w_return        int,
    @w_tipo_ced      char(2),
    @w_ced_ruc       char(16),
    @w_ced_r         char(16),
    @w_nombre        varchar(64),
    @w_p_apellido    varchar(16),
    @w_s_apellido    varchar(16),
    @w_descripcion   varchar(37),
    @w_akas          varchar(8000),
    @w_pasaporte     char(13),
    @w_cmd           varchar(255),
    @w_s_app         varchar(255),
    @w_destino       varchar(255),
    @w_errores       varchar(255),
    @w_comando       varchar(255),
    @w_error         int,
    @w_path          varchar(255),
    @w_contador      smallint,
    @w_path_lis      varchar(255),
    @w_entid         varchar(50),
    @w_apellido      varchar(100),
    @w_cont          int,
    @w_control       char(1),
    @w_fecha_ref     datetime,
    @w_fecha_ref1    varchar(12),
    @w_observacion   varchar(255),
    @w_subtipo       char(1),
    @w_origen        varchar(10),
    @t_debug         char(1),
    @w_nomlar        varchar(100),
    @t_file          varchar(14),
    @w_codigo        int,
    @w_documento     varchar(20),
    @w_fecha_mod     datetime,
    @w_usuario       varchar(20),
    @w_estado        varchar(104),
    @w_des_estado    varchar(10),
    @w_detalle       varchar(200),
    @i_archivo       varchar(255),
    @i_operacion     char(1),
    @i_path          varchar(255),
    @w_sexo          char(1),
    @w_entryCat      varchar(8000),
    @w_entrySubC     varchar(255),
    @w_categoria     varchar(10),
    @w_subcategoria  varchar(20),
    @w_cadena        varchar(24),
    @w_dia           char(2),
    @w_mes           char(2),
    @w_anio          char(4),
    @w_ascii         int,
    @w_entid_tmp     char(1),
    @w_ruta          varchar(100),
    @w_name          varchar(100),
    @w_concepto      varchar(100),
    @w_otro_id       varchar(20),
    @w_fuente        varchar(20),
    @w_reg           int,
    @w_arch          varchar(255),
    @w_reg_arch      int,
    @w_parlista      varchar(10),
    @w_parlistares   varchar(10),
    @w_restrictiva   varchar(10),
    @w_ente          int,
    @w1              int,
    @w_malaref       char(1),
    @w_cantidad      smallint,
    @w_xced          smallint,
    @w_xnom          smallint,
    @w_parlistanres  varchar(10),
    @w_tipo_id       char(2),
    @w_nombrelargo   varchar(64),
    @w_origen_refinh catalogo,
    @w_estado_refinh catalogo,
    @w_ssn           int,
    @w_msg           varchar(255)

  set ansi_warnings off
  select
    @i_archivo = convert (varchar(255), @i_param1)
  select
    @i_operacion = convert (char(1), @i_param2)
  select
    @i_path = convert (varchar(255), @i_param3)
  select
    @w_sp_name = 'sp_verifhom'
  select
    @w_reg = 0
  select
    @w_arch = ''
  select
    @w_reg_arch = 0
  select
    @w_restrictiva = ''

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_path_lis = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 2

  select
    @w_ruta = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  select
    @w_parlista = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'LNRES'

  if exists (select
               1
             from   sysobjects
             where  name = 'cl_val_arch')
    drop table cl_val_arch

  create table cl_val_arch
  (
    registros varchar(255)
  )

  if @i_operacion = 'W'
  begin
    /* cl_ente_procesawc.nombre*/
    if exists (select
                 name
               from   sysindexes
               where  name = 'en_nomlar')
      drop index cl_ente_procesawc.en_nomlar
    /* cl_ente_procesawc.en_ced_ruc*/
    if exists (select
                 name
               from   sysindexes
               where  name = 'en_ced_ruc')
      drop index cl_ente_procesawc.en_ced_ruc

    /*** Se cambia el borrado de indices por desabilitacion del indice *****/
    if exists (select
                 *
               from   sys.indexes
               where  object_id = object_id(N'[dbo].[cl_refinh]')
                  and name      = N'cl_refinh_Key')
  --DROP INDEX [cl_refinh_Key] ON [dbo].[cl_refinh] WITH ( ONLINE = OFF )
  alter index [cl_refinh_Key] on [dbo].[cl_refinh] disable
    if exists (select
                 *
               from   sys.indexes
               where  object_id = object_id(N'[dbo].[cl_refinh]')
                  and name      = N'idx_categoria')
  -- DROP INDEX [idx_categoria] ON [dbo].[cl_refinh] WITH ( ONLINE = OFF )
  alter index [idx_categoria] on [dbo].[cl_refinh] disable
    if exists (select
                 *
               from   sys.indexes
               where  object_id = object_id(N'[dbo].[cl_refinh]')
                  and name      = N'iin_ced_ruc')
  --DROP INDEX [iin_ced_ruc] ON [dbo].[cl_refinh] WITH ( ONLINE = OFF )
  alter index [iin_ced_ruc] on [dbo].[cl_refinh] disable
    if exists (select
                 *
               from   sys.indexes
               where  object_id = object_id(N'[dbo].[cl_refinh]')
                  and name      = N'iin_fecha_mod')
  --DROP INDEX [iin_fecha_mod] ON [dbo].[cl_refinh] WITH ( ONLINE = OFF )
  alter index [iin_fecha_mod] on [dbo].[cl_refinh] disable
    truncate table cobis..cl_wordc_tmp
    truncate table cobis..cl_ente_procesawc

    insert into cl_ente_procesawc
                (en_ente,en_ced_ruc,en_tipo_ced,en_nomlar)
      select
        en_ente,en_ced_ruc,en_tipo_ced,replace (ltrim(rtrim(en_nomlar)),
                 '  ',
                 ' ')
      from   cobis..cl_ente

    select
      @w1 = count(0)
    from   cl_ente_procesawc
    print @w1

    create index en_nomlar
      on cl_ente_procesawc ( en_nomlar)
      on indexgroup
    create index en_ced_ruc
      on cl_ente_procesawc ( en_ced_ruc)
      on indexgroup

    select
      @w_comando = 'wc -l ' + @i_path + '\' + @i_archivo + ' > ' + @w_path_lis +
                                            '\salida.out'

    exec @w_error = xp_cmdshell
      @w_comando
    if @w_error <> 0
    begin
      select
        @w_msg = '[sp_verifhom] Error validando cantidad de registros ' +
                 @w_comando
      insert into cl_error_log
                  (er_fecha_proc,er_usuario,er_descripcion)
      values      (getdate(),'op_batch',@w_msg)
      print @w_msg
      return 1
    end

    select
      @w_s_app = 's_app bcp -auto -login cobis..cl_val_arch in '
    select
      @w_destino = @i_path + @i_archivo,
      @w_errores = @w_path_lis + @i_archivo + '.err'
    select
      @w_comando =
      @w_s_app + @w_path_lis + '\' + 'salida.out' + ' -b5000 -c -e' + @w_errores
      +
      ' -t"|" ' + '-config '+
                   + @w_ruta + 's_app.ini'

    exec @w_error = xp_cmdshell
      @w_comando
    if @w_error <> 0
    begin
      select
        @w_msg = '[sp_verifhom] Error Cargando numero de registros del archivo '
                 +
                        @w_comando
      insert into cl_error_log
                  (er_fecha_proc,er_usuario,er_descripcion)
      values      (getdate(),'op_batch',@w_msg)
      print @w_msg
      return 1
    end

    select
      @w_arch = registros
    from   cobis..cl_val_arch

    select
      @w_arch
    select
      @w_reg_arch = convert(int, rtrim(ltrim(substring (ltrim(@w_arch),
                                                        1,
                                                        charindex(' ',
                                                                  ltrim(@w_arch)
                                             ))
                                       ))
                    )
    select
      @w_reg_arch = isnull(@w_reg_arch,
                           0)

    select
      @w_s_app = 's_app bcp -auto -login cobis..cl_wordc_tmp in '
    select
      @w_destino = @i_path + @i_archivo,
      @w_errores = @w_path_lis + @i_archivo + '.err'
    select
      @w_comando = @w_s_app + @i_path + '\' + @i_archivo + ' -b5000 -c -e' +
                   @w_errores + ' -t"|" '
                   + '-config '+ + @w_ruta
                   + 's_app.ini'

    exec @w_error = xp_cmdshell
      @w_comando
    if @w_error <> 0
    begin
      select
        @w_msg = '[sp_verifhom] Error Cargando archivo: ' + @i_archivo
      insert into cl_error_log
                  (er_fecha_proc,er_usuario,er_descripcion)
      values      (getdate(),'op_batch',@w_msg)
      print @w_msg
      return 1
    end

    select
      @w_reg = count(1)
    from   cobis..cl_wordc_tmp

    select
      @w_entid = ''
    select
      @w_observacion = 'CARGUE WORLD COMPLIANCE'
    select
      @w_contador = 0
    select
      @w_usuario = 'sarlaft'
    select
      @w_origen = '000'

    if @w_reg <> @w_reg_arch
    begin
      select
        @w_msg =
      '[sp_verifhom] NO SE CARGO EL ARCHIVO CORRECTAMENTE, POR FAVOR VALIDAR'
      insert into cl_error_log
                  (er_fecha_proc,er_usuario,er_descripcion)
      values      (getdate(),'op_batch',@w_msg)
      print @w_msg
      return 1
    end

    if @w_reg = 0
    begin
      select
        @w_msg =
      '[sp_verifhom] NO SE CARGO EL ARCHIVO CORRECTAMENTE, POR FAVOR VALIDAR'
      insert into cl_error_log
                  (er_fecha_proc,er_usuario,er_descripcion)
      values      (getdate(),'op_batch',@w_msg)
      print @w_msg
      return 1
    end

    update cl_wordc_tmp
    set    name = stuff(name,
                        charindex('Ý',
                                  name),
                        1,
                        'ñ')
    where  (charindex('Ý',
                      name)) > 0

    update cl_wordc_tmp
    set    first_name = stuff(first_name,
                              charindex('Ý',
                                        first_name),
                              1,
                              'ñ')
    where  (charindex('Ý',
                      first_name)) > 0

    update cl_wordc_tmp
    set    LastName = stuff(LastName,
                            charindex('Ý',
                                      LastName),
                            1,
                            'ñ')
    where  (charindex('Ý',
                      LastName)) > 0

    while 1 = 1
    begin
      set rowcount 1

      select
        @w_categoria = '000',
        @w_subcategoria = '000',
        @w_ced_ruc = '',
        @w_ced_r = '',
        @w_pasaporte = '',
        @w_nombre = '',
        @w_apellido = '',
        @w_p_apellido = '',
        @w_s_apellido = '',
        @w_akas = '',
        @w_nomlar = '',
        @w_name = '',
        @w_estado = '',
        @w_detalle = '',
        @w_entryCat = '',
        @w_entrySubC = '',
        @w_fecha_ref1 = '',
        @w_fuente = '',
        @w_concepto = '',
        @w_otro_id = '',
        @w_subtipo = null,
        @w_observacion = 'CARGUE WORLD COMPLIANCE'

      select
        @w_entid = Ent_ID,
        @w_ced_ruc = case
                       when isnull((charindex('"',
                                              substring(NationalID,
                                                        (charindex ('"',
                                                         NationalID)
                                                         +
                                                         1
                                    ),
                                                        isnull(len(NationalID),
                                                               0))) - 1),
                                   0) = 0 then upper(NationalID)
                       when isnull((charindex('"',
                                              substring(NationalID,
                                                        (charindex ('"',
                                                         NationalID)
                                                         +
                                                         1
                                    ),
                                                        isnull(len(NationalID),
                                                               0))) - 1),
                                   0) < 0 then upper(replace(NationalID,
                                                             '.',
                                                             ''))
                       else convert(varchar(13), isnull (
                            replace ((convert(varchar
                                      (
                                      13)
                                      ,
                            substring (
                            substring(NationalID,
                                    (charindex ('"',
                                     NationalID) + 1),
                                    len(NationalID)),
                            1,
                            charindex ('"',
                            substring(NationalID,
                                      (charindex ('"'
                                       ,
                                       NationalID ) +
                                       1),
                                      len(NationalID)
                              )
                              ) - 1))),
                                     '.',
                                     ''),
                            ''))
                     end,
        @w_pasaporte = case
                         when isnull((charindex('"',
                                                substring(PassportID,
                                                          (charindex ('"',
                                                           PassportID)
                                                           +
                                                           1),
                                                          isnull(len(PassportID)
                                      ,
                                                                 0))) - 1),
                                     0) = 0 then upper(PassportID)
                         when isnull((charindex('"',
                                                substring(PassportID,
                                                          (charindex ('"',
                                                           PassportID)
                                                           +
                                                           1),
                                                          isnull(len(PassportID)
                                      ,
                                                                 0))) - 1),
                                     0) < 0 then upper(replace(PassportID,
                                                               '.',
                                                               ''))
                         else substring (substring(PassportID,
                                                   (charindex ('"', PassportID)
                                                    +
                                                    1)
                                         ,
                                                   len(PassportID)),
                                         1,
                                         charindex('"',
                                                   substring(PassportID,
                                                             (charindex ('"',
                                                              PassportID
                                                              ) + 1),
                                                             len(first_name)))
                                         - 1
                              )
                       end,
        @w_nombre = case
                      when isnull((charindex('"',
                                             substring(first_name,
                                                       (charindex ('"',
                                                        first_name
                                                        )
                                                        +
                                                        1
                                   ),
                                                       isnull(len(first_name),
                                                              0))) - 1),
                                  0) = 0 then upper(first_name)
                      when isnull((charindex('"',
                                             substring(first_name,
                                                       (charindex ('"',
                                                        first_name
                                                        )
                                                        +
                                                        1
                                   ),
                                                       isnull(len(first_name),
                                                              0))) - 1),
                                  0) < 0 then upper(replace(first_name,
                                                            '-',
                                                            ''))
                      else upper (substring (substring(first_name,
                                                       (charindex ('"',
                                                        first_name
                                                        )
                                                        +
                                                        1
                                             ),
                                                       len(first_name)),
                                             1,
                                             charindex('"',
                                                       substring(first_name,
                                                                 (charindex ('"'
                                                                  ,
                                                                  first_name) +
                                                                  1)
                                  ,
                                                                 len(first_name)
                                  ))
                                             - 1
                                  ))
                    end,
        @w_apellido = case
                        when isnull((charindex('"',
                                               substring(LastName,
                                                         (charindex ('"',
                                                          LastName
                                                          )
                                                          +
                                                          1
                                     ),
                                                         isnull(len(LastName),
                                                                0))) - 1),
                                    0) = 0 then upper(LastName)
                        when isnull((charindex('"',
                                               substring(LastName,
                                                         (charindex ('"',
                                                          LastName
                                                          )
                                                          +
                                                          1
                                     ),
                                                         isnull(len(LastName),
                                                                0))) - 1),
                                    0) < 0 then upper(replace(LastName,
                                                              '-',
                                                              ''))
                        else upper (substring (substring(LastName,
                                                         (charindex ('"',
                                                          LastName
                                                          )
                                                          +
                                                          1
                                               ),
                                                         len(LastName)),
                                               1,
                                               charindex('"',
                                                         substring(LastName,
                                                                   (charindex (
                                                                    '"',
                                                                    LastName) +
                                                                    1)
                                    ,
                                                                   len(LastName)
                                    ))
                                               - 1
                                    ))
                      end,
        @w_akas = case
                    when isnull((charindex('"',
                                           substring(aka,
                                                     (charindex ('"', aka) + 1),
                                                     isnull(len(aka),
                                                            0))) - 1),
                                0) = 0 then upper(aka)
                    when isnull((charindex('"',
                                           substring(aka,
                                                     (charindex ('"', aka) + 1),
                                                     isnull(len(aka),
                                                            0))) - 1),
                                0) < 0 then upper(replace (aka,
                                                           '.',
                                                           ''))
                    else upper (substring (substring(aka,
                                                     (charindex ('"', aka) + 1),
                                                     len(aka)),
                                           1,
                                           charindex('"',
                                                     substring(aka,
                                                               (charindex ('"',
                                                                aka)
                                                                +
                                                                1
                                ),
                                                               len(aka))) - 1))
                  end,
        @w_nomlar = isnull(@w_apellido, '') + ' ' + isnull(@w_nombre, ''),
        @w_name = upper(name),
        @w_estado = case
                      when isnull((charindex('"',
                                             substring(origen_nombre,
                                                       (charindex ('"',
                                                        origen_nombre)
                                                        +
                                                        1),
                                                       isnull(len(origen_nombre)
                                   ,
                                                              0))) - 1),
                                  0) = 0 then upper(origen_nombre)
                      when isnull((charindex('"',
                                             substring(origen_nombre,
                                                       (charindex ('"',
                                                        origen_nombre)
                                                        +
                                                        1),
                                                       isnull(len(origen_nombre)
                                   ,
                                                              0))) - 1),
                                  0) < 0 then upper(replace(origen_nombre,
                                                            '-',
                                                            ''))
                      else upper (substring (substring(origen_nombre,
                                                       (charindex ('"',
                                                        origen_nombre)
                                                        +
                                                        1),
                                                       len(origen_nombre)),
                                             1,
                                             charindex('"',
                                                       substring(origen_nombre,
                                                                 (charindex ('"'
                                                                  ,
                                                                  origen_nombre)
                                                                  +
                                                                  1
                                  ),
                                                                 len(
                                                       origen_nombre
                                  ))
                                  )
                                             - 1))
                    end,
        @w_detalle = convert(varchar(200), remarks),
        @w_entryCat = case
                        when charindex('"',
                                       entryCategory) > 0 then
                        substring(entryCategory,
                                  charindex('"', entryCategory)
                        + 1,
                                  len(entryCategory) - 2)
                        else entryCategory
                      end,
        @w_entrySubC = case
                         when charindex('"',
                                        entrySubCategory) > 0 then
                         substring(entrySubCategory,
                                   charindex('"', entrySubCategory) + 1,
                                   len(entrySubCategory) - 2)
                         else entrySubCategory
                       end,
        @w_fecha_ref1 = convert(varchar(10), substring (TouchDate,
                                                        1,
                                                        charindex(' ',
                                                                  TouchDate)),
                        101
                        ),
        @w_fuente = origen_nombre,
        @w_concepto = substring (remarks,
                                 1,
                                 100),
        @w_otro_id = substring (OtherID,
                                1,
                                20)
      from   cobis..cl_wordc_tmp
      where  Ent_ID > @w_entid
      order  by Ent_ID

      if @@rowcount = 0
        break

      select
        @w_detalle = upper(@w_detalle)
      select
        @w_nomlar = replace(ltrim(rtrim(@w_nomlar)),
                            '  ',
                            ' ')

      select
        @w_entid_tmp = substring(@w_entid,
                                 1,
                                 1)

      select
        @w_ascii = ascii(@w_entid_tmp)

      if (@w_ascii < 48)
          or (@w_ascii > 57)
      begin
        select
          @w_msg =
'[sp_verifhom] EL DOCUMENTO DE IDENTIDAD CONTIENE VALORES NO NUMERICOS '
+
@w_entid
insert into cl_error_log
          (er_fecha_proc,er_usuario,er_descripcion)
values      (getdate(),'op_batch',@w_msg)
goto SIGUIENTE
end

set rowcount 0

select
@w_anio = substring (@w_fecha_ref1,
                   1,
                   charindex('-',
                             @w_fecha_ref1) - 1)
select
@w_cadena = substring (@w_fecha_ref1,
                     charindex('-', @w_fecha_ref1) + 1,
                     len(@w_fecha_ref1))
select
@w_mes = substring (@w_cadena,
                  1,
                  charindex('-',
                            @w_cadena) - 1)
select
@w_dia = substring (@w_cadena,
                  charindex('-', @w_cadena) + 1,
                  len(@w_cadena))

if len(@w_dia) = 1
select
@w_dia = case
           when convert(int, @w_dia) < 10 then '0' + @w_dia
           else @w_dia
         end
if len(@w_mes) = 1
select
@w_mes = case
           when convert(int, @w_mes) < 10 then '0' + @w_mes
           else @w_mes
         end

select
@w_fecha_ref = @w_mes + '/' + @w_dia + '/' + @w_anio

select
@w_p_apellido = case
                when charindex(' ',
                               @w_apellido) > 0 then ltrim(rtrim(
                substring(@w_apellido,
                          1,
                          charindex(' ',
                          @w_apellido))))
                else @w_apellido
              end
select
@w_s_apellido = case
                when charindex(' ',
                               @w_apellido) > 0 then ltrim(rtrim(
                substring(@w_apellido,
                          charindex(' ',
                @w_apellido) + 1,
                          len(@w_apellido))))
                else null
              end
select
@w_fecha_mod = convert(varchar(10), getdate(), 101)
select
@w_entryCat = upper(@w_entryCat)
select
@w_entrySubC = upper(@w_entrySubC)
select
@w_nombre = isnull(@w_nombre,
                 isnull(@w_name,
                        ''))

if exists (select
         1
       from   cobis..cl_refinh,
              cobis..cl_autoriza_sarlaft_lista
       where  as_sec_refinh = in_codigo
          and in_entid      = convert(int, rtrim(ltrim(@w_entid))))
begin
delete cobis..cl_autoriza_sarlaft_lista
from   cobis..cl_refinh
where  as_sec_refinh = in_codigo
 and in_entid      = convert(int, rtrim(ltrim(@w_entid)))
end

if exists (select
         1
       from   cobis..cl_refinh
       where  in_entid = convert(int, rtrim(ltrim(@w_entid))))
begin
delete cobis..cl_refinh
where  in_entid = convert(int, rtrim(ltrim(@w_entid)))
end

select
@w_categoria = C.codigo
from   cobis..cl_tabla T,
   cobis..cl_catalogo C
where  T.tabla  = 'cl_refinh_sarlaft'
and T.codigo = C.tabla
and C.valor  = @w_entryCat

select
@w_subcategoria = C.codigo
from   cobis..cl_tabla T,
   cobis..cl_catalogo C,
   cobis..cl_manejo_sarlaft
where  T.tabla   = 'cl_estado_refinh_sarlaft'
and T.codigo  = C.tabla
and C.valor   = @w_entrySubC
and ms_origen = @w_categoria
and ms_estado = C.codigo

if @@rowcount = 0
select
@w_subcategoria = '000'

if exists (select
         1
       from   cobis..cl_refinh --valida existencia en tabla refinh
       where  in_entid = convert(int, rtrim(ltrim(@w_entid))))
begin
if @w_p_apellido is null
  or @w_p_apellido = ''
begin
select
  @w_subtipo = 'C'
select
  @w_tipo_ced = 'N'
end

if @w_subtipo is null
  or @w_subtipo = ''
begin
select
  @w_subtipo = 'P'
select
  @w_tipo_ced = 'CC'
end

if @w_p_apellido = ''
select
  @w_p_apellido = null

if @w_s_apellido = ''
select
  @w_s_apellido = null

select
@w_des_estado = valor
from   cobis..cl_catalogo
where  tabla  = (select
                 codigo
               from   cobis..cl_tabla
               where  tabla = 'cl_equiv_refinh_sarlaft')
 and codigo = @w_estado
 and estado = 'V'

select
@w_cont = count(1)
from   cl_ente_procesawc
where  en_nomlar = isnull(@w_nomlar,
                        'SIN NOMBRE')

select
@w_ced_r = en_ced_ruc
from   cl_ente_procesawc
where  en_nomlar = isnull(@w_nomlar,
                        'SIN NOMBRE')

select
@w_akas = convert(varchar(120), @w_akas)

select
@w_cont = isnull(@w_cont, 0) + count(1)
from   cl_ente_procesawc
where  en_nomlar = isnull(@w_akas,
                        'SIN AKAS')

if @w_cont > 0
begin
select
  @w_observacion = 'NOMBRE HOMONIMO ID: ' + cast(@w_ced_r as varchar)
select
  @w_observacion = @w_observacion + ' - ' + isnull(@w_detalle, '')
end

select
@w_cont = 0

select
@w_cont = count(1)
from   cl_ente_procesawc
where  en_ced_ruc = isnull(@w_ced_ruc,
                         'SIN IDENTIFICACION')

if @w_cont > 0
begin
select
  @w_control = 'S'
select
  @w_contador = @w_contador + 1
select
  @w_observacion = 'NUMERO IDENTIFICACION'
select
  @w_observacion = @w_observacion + ' - ' + isnull(@w_detalle, '')
end

if @w_p_apellido is null
  or @w_p_apellido = ''
begin
select
  @w_subtipo = 'C'
select
  @w_tipo_ced = 'N'
end

if @w_subtipo is null
  or @w_subtipo = ''
begin
select
  @w_tipo_ced = 'CC'
select
  @w_subtipo = 'P'
end

if @w_p_apellido = ''
select
  @w_p_apellido = null

if @w_s_apellido = ''
select
  @w_s_apellido = null

select
@w_nombre = ltrim(rtrim(@w_nombre))
select
@w_p_apellido = ltrim(rtrim(@w_p_apellido))
select
@w_s_apellido = ltrim(rtrim(@w_s_apellido))

if @w_s_apellido is null
  or @w_s_apellido = ' '
begin
select
  @w_nomlar = isnull(@w_p_apellido, '') + ' ' + isnull(@w_nombre, '')
end
if @w_s_apellido is not null
  or @w_s_apellido <> ' '
begin
select
  @w_nomlar = isnull(@w_p_apellido, '') + ' ' + isnull(@w_s_apellido, ''
              )
              +
              ' '
              +
                     isnull(
                     @w_nombre, '')
end

select
@w_nomlar = replace(ltrim(rtrim(@w_nomlar)),
                    '  ',
                    ' ')

update cobis..cl_refinh
set    in_ced_ruc = @w_ced_ruc,
     in_nombre = @w_nombre,
     in_fecha_ref = @w_fecha_ref,
     in_origen = @w_categoria,
     in_fecha_mod = @w_fecha_mod,
     in_subtipo = @w_subtipo,
     in_p_p_apellido = @w_p_apellido,
     in_p_s_apellido = @w_s_apellido,
     in_tipo_ced = @w_tipo_ced,
     in_nomlar = @w_nomlar,
     in_estado = @w_subcategoria,
     in_sexo = @w_sexo,
     in_usuario = @w_usuario,
     in_aka = @w_akas,
     in_fuente = @w_usuario,
     in_pasaporte = @w_pasaporte
where  in_entid = @w_entid

if @@error <> 0
begin
select
  @w_msg = '[sp_verifhom] Error actualizar cl_refinh CC. ENTE '
           + convert(varchar(15), @w_ced_ruc)
insert into cl_error_log
            (er_fecha_proc,er_usuario,er_descripcion)
values      (getdate(),'op_batch',@w_msg)
print @w_msg
goto SIGUIENTE
end

select
@w_codigo = in_codigo,
@w_ced_ruc = in_ced_ruc,
@w_p_apellido = in_p_p_apellido,
@w_s_apellido = in_p_s_apellido,
@w_nombre = in_nombre
from   cobis..cl_refinh
where  in_entid = @w_entid

update cobis..cl_autoriza_sarlaft_lista
set    as_tipo_id = @w_documento,
     as_nro_id = @w_ced_ruc,
     as_nombrelargo = @w_nomlar,
     as_origen_refinh = @w_categoria,
     as_estado_refinh = @w_subcategoria,
     as_fecha_refinh = @w_fecha_mod
where  as_sec_refinh = @w_codigo

if @@error <> 0
begin
select
  @w_msg =
'[sp_verifhom] Error actualizar cl_autoriza_sarlaft_lista CC. ENTE '
+ convert(varchar(15), @w_ced_ruc)
insert into cl_error_log
            (er_fecha_proc,er_usuario,er_descripcion)
values      (getdate(),'op_batch',@w_msg)
print @w_msg
goto SIGUIENTE
end

end
else
begin
/**** VALIDA NUMERO DE DOCUMENTO ****/
select
@w_cont = 0

select
@w_cont = count(1)
from   cl_ente_procesawc
where  en_ced_ruc = isnull(@w_ced_ruc,
                         'SIN IDENTIFICACION')

if @w_cont > 0
begin
select
  @w_control = 'S'
select
  @w_contador = @w_contador + 1
select
  @w_observacion = 'NUMERO IDENTIFICACION'
select
  @w_observacion = @w_observacion + ' - ' + isnull(@w_detalle, '')
end

if @w_p_apellido is null
  or @w_p_apellido = ''
begin
select
  @w_subtipo = 'C'
select
  @w_tipo_ced = 'N'
end

if @w_subtipo is null
  or @w_subtipo = ''
begin
select
  @w_subtipo = 'P'
select
  @w_tipo_ced = 'CC'
end

if @w_p_apellido = ''
select
  @w_p_apellido = null

if @w_s_apellido = ''
select
  @w_s_apellido = null

select
@w_des_estado = valor
from   cobis..cl_catalogo
where  tabla  = (select
                 codigo
               from   cobis..cl_tabla
               where  tabla = 'cl_equiv_refinh_sarlaft')
 and codigo = @w_estado
 and estado = 'V'

if @w_cont > 0
begin
begin tran

exec @w_return = sp_cseqnos
  @t_debug     = @t_debug,
  @t_file      = @t_file,
  @t_from      = @w_sp_name,
  @i_tabla     = 'cl_refinh',
  @o_siguiente = @w_codigo out

select
  @w_nombre = ltrim(rtrim(@w_nombre))
select
  @w_p_apellido = ltrim(rtrim(@w_p_apellido))
select
  @w_s_apellido = ltrim(rtrim(@w_s_apellido))

if @w_s_apellido is null
    or @w_s_apellido = ' '
begin
  select
    @w_nomlar = isnull(@w_p_apellido, '') + ' ' + isnull(@w_nombre, '')
end
if @w_s_apellido is not null
    or @w_s_apellido <> ' '
begin
  select
    @w_nomlar = isnull(@w_p_apellido, '') + ' ' + isnull(@w_s_apellido,
                ''
                )
                +
                ' '
                +
                       isnull(
                       @w_nombre, '')
end

select
  @w_nomlar = replace(ltrim(rtrim(@w_nomlar)),
                      '  ',
                      ' ')

insert into cobis..cl_refinh
            (in_codigo,in_documento,in_ced_ruc,in_nombre,in_fecha_ref,
             in_origen,in_observacion,in_fecha_mod,in_subtipo,
             in_p_p_apellido,
             in_p_s_apellido,in_tipo_ced,in_nomlar,in_estado,in_sexo,
             in_usuario,in_aka,in_categoria,in_subcategoria,in_fuente,
             in_otroid,in_pasaporte,in_concepto,in_entid)
values      (@w_codigo,99,@w_ced_ruc,@w_nombre,@w_fecha_ref,
             @w_categoria,@w_observacion,@w_fecha_mod,@w_subtipo,
             @w_p_apellido
             ,
             @w_s_apellido,@w_tipo_ced,@w_nomlar,
             @w_subcategoria,@w_sexo,
             @w_usuario,@w_akas,@w_ced_r,null,@w_fuente,
             @w_otro_id,@w_pasaporte,@w_concepto,@w_entid )

if @@error <> 0
begin
  rollback tran
  select
    @w_msg = '[sp_verifhom] Error insert cl_refinh CC UNO. ENTE '
             + convert(varchar(15), @w_ced_ruc)
  insert into cl_error_log
              (er_fecha_proc,er_usuario,er_descripcion)
  values      (getdate(),'op_batch',@w_msg)
  print @w_msg
  goto SIGUIENTE
end

select
  @w_restrictiva = ''
select
  @w_parlista = ''
select
  @w_restrictiva = ms_restrictiva
from   cobis..cl_manejo_sarlaft
where  ms_origen = @w_categoria
   and ms_estado = @w_subcategoria

select
  @w_parlista = pa_char
from   cobis..cl_parametro
where  pa_producto = 'MIS'
   and pa_nemonico = 'LNRES'

if @w_restrictiva = @w_parlista
begin
  insert into cobis..cl_autoriza_sarlaft_lista
              (as_sec_refinh,as_tipo_id,as_nro_id,as_nombrelargo,
               as_origen_refinh,
               as_estado_refinh,as_fecha_refinh,as_aut_sarlaft,
               as_obs_sarlaft,
               as_usr_sarlaft,
               as_fecha_sarlaft,as_aut_cial,as_obs_cial,as_usr_cial,
               as_fecha_cial,
               as_valida_total,as_oficina)
  values      ( @w_codigo,@w_tipo_ced,@w_ced_ruc,@w_nomlar,@w_categoria,
                @w_subcategoria,@w_fecha_mod,null,null,null,
                null,null,null,null,null,
                null,null )
  if @@error <> 0
  begin
    rollback tran
    select
      @w_msg =
    '[sp_verifhom] Error actualizar cl_autoriza_sarlaft_lista CC. ENTE '
    + convert(varchar(15), @w_ced_ruc)
    insert into cl_error_log
                (er_fecha_proc,er_usuario,er_descripcion)
    values      (getdate(),'op_batch',@w_msg)
    print @w_msg
    goto SIGUIENTE
  end
end --restrictiva
commit tran
end

if @w_cont > 0
begin
begin tran

update cobis..cl_ente
set    en_mala_referencia = 'S',
       en_cont_malas = isnull(en_cont_malas, 0) + 1,
       en_comentario = 'WC cruce por identificacion'
where  en_ced_ruc = @w_ced_ruc

if @@error <> 0
begin
  rollback tran
  select
    @w_msg =
  '[sp_verifhom] ERROR EN ACTUALIZACION DE MALA REFERENCIA. ENTE '
  + convert(varchar(15), @w_ced_ruc)
  insert into cl_error_log
              (er_fecha_proc,er_usuario,er_descripcion)
  values      (getdate(),'op_batch',@w_msg)
  print @w_msg
  goto SIGUIENTE
end

commit tran

end

------  ------------------------------------------------------------------------------------------
/****   VALIDA NUMERO DE DOCUMENTO EN EL CAMPO OtrosID****/

select
@w_cont = 0

select
@w_cont = count(1)
from   cl_ente_procesawc
where  en_ced_ruc = isnull(@w_otro_id,
                         'SIN IDENTIFICACION')

if @w_cont > 0
begin
select
  @w_control = 'S'
select
  @w_contador = @w_contador + 1
select
  @w_observacion = 'NUMERO IDENTIFICACION OTHER_ID'
select
  @w_observacion = @w_observacion + ' - ' + isnull(@w_detalle, '')
end

if @w_p_apellido is null
  or @w_p_apellido = ''
begin
select
  @w_subtipo = 'C'
select
  @w_tipo_ced = 'N'
end

if @w_subtipo is null
  or @w_subtipo = ''
begin
select
  @w_subtipo = 'P'
select
  @w_tipo_ced = 'CC'
end

if @w_p_apellido = ''
select
  @w_p_apellido = null

if @w_s_apellido = ''
select
  @w_s_apellido = null

select
@w_des_estado = valor
from   cobis..cl_catalogo
where  tabla  = (select
                 codigo
               from   cobis..cl_tabla
               where  tabla = 'cl_equiv_refinh_sarlaft')
 and codigo = @w_estado
 and estado = 'V'

if @w_cont > 0
begin
begin tran

exec @w_return = sp_cseqnos
  @t_debug     = @t_debug,
  @t_file      = @t_file,
  @t_from      = @w_sp_name,
  @i_tabla     = 'cl_refinh',
  @o_siguiente = @w_codigo out

select
  @w_nombre = ltrim(rtrim(@w_nombre))
select
  @w_p_apellido = ltrim(rtrim(@w_p_apellido))
select
  @w_s_apellido = ltrim(rtrim(@w_s_apellido))

if @w_s_apellido is null
    or @w_s_apellido = ' '
begin
  select
    @w_nomlar = isnull(@w_p_apellido, '') + ' ' + isnull(@w_nombre, '')
end
if @w_s_apellido is not null
    or @w_s_apellido <> ' '
begin
  select
    @w_nomlar = isnull(@w_p_apellido, '') + ' ' + isnull(@w_s_apellido,
                ''
                )
                +
                ' '
                +
                       isnull(
                       @w_nombre, '')
end

select
  @w_nomlar = replace(ltrim(rtrim(@w_nomlar)),
                      '  ',
                      ' ')

insert into cobis..cl_refinh
            (in_codigo,in_documento,in_ced_ruc,in_nombre,in_fecha_ref,
             in_origen,in_observacion,in_fecha_mod,in_subtipo,
             in_p_p_apellido,
             in_p_s_apellido,in_tipo_ced,in_nomlar,in_estado,in_sexo,
             in_usuario,in_aka,in_categoria,in_subcategoria,in_fuente,
             in_otroid,in_pasaporte,in_concepto,in_entid)
values      (@w_codigo,99,@w_ced_ruc,@w_nombre,@w_fecha_ref,
             @w_categoria,@w_observacion,@w_fecha_mod,@w_subtipo,
             @w_p_apellido
             ,
             @w_s_apellido,@w_tipo_ced,@w_nomlar,
             @w_subcategoria,@w_sexo,
             @w_usuario,@w_akas,@w_ced_r,null,@w_fuente,
             @w_otro_id,@w_pasaporte,@w_concepto,@w_entid )

if @@error <> 0
begin
  rollback tran
  select
    @w_msg = '[sp_verifhom] Error insert cl_refinh OTHER ID UNO. ENTE '
             + convert(varchar(15), @w_ced_ruc)
  insert into cl_error_log
              (er_fecha_proc,er_usuario,er_descripcion)
  values      (getdate(),'op_batch',@w_msg)
  print @w_msg
  goto SIGUIENTE
end

select
  @w_restrictiva = ''
select
  @w_parlista = ''
select
  @w_restrictiva = ms_restrictiva
from   cobis..cl_manejo_sarlaft
where  ms_origen = @w_categoria
   and ms_estado = @w_subcategoria

select
  @w_parlista = pa_char
from   cobis..cl_parametro
where  pa_producto = 'MIS'
   and pa_nemonico = 'LNRES'

if @w_restrictiva = @w_parlista
begin
  insert into cobis..cl_autoriza_sarlaft_lista
              (as_sec_refinh,as_tipo_id,as_nro_id,as_nombrelargo,
               as_origen_refinh,
               as_estado_refinh,as_fecha_refinh,as_aut_sarlaft,
               as_obs_sarlaft,
               as_usr_sarlaft,
               as_fecha_sarlaft,as_aut_cial,as_obs_cial,as_usr_cial,
               as_fecha_cial,
               as_valida_total,as_oficina)
  values      ( @w_codigo,@w_tipo_ced,@w_otro_id,@w_nomlar,@w_categoria,
                @w_subcategoria,@w_fecha_mod,null,null,null,
                null,null,null,null,null,
                null,null )
  if @@error <> 0
  begin
    rollback tran
    select
      @w_msg =
'[sp_verifhom] Error insert cl_autoriza_sarlaft_lista other_id. ENTE '
+ convert(varchar(15), @w_ced_ruc)
insert into cl_error_log
      (er_fecha_proc,er_usuario,er_descripcion)
values      (getdate(),'op_batch',@w_msg)
print @w_msg
goto SIGUIENTE
  end
end --restrictiva
commit tran
end

if @w_cont > 0
begin
begin tran

update cobis..cl_ente
set    en_mala_referencia = 'S',
       en_cont_malas = isnull(en_cont_malas, 0) + 1,
       en_comentario = 'WC cruce por identificacion OtherID'
where  en_ced_ruc = @w_otro_id

if @@error <> 0
begin
  rollback tran
  select
    @w_msg =
'[sp_verifhom] ERROR EN ACTUALIZACION DE MALA REFERENCIA other id. ENTE '
     + convert(varchar(15), @w_ced_ruc)
insert into cl_error_log
      (er_fecha_proc,er_usuario,er_descripcion)
values      (getdate(),'op_batch',@w_msg)
print @w_msg
goto SIGUIENTE
end

commit tran

end

------  -------------------------------------------------------------------------------------------

select
@w_observacion = 'CARGUE WORLD COMPLIANCE'

/**** VALIDA NOMBRES HOMONIMOS ****/

select
@w_cont = 0

select
@w_cont = count(1)
from   cl_ente_procesawc
where  en_nomlar = isnull(@w_nomlar,
                        'SIN NOMBRE')
  or en_nomlar = isnull(@w_nombre,
                        'SIN NOMBRE')

select
en_nomlar,
en_ced_ruc
into   #nom_homonimo
from   cl_ente_procesawc
where  en_nomlar = isnull(@w_nomlar,
                        'SIN NOMBRE')
  or en_nomlar = isnull(@w_nombre,
                        'SIN NOMBRE')

select
@w_ced_r = en_ced_ruc
from   cl_ente_procesawc
where  en_nomlar = isnull(@w_nomlar,
                        'SIN NOMBRE')
  or en_nomlar = isnull(@w_nombre,
                        'SIN NOMBRE')

select
@w_cont = isnull(@w_cont, 0) + count(1)
from   cl_ente_procesawc
where  en_nomlar = isnull(@w_akas,
                        'SIN AKAS')

if @w_p_apellido is null
  or @w_p_apellido = ''
begin
select
  @w_subtipo = 'C'
select
  @w_tipo_ced = 'N'
end

if @w_subtipo is null
  or @w_subtipo = ''
begin
select
  @w_tipo_ced = 'CC'
select
  @w_subtipo = 'P'
end

if @w_p_apellido = ''
select
  @w_p_apellido = null

if @w_s_apellido = ''
select
  @w_s_apellido = null

select
@w_des_estado = valor
from   cobis..cl_catalogo
where  tabla  = (select
                 codigo
               from   cobis..cl_tabla
               where  tabla = 'cl_equiv_refinh_sarlaft')
 and codigo = @w_estado
 and estado = 'V'

if @w_cont > 0
begin
select
  @w_control = 'S'
select
  @w_contador = @w_contador + 1
end

if @w_cont > 0
begin
while 1 = 1
begin
  begin tran

  select
    @w_ced_r = ''

  exec @w_return = sp_cseqnos
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_tabla     = 'cl_refinh',
    @o_siguiente = @w_codigo out

  if @w_return <> 0
  begin
    --insert into log (mensaje) values ('Error seqnos')
    return @w_return
  end

  set rowcount 1

  select
    @w_ced_r = en_ced_ruc
  from   #nom_homonimo

  if @@rowcount = 0
    break

  delete #nom_homonimo
  where  en_ced_ruc = @w_ced_r

  set rowcount 0

  select
    @w_observacion = 'NOMBRE HOMONIMO ID: ' + cast(@w_ced_r as varchar)
  select
    @w_observacion = @w_observacion + ' - ' + isnull(@w_detalle, '')

  select
    @w_parlista = ''
  select
    @w_parlistares = ''
  select
    @w_restrictiva = ''
  select
    @w_parlistares = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'LRES'

  select
    @w_restrictiva = ms_restrictiva
  from   cobis..cl_manejo_sarlaft
  where  ms_origen = @w_categoria
     and ms_estado = @w_subcategoria

  if (@w_restrictiva = @w_parlistares)
  begin
    if not exists (select
                     1
                   from   cobis..cl_lista_exonerados
                   where  le_ced_ruc = @w_ced_r)
    begin
      select
        @w_nombre = ltrim(rtrim(@w_nombre))
      select
        @w_p_apellido = ltrim(rtrim(@w_p_apellido))
      select
        @w_s_apellido = ltrim(rtrim(@w_s_apellido))

      if @w_s_apellido is null
          or @w_s_apellido = ' '
      begin
        select
          @w_nomlar = isnull(@w_p_apellido, '') + ' ' + isnull(@w_nombre
                      ,
                      ''
                      )
      end
      if @w_s_apellido is not null
          or @w_s_apellido <> ' '
      begin
        select
          @w_nomlar = isnull(@w_p_apellido, '') + ' ' + isnull(
                      @w_s_apellido,
                      ''
                      )
                      +
                      ' '
                             + isnull(
                             @w_nombre, '')
      end

      select
        @w_nomlar = replace(ltrim(rtrim(@w_nomlar)),
                            '  ',
                            ' ')

      insert into cobis..cl_refinh
                  (in_codigo,in_documento,in_ced_ruc,in_nombre,
                   in_fecha_ref,
                   in_origen,in_observacion,in_fecha_mod,in_subtipo,
                   in_p_p_apellido,
                   in_p_s_apellido,in_tipo_ced,in_nomlar,in_estado,
                   in_sexo
                   ,
                   in_usuario,in_aka,
                   in_categoria,in_subcategoria,in_fuente,
                   in_otroid,in_pasaporte,in_concepto,in_entid)
      values      ( @w_codigo,convert(int, @w_documento),@w_ced_ruc,
                    @w_nombre,
                    @w_fecha_ref,
                    @w_categoria,@w_observacion,@w_fecha_mod,@w_subtipo,
                    @w_p_apellido,
                    @w_s_apellido,@w_tipo_ced,@w_nomlar,@w_subcategoria,
                    @w_sexo,
                    @w_usuario,@w_akas,@w_ced_r,null,@w_fuente,
                    @w_otro_id,@w_pasaporte,@w_concepto,@w_entid )
      if @@error <> 0
      begin
        rollback tran
        select
          @w_msg = '[sp_verifhom] Error insert cl_refinh CC DOS. ENTE '
                   + convert(varchar(15), @w_ced_ruc)
        insert into cl_error_log
                    (er_fecha_proc,er_usuario,er_descripcion)
        values      (getdate(),'op_batch',@w_msg)
        print @w_msg
        goto SIGUIENTE
      end

      update cobis..cl_ente
      set    en_mala_referencia = 'S',
             en_cont_malas = isnull(en_cont_malas, 0) + 1,
             en_comentario = 'WC cruce por homonimia'
      where  en_ced_ruc = ltrim(rtrim(@w_ced_r))
         and en_ente not in(select
                              le_ente
                            from   cobis..cl_lista_exonerados)

      if @@error <> 0
      begin
        rollback tran
        select
          @w_msg =
        '[sp_verifhom] ERROR EN ACTUALIZACION DE MALA REFERENCIA. ENTE '
        + convert(varchar(15), @w_ced_ruc)
        insert into cl_error_log
                    (er_fecha_proc,er_usuario,er_descripcion)
        values      (getdate(),'op_batch',@w_msg)
        print @w_msg
        goto SIGUIENTE
      end
    end --lexonera
  end -- restrictiva

  select
    @w_parlista = ''
  select
    @w_restrictiva = ''

  select
    @w_restrictiva = ms_restrictiva
  from   cobis..cl_manejo_sarlaft
  where  ms_origen = @w_categoria
     and ms_estado = @w_subcategoria

  select
    @w_parlista = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'LNRES'

  if (@w_restrictiva = @w_parlista)
     and @w_observacion not like '%HOMONIM%'
  begin
    insert into cobis..cl_autoriza_sarlaft_lista
                (as_sec_refinh,as_tipo_id,as_nro_id,as_nombrelargo,
                 as_origen_refinh,
                 as_estado_refinh,as_fecha_refinh,as_aut_sarlaft,
                 as_obs_sarlaft,
                 as_usr_sarlaft,
                 as_fecha_sarlaft,as_aut_cial,as_obs_cial,as_usr_cial,
                 as_fecha_cial,
                 as_valida_total,as_oficina)
    values      ( @w_codigo,convert(int, @w_documento),@w_ced_ruc,
                  @w_nomlar,
                  @w_categoria,
                  @w_subcategoria,@w_fecha_mod,null,null,null,
                  null,null,null,null,null,
                  null,null )

    if @@error <> 0
    begin
      rollback tran
      select
        @w_msg =
'[sp_verifhom] Error insert cl_autoriza_sarlaft_lista CC DOS. ENTE '
+ convert(varchar(15), @w_ced_ruc)
insert into cl_error_log
        (er_fecha_proc,er_usuario,er_descripcion)
values      (getdate(),'op_batch',@w_msg)
print @w_msg
goto SIGUIENTE
    end

    update cobis..cl_ente
    set    en_mala_referencia = 'S',
           en_cont_malas = isnull(en_cont_malas, 0) + 1,
           en_comentario = 'WC cruce por homonimia2'
    where  en_ced_ruc = ltrim(rtrim(@w_ced_r))
       and en_ente not in(select
                            le_ente
                          from   cobis..cl_lista_exonerados)

    if @@error <> 0
    begin
      rollback tran
      select
        @w_msg =
'[sp_verifhom] ERROR EN ACTUALIZACION DE MALA REFERENCIA CC DOS. ENTE '
+ convert(varchar(15), @w_ced_ruc)
insert into cl_error_log
        (er_fecha_proc,er_usuario,er_descripcion)
values      (getdate(),'op_batch',@w_msg)
print @w_msg
goto SIGUIENTE
end
end -- restrictiva

select
@w_observacion = 'CARGUE WORLD COMPLIANCE'

commit tran

end --while
end --if

drop table #nom_homonimo

/**** VALIDA NUMERO DE PASAPORTE ****/
select
@w_cont = 0

select
@w_cont = count(1)
from   cl_ente_procesawc
where  en_ced_ruc = isnull(@w_pasaporte,
                         'SIN PASAPORTE')

if @w_cont > 0
begin
select
  @w_control = 'S'
select
  @w_contador = @w_contador + 1
select
  @w_observacion = 'PASAPORTE'
select
  @w_observacion = @w_observacion + ' - ' + isnull(@w_detalle, '')
end

if @w_cont > 0
begin
begin tran

exec @w_return = sp_cseqnos
  @t_debug     = @t_debug,
  @t_file      = @t_file,
  @t_from      = @w_sp_name,
  @i_tabla     = 'cl_refinh',
  @o_siguiente = @w_codigo out

if @w_return <> 0
begin
  --insert into log (mensaje) values ('Error seqnos')
  return @w_return
end

if @w_p_apellido is null
    or @w_p_apellido = ''
begin
  select
    @w_subtipo = 'C'
  select
    @w_tipo_ced = 'N'
end

if @w_subtipo is null
    or @w_subtipo = ''
begin
  select
    @w_subtipo = 'P'
  select
    @w_tipo_ced = 'CC'
end

if @w_p_apellido = ''
  select
    @w_p_apellido = null

if @w_s_apellido = ''
  select
    @w_s_apellido = null

select
  @w_des_estado = valor
from   cobis..cl_catalogo
where  tabla  = (select
                   codigo
                 from   cobis..cl_tabla
                 where  tabla = 'cl_equiv_refinh_sarlaft')
   and codigo = @w_estado
   and estado = 'V'

select
  @w_nombre = ltrim(rtrim(@w_nombre))
select
  @w_p_apellido = ltrim(rtrim(@w_p_apellido))
select
  @w_s_apellido = ltrim(rtrim(@w_s_apellido))

if @w_s_apellido is null
    or @w_s_apellido = ' '
begin
  select
    @w_nomlar = isnull(@w_p_apellido, '') + ' ' + isnull(@w_nombre, '')
end
if @w_s_apellido is not null
    or @w_s_apellido <> ' '
begin
  select
    @w_nomlar = isnull(@w_p_apellido, '') + ' ' + isnull(@w_s_apellido,
                ''
                )
                +
                ' '
                +
                       isnull(
                       @w_nombre, '')
end

select
  @w_nomlar = replace (ltrim(rtrim(@w_nomlar)),
                       '  ',
                       ' ')

insert into cobis..cl_refinh
            (in_codigo,in_documento,in_ced_ruc,in_nombre,in_fecha_ref,
             in_origen,in_observacion,in_fecha_mod,in_subtipo,
             in_p_p_apellido,
             in_p_s_apellido,in_tipo_ced,in_nomlar,in_estado,in_sexo,
             in_usuario,in_aka,in_categoria,in_subcategoria,in_fuente,
             in_otroid,in_pasaporte,in_concepto,in_entid)
values      ( @w_codigo,convert(int, @w_documento),@w_ced_ruc,@w_nombre,
              @w_fecha_ref,
              @w_categoria,@w_observacion,@w_fecha_mod,@w_subtipo,
              @w_p_apellido,
              @w_s_apellido,@w_tipo_ced,@w_nomlar,@w_subcategoria,
              @w_sexo,
              @w_usuario,@w_akas,null,null,@w_fuente,
              @w_otro_id,@w_pasaporte,@w_concepto,@w_entid )

if @@error <> 0
begin
  rollback tran
  select
    @w_msg = '[sp_verifhom] Error insert cl_refinh CC TRES. ENTE '
             + convert(varchar(15), @w_ced_ruc)
  insert into cl_error_log
              (er_fecha_proc,er_usuario,er_descripcion)
  values      (getdate(),'op_batch',@w_msg)
  print @w_msg
  goto SIGUIENTE
end

select
  @w_restrictiva = ''
select
  @w_parlista = ''
select
  @w_restrictiva = ms_restrictiva
from   cobis..cl_manejo_sarlaft
where  ms_origen = @w_categoria
   and ms_estado = @w_subcategoria

select
  @w_parlista = pa_char
from   cobis..cl_parametro
where  pa_producto = 'MIS'
   and pa_nemonico = 'LNRES'

if @w_restrictiva = @w_parlista
begin
  insert into cobis..cl_autoriza_sarlaft_lista
              (as_sec_refinh,as_tipo_id,as_nro_id,as_nombrelargo,
               as_origen_refinh,
               as_estado_refinh,as_fecha_refinh,as_aut_sarlaft,
               as_obs_sarlaft,
               as_usr_sarlaft,
               as_fecha_sarlaft,as_aut_cial,as_obs_cial,as_usr_cial,
               as_fecha_cial,
               as_valida_total,as_oficina)
  values      ( @w_codigo,convert(int, @w_documento),@w_ced_ruc,
                @w_nomlar,
                @w_categoria,
                @w_subcategoria,@w_fecha_mod,null,null,null,
                null,null,null,null,null,
                null,null )

  if @@error <> 0
  begin
    rollback tran
    select
      @w_msg =
'[sp_verifhom] Error insert cl_autoriza_sarlaft_lista CC TRES. ENTE '
+ convert(varchar(15), @w_ced_ruc)
insert into cl_error_log
      (er_fecha_proc,er_usuario,er_descripcion)
values      (getdate(),'op_batch',@w_msg)
print @w_msg
goto SIGUIENTE
  end
end --restrictiva

if @w_cont > 0
begin
  update cobis..cl_ente
  set    en_mala_referencia = 'S',
         en_cont_malas = isnull(en_cont_malas, 0) + 1,
         en_comentario = 'WC cruce por OTRA identificacion'
  where  en_ced_ruc = @w_pasaporte

  if @@error <> 0
  begin
    rollback tran
    select
      @w_msg =
'[sp_verifhom] ERROR EN ACTUALIZACION DE MALA REFERENCIA CC TRES. ENTE '
     + convert(varchar(15), @w_ced_ruc)
insert into cl_error_log
      (er_fecha_proc,er_usuario,er_descripcion)
values      (getdate(),'op_batch',@w_msg)
print @w_msg
goto SIGUIENTE
end
end

commit tran
end

select
@w_observacion = 'CARGUE WORLD COMPLIANCE'

select
@w_nombre = ltrim(rtrim(@w_nombre))
select
@w_p_apellido = ltrim(rtrim(@w_p_apellido))
select
@w_s_apellido = ltrim(rtrim(@w_s_apellido))

if @w_s_apellido is null
  or @w_s_apellido = ' '
begin
select
  @w_nomlar = isnull(@w_p_apellido, '') + ' ' + isnull(@w_nombre, '')
end
if @w_s_apellido is not null
  or @w_s_apellido <> ' '
begin
select
  @w_nomlar = isnull(@w_p_apellido, '') + ' ' + isnull(@w_s_apellido, ''
              )
              +
              ' '
              +
                     isnull(
                     @w_nombre, '')
end

select
@w_nomlar = replace(ltrim(rtrim(@w_nomlar)),
                    '  ',
                    ' ')

begin tran

exec @w_return = sp_cseqnos
@t_debug     = @t_debug,
@t_file      = @t_file,
@t_from      = @w_sp_name,
@i_tabla     = 'cl_refinh',
@o_siguiente = @w_codigo out

insert into cobis..cl_refinh
          (in_codigo,in_documento,in_ced_ruc,in_nombre,in_fecha_ref,
           in_origen,in_observacion,in_fecha_mod,in_subtipo,
           in_p_p_apellido,
           in_p_s_apellido,in_tipo_ced,in_nomlar,in_estado,in_sexo,
           in_usuario,in_aka,in_categoria,in_subcategoria,in_fuente,
           in_otroid,in_pasaporte,in_concepto,in_entid)
values      ( @w_codigo,99,@w_ced_ruc,@w_nombre,@w_fecha_ref,
            @w_categoria,@w_observacion,@w_fecha_mod,@w_subtipo,
            @w_p_apellido,
            @w_s_apellido,@w_tipo_ced,@w_nomlar,@w_subcategoria,@w_sexo,
            @w_usuario,@w_akas,null,null,@w_fuente,
            @w_otro_id,@w_pasaporte,@w_concepto,@w_entid )

if @@error <> 0
begin
rollback tran
select
  @w_msg = '[sp_verifhom] Error insert cl_refinh CC CUATRO. ENTE '
           + convert(varchar(15), @w_ced_ruc)
insert into cl_error_log
            (er_fecha_proc,er_usuario,er_descripcion)
values      (getdate(),'op_batch',@w_msg)
print @w_msg
goto SIGUIENTE
end

select
@w_restrictiva = ''
select
@w_parlista = ''
select
@w_restrictiva = ms_restrictiva
from   cobis..cl_manejo_sarlaft
where  ms_origen = @w_categoria
 and ms_estado = @w_subcategoria

select
@w_parlista = pa_char
from   cobis..cl_parametro
where  pa_producto = 'MIS'
 and pa_nemonico = 'LNRES'

if @w_restrictiva = @w_parlista
begin
insert into cobis..cl_autoriza_sarlaft_lista
            (as_sec_refinh,as_tipo_id,as_nro_id,as_nombrelargo,
             as_origen_refinh,
             as_estado_refinh,as_fecha_refinh,as_aut_sarlaft,
             as_obs_sarlaft,
             as_usr_sarlaft,
             as_fecha_sarlaft,as_aut_cial,as_obs_cial,as_usr_cial,
             as_fecha_cial,
             as_valida_total,as_oficina)
values      ( @w_codigo,convert(int, @w_documento),@w_ced_ruc,@w_nomlar,
              @w_categoria,
              @w_subcategoria,@w_fecha_mod,null,null,null,
              null,null,null,null,null,
              null,null)

if @@error <> 0
begin
  rollback tran
  select
    @w_msg =
  '[sp_verifhom] Error insert cl_autoriza_sarlaft_lista CC CINCO. ENTE '
  + convert(varchar(15), @w_ced_ruc)
  insert into cl_error_log
              (er_fecha_proc,er_usuario,er_descripcion)
  values      (getdate(),'op_batch',@w_msg)
  print @w_msg
  goto SIGUIENTE
end
end --restrictiva
commit tran
end

--Recalcula marca malas referencias del cliente
select
@w_parlista = ''
select
@w_parlistares = ''
select
@w_restrictiva = ''
select
@w_malaref = 'N'
select
@w_cantidad = 0

select
@w_parlistares = pa_char
from   cobis..cl_parametro
where  pa_producto = 'MIS'
and pa_nemonico = 'LRES'

select
@w_restrictiva = ms_restrictiva
from   cobis..cl_manejo_sarlaft
where  ms_origen = @w_categoria
and ms_estado = @w_subcategoria

if (@w_restrictiva = @w_parlistares)
begin
select
@w_xced = 0
select
@w_xced = isnull(count(0),
                 0)
from   cobis..cl_refinh
where  in_ced_ruc = @w_ced_ruc

select
@w_xnom = 0
select
@w_xnom = isnull(count(0),
                 0)
from   cobis..cl_refinh
where  in_nomlar = @w_nomlar

if @w_xced > 0
begin
begin tran

select
  @w_malaref = 'S',
  @w_cantidad = @w_xced

update cobis..cl_ente
set    en_mala_referencia = @w_malaref,
       en_cont_malas = @w_cantidad,
       en_comentario = 'WC cruce por GENERAL1'
where  en_ced_ruc = @w_ced_ruc

if @@error <> 0
begin
  rollback tran
  select
    @w_msg = '[sp_verifhom] Error actualizar cl_refinh CC. ENTE '
             + convert(varchar(15), @w_ced_ruc)
  insert into cl_error_log
              (er_fecha_proc,er_usuario,er_descripcion)
  values      (getdate(),'op_batch',@w_msg)
  print @w_msg
  goto SIGUIENTE
end

if @w_xced = 0
   and @w_xnom = 0
begin
  --and exists (select 1 from cobis..cl_lista_exonerados where  le_ced_ruc  = @w_ced_r) begin
  select
    @w_cantidad = @w_cantidad + @w_xnom
  select
    @w_malaref = 'N'

  update cobis..cl_ente
  set    en_mala_referencia = @w_malaref,
         en_cont_malas = @w_cantidad,
         en_comentario = 'WC cruce por GENERAL2'
  where  en_nomlar = @w_nomlar

  if @@error <> 0
  begin
    rollback tran
    select
      @w_msg = '[sp_verifhom] Error al Marcar Mala Referencia. ENTE '
               + convert(varchar(15), @w_ced_ruc)
    insert into cl_error_log
                (er_fecha_proc,er_usuario,er_descripcion)
    values      (getdate(),'op_batch',@w_msg)
    print @w_msg
    goto SIGUIENTE
  end
end

if @w_xced = 0
   and @w_xnom > 1
   and not exists (select
                     1
                   from   cobis..cl_lista_exonerados
                   where  le_ced_ruc = @w_ced_r)
begin
  select
    @w_cantidad = @w_cantidad + @w_xnom
  select
    @w_malaref = 'S'

  update cobis..cl_ente
  set    en_mala_referencia = @w_malaref,
         en_cont_malas = @w_cantidad,
         en_comentario = 'WC cruce por GENERAL3'
  where  en_nomlar = @w_nomlar

  if @@error <> 0
  begin
    rollback tran
    select
      @w_msg = '[sp_verifhom] Error al Marcar Mala Referencia. ENTE '
               + convert(varchar(15), @w_ced_ruc)
    insert into cl_error_log
                (er_fecha_proc,er_usuario,er_descripcion)
    values      (getdate(),'op_batch',@w_msg)
    print @w_msg
    goto SIGUIENTE
  end
end

commit tran

end
end -- restrictivas

select
@w_parlistanres = pa_char
from   cobis..cl_parametro
where  pa_producto = 'MIS'
and pa_nemonico = 'LNRES'

select
@w_restrictiva = ms_restrictiva
from   cobis..cl_manejo_sarlaft
where  ms_origen = @w_categoria
and ms_estado = @w_subcategoria

if (@w_restrictiva = @w_parlistanres)
begin
select
@w_xced = 0
select
@w_xced = isnull(count(0),
                 0)
from   cobis..cl_refinh
where  in_ced_ruc = @w_ced_ruc

if @w_xced > 0
begin
select
  @w_malaref = 'S',
  @w_cantidad = @w_xced

begin tran

update cobis..cl_ente
set    en_mala_referencia = @w_malaref,
       en_cont_malas = @w_cantidad,
       en_comentario = 'WC cruce por NRES'
where  en_ced_ruc = @w_ced_ruc

if @@error <> 0
begin
  rollback tran
  select
    @w_msg = '[sp_verifhom] Error al Marcar Mala Referencia. ENTE '
             + convert(varchar(15), @w_ced_ruc)
  insert into cl_error_log
              (er_fecha_proc,er_usuario,er_descripcion)
  values      (getdate(),'op_batch',@w_msg)
  print @w_msg
  goto SIGUIENTE
end

commit tran
end
end
--Recalcula marca malas referencias del cliente

select
@w_contador = 0
select
@w_cont = 0

SIGUIENTE:

while @@trancount > 0
commit tran
end

print 'Inicia indexacion'
select
getdate()
/**********   Como los iondices estan desabilitados solo hace falta reconstruirlos
CREATE NONCLUSTERED INDEX [cl_refinh_Key] ON [dbo].[cl_refinh]
(
      [in_nomlar] ASC,
      [in_codigo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [indexgroup]

CREATE NONCLUSTERED INDEX [idx_categoria] ON [dbo].[cl_refinh]
(
      [in_categoria] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [indexgroup]

CREATE NONCLUSTERED INDEX [iin_ced_ruc] ON [dbo].[cl_refinh]
(
      [in_ced_ruc]  ASC, [in_origen] desc
)INCLUDE in_fecha_ref,in_nomlar, in_estado)  WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [indexgroup]

CREATE NONCLUSTERED INDEX [iin_fecha_mod] ON [dbo].[cl_refinh]
(
      [in_fecha_mod] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [indexgroup]
***************/
alter index [cl_refinh_Key] on [dbo].[cl_refinh] rebuild alter index
[idx_categoria] on [dbo].[cl_refinh] rebuild alter index [iin_ced_ruc] on
[dbo].[cl_refinh] rebuild alter index [iin_fecha_mod] on [dbo].[cl_refinh]
rebuild
print 'Fin indexacion'
select
getdate()
end

  if @i_operacion = 'D'
  begin
    select
      @w_comando = 'wc -l ' + @i_path + '\' + @i_archivo + ' > ' + @w_path_lis +
                          '\salida.out'

    exec @w_error = xp_cmdshell
      @w_comando
    if @w_error <> 0
    begin
      print 'Error validando cantidad de registros'
      print @w_comando
      return 1
    end

    select
      @w_s_app = 's_app bcp -auto -login cobis..cl_val_arch in '
    select
      @w_destino = @i_path + @i_archivo,
      @w_errores = @w_path_lis + @i_archivo + '.err'
    select
      @w_comando =
      @w_s_app + @w_path_lis + '\' + 'salida.out' + ' -b5000 -c -e' + @w_errores
      +
      ' -t"|" ' + '-config '+
                   + @w_ruta + 's_app.ini'

    exec @w_error = xp_cmdshell
      @w_comando
    if @w_error <> 0
    begin
      print 'Error Cargando numero de registros del archivo'
      print @w_comando
      return 1
    end

    select
      @w_arch = registros
    from   cobis..cl_val_arch

    select
      @w_reg_arch = convert(int, rtrim(ltrim(substring (ltrim(@w_arch),
                                                        1,
                                                        charindex(' ',
                                                                  ltrim(@w_arch)
                                             ))
                                       ))
                    )
    select
      @w_reg_arch = isnull(@w_reg_arch,
                           0)

    delete cobis..cl_borra_wc

    select
      @w_s_app = 's_app bcp -auto -login cobis..cl_borra_wc in '
    select
      @w_destino = @i_path + @i_archivo,
      @w_errores = @w_path_lis + @i_archivo + '.err'
    select
      @w_comando = @w_s_app + @i_path + '\' + @i_archivo + ' -b5000 -c -e' +
                   @w_errores + ' -t"|" '
                   + '-config ' + @w_ruta
                   + 's_app.ini'

    exec @w_error = xp_cmdshell
      @w_comando
    if @w_error <> 0
    begin
      print 'Error Cargando archivo: ' + @i_archivo
      print @w_comando
      return 1
    end

    select
      @w_reg = count(1)
    from   cobis..cl_borra_wc

    if @w_reg <> @w_reg_arch
    begin
      print '@w_reg ' + cast(@w_reg as varchar)
      print '@w_reg_arch ' + cast(@w_reg_arch as varchar)
      print 'NO SE CARGO EL ARCHIVO CORRECTAMENTE, POR FAVOR VALIDAR'
      return 1
    end

    if @w_reg = 0
    begin
      print '@w_reg ' + cast(@w_reg as varchar)
      print 'NO SE CARGO EL ARCHIVO CORRECTAMENTE, POR FAVOR VALIDAR'
      return 1
    end

    while 1 = 1
    begin
      set rowcount 1

      select
        @w_entid = bw_entid
      from   cobis..cl_borra_wc
      where  bw_entid <> 'Ent_ID'

      if @@rowcount = 0
      begin
        set rowcount 0
        break
      end

      delete cobis..cl_borra_wc
      where  bw_entid = @w_entid

      select
        @w_entid_tmp = substring(@w_entid,
                                 1,
                                 1)

      select
        @w_ascii = ascii(@w_entid_tmp)

      if (@w_ascii < 48)
          or (@w_ascii > 57)
      begin
        goto SIGUIENTE_D
      end

      select
        @w_codigo = in_codigo,
        @w_ced_ruc = in_ced_ruc,
        @w_tipo_id = in_tipo_ced,
        @w_p_apellido = in_p_p_apellido,
        @w_s_apellido = in_p_s_apellido,
        @w_nombre = in_nombre,
        @w_nombrelargo = in_nomlar,
        @w_origen_refinh = in_origen,
        @w_estado_refinh = in_estado
      from   cobis..cl_refinh
      where  in_entid = convert(int, ltrim(rtrim(@w_entid)))

      if @@rowcount = 0
      begin
        goto SIGUIENTE_D
      end

      set rowcount 0

      begin tran

      delete cobis..cl_refinh
      where  in_entid = convert(int, ltrim(rtrim(@w_entid)))

      if @@error <> 0
      begin
        set rowcount 0
        rollback tran
        select
          @w_msg = '[sp_verifhom] ERROR EN BORRADO DE REFINH. ENTE ' + convert(
                   varchar
                   (
                                          15),
                                          @w_ced_ruc)
        insert into cl_error_log
                    (er_fecha_proc,er_usuario,er_descripcion)
        values      (getdate(),'op_batch',@w_msg)
        print @w_msg
        goto SIGUIENTE_D
      end

      exec @w_ssn = ADMIN...rp_ssn

      insert into cl_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,
                   ts_usuario,
                   ts_terminal,ts_srv,ts_lsrv,ts_tipo_ced,ts_cedruc,
                   ts_nombre,ts_fecha_ref,ts_origen,ts_codigo_mr,
                   ts_observaciones,
                   ts_documento,ts_fecha_mod,ts_p_apellido,ts_s_apellido,
                   ts_estado_ref)
      values      ( @w_ssn,1282,'N',getdate(),'op_batch',
                    null,null,null,@w_tipo_id,@w_ced_ruc,
                    @w_nombre,getdate(),@w_origen_refinh,@w_codigo,
                    'ELIMINACION POR BATCH [sp_verifhom]',
                    null,getdate(),@w_p_apellido,@w_s_apellido,@w_estado_refinh)

      if @@error <> 0
      begin
        rollback tran
        select
          @w_msg =
        '[sp_verifhom] ERROR EN INSERCION DE TRANSACCION DE SERVICIO. ENTE '
        + convert(varchar(15), @w_ced_ruc)
        insert into cl_error_log
                    (er_fecha_proc,er_usuario,er_descripcion)
        values      (getdate(),'op_batch',@w_msg)
        print @w_msg
        goto SIGUIENTE_D
      end

      delete cobis..cl_autoriza_sarlaft_lista
      where  as_sec_refinh = @w_codigo

      if @@error <> 0
      begin
        set rowcount 0
        rollback tran
        select
          @w_msg =
        '[sp_verifhom] ERROR EN BORRADO DE cl_autoriza_sarlaft_lista. ENTE '
        + convert(varchar(15), @w_ced_ruc)
        insert into cl_error_log
                    (er_fecha_proc,er_usuario,er_descripcion)
        values      (getdate(),'op_batch',@w_msg)
        print @w_msg
        goto SIGUIENTE_D
      end

      insert into cl_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_tclase,ts_fecha,
                   ts_usuario
                   ,
                   ts_terminal,ts_srv,ts_lsrv,ts_tipo_ced,
                   ts_cedruc,
                   ts_nombre,ts_fecha_ref,ts_origen,ts_estado_ref,ts_tipo,
                   ts_descripcion,ts_clase,ts_calificacion,ts_observaciones,
                   ts_fecha_mod,
                   ts_restado,ts_oficina)
      values      ( @w_codigo,1038,'N',getdate(),'op_batch',
                    null,null,null,@w_tipo_id,@w_ced_ruc,
                    @w_nombrelargo,null,@w_origen_refinh,@w_estado_refinh,null,
                    'EMININACION POR BATCH','S','ELIMINADO',
                    'Eliminacion WC cruce por DELETIONS1',getdate(),
                    'D',null)

      if @@error <> 0
      begin
        rollback tran
        select
          @w_msg =
        '[sp_verifhom] ERROR EN INSERCION DE TRANSACCION DE SERVICIO. ENTE '
        + convert(varchar(15), @w_ced_ruc)
        insert into cl_error_log
                    (er_fecha_proc,er_usuario,er_descripcion)
        values      (getdate(),'op_batch',@w_msg)
        print @w_msg
        goto SIGUIENTE_D
      end

      update cobis..cl_ente
      set    en_mala_referencia = 'N',
             en_comentario = 'WC cruce por DELETIONS1'
      where  p_p_apellido = @w_p_apellido
         and p_s_apellido = @w_s_apellido
         and en_nombre    = @w_nombre

      select
        @w_error = @@error,
        @w_cont = @@rowcount

      if @w_error <> 0
      begin
        set rowcount 0
        rollback tran
        select
          @w_msg =
        '[sp_verifhom] ERROR EN BORRADO DE cl_autoriza_sarlaft_lista. ENTE '
        + convert(varchar(15), @w_ced_ruc)
        insert into cl_error_log
                    (er_fecha_proc,er_usuario,er_descripcion)
        values      (getdate(),'op_batch',@w_msg)
        print @w_msg
        goto SIGUIENTE_D
      end

      if @w_cont = 0
      begin
        set rowcount 0

        update cobis..cl_ente
        set    en_mala_referencia = 'N',
               en_comentario = 'WC cruce por DELETIONS2'
        where  en_ced_ruc = @w_ced_ruc

        if @@error <> 0
        begin
          set rowcount 0
          rollback tran
          select
            @w_msg = '[sp_verifhom] ERROR EN ACTUALIZACION DE ENTE. ENTE '
                     + convert(varchar(15), @w_ced_ruc)
          insert into cl_error_log
                      (er_fecha_proc,er_usuario,er_descripcion)
          values      (getdate(),'op_batch',@w_msg)
          print @w_msg
          goto SIGUIENTE_D
        end
      end
      commit tran
      SIGUIENTE_D:
      while @@trancount > 0
        commit tran
    end

    print 'Fin indexacion'
    select
      getdate()
  end

  return 0

go

