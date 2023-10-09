/************************************************************************/
/*   Archivo            : cl_consextc12.sp                              */
/*   Stored procedure   : sp_consulta_extracto_c12                      */
/*   Base de datos      : cobis                                         */
/*   Producto           : CLIENTES                                      */
/*   Disenado por       : Harvey Montes                                 */
/*   Fecha de escritura : 2013/02/15                                    */
/************************************************************************/
/*                        IMPORTANTE                                    */
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
/*                        PROPOSITO                                     */
/*   Consulta de informacion para extractos de costos                   */
/*   financieros de clientes                                            */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*   FECHA                AUTOR              RAZON                      */
/*   2013/02/21           Harvey Montes      Emision Inicial            */
/*   2013/10/21           Luis C. Moreno     364-Alc. Circular 12       */
/*   2016/05/02           DFu                Migracion CEN              */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER on
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_consulta_extracto_c12')
  drop proc sp_consulta_extracto_c12
go

create proc sp_consulta_extracto_c12
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_date         datetime = null,
  @s_ofi          smallint = null,
  @t_show_version bit = 0,
  @i_ano_genera   int = null,
  @i_cliente      int = null,
  @i_operacion    char(1) = null,
  @i_envio        char(1) = 'I',
  @i_tipo         char(1) = 'I',
  @i_secuencia    int = null,
  @i_correo       varchar(255) = null
)
as
  declare
    @w_sp_name    varchar(30),
    @w_return     int,
    @w_error      int,
    @w_msg        varchar(255),
    @w_sec_tmp    int,
    @w_s_app      varchar(255),
    @w_path_plano varchar(255),
    @w_server     varchar(50),
    @w_errores    varchar(255),
    @w_cmd        varchar(255),
    @w_comando    varchar(500),
    @w_fec_proc   datetime,
    @w_servidor   varchar(10),
    @w_debug      char(1),
    @w_query      varchar(255),
    @w_fec_ini    datetime,
    @w_fec_fin    datetime,
    @w_FtpServer  varchar(50),
    @w_tmpfile    varchar(100),
    @w_passcryp   varchar(255),
    @w_login      varchar(255),
    @w_password   varchar(255),
    @w_nomb_prod  varchar(64),
    @w_nro_prod   varchar(40),
    @w_nom_pro    varchar(64),
    @w_num_pro    varchar(40),
    @w_max        int,
    @w_min        int,
    @w_forma_ex   char(1),
    @w_codigo     int,
    @w_cd_cliente int

  set ANSI_NULLS on
  set ANSI_WARNINGS on

  select
    @w_sp_name = 'sp_consulta_extracto_c12'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Asignacion de Variables */

  select
    @w_debug = 'N'

  /* PARAMETRO GENERAL SERVIDOR HISTORICOS*/
  select
    @w_servidor = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'CCA'
     and pa_nemonico = 'SRVHIS'

  if @i_cliente is null
  begin
    select
      @w_error = 2006018,
      @w_msg = 'EL CODIGO DEL CLIENTE ES DATO OBLIGATORIO'
    goto ERROR
  end

  if @w_debug = 'S'
  begin
    print 'SERVIDOR: ' + @w_servidor
  end

  create table #catalogo
  (
    aplicativo   int not null,
    benef        char(1) not null,
    concepto_des varchar(64) not null
  )

  /* LLENADO TABLAS TEMPORALES CON LA PARAMETRIZACION EN CATALOGOS */
  insert into #catalogo
    select distinct
      aplicativo = right(a.tabla,
                         charindex('_',
                                                 reverse(a.tabla)) - 1),benef =
      substring(b.valor,
                        1,
                        1),concepto_des = substring(b.valor,
                               3,
                               1000)
    from   cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  a.tabla like 'exco_conceptos_aplica_%'
       and b.tabla  = a.codigo
       and b.estado = 'V'

  if isnull(@w_servidor,
            '') <> 'NOHIST'
     and isnull(@i_secuencia,
                0) = 0
  begin
    delete cob_conta_super..sb_datos_cobro
    where  dc_cliente = @i_cliente
       and dc_year    = @i_ano_genera
    delete cob_conta_super..sb_datos_cobro_det
    where  cd_cliente = @i_cliente
       and cd_year    = @i_ano_genera

    select
      @w_comando = 'insert into cob_conta_super..sb_datos_cobro select * from '
                   +
                                                              @w_servidor
                   + '.cob_conta_super.dbo.sb_datos_cobro where dc_cliente ='
                   + convert(varchar, @i_cliente) + ' and  dc_year=' + convert(
                                                              varchar,
                   @i_ano_genera
                   )
    exec @w_error = sp_sqlexec
      @w_comando

    select
      @w_comando =
      'insert into cob_conta_super..sb_datos_cobro_det select * from '
      +
                            @w_servidor
      + '.cob_conta_super.dbo.sb_datos_cobro_det where cd_cliente='
      + convert(varchar, @i_cliente) + ' and  cd_year=' + convert(
                            varchar, @i_ano_genera)
    exec @w_error = sp_sqlexec
      @w_comando
  end

  select
    *
  into   #sb_datos_cobro
  from   cob_conta_super.dbo.sb_datos_cobro
  where  1 = 2

  ---SE CARGAN PREVIAENTE POR SI NO SE CARGAN DESPUES
  select
    @w_fec_ini = '01/01/' + convert(varchar, @i_ano_genera)
  select
    @w_fec_fin = '12/31/' + convert(varchar, @i_ano_genera)

  insert into #sb_datos_cobro
    select
      *
    from   cob_conta_super.dbo.sb_datos_cobro
    where  dc_cliente = @i_cliente
       and dc_year    = @i_ano_genera

  if @@rowcount = 0
  begin
    /* FECHA INICIAL PARA LA GENERACION DE EXTRACTO */
    if @i_ano_genera = 2012
      select
        @w_fec_ini = '07/01/' + convert(varchar, @i_ano_genera)
    else
      select
        @w_fec_ini = '01/01/' + convert(varchar, @i_ano_genera)

    /* FECHA INICIAL PARA LA GENERACION DE EXTRACTO */
    select
      @w_fec_fin = '12/31/' + convert(varchar, @i_ano_genera)

    insert into #sb_datos_cobro
      select
        @i_cliente,@i_ano_genera,@s_date,@w_fec_ini,@w_fec_fin,
        isnull(en_oficina_prod,
               en_oficina),en_tipo_ced,en_ced_ruc
      from   cobis..cl_ente
      where  en_ente = @i_cliente

  end

  select
    *
  into   #sb_datos_cobro_det
  from   cob_conta_super.dbo.sb_datos_cobro_det
  where  1 = 2

  insert into #sb_datos_cobro_det
    select
      *
    from   cob_conta_super.dbo.sb_datos_cobro_det
    where  cd_cliente   = @i_cliente
       and cd_year      = @i_ano_genera
       and cd_vlr_cobro > 0

  select
    @w_cd_cliente = cd_cliente
  from   #sb_datos_cobro_det
  where  cd_cliente = @i_cliente
     and cd_year    = @i_ano_genera
  if @@rowcount = 0
  begin ---EN ESTA PARTE PONEN LOS PRODUCTOS UNICAMENTE
    insert into #sb_datos_cobro_det
      select
        cl_cliente,@i_ano_genera,0,dp_producto,substring(pd_descripcion,
                  1,
                  30),
        dp_cuenta,'',0,'B'
      from   cobis..cl_cliente,
             cobis..cl_det_producto,
             cobis..cl_producto
      where  cl_det_producto = dp_det_producto
         and dp_producto     = pd_producto
         and dp_fecha        <= @w_fec_fin
         and cl_rol in ('T', 'C', 'D')
         and cl_cliente      = @i_cliente
         and dp_estado_ser   <> 'X'
      order  by dp_producto,
                dp_cuenta
  end

  if @w_debug = 'S'
    print ' @w_fec_ini ' + cast ( @w_fec_ini as varchar) + ' @w_fec_fin : '
          + cast ( @w_fec_fin as varchar)

  delete #sb_datos_cobro_det
  from   cob_ahorros..ah_cuenta
  where  cd_producto      = 4
     and cd_nro_prod      = ah_cta_banco
     and ah_estado        = 'C'
     and ah_fecha_ult_mov < @w_fec_ini

  delete #sb_datos_cobro_det
  from   cob_pfijo..pf_operacion
  where  cd_producto      = 14
     and cd_nro_prod      = op_num_banco
     and op_estado        = 'CAN'
     and op_fecha_cancela < @w_fec_ini

  delete #sb_datos_cobro_det
  from   cob_cartera..ca_operacion
  where  cd_producto          = 7
     and cd_nro_prod          = op_banco
     and op_estado            = 3
     and op_fecha_ult_proceso < @w_fec_ini

  --ELIMINA OPERACIONES CASTIGADAS
  select distinct
    producto = cd_producto,
    banco = cd_nro_prod
  into   #borrar_castigos
  from   #sb_datos_cobro_det,
         cob_cartera..ca_transaccion with (nolock),
         cob_cartera..ca_operacion with (nolock)
  where  tr_banco     = cd_nro_prod
     and op_banco     = tr_banco
     and tr_tran      = 'CAS'
     and tr_estado    <> 'RV'
     and op_estado    = 4
     and cd_producto  = 7
     and (tr_fecha_ref < @w_fec_ini
           or tr_fecha_ref > @w_fec_fin)

  insert into #borrar_castigos
    select distinct
      producto = cd_producto,banco = cd_nro_prod
    from   #sb_datos_cobro_det,
           cob_cartera..ca_transaccion_bancamia with (nolock),
           cob_cartera..ca_operacion with (nolock)
    where  tr_banco     = cd_nro_prod
       and tr_banco     = op_banco
       and tr_tran      = 'CAS'
       and tr_estado    <> 'RV'
       and op_estado    = 4
       and cd_producto  = 7
       and (tr_fecha_ref < @w_fec_ini
             or tr_fecha_ref > @w_fec_fin)

  insert into #borrar_castigos
    select
      producto = 7,banco = op_banco
    from   #sb_datos_cobro_det,
           cob_cartera..ca_operacion with (nolock)
    where  op_toperacion in ('ALT_FNG', 'BALIQCPAS', 'BAPROGRPAS')
       and cd_nro_prod = op_banco
       and cd_producto = 7

  --ELIMINA OPERACIONES CASTIGADAS
  delete #sb_datos_cobro_det
  from   #borrar_castigos
  where  producto    = cd_producto
     and banco       = cd_nro_prod
     and cd_producto = 7

  if @i_operacion = 'P'
  begin
    if not exists(select
                    1
                  from   #sb_datos_cobro,
                         cobis..cl_forma_extractos
                  where  dc_cliente       = fe_cliente
                     and fe_forma_entrega <> 'C')
    begin
      select
        @w_error = 2006019,
        @w_msg = 'NO HAY INFORMACION PARA EXTRACTOS POR E-MAIL'
      goto ERROR
    end
  end
  ---MASCARA DE PRODUCTO
  update #sb_datos_cobro_det
  set    cd_nro_prod = right(replicate('X', 12) + substring(cd_nro_prod, len(
                             rtrim(
                                    cd_nro_prod))-3, 4
                                                  ),
                             12)
  where  cd_cliente = @i_cliente
     and cd_year    = @i_ano_genera

  if @@error <> 0
  begin
    select
      @w_error = 2006015,
      @w_msg = 'ERROR AL ENMASCARAR LOS PRODUCTOS EN UNO DE LOS REGISTROS'
    goto ERROR
  end

  /* Elaborar operaci½n para consulta Individual */
  if @i_operacion = 'C'
  begin
    if not exists(select
                    1
                  from   #sb_datos_cobro_det
                  where  cd_year    = @i_ano_genera
                     and cd_cliente = @i_cliente)
    begin
      select
        @w_error = 2006013,
        @w_msg = 'NO HAY INFORMACION PARA EXTRACTOS'
      goto ERROR
    end

    if @i_envio in ('D', 'C')
    -- Extraccion de Datos para Impresion o Archivo Plano
    begin
      delete cob_conta_super..tmp_plano_extcob_linea
      where  pe_user    = @s_user
         and pe_cliente = @i_cliente

      if @@error <> 0
      begin
        select
          @w_error = 708155,
          @w_msg = 'ERROR AL BORRAR TABLA DE PLANOS DE EXTRACTOS'
        goto ERROR
      end

      create table #datos_cliente
      (
        en_ente        int not null,
        ti_oficina     smallint null,
        ti_nombre      descripcion null,
        en_nomlar      varchar(254) null,
        ti_descripcion descripcion null,
        ti_parroquia   smallint null,
        qt_descripcion descripcion null,
        ti_ciudad      int null,
        ct_descripcion descripcion null,
        ti_provincia   smallint null,
        pt_descripcion descripcion null
      )

      if @@error <> 0
      begin
        select
          @w_error = 703105,
          @w_msg = 'ERROR EN LA CREACION DE LA TABLA TEMPORAL #datos_cliente'
        goto ERROR
      end

      insert into #datos_cliente
        select
          en_ente = en_ente,ti_oficina = @s_ofi,ti_nombre = 'S/D',
          en_nomlar = en_nomlar,
          ti_descripcion = 'S/D',
          ti_parroquia = null,qt_descripcion = 'S/D',ti_ciudad = null,
          ct_descripcion = 'S/D',ti_provincia = null,
          pt_descripcion = 'S/D'
        from   cobis..cl_ente
        where  en_ente = @i_cliente

      if @@error <> 0
      begin
        select
          @w_msg =
  'ERROR EN LA INSERCION DE REGISTROS EN  LA TABLA TEMPORAL #datos_cliente'
  goto ERROR
  end

  if @i_tipo = 'I'
  begin
  select
  @w_forma_ex = '',
  @w_codigo = 0

  /* OBTIENE LA FORMA DE ENVIO DE EXTRACTO ASOCIADA AL CLIENTE */
  select
  @w_forma_ex = fe_forma_entrega,
  @w_codigo = fe_codigo
  from   cl_forma_extractos
  where  fe_cliente = @i_cliente

  if @@rowcount = 0
    or @w_forma_ex <> 'D'
  select
    @w_codigo = 0

  if @w_codigo = 0
  /* BUSCA DIRECCION DE NEGOCIO */
  select top 1
    @w_codigo = di_direccion
  from   cobis..cl_direccion
  where  di_ente = @i_cliente
     and di_tipo = '011'

  if @w_codigo = 0
  /* BUSCA DIRECCION PRINCIPAL */
  select
    @w_codigo = di_direccion
  from   cobis..cl_direccion
  where  di_ente      = @i_cliente
     and di_tipo      <> '001'
     and di_principal = 'S'

  if @w_codigo = 0
  /* BUSCA DIRECCION DE RESIDENCIA */
  select top 1
    @w_codigo = di_direccion
  from   cobis..cl_direccion
  where  di_ente = @i_cliente
     and di_tipo = '002'

  if @w_codigo = 0
  /* BUSCA DIRECCION DEL CLIENTE DIFERENTE A CORREO ELECTRONICO */
  select top 1
    @w_codigo = di_direccion
  from   cobis..cl_direccion
  where  di_ente = @i_cliente
     and di_tipo <> '001'

  if @w_codigo = 0
  if @@rowcount = 0
  begin
    select
      @w_error = 101059,
      @w_msg = 'NO EXISTE DIRECCION PRINCIPAL O DE ENVIO DE EXTRACTO'
    goto ERROR
  end

  /* ACTUALIZA LOS DATOS DE LA DIRECCION */
  update #datos_cliente
  set    ti_descripcion = di_descripcion,
       ti_ciudad = di_ciudad,
       ti_parroquia = di_parroquia,
       ti_provincia = di_provincia,
       qt_descripcion = case di_rural_urb
                          when 'R' then di_barrio
                          else (select
                                  pq_descripcion
                                from   cobis..cl_parroquia
                                where  pq_parroquia = di_parroquia
                                   and pq_ciudad    = di_ciudad)
                        end
  from   cobis..cl_direccion
  where  en_ente      = di_ente
   and di_direccion = @w_codigo

  if @@rowcount = 0
  begin
  select
    @w_error = 101059,
    @w_msg = 'NO EXISTE DIRECCION PRINCIPAL O DE ENVIO DE EXTRACTO'
  goto ERROR
  end

  update #datos_cliente
  set    ct_descripcion = ci_descripcion
  from   cobis..cl_ciudad
  where  ci_ciudad = ti_ciudad

  if @@rowcount = 0
  begin
  select
    @w_error = 1901007,
    @w_msg = 'ERROR AL ACTUALIZAR CIUDAD EN TABLA TEMPORAL #datos_cliente'
  goto ERROR
  end

  end
  if @i_envio = 'C'
  begin
  update #datos_cliente
  set    ti_descripcion = @i_correo

  if @@rowcount = 0
  begin
  select
    @w_error = 100211,
    @w_msg = 'NO EXISTE CORREO ELECTRONICO'
  goto ERROR
  end

  end

  update #datos_cliente
  set    ti_nombre = of_nombre
  from   cobis..cl_oficina
  where  of_oficina = ti_oficina

  if @@rowcount = 0
  begin
  select
  @w_error = 1901007,
  @w_msg =
  'ERROR AL ACTUALIZAR NOMBRE OFICINA EN TABLA TEMPORAL #datos_cliente'
  goto ERROR
  end

  update #datos_cliente
  set    pt_descripcion = pv_descripcion
  from   cobis..cl_provincia
  where  pv_provincia = ti_provincia

  if @@rowcount = 0
  begin
  select
  @w_error = 1901007,
  @w_msg = 'ERROR AL ACTUALIZAR PROVINCIA EN TABLA TEMPORAL #datos_cliente'
  goto ERROR
  end

  /* Llenado de los datos en temporal: */
  insert into cob_conta_super..tmp_plano_extcob_linea
          (pe_secuencia,pe_fecha_gen,pe_oficina,pe_nombre_ofi,pe_fecha_ini,
           pe_fecha_fin,pe_cliente,pe_identifica,pe_nombre,pe_direccion,
           pe_barrio,pe_nomb_barrio,pe_ciudad,pe_nomb_ciud,pe_depto,
           pe_nomb_depto,pe_nomb_prod,pe_nro_prod,pe_concepto,pe_val_bco,
           pe_val_ter,pe_nomb_pdf,pe_user,pe_ssn)
  select
  1,convert(varchar, dc_fecha_gen, 103),dc_oficina,ti_nombre,
  convert(varchar, dc_fec_inicio, 103),
  convert(varchar, dc_fec_final, 103),dc_cliente,dc_num_doc,en_nomlar,
  ti_descripcion,
  ti_parroquia,qt_descripcion,ti_ciudad,ct_descripcion,ti_provincia,
  pt_descripcion,cd_nomb_prd,cd_nro_prod,cd_concepto,case cd_a_favor
    when 'B' then cd_vlr_cobro
    else 0
  end,
  case cd_a_favor
    when 'T' then cd_vlr_cobro
    else 0
  end,case @i_tipo
    when 'I' then null
    else ('extcob_' + dc_num_doc + convert(varchar(20), dc_year) + '.pdf')
  end,@s_user,@s_ssn
  from   #sb_datos_cobro_det,
       #sb_datos_cobro,
       #datos_cliente
  order  by cd_nomb_prd,
          cd_nro_prod,
          cd_concepto

  if @@error <> 0
  begin
  select
  @w_error = 2006014,
  @w_msg = 'ERROR AL LLENAR LA ESTRUCTURA TEMPORAL PARA LOS PLANOS'
  goto ERROR
  end

  /* Generar los consecutivos */

  select
  @w_sec_tmp = 0

  update cob_conta_super..tmp_plano_extcob_linea
  set    pe_secuencia = @w_sec_tmp,
     @w_sec_tmp = @w_sec_tmp + 1

  if @@error <> 0
  begin
  select
  @w_error = 2006015,
  @w_msg = 'ERROR AL ACTUALIZAR EL CONSECUTIVO DE LOS REGISTROS'
  goto ERROR
  end

  /* Actualizar datos de tel'fonos */
  update cob_conta_super..tmp_plano_extcob_linea
  set    pe_telefono1 = te_valor
  from   cobis..cl_telefono,
     cobis..cl_direccion
  where  pe_cliente    = @i_cliente
  and di_ente       = pe_cliente
  and ((@i_envio      = 'I'
       and di_principal  = 'S'
       and di_tipo       <> '001')
       or (@i_envio      = 'P'
           and di_tipo       = '001'))
  and te_ente       = di_ente
  and te_direccion  = di_direccion
  and te_secuencial = 1

  if @@error <> 0
  begin
  select
  @w_error = 2006016,
  @w_msg = 'ERROR AL ACTUALIZAR LOS DATOS DE TELEFONOS'
  goto ERROR
  end

  update cob_conta_super..tmp_plano_extcob_linea
  set    pe_telefono2 = te_valor
  from   cobis..cl_telefono,
     cobis..cl_direccion
  where  pe_cliente    = @i_cliente
  and di_ente       = pe_cliente
  and ((@i_envio      = 'I'
       and di_principal  = 'S'
       and di_tipo       <> '001')
       or (@i_envio      = 'P'
           and di_tipo       = '001'))
  and te_ente       = di_ente
  and te_direccion  = di_direccion
  and te_secuencial = 2

  if @@error <> 0
  begin
  select
  @w_error = 2006016,
  @w_msg = 'ERROR AL ACTUALIZAR LOS DATOS DE TELEFONOS'
  goto ERROR
  end
  end

    /* Envio de datos al FE, cuando es impresi½n: */
    if @i_envio = 'I' -- Consulta para imprimir
    begin
      -- Envio de datos al Frontend
      set rowcount 10

      select
        pe_secuencia,
        pe_fecha_gen,
        pe_oficina,
        pe_nombre_ofi,
        convert(varchar, pe_fecha_ini, 103),
        convert(varchar, pe_fecha_fin, 103),
        pe_cliente,
        pe_identifica,
        pe_nombre,
        pe_direccion,
        pe_telefono1,
        pe_telefono2,
        pe_barrio,
        pe_nomb_barrio,
        pe_ciudad,
        pe_nomb_ciud,
        pe_depto,
        pe_nomb_depto,
        pe_nomb_prod,
        pe_nro_prod,
        pe_concepto,
        pe_val_bco,
        pe_val_ter,
        pe_nomb_pdf
      from   cob_conta_super..tmp_plano_extcob_linea
      where  pe_cliente   = @i_cliente
         and pe_secuencia > @i_secuencia
         and pe_user      = @s_user
      order  by pe_nomb_prod,
                pe_nro_prod
      --order by pe_secuencia,pe_nomb_prod,pe_nro_prod

      set rowcount 0
    end

    /* Generacion de plano, cuando es correo electr½nico:*/
    if @i_envio = 'C'
    begin
      -- Generar plano fisico para PDF'S y notificador
      select
        @w_s_app = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'ADM'
         and pa_nemonico = 'S_APP'

      select
        @w_path_plano = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'PATHEC'

      select
        @w_server = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'NOTSRV'

      if exists (select
                   1
                 from   sysobjects
                 where  name = 'tmp_plano_cliente')
        drop table cobis..tmp_plano_cliente

      create table cobis..tmp_plano_cliente
      (
        sec            int identity(1, 1),
        pc_secuencia   int not null,
        pc_fecha_gen   varchar(10) not null,
        pc_oficina     smallint not null,
        pc_nombre_ofi  varchar(40) not null,
        pc_fecha_ini   varchar(10) not null,
        pc_fecha_fin   varchar(10) not null,
        pc_cliente     int not null,
        pc_identifica  varchar(15) not null,
        pc_nombre      varchar(80) not null,
        pc_direccion   varchar(100) not null,
        pc_telefono1   varchar(20) null,
        pc_telefono2   varchar(20) null,
        pc_barrio      smallint null,
        pc_nomb_barrio varchar(40) null,
        pc_ciudad      int not null,
        pc_nomb_ciud   varchar(40) not null,
        pc_depto       smallint not null,
        pc_nomb_depto  varchar(40) not null,
        pc_nomb_prod   varchar(64) null,
        pc_nro_prod    varchar(40) not null,
        pc_concepto    varchar(64) not null,
        pc_val_bco     varchar(30) null,
        pc_val_ter     varchar(30) null,
        pc_nomb_pdf    varchar(40) null
      )

      if exists (select
                   1
                 from   sysobjects
                 where  name = 'tmp_plano_cliente_def')
        drop table cobis..tmp_plano_cliente_def

      create table cobis..tmp_plano_cliente_def
      (
        pcd_secuencia   int not null,
        pcd_fecha_gen   varchar(10) not null,
        pcd_oficina     smallint not null,
        pcd_nombre_ofi  varchar(40) not null,
        pcd_fecha_ini   varchar(10) not null,
        pcd_fecha_fin   varchar(10) not null,
        pcd_cliente     int not null,
        pcd_identifica  varchar(15) not null,
        pcd_nombre      varchar(80) not null,
        pcd_direccion   varchar(100) not null,
        pcd_telefono1   varchar(20) null,
        pcd_telefono2   varchar(20) null,
        pcd_barrio      smallint null,
        pcd_nomb_barrio varchar(40) null,
        pcd_ciudad      int not null,
        pcd_nomb_ciud   varchar(40) not null,
        pcd_depto       smallint not null,
        pcd_nomb_depto  varchar(40) not null,
        pcd_nomb_prod   varchar(64) null,
        pcd_nro_prod    varchar(40) not null,
        pcd_concepto    varchar(64) not null,
        pcd_val_bco     varchar(30) null,
        pcd_val_ter     varchar(30) null,
        pcd_nomb_pdf    varchar(40) null
      )

      insert into cobis..tmp_plano_cliente
        select
          pe_secuencia,pe_fecha_gen,pe_oficina,pe_nombre_ofi,pe_fecha_ini,
          pe_fecha_fin,pe_cliente,pe_identifica,pe_nombre,pe_direccion,
          pe_telefono1,pe_telefono2,pe_barrio,pe_nomb_barrio,pe_ciudad,
          pe_nomb_ciud,pe_depto,pe_nomb_depto,pe_nomb_prod,pe_nro_prod,
          pe_concepto,(case pe_val_bco
             when 0.00 then '0.00'
             else convert(varchar(30), pe_val_bco)
           end),(case pe_val_ter
             when 0.00 then '0.00'
             else convert(varchar(30), pe_val_ter)
           end),'costos_financieros_' + cast(pe_cliente as varchar) + '_'
          + convert(varchar(20), @i_ano_genera) + '.pdf'
        from   cob_conta_super..tmp_plano_extcob_linea
        where  pe_user    = @s_user
           and pe_cliente = @i_cliente

      select
        @w_max = max (sec)
      from   cobis..tmp_plano_cliente
      select
        @w_nom_pro = ''
      select
        @w_num_pro = ''
      select
        @w_min = 1

      while (@w_min <= @w_max)
      begin
        select
          @w_nomb_prod = pc_nomb_prod,
          @w_nro_prod = pc_nro_prod
        from   cobis..tmp_plano_cliente
        where  sec = @w_min

        if @w_nro_prod = @w_num_pro
          select
            @w_nom_pro = null
        else
          select
            @w_nom_pro = @w_nomb_prod

        select
          @w_num_pro = @w_nro_prod

        update cobis..tmp_plano_cliente
        set    pc_nomb_prod = @w_nom_pro
        where  sec = @w_min

        select
          @w_min = @w_min + 1

      end

      insert into cobis..tmp_plano_cliente_def
        select
          pc_secuencia,pc_fecha_gen,pc_oficina,pc_nombre_ofi,pc_fecha_ini,
          pc_fecha_fin,pc_cliente,pc_identifica,pc_nombre,pc_direccion,
          pc_telefono1,pc_telefono2,pc_barrio,pc_nomb_barrio,pc_ciudad,
          pc_nomb_ciud,pc_depto,pc_nomb_depto,pc_nomb_prod,pc_nro_prod,
          pc_concepto,pc_val_bco,pc_val_ter,pc_nomb_pdf
        from   cobis..tmp_plano_cliente

      --select 'tabla final ',pcd_nomb_prod ,pcd_nro_prod,* from cobis..tmp_plano_cliente_def

      select
        @w_errores = @w_server + @w_path_plano + 'Extracto_cobros' + convert(
                     varchar,
                            @i_cliente) +
                            '.err'
      select
        @w_cmd = @w_s_app + 's_app bcp  cobis..tmp_plano_cliente_def out '
      select
        @w_comando = @w_cmd + @w_server + @w_path_plano + 'ExtCobrosDATA_' +
                     convert
                     (
                     varchar,
                     @i_cliente
        ) + '_'
                     + convert (varchar, @i_ano_genera) + '_' + convert (varchar
                     (
                     8
                     ),
        getdate(), 112)
                     + '.TXT -b5000  -w -e ' + @w_errores +
        ' -t"|" -auto -login -config ' + @w_s_app + 's_app.ini'

      exec @w_error = xp_cmdshell
        @w_comando

      if @w_error <> 0
      begin
        print 'ERROR GENERANDO ARCHIVO PLANO: '
        print @w_comando
        delete cob_conta_super..tmp_plano_extcob_linea
        where  pe_user = @s_user
           and pe_ssn  = @s_ssn

        if @@error <> 0
        begin
          select
            @w_error = 708155,
            @w_msg = 'ERROR AL BORRAR TABLA DE PLANOS DE EXTRACTOS'
          goto ERROR
        end
        return 1
      end

      -- Usuario se ingresa desde modulo de seguridad
      select
        @w_passcryp = up_password,
        @w_login = up_login
      from   cobis..ad_usuario_xp
      where  up_equipo = 'F'

      if @@rowcount = 0
      begin
        print 'Error lectura Usuario Notificador de Correos '
        return 1
      end

      exec @w_return = CIFRAR...xp_decifrar
        @i_data = @w_passcryp,
        @o_data = @w_password out

      if @w_return <> 0
      begin
        print 'Error lectura Usuario Notificador de Correos '
        return 1
      end

      select
        @w_FtpServer = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'FTPSRV'
      if @@rowcount = 0
      begin
        print 'Error lectura Servidor de Notificacion de Correos '
        return 1
      end

      select
        @w_tmpfile = @w_server + @w_path_plano + @s_user + '_' + 'fuente_ftp'

      select
        @w_cmd = 'del ' + @w_tmpfile
      exec xp_cmdshell
        @w_cmd

      select
        @w_cmd = 'echo ' + @w_login + '>> ' + @w_tmpfile
      exec xp_cmdshell
        @w_cmd

      select
        @w_cmd = 'echo ' + @w_password + '>> ' + @w_tmpfile
      exec xp_cmdshell
        @w_cmd

      select
        @w_cmd = 'echo ' + 'cd extractos\a_procesar ' + ' >> ' + @w_tmpfile
      exec xp_cmdshell
        @w_cmd

      select
        @w_cmd = 'echo ' + 'put  ' + @w_server + @w_path_plano +
                 'ExtCobrosDATA_'
                 +
                                   convert (
                                   varchar, @i_cliente)
                 + '_' + convert (varchar, @i_ano_genera) + '_' + convert (
                 varchar
                 (8
                 )
                                   , getdate(), 112) + '.TXT'
                 + ' >> ' + @w_tmpfile

      exec xp_cmdshell
        @w_cmd

      if @w_error <> 0
      begin
        print 'ERROR Realizando Transferencia de Correo '
        return -1
      end

      select
        @w_cmd = 'echo ' + 'quit ' + '>> ' + @w_tmpfile
      exec xp_cmdshell
        @w_cmd

      select
        @w_cmd = 'ftp -s:' + @w_tmpfile + ' ' + @w_FtpServer
      exec xp_cmdshell
        @w_cmd

      if @@error <> 0
      begin
        print 'Error Transfiriendo Extracto a Notificador de Correos'
        return 1
      end

      select
        @w_cmd = 'del ' + @w_tmpfile
      exec xp_cmdshell
        @w_cmd

      delete cob_conta_super..tmp_plano_extcob_linea
      where  pe_user = @s_user
         and pe_ssn  = @s_ssn

      if @@error <> 0
      begin
        select
          @w_error = 708155,
          @w_msg = 'ERROR AL BORRAR TABLA DE PLANOS DE EXTRACTOS'
        goto ERROR
      end
    end
    return 0
  end

  set ANSI_NULLS off
  set ANSI_WARNINGS off

  ERROR:

  exec cobis..sp_cerror
    @t_from = @w_sp_name,
    @i_num  = @w_error,
    @i_msg  = @w_msg

  return @w_error

go

