/************************************************************************/
/*  Archivo:                cl_msv_valida_neg.sp                        */
/*  Stored procedure:       sp_msv_valida_neg                           */
/*  Base de datos:          cobis                                       */
/*  Producto:               CLIentes                                    */
/*  Disenado por:           Nini Salazar                                */
/*  Fecha de escritura:     13-Mar-2013                                 */
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
/*  Este stored procedure procesa:                                      */
/*                                                                      */
/************************************************************************/
/*              MODifiCAciONES                                          */
/*  FECHA         AUTOR               RAZON                             */
/*  13/Mar/2013   Nini Salazar        Emision inicial                   */
/*  02/May/2016   DFu                 Migracion CEN                     */
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
           where  name = 'sp_msv_valida_neg')
  drop proc sp_msv_valida_neg
go

create proc sp_msv_valida_neg
(
  @t_show_version bit = 0,
  @i_bloque       int
)
as
  declare
    @w_sp_name       varchar(32),
    @w_error         int,
    @w_msg           descripcion,
    @w_fecha_actual  int,
    @w_retorno       int,
    @w_mc_id_carga   int,
    @w_mc_id_Alianza numero,
    @w_mc_tipo_ced   varchar(2),
    @w_mc_cedula     numero,
    @w_mc_sexo       char(1),
    @w_return        int,
    @w_mensaje       varchar(200),
    @w_debug         char(1),
    @w_id_alianza    int,
    @w_id_aliado     varchar(24),
    @w_mr_nom_campo  varchar(20),
    @w_cadena        varchar(2000),
    @w_valor_default varchar(255),
    @w_cod_alianza   int,
    @w_tipo_dato     varchar(20)

  select
    @w_sp_name = 'sp_msv_valida_neg'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*******TABLA TEMPORAL*******/
  set rowcount @i_bloque
  select
    @w_debug = 'N'

  --insert into cob_credito..seguim values ( 1, getdate(), 'xxx' )

  select
    *
  into   #ca_msv_error_aux
  from   cobis..ca_msv_error
  where  1 = 2

  create index idx1
    on #ca_msv_error_aux ( me_id_carga )

  --insert into cobis..control_msv values ('00_1. Hora Sys: ' + CONVERT(varchar(50), getdate(), 109) + '-sp_msv_valida_neg' )
  -- VALIDACION DE EXISTENCIA DE CEDULA Y TIPO DE ID , POR CLIENTE 
  if exists (select
               '1'
             from   cob_externos..ex_msv_clientes
             where  mc_estado = 'E'
                and (mc_id_Alianza) not in (select
                                              en_ced_ruc
                                            from   cobis..cl_alianza,
                                                   cobis..cl_ente
                                            where  al_ente   = en_ente
                                               and al_estado = 'V'))
  begin
    insert into cobis..ca_msv_error
      select
        me_fecha = getdate(),me_id_carga = a.mc_id_carga,me_id_alianza = 0,
        me_referencia = a.mc_cedula + '-' + a.mc_tipo_ced,me_tipo_proceso = 'C',
        me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
        me_codigo_err = 0
        ,me_descripcion = 'ALIANZA NO EXISTE O NO ESTA VIGENTE. ' + 'NIT: ' +
                          a.mc_id_Alianza
        + ' CED: ' +
        a.mc_cedula
        + ' TIPO: ' + a.mc_tipo_ced
      from   cob_externos..ex_msv_clientes a
      where  mc_estado = 'E'
         and (mc_id_Alianza) not in (select
                                       en_ced_ruc
                                     from   cobis..cl_alianza,
                                            cobis..cl_ente
                                     where  al_ente   = en_ente
                                        and al_estado = 'V')

    update cob_externos..ex_msv_clientes
    set    mc_estado = 'P'
    where  mc_estado = 'E'
       and (mc_id_Alianza) not in (select
                                     en_ced_ruc
                                   from   cobis..cl_alianza,
                                          cobis..cl_ente
                                   where  al_ente   = en_ente
                                      and al_estado = 'V')

    return 0

  end

/* INICIO REQ. 417 AZU: ALCANCE ALIANZAS COMERCIALES */
  /* ACTUALIZAR LOS CAMPOS DE LA TABLA DE COB_EXTERNOS CON BASE EN LA TABLA DE DEFAULTS POR ALIANZA */

  set rowcount 0

  select
    mr_alianza,
    mr_nom_campo,
    mr_valor_default,
    mr_tipo_dato = C.name
  into   #temporal
  from   cobis..cl_msv_relacion_default_ente with (nolock),
         cobis..cl_alianza with (nolock),
         cobis..cl_ente with (nolock),
         cob_externos..sysobjects A,
         cob_externos..syscolumns B,
         cob_externos..systypes C
  where  al_ente      = en_ente
     and al_estado    = 'V'
     and al_alianza   = mr_alianza
     and mr_valor_default is not null
     and A.name       = 'ex_msv_clientes'
     and A.id         = B.id
     and B.xtype      = C.xtype
     and mr_nom_campo = B.name

  select
    @w_cadena = ''

  while 1 = 1
  begin
    set rowcount 1

    select
      @w_mr_nom_campo = mr_nom_campo,
      @w_valor_default = mr_valor_default,
      @w_cod_alianza = mr_alianza,
      @w_tipo_dato = mr_tipo_dato
    from   #temporal

    if @@rowcount = 0
    begin
      set rowcount 0
      break
    end

    set rowcount 0

    delete #temporal
    where  mr_nom_campo = @w_mr_nom_campo

    if @w_tipo_dato in ('smallint', 'int', 'tinyint', 'money')
    begin
      select
        @w_cadena = 'update cob_externos..ex_msv_clientes set ' +
                    @w_mr_nom_campo
                    +
                           ' = ' +
                           @w_valor_default
                    + ' '
      select
        @w_cadena = @w_cadena
                    +
'from cob_externos..ex_msv_clientes A, cobis..cl_alianza with (nolock), cobis..cl_ente with (nolock) '
  select
    @w_cadena = @w_cadena + 'where al_ente = en_ente and al_estado =  ' +
                '''V'''
                + ' and   al_alianza = ' + convert(varchar, @w_cod_alianza)
                + ' and mc_id_Alianza = en_ced_ruc '
  select
    @w_cadena = @w_cadena + 'and mc_estado = ''E''' + ' '
end
else
begin
  select
    @w_cadena = 'update cob_externos..ex_msv_clientes set ' + @w_mr_nom_campo +
                       ' = '''
                + @w_valor_default + ''''
  select
    @w_cadena = @w_cadena
                +
' from cob_externos..ex_msv_clientes, cobis..cl_alianza with (nolock), cobis..cl_ente with (nolock) '
  select
    @w_cadena = @w_cadena + 'where al_ente = en_ente and al_estado =  ' +
                '''V'''
                + ' and   al_alianza = ' + convert(varchar, @w_cod_alianza)
                + ' and mc_id_Alianza = en_ced_ruc '
  select
    @w_cadena = @w_cadena + 'and mc_estado = ''E''' + ' '
end

  exec (@w_cadena)

  select
    @w_cadena = ''

end

/* FIN    REQ. 417 AZU: ALCANCE ALIANZAS COMERCIALES */
  --insert into cob_credito..seguim values ( 2, getdate(), 'xxx' )

  select
    *
  into   #cl_plano_tmp
  from   cob_externos..ex_msv_clientes with (nolock)
  where  mc_estado = 'E'
  order  by mc_cedula

  set rowcount 0

  --select * from #cl_plano_tmp

  /*SE OBTIENE ID DE LA ALIANZA*/
  select
    en_ente,
    en_ced_ruc,
    mc_id_Alianza,
    mc_id_carga,
    mc_cedula
  into   #msv_nit
  from   cobis..cl_ente with (nolock),
         #cl_plano_tmp
  where  en_ced_ruc = mc_id_Alianza

  select
    al_alianza,
    en_ente,
    en_ced_ruc,
    mc_id_Alianza,
    mc_id_carga,
    mc_cedula
  into   #msv_alianza
  from   cobis..cl_alianza with (nolock),
         #msv_nit
  where  al_ente   = en_ente
     and al_estado = 'V'

  --create index idx1 on #msv_alianza  ( mc_cedula, mc_id_Alianza, mc_id_carga ) 

/*CAMBIO DE ESTADO A PROCESADO*/
  --insert into cob_credito..seguim values ( 3, getdate(), 'xxx' )

  update cob_externos..ex_msv_clientes with (rowlock)
  set    mc_estado = 'P',
         mc_fecha_estado = getdate()
  from   #cl_plano_tmp A
  where  ex_msv_clientes.mc_id_carga   = A.mc_id_carga
     and ex_msv_clientes.mc_id_Alianza = A.mc_id_Alianza
     and ex_msv_clientes.mc_cedula     = A.mc_cedula
     and ex_msv_clientes.mc_tipo_ced   = A.mc_tipo_ced
     and ex_msv_clientes.mc_estado     = 'E'

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR EN LA ACTUALIZACION DE LA TABLA #cl_plano_tmp'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 4, getdate(), 'xxx' )

  /*** INICIO: VALIDA TIPO DE DOCUMENTO PERMITIDO ***/
  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'TIPO DE DOCUMENTO NO PERMITIDO. ' + 'NIT: ' +
                              A.mc_id_Alianza
                              + ' CED: ' +
                              A.mc_cedula
                       + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_tipo_ced not in (select
                                   ct_codigo
                                 from   cobis..cl_tipo_documento
                                 where  ct_subtipo = 'P'
                                    and ct_estado  = 'V')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DOC. NO PERMITIDO.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 5, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_tipo_ced not in (select
                                   ct_codigo
                                 from   cobis..cl_tipo_documento
                                 where  ct_subtipo = 'P'
                                    and ct_estado  = 'V')
/*** FIN: VALIDA TIPO DE DOCUMENTO PERMITIDO ***/
  --insert into cob_credito..seguim values ( 6, getdate(), 'xxx' )

  -------------
  -- VALIDACION: SI DOCUMENTO Y TIPO DE DOCUMENTO EXISTE SE DEBE INGRESAR MENSAJE Y NO ACTUALIZAR EL CLIENTE.
  if exists (select
               '1'
             from   #cl_plano_tmp,
                    cobis..cl_ente
             where  mc_tipo_ced = en_tipo_ced
                and mc_cedula   = en_ced_ruc
                and mc_estado   = 'E')
  begin
    insert into cobis..ca_msv_error
      select
        me_fecha = getdate(),me_id_carga = mc_id_carga,me_id_alianza = 0,
        me_referencia
        = mc_cedula + '-' + mc_tipo_ced,me_tipo_proceso = 'C',
        me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
        me_codigo_err = 0
        ,me_descripcion =
'CLIENTE YA EXISTE EN LA BASE DE DATOS DE BANCAMIA, NO SE ACTUALIZARA LA INFORMACION. '
                 + 'NIT: ' + mc_id_Alianza + ' CED: ' + mc_cedula + ' TIPO: ' +
mc_tipo_ced
from   #cl_plano_tmp,
       cobis..cl_ente
where  mc_tipo_ced = en_tipo_ced
   and mc_cedula   = en_ced_ruc
   and mc_estado   = 'E'

  /*******INSERCION A TABLA FISICA*******/
  insert into cl_msv_crear with (rowlock)
    select
      mc_id_carga = A.mc_id_carga,mc_id_Alianza = b.al_alianza,mc_ofi = A.mc_ofi
      ,
      mc_nombre = A.mc_nombre,mc_p_apelLIdo = A.mc_p_apellido,
      mc_s_apelLIdo = A.mc_s_apellido,mc_sexo = A.mc_sexo,mc_fecha_nac =
      A.mc_fecha_nac,mc_tipo_ced = A.mc_tipo_ced,mc_cedula = A.mc_cedula,
      mc_ciudad_nac = A.mc_ciudad_nac,mc_lugar_doc = A.mc_lugar_doc,
      mc_estado_civil
      = A.mc_estado_civil,mc_actividad = A.mc_actividad,mc_fecha_emision =
      A.mc_fecha_emision,
      mc_sector = A.mc_sector,mc_tipo_productor = A.mc_tipo_productor,
      mc_regimen_fiscal = A.mc_regimen_fiscal,mc_antiguedad = A.mc_antiguedad,
      mc_estrato = A.mc_estrato,
      mc_recurso_pub = A.mc_recurso_pub,mc_influencia = A.mc_influencia,
      mc_persona_pub = A.mc_persona_pub,mc_victima = A.mc_victima,mc_descripcion
      =
      A.mc_descripcion,
      mc_tipo = A.mc_tipo,mc_principal = A.mc_principal,mc_ciudad = A.mc_ciudad,
      mc_rural_urb = A.mc_rural_urb,mc_observacion = A.mc_observacion,
      mc_valor = A.mc_valor,mc_tipo_telefono = A.mc_tipo_telefono,
      mc_origen_fondos = A.mc_origen_fondos,mc_mercado_objetivo =
      A.mc_mercado_objetivo,mc_subtipo_mo = A.mc_subtipo_mo,
      mc_banca = A.mc_banca,mc_segmento = A.mc_segmento,mc_subsegmento =
      A.mc_subsegmento
    from   #cl_plano_tmp A,
           #msv_alianza b,
           cobis..cl_ente en
    where  A.mc_id_carga   = b.mc_id_carga
       and A.mc_id_Alianza = b.mc_id_Alianza
       and A.mc_cedula     = b.mc_cedula
       and A.mc_cedula     = en.en_ced_ruc
       and A.mc_tipo_ced   = en.en_tipo_ced
       and A.mc_estado     = 'E'

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR EN LA TABLA FISICA.'
    goto ERROR_FIN
  end

  delete #cl_plano_tmp
  from   cobis..cl_ente
  where  mc_tipo_ced = en_tipo_ced
     and mc_cedula   = en_ced_ruc
     and mc_estado   = 'E'
end
  -----------------

  /*******VALIDA EXISTENCIA DE CATALOGO POR OFICINA*******/
  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,me_descripcion = 'OFICINA, NO EXISTE. ' + 'NIT: ' + A.mc_id_Alianza +
                        ' CED: ' +
      A.mc_cedula +
      ' TIPO: '
      + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_ofi not in (select
                              of_oficina
                            from   cobis..cl_oficina)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR EN TABLA DE ERROR POR OFICINA NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 7, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_ofi not in (select
                              of_oficina
                            from   cobis..cl_oficina)

  /*******VALIDA EXISTENCIA DE CATALOGO POR SEXO*******/
  select
    c.codigo codigo
  into   #codigo_sex
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_sexo'
     and c.estado = 'V'

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'SEXO NO CORRESPONDE. ' + 'NIT: ' +
                              A.mc_id_Alianza
                              +
                              ' CED: '
                              + A.mc_cedula +
                              ' TIPO: '
                       + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_sexo not in (select
                               codigo
                             from   #codigo_sex)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR EN TABLA DE ERROR POR SEXO NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 8, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_sexo not in (select
                               codigo
                             from   #codigo_sex)

  /*VALIDA EXISTENCIA DE TIPO DE DOCUMENTO*/
  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'TIPO DE DOCUMENTO NO EXISTE. ' + 'NIT: ' +
                              A.mc_id_Alianza +
                              ' CED: ' +
                              A.mc_cedula
                       + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_tipo_ced not in (select
                                   ct_codigo
                                 from   cobis..cl_tipo_documento
                                 where  ct_estado = 'V')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
      'ERROR AL INSERTAR EN TABLA DE ERROR POR TIPO DE DOCUMENTO NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 9, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_tipo_ced not in (select
                                   ct_codigo
                                 from   cobis..cl_tipo_documento
                                 where  ct_estado = 'V')

  --insert into cob_credito..seguim values ( 10, getdate(), 'xxx' )

  /*VALIDA EXISTENCIA DE CATALOGO POR CIUDAD DE NACIMIENTO*/
  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'CIUDAD DE NACIMIENTO NO EXISTE. ' + 'NIT: ' +
                              A.mc_id_Alianza
                              + ' CED: ' +
                              A.mc_cedula
                       + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_ciudad_nac not in (select
                                     ci_ciudad
                                   from   cobis..cl_ciudad)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR EN TABLA DE ERROR POR QUE CIUDAD DE NACIMIENTO NO EXISTENTE.'
  goto ERROR_FIN
end

  --insert into cob_credito..seguim values ( 11, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_ciudad_nac not in (select
                                     ci_ciudad
                                   from   cobis..cl_ciudad)

  --insert into cob_credito..seguim values ( 12, getdate(), 'xxx' )

  /*VALIDA EXISTENCIA DE CATALOGO POR CIUDAD DE LUGAR DE DOC*/
  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'CIUDAD DEL DOCUMENTO NO EXISTE. ' + 'NIT: ' +
                              A.mc_id_Alianza
                              + ' CED: ' +
                              A.mc_cedula
                       + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_ciudad_nac not in (select
                                     ci_ciudad
                                   from   cobis..cl_ciudad)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR EN TABLA DE ERROR POR QUE CIUDAD DE DOCUMENTO NO EXISTENTE.'
  goto ERROR_FIN
end

  --insert into cob_credito..seguim values ( 13, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_ciudad_nac not in (select
                                     ci_ciudad
                                   from   cobis..cl_ciudad)

  --insert into cob_credito..seguim values ( 14, getdate(), 'xxx' )

  /*VALIDA EXISTENCIA DE CATALOGO ESTADO CIVIL*/
  select
    c.codigo codigo
  into   #codigo_ecivil
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_ecivil'
     and c.estado = 'V'

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'ESTADO CIVIL NO EXISTE. ' + 'NIT: ' +
                              A.mc_id_Alianza
                              +
                              ' CED: ' + A.mc_cedula
                              +
      ' TIPO: '
                       + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_estado_civil not in (select
                                       codigo
                                     from   #codigo_ecivil)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR ESTADO CIVIL NO EXISTENTE.'
    goto ERROR_FIN
  end

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_estado_civil not in (select
                                       codigo
                                     from   #codigo_ecivil)

  --insert into cob_credito..seguim values ( 15, getdate(), 'xxx' )

  /*VALIDA EXISTENCIA DE CATALOGO ACTIVIDAD*/
  select
    c.codigo codigo
  into   #codigo_actividad
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_actividad'
     and c.estado = 'V'

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'ACTIVIDAD ECONOMICA NO EXISTE. ' + 'NIT: ' +
                              A.mc_id_Alianza +
                              ' CED: ' +
                              A.mc_cedula
                       + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_actividad not in (select
                                    codigo
                                  from   #codigo_actividad)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR POR ACTIVIDAD NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 16, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_actividad not in (select
                                    codigo
                                  from   #codigo_actividad)

/*VALIDA MAYORiA DE EDAD (FECHA DE EMICION)*/
  --insert into cob_credito..seguim values ( 17, getdate(), 'xxx' )

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'NO POSEE EDAD SUFICIENTE. ' + 'NIT: ' +
                              A.mc_id_Alianza +
                              ' CED: ' +
                              A.mc_cedula
      + ' TIPO: '
                       + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula                                     = B.mc_cedula
       and A.mc_id_Alianza                                 = B.mc_id_Alianza
       and A.mc_id_carga                                   = B.mc_id_carga
       and datediff (mm,
                     mc_fecha_nac,
                     mc_fecha_emision) / 12 < 18

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR, NO POSEE EDAD SUFICIENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 18, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and datediff (mm,
                       mc_fecha_nac,
                       mc_fecha_emision) / 12 < 18

  --insert into cob_credito..seguim values ( 19, getdate(), 'xxx' )

  /*VALIDA EXISTENCIA DE CATALOGO SECTOR*/
  select
    c.codigo codigo
  into   #codigo_sect
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_sectoreco'
     and c.estado = 'V'

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'SECTOR ECONOMICO NO EXISTE.' + 'NIT: ' +
                              A.mc_id_Alianza +
                              ' CED: ' +
                              A.mc_cedula
      + ' TIPO: '
                       + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_sector not in (select
                                 codigo
                               from   #codigo_sect)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR POR SECTOR NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 20, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_sector not in (select
                                 codigo
                               from   #codigo_sect)

  --insert into cob_credito..seguim values ( 21, getdate(), 'xxx' )

  /*VALIDA EXISTENCIA DE TIPO PRODUCTOR*/
  select
    c.codigo codigo
  into   #codigo_tipopro
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_tipo_productor'
     and c.estado = 'V'

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'TIPO DE PRODUCTOR NO EXISTE. ' + 'NIT: ' +
                              A.mc_id_Alianza +
                              ' CED: ' +
                              A.mc_cedula
                       + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_tipo_productor not in (select
                                         codigo
                                       from   #codigo_tipopro)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO PRODUCTOR NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 22, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_tipo_productor not in (select
                                         codigo
                                       from   #codigo_tipopro)

  --insert into cob_credito..seguim values ( 23, getdate(), 'xxx' )

  /*VALIDA EXISTENCIA DE CATALOGO REGIMEN FISCAL*/
  select
    c.codigo codigo
  into   #codigo_regfisc
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cb_regimen_fiscal'
     and c.estado = 'V'

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'REGIMEN FISCAL NO EXISTE. ' + 'NIT: ' +
                              A.mc_id_Alianza +
                              ' CED: ' +
                              A.mc_cedula
      + ' TIPO: '
                       + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_regimen_fiscal not in (select
                                         codigo
                                       from   #codigo_regfisc)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR REGIMEN FISCAL NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 24, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_regimen_fiscal not in (select
                                         codigo
                                       from   #codigo_regfisc)

  --insert into cob_credito..seguim values ( 25, getdate(), 'xxx' )

  /*VALIDA EXISTENCIA DE CATALOGO ESTRATO*/
  select
    c.codigo codigo
  into   #codigo_estrato
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_estrato'
     and c.estado = 'V'

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'CODIGO DE ESTRATO INVALIDO.' + 'NIT: ' +
                              A.mc_id_Alianza +
                              ' CED: ' +
                              A.mc_cedula
      + ' TIPO: '
                       + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_estrato not in (select
                                  codigo
                                from   #codigo_estrato)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR POR ESTRATO NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 26, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_estrato not in (select
                                  codigo
                                from   #codigo_estrato)

  --insert into cob_credito..seguim values ( 27, getdate(), 'xxx' )

  /*VALIDA CAMPO DE SI MANEJA RECURSO PUBLICO*/
  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion =
             'ERROR EN INFORMACION DE MANEJO DE RECURSO PUBLICO.'
             +
             'NIT: '
             + A.mc_id_Alianza
                       + ' CED: ' + A.mc_cedula + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula      = B.mc_cedula
       and A.mc_id_Alianza  = B.mc_id_Alianza
       and A.mc_id_carga    = B.mc_id_carga
       and A.mc_recurso_pub <> null
       and A.mc_recurso_pub not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO SI MANEJA RECURSO PUBLICO.'
  goto ERROR_FIN
end

  --insert into cob_credito..seguim values ( 28, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_recurso_pub not in ('S', 'N')

  /*VALIDA CAMPO DE SI MANEJA INFLUENCIA*/
  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'INFLUENCIA NO EXISTE. ' + 'NIT: ' +
                              A.mc_id_Alianza
                              +
                              ' CED: '
                              + A.mc_cedula +
                              ' TIPO: '
                       + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_influencia <> null
       and A.mc_influencia not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO SI MANEJA INFLUENCIA.'
  goto ERROR_FIN
end

  --insert into cob_credito..seguim values ( 29, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_influencia not in ('S', 'N')

  --insert into cob_credito..seguim values ( 30, getdate(), 'xxx' )

  /*VALIDA CAMPO DE SI MANEJA PERSONA PUBLICA*/
  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion =
             'ERROR EN INFORMACION DE MANEJO DE PERSONA PUBLICA. '
             + 'NIT: '
             +
             A.mc_id_Alianza
                       + ' CED: ' + A.mc_cedula + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula      = B.mc_cedula
       and A.mc_id_Alianza  = B.mc_id_Alianza
       and A.mc_id_carga    = B.mc_id_carga
       and A.mc_persona_pub <> null
       and A.mc_persona_pub not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO SI MANEJA PERSONA PUBLICA.'
  goto ERROR_FIN
end

  --insert into cob_credito..seguim values ( 31, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_persona_pub not in ('S', 'N')

  /*VALIDA CAMPO DE SI ES VICTIMA DE HECHOS VIOLENTOS*/
  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,me_descripcion = 'ERROR INFORMACION DE MANEJO DE VICTIMA.' + 'NIT: ' +
                        A.mc_id_Alianza
      + ' CED: '
                       + A.mc_cedula + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_victima    <> null
       and A.mc_victima not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO SI ES VICTIMA DE HECHOS VIOLENTOS.'
  goto ERROR_FIN
end

  --insert into cob_credito..seguim values ( 32, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_victima not in ('S', 'N')

  --insert into cob_credito..seguim values ( 33, getdate(), 'xxx' )

  /*VALIDA EXISTENCIA DE TIPO DE DIRECCION*/
  select
    c.codigo codigo
  into   #codigo_tdir
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_tdireccion'
     and c.estado = 'V'

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'TIPO DE DIRECCION NO EXISTE.' + 'NIT: ' +
                              A.mc_id_Alianza +
                              ' CED: ' +
                              A.mc_cedula
      + ' TIPO: '
                       + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_tipo not in (select
                               codigo
                             from   #codigo_tdir)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
      'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DIRECCION NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 34, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_tipo not in (select
                               codigo
                             from   #codigo_tdir)

  --insert into cob_credito..seguim values ( 35, getdate(), 'xxx' )

  /**********VALIDA CAMPO DE SI ES O NO DIR PRINCIPAL*/
  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'ERROR INFORMACION DE DIRECCION PRINCIPAL.' +
                              'NIT: '
                              +
                              A.mc_id_Alianza
      +
                              ' CED: '
                       + A.mc_cedula + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_principal  <> null
       and A.mc_principal not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO SI ES O NO DIR PRINCIPAL.'
  goto ERROR_FIN
end

  --insert into cob_credito..seguim values ( 36, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_principal not in ('S', 'N')

  --insert into cob_credito..seguim values ( 37, getdate(), 'xxx' )
  ----------------------------------------
  /*VAlIDA LA OFICINA DE LA CIUDAD DE DOMICILIO*/
  select
    ari_cod_oficina,
    ari_cod_ciudad
  into   #area_influ
  from   #cl_plano_tmp A,
         cobis..cl_area_influencia
  where  ari_cod_ciudad = A.mc_ciudad

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion =
             'ERROR INFORMACION OFICINA DIRECCION DE DOMICILIO. '
             +
             'NIT: '
             + A.mc_id_Alianza
                       + ' CED: ' + A.mc_cedula + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_ciudad in
           (select
              ci_ciudad
            from   cobis..cl_ciudad)
       and A.mc_ofi in
           (select
              of_oficina
            from   cobis..cl_oficina)
       --and   A.mc_ofi   not in(select ari_cod_oficina from cobis..cl_area_influencia where ari_cod_ciudad = A.mc_ciudad)
       and A.mc_ofi not in (select
                              ari_cod_oficina
                            from   #area_influ
                            where  ari_cod_ciudad = A.mc_ciudad)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR EN TABLA DE ERROR POR OFICINA DE CIUDAD DE DOMICILIO NO EXISTENTE.'
  goto ERROR_FIN
end

  --insert into cob_credito..seguim values ( 38, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_ciudad in
             (select
                ci_ciudad
              from   cobis..cl_ciudad)
         and mc_ofi in
             (select
                of_oficina
              from   cobis..cl_oficina)
         --and    mc_ofi not in(select ari_cod_oficina from cobis..cl_area_influencia where ari_cod_ciudad = mc_ciudad)
         and mc_ofi not in(select
                             ari_cod_oficina
                           from   #area_influ
                           where  ari_cod_ciudad = mc_ciudad)

  --select * from #cl_plano_tmp

  ----------------------------------------------

  --insert into cob_credito..seguim values ( 39, getdate(), 'xxx' )

  /*VAlIDA LA CIUDAD DE DOMICILIO*/
  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'ERROR INFORMACION DIRECCION DE DOMICILIO.' +
                              'NIT: '
                              +
                              A.mc_id_Alianza
      +
                              ' CED: '
                       + A.mc_cedula + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_ciudad not in (select
                                 ci_ciudad
                               from   cobis..cl_ciudad)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR EN TABLA DE ERROR POR CIUDAD DE DOMICILIO NO EXISTENTE.'
goto ERROR_FIN
end

  --insert into cob_credito..seguim values ( 40, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_ciudad not in (select
                                 ci_ciudad
                               from   cobis..cl_ciudad)

  /*VALIDA DIRECCION RURAL O URBANO*/
  select
    c.codigo codigo
  into   #codigo_tparr
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_tparroquia'
     and c.estado = 'V'

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion =
             'INFORMACION INCONSISTENTE, TIPO DIRECCION NO EXISTE. ' +
             'NIT: ' +
             A.mc_id_Alianza
                       + ' CED: ' + A.mc_cedula + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_rural_urb not in (select
                                    codigo
                                  from   #codigo_tparr)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
      'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DIRECCION NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 41, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_rural_urb not in (select
                                    codigo
                                  from   #codigo_tparr)

  /*VALIDA EXISTENCIA DE CATALOGO TIPO TELEFONO*/
  select
    c.codigo codigo
  into   #codigo_tel
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_ttelefono'
     and c.estado = 'V'

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'TIPO TELEFONO NO EXISTE' + 'NIT: ' +
                              A.mc_id_Alianza
                              +
                              ' CED: ' + A.mc_cedula +
                              ' TIPO: '
                       + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_tipo_telefono not in (select
                                        codigo
                                      from   #codigo_tel)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO TELEFONO NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 42, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_carga in
             (select
                a.mc_id_carga
              from   #msv_alianza a)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_tipo_telefono not in (select
                                        codigo
                                      from   #codigo_tel)

  --insert into cob_credito..seguim values ( 43, getdate(), 'xxx' )

  /*VALIDA LONGITUD DE TELEFONO*/
  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'LONGITUD DE TELEFONO NO VALIDO. ' + 'NIT: ' +
                              A.mc_id_Alianza
                              + ' CED: ' +
                              A.mc_cedula
                       + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula        = B.mc_cedula
       and A.mc_id_Alianza    = B.mc_id_Alianza
       and A.mc_id_carga      = B.mc_id_carga
       and A.mc_tipo_telefono is not null
       and A.mc_valor is not null
       and (A.mc_tipo_telefono = 'C'
            and len(A.mc_valor)    <> 10)
        or (A.mc_tipo_telefono = 'D'
            and len(A.mc_valor)    <> 7)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR LONGITUD DE TELEFONO DE CELULAR INVAlIDO.'
  goto ERROR_FIN
end

  --insert into cob_credito..seguim values ( 44, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and (mc_tipo_telefono = 'C'
              and len(mc_valor)    <> 10)
          or (mc_tipo_telefono = 'D'
              and len(mc_valor)    <> 7)

  /*VALIDA MERCADO OBJETIVO*/
  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'INFORMACION INCONSISTENTE, MERCADO OBJETIVO.' +
                              'NIT: ' +
                              A.mc_id_Alianza
      +
                              ' CED: '
                       + A.mc_cedula + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_mercado_objetivo not in (select
                                           codigo
                                         from   #codigo_tparr)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
      'ERROR AL INSERTAR LA TABLA DE ERROR POR MERCADO OBJETIVO NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 45, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_mercado_objetivo not in (select
                                           codigo
                                         from   #codigo_tparr)

  --insert into cob_credito..seguim values ( 46, getdate(), 'xxx' )

  /*VALIDA SUBTIPO MERCADO*/
  select
    c.codigo codigo
  into   #codigo_sub_mer
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_subtipo_mercado'
     and c.estado = 'V'

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'INFORMACION INCONSISTENTE, SUBTIPO MERCADO.' +
                              'NIT: ' +
                              A.mc_id_Alianza
      +
                              ' CED: '
                       + A.mc_cedula + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_subtipo_mo not in (select
                                     codigo
                                   from   #codigo_sub_mer)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR SUBTIPO MERCADO NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 47, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_subtipo_mo not in (select
                                     codigo
                                   from   #codigo_sub_mer)

  --insert into cob_credito..seguim values ( 48, getdate(), 'xxx' )

  /*VALIDA BANCA*/
  select
    c.codigo codigo
  into   #codigo_ban_cli
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_banca_cliente'
     and c.estado = 'V'

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'INFORMACION INCONSISTENTE, BANCA NO EXISTE.' +
                              'NIT: ' +
                              A.mc_id_Alianza
      +
                              ' CED: '
                       + A.mc_cedula + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_banca not in (select
                                codigo
                              from   #codigo_ban_cli)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR POR BANCA NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 49, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_banca not in (select
                                codigo
                              from   #codigo_ban_cli)

  ------------------ INICIO: ASOCIACION ENTRE MERCADO OBJETIVO Y BANCA  -----------
  --insert into cob_credito..seguim values ( 50, getdate(), 'xxx' )

  /*VALIDA ASOCIACION ENTRE MERCADO OBJETIVO Y BANCA*/
  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion =
             'NO EXISTE ASOCIACION ENTRE MERCADO OBJETIVO Y BANCA.'
             +
             'NIT: ' +
             A.mc_id_Alianza
                       + ' CED: ' + A.mc_cedula + ' TIPO: ' + A.mc_tipo_ced +
             ' --> Activ:' + A.mc_actividad + ' MerObj:'
                       + A.mc_mercado_objetivo + ' SubTip:' + A.mc_subtipo_mo
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and ltrim(rtrim(A.mc_actividad)) + ltrim(rtrim(A.mc_mercado_objetivo))
           + ltrim(rtrim(A.mc_subtipo_mo)) not in
           (select
               ltrim(rtrim(aa_actividad)) + ltrim(rtrim(aa_mercado)) + ltrim(
               rtrim(
               aa_subtipo
               ))
                                                   from
           cobis..cl_asociacion_actividad)

  if @@error <> 0
  begin
    select
      @w_error = 100218,
      @w_msg = 'NO EXISTE ASOCIACION ENTRE MERCADO OBJETIVO  Y BANCA.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 51, getdate(), 'xxx' )

  delete #cl_plano_tmp
  where  mc_cedula + mc_tipo_ced in
         (select
            A.mc_cedula + A.mc_cedula
          from   #cl_plano_tmp A,
                 #msv_alianza B
          where  A.mc_cedula     = B.mc_cedula
             and A.mc_id_Alianza = B.mc_id_Alianza
             and A.mc_id_carga   = B.mc_id_carga
             and ltrim(rtrim(A.mc_actividad)) +
                 ltrim(rtrim(A.mc_mercado_objetivo))
                 + ltrim(rtrim(A.mc_subtipo_mo)) not in
                 (select
                     ltrim(rtrim(aa_actividad)) + ltrim(rtrim(aa_mercado)) +
                     ltrim
                     (
                     rtrim(
                     aa_subtipo))
                                                         from
                 cobis..cl_asociacion_actividad))

  --insert into cob_credito..seguim values ( 52, getdate(), 'xxx' )

  ------------------ FIN : ASOCIACION ENTRE MERCADO OBJETIVO Y BANCA  -----------

  /*VALIDA SEGMENTO*/
  select
    c.codigo codigo
  into   #codigo_seg
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_segmento'
     and c.estado = 'V'

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,
             me_descripcion = 'INFORMACION INCONSISTENTE, SEGMENTO NO EXISTE.' +
                              'NIT: ' +
                              A.mc_id_Alianza
      +
                              ' CED: '
                       + A.mc_cedula + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_segmento not in (select
                                   codigo
                                 from   #codigo_seg)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR POR SEGMENTO NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 53, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_segmento not in (select
                                   codigo
                                 from   #codigo_seg)

  --insert into cob_credito..seguim values ( 54, getdate(), 'xxx' )

  /*VALIDA SUBSEGMENTO*/
  select
    c.codigo codigo
  into   #codigo_sub_seg
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_sub_segmento'
     and c.estado = 'V'

  insert into #ca_msv_error_aux
    select
      me_fecha = getdate(),me_id_carga = A.mc_id_carga,
      me_id_alianza = isnull(al_alianza,
                             0),me_referencia = A.mc_cedula + '-' +
                                                A.mc_tipo_ced,
      me_tipo_proceso = 'C',
      me_procedimiento = 'sp_msv_valida_neg',me_codigo_interno = 0,
      me_codigo_err = 0
      ,me_descripcion = 'INFORMACION INCONSISTENTE, SUBSEGMENTO NO EXISTE.' +
                        'NIT: ' +
      A.mc_id_Alianza
      + ' CED: ' + A.mc_cedula + ' TIPO: ' + A.mc_tipo_ced
    from   #cl_plano_tmp A,
           #msv_alianza B
    where  A.mc_cedula     = B.mc_cedula
       and A.mc_id_Alianza = B.mc_id_Alianza
       and A.mc_id_carga   = B.mc_id_carga
       and A.mc_subsegmento not in (select
                                      codigo
                                    from   #codigo_sub_seg)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR SUBSEGMENTO NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 55, getdate(), 'xxx' )

  delete from #cl_plano_tmp
  where  mc_id_carga in
         (select
            me_id_carga
          from   #ca_msv_error_aux)
         and mc_id_Alianza in
             (select
                a.mc_id_Alianza
              from   #msv_alianza a)
         and mc_cedula + '-' + mc_tipo_ced in
             (select
                me_referencia
              from   #ca_msv_error_aux)
         and mc_subsegmento not in (select
                                      codigo
                                    from   #codigo_sub_seg)

  --insert into cob_credito..seguim values ( 56, getdate(), 'xxx' )
/*************************************************/
  /*VALIDA CORRESPONDENCIA DE NUMERO CEDULA Y SEXO */
  select
    carga = mc_id_carga,
    id_ali = mc_id_Alianza,
    tipo_ced = mc_tipo_ced,
    cedula = mc_cedula,
    sexo = mc_sexo
  into   #cl_Cedu_Vs_Sex
  from   #cl_plano_tmp

  if @w_debug = 'S'
    print '01'

  if @w_debug = 'S'
    select
      *
    from   #cl_Cedu_Vs_Sex

  while exists (select
                  1
                from   #cl_Cedu_Vs_Sex)
  begin
    if @w_debug = 'S'
      print '02'

    select
      @w_mc_id_carga = null
    select
      @w_mc_id_Alianza = null
    select
      @w_mc_tipo_ced = null
    select
      @w_mc_cedula = null
    select
      @w_mc_sexo = null
    select
      @w_return = 0
    select
      @w_mensaje = null
    select
      @w_retorno = null

    set rowcount 1
    select
      @w_mc_id_carga = carga,
      @w_mc_id_Alianza = id_ali,
      @w_mc_tipo_ced = tipo_ced,
      @w_mc_cedula = cedula,
      @w_mc_sexo = sexo
    from   #cl_Cedu_Vs_Sex
    set rowcount 0

    if @w_debug = 'S'
      print '03'

    delete #cl_Cedu_Vs_Sex
    where  @w_mc_id_carga   = carga
       and @w_mc_id_Alianza = id_ali
       and @w_mc_tipo_ced   = tipo_ced
       and @w_mc_cedula     = cedula
       and @w_mc_sexo       = sexo

    if @@error <> 0
    begin
      select
        @w_error = 201242,
        @w_msg = 'ERROR AL VERIFICAR RELACION NUMERO CEDULA vs SEXO.'
      goto ERROR_FIN
    end

    if @w_debug = 'S'
      print '04'

    exec @w_return = sp_val_doc
      @t_trn              = 1116,
      @i_numero_documento = @w_mc_cedula,
      @i_tipo_documento   = @w_mc_tipo_ced,
      @i_sexo             = @w_mc_sexo,
      @i_subtipo          = 'P',
      @i_tram_ext         = 'S',
      @o_mensaje          = @w_mensaje out,
      @o_retorno          = @w_retorno out

    if @@error <> 0
    begin
      select
        @w_error = 201242,
        @w_msg = 'ERROR AL VERIFICAR RELACION NUMERO CEDULA vs SEXO..'
      goto ERROR_FIN
    end

    if @w_debug = 'S'
      print '05'

    if @w_return > 0
    begin
      if @w_debug = 'S'
        print '06'

      select
        @w_id_alianza = isnull(al_alianza,
                               0)
      from   #cl_plano_tmp A,
             #msv_alianza B
      where  A.mc_cedula     = B.mc_cedula
         and A.mc_id_Alianza = B.mc_id_Alianza
         and A.mc_id_carga   = B.mc_id_carga
         and B.mc_cedula     = @w_mc_cedula

      /*VALIDA NRO CEDULA VS SEXO */
      insert into #ca_msv_error_aux
                  (me_fecha,me_id_carga,me_id_alianza,me_referencia,
                   me_tipo_proceso,
                   me_procedimiento,me_codigo_interno,me_codigo_err,
                   me_descripcion
      )
      values      ( getdate(),@w_mc_id_carga,@w_id_alianza,@w_mc_cedula + '-' +
                    @w_mc_tipo_ced,'C',
                    'sp_msv_valida_neg',0,0,@w_mensaje )

      if @@error <> 0
      begin
        select
          @w_error = 201242,
          @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR Nro. CEDULA Vs SEXO.'
        goto ERROR_FIN
      end

      if @w_debug = 'S'
        print '07'

      delete #cl_plano_tmp
      where  mc_id_carga   = @w_mc_id_carga
         and mc_id_Alianza = @w_mc_id_Alianza
         and mc_tipo_ced   = @w_mc_tipo_ced
         and mc_cedula     = @w_mc_cedula
         and mc_sexo       = @w_mc_sexo

      if @w_debug = 'S'
        print '08'

    end

    -- VALIDACION CLIENTE NO OBJETIVO
    if @w_return = 0
    begin
      select
        @w_mensaje = null
      exec @w_return = cobis..sp_ente_bloqueado
        @s_ofi       = 1,
        @t_trn       = 175,
        @i_operacion = 'F',
        --@i_tipo     = 'V',
        @i_ced_ruc   = @w_mc_cedula,
        --codigo de transaccion
        @i_canal     = '001',
        @i_tipo_id   = @w_mc_tipo_ced,
        @i_numero_id = @w_mc_cedula,
        @i_crea_ext  = 'S',
        @o_mensaje   = @w_mensaje out

      if @w_mensaje is not null
      begin
        select
          @w_id_alianza = isnull(al_alianza,
                                 0)
        from   #cl_plano_tmp A,
               #msv_alianza B
        where  A.mc_cedula     = B.mc_cedula
           and A.mc_id_Alianza = B.mc_id_Alianza
           and A.mc_id_carga   = B.mc_id_carga
           and B.mc_cedula     = @w_mc_cedula

        select
          @w_mensaje = @w_mensaje + '. Alianza: ' + isnull(convert( varchar(30),
                       @w_id_alianza)
                       ,
                       ''
                       )
                                                                      +
                                                                      ' CED: '
                       + isnull(@w_mc_cedula, '') + ' TIPO: ' + isnull(
                       @w_mc_tipo_ced
                       ,
                       ''
                                                                      )

        /*VALIDA NRO CEDULA VS SEXO */
        insert into #ca_msv_error_aux
                    (me_fecha,me_id_carga,me_id_alianza,me_referencia,
                     me_tipo_proceso,
                     me_procedimiento,me_codigo_interno,me_codigo_err,
                     me_descripcion
        )
        values      ( getdate(),@w_mc_id_carga,@w_id_alianza,@w_mc_cedula + '-'
                      +
                      @w_mc_tipo_ced,'C',
                      'sp_msv_valida_neg',0,0,@w_mensaje )

        if @@error <> 0
        begin
          select
            @w_error = 201242,
            @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR CLIENTE NO OBJETIVO.'
          goto ERROR_FIN
        end

        delete #cl_plano_tmp
        where  mc_id_carga   = @w_mc_id_carga
           and mc_id_Alianza = @w_mc_id_Alianza
           and mc_tipo_ced   = @w_mc_tipo_ced
           and mc_cedula     = @w_mc_cedula
           and mc_sexo       = @w_mc_sexo
      end
    end
  end

  insert into cobis..ca_msv_error
    select
      *
    from   #ca_msv_error_aux
  --insert into cob_credito..seguim values ( 57, getdate(), 'xxx' )

  /*******INSERCION A TABLA FISICA*******/
  insert into cl_msv_crear with (rowlock)
    select
      mc_id_carga = A.mc_id_carga,mc_id_Alianza = b.al_alianza,mc_ofi = A.mc_ofi
      ,
      mc_nombre = A.mc_nombre,mc_p_apelLIdo = A.mc_p_apellido,
      mc_s_apelLIdo = A.mc_s_apellido,mc_sexo = A.mc_sexo,mc_fecha_nac =
      A.mc_fecha_nac,mc_tipo_ced = A.mc_tipo_ced,mc_cedula = A.mc_cedula,
      mc_ciudad_nac = A.mc_ciudad_nac,mc_lugar_doc = A.mc_lugar_doc,
      mc_estado_civil
      = A.mc_estado_civil,mc_actividad = A.mc_actividad,mc_fecha_emision =
      A.mc_fecha_emision,
      mc_sector = A.mc_sector,mc_tipo_productor = A.mc_tipo_productor,
      mc_regimen_fiscal = A.mc_regimen_fiscal,mc_antiguedad = A.mc_antiguedad,
      mc_estrato = A.mc_estrato,
      mc_recurso_pub = A.mc_recurso_pub,mc_influencia = A.mc_influencia,
      mc_persona_pub = A.mc_persona_pub,mc_victima = A.mc_victima,mc_descripcion
      =
      A.mc_descripcion,
      mc_tipo = A.mc_tipo,mc_principal = A.mc_principal,mc_ciudad = A.mc_ciudad,
      mc_rural_urb = A.mc_rural_urb,mc_observacion = A.mc_observacion,
      mc_valor = A.mc_valor,mc_tipo_telefono = A.mc_tipo_telefono,
      mc_origen_fondos = A.mc_origen_fondos,mc_mercado_objetivo =
      A.mc_mercado_objetivo,mc_subtipo_mo = A.mc_subtipo_mo,
      mc_banca = A.mc_banca,mc_segmento = A.mc_segmento,mc_subsegmento =
      A.mc_subsegmento
    from   #cl_plano_tmp A,
           #msv_alianza b
    where  A.mc_id_carga   = b.mc_id_carga
       and A.mc_id_Alianza = b.mc_id_Alianza
       and A.mc_cedula     = b.mc_cedula

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR EN LA TABLA FISICA.'
    goto ERROR_FIN
  end

  --insert into cob_credito..seguim values ( 58, getdate(), 'xxx' )

  return 0

  ERROR_FIN:

  insert into cobis..ca_msv_error
    select
      *
    from   #ca_msv_error_aux

  select
    ' sp_msv_valida_neg ENTRO EN ERROR_FIN.'
  return 1

go

