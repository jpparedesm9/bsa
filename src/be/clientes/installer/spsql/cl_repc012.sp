/************************************************************************/
/*  Archivo:            cl_repc012.sp                                   */
/*  Stored procedure:   sp_rep_c012                                     */
/*  Base de datos:      cobis                                           */
/*  Disenado por:       Edwin Jimenez                                   */
/*  Fecha de escritura: 04-Jul-2014                                     */
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
/*                             PROPOSITO                                */
/*  Este stored procedure genera un archivo plano con la base utilizada */
/*  para la realizacion en la marcacion de clientes Circular 012        */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA          AUTOR            RAZON                               */
/*  04-Jul-2014    E.Jimenez      Emision Inicial                       */
/*  02-May-2016    DFu            Migracion CEN                         */
/************************************************************************/
use cobis
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_rep_c012')
  drop proc sp_rep_c012
go

create proc sp_rep_c012
(
  @t_show_version bit = 0,
  @i_param1       datetime = null,--FECHA INICIO
  @i_param2       datetime = null --FECHA FIN
)
as
  declare
    @w_sp_name         varchar(30),
    @w_tipo_ent        varchar(10),
    @w_cod_entidad     varchar(10),
    @w_sp_name_batch   varchar(50),
    @w_path            varchar(255),
    @w_s_app           varchar(255),
    @w_path_plano      varchar(255),
    @w_cmd             varchar(255),
    @w_msg             varchar(100),
    @w_comando         varchar(500),
    @w_errores         varchar(255),
    @w_error           int,
    @w_fecha           datetime,
    @w_fecha_ini       datetime,
    @w_fecha_fin       datetime,
    @w_fecha_ultpro    datetime,
    @w_fecha_arch      char(8),
    @w_nombre_arch_txt varchar(255),
    @w_nombre_arch_err varchar(255),
    @w_fecha_rep       datetime,
    @w_variables       int,
    @w_total_reg       int,
    @w_inconsistencias int,
    @w_aux             int

  select
    @w_sp_name = 'sp_rep_c012'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha_ini = convert(datetime, @i_param1),
    @w_fecha_fin = convert(datetime, @i_param2),
    @w_fecha = convert(varchar, fp_fecha, 101)
  from   cobis..ba_fecha_proceso

  select
    @w_fecha_ultpro = dateadd(dd,
                              1,
                              @w_fecha_fin)

  select
    'HORA INICIO: ' = getdate()

  create table cl_rep_c012
  (
    rc_oficina    varchar(20) null,
    rc_sinmarca   varchar(20) null,
    rc_correoelec varchar(20) null,
    rc_retofi     varchar(20) null,
    rc_dirFis     varchar(20) null,
    rc_total      varchar(20) null
  )

  insert into cobis..cl_rep_c012
    select
      'Oficina','SinMarca','CorreoElectronico','RetenerOficina','DirFisica',
      'Total'

  /*** CREA TABLA UNIVERSO DE TRABAJO ***/
  select
    *
  into   #cl_forma_extractos
  from   cobis..cl_forma_extractos

  --Clientes sin movimiento
  select
    cl_cliente,
    cl_rol,
    dp_producto,
    dp_cuenta
  into   #clientes_sin_mov1
  from   cobis..cl_det_producto with (nolock),
         cobis..cl_cliente with (nolock)
  where  cl_det_producto = dp_det_producto
     and dp_fecha        <= @w_fecha_fin
     and cl_rol in ('T', 'D')

  select
    cl_cliente,
    cl_rol,
    dp_producto,
    dp_cuenta
  into   #clientes_sin_mov
  from   #clientes_sin_mov1,
         cob_cartera..ca_operacion
  where  dp_producto = 7
     and dp_cuenta   = op_banco
     and cl_cliente  = op_cliente

  insert into #clientes_sin_mov
    select
      cl_cliente,cl_rol,dp_producto,dp_cuenta
    from   #clientes_sin_mov1,
           cob_pfijo..pf_operacion
    where  dp_producto = 14
       and dp_cuenta   = op_num_banco
       and cl_cliente  = op_ente

  insert into #clientes_sin_mov
    select
      cl_cliente,cl_rol,dp_producto,dp_cuenta
    from   #clientes_sin_mov1,
           cob_ahorros..ah_cuenta
    where  dp_producto = 4
       and dp_cuenta   = ah_cta_banco
       and cl_cliente  = ah_cliente

  select
    count(distinct cl_cliente)
  from   #clientes_sin_mov1
  select
    count(distinct cl_cliente)
  from   #clientes_sin_mov
  select
    universo_tot = count(1)
  from   #clientes_sin_mov
  select
    universo_aho = count(1)
  from   #clientes_sin_mov
  where  dp_producto = 4
  select
    universo_cca = count(1)
  from   #clientes_sin_mov
  where  dp_producto = 7
  select
    universo_dpf = count(1)
  from   #clientes_sin_mov
  where  dp_producto = 14

  select
    producto = dp_producto,
    banco = dp_cuenta
  into   #borrar_ahorros
  from   #clientes_sin_mov,
         cob_ahorros..ah_cuenta with (nolock)
  where  dp_cuenta                                    = ah_cta_banco
     and dp_producto                                  = 4
     and isnull(ah_fecha_ult_proceso,
                @w_fecha_ultpro) < @w_fecha_ini

  delete #clientes_sin_mov
  from   #borrar_ahorros
  where  producto    = dp_producto
     and banco       = dp_cuenta
     and dp_producto = 4

  select
    tot_del_aho = count(1)
  from   #borrar_ahorros
  select
    uni_del_aho = count(1)
  from   #clientes_sin_mov

  select
    producto = dp_producto,
    banco = dp_cuenta
  into   #borrar_cartera
  from   #clientes_sin_mov,
         cob_cartera..ca_operacion with (nolock)
  where  dp_cuenta            = op_banco
     and dp_producto          = 7
     and op_fecha_ult_proceso < @w_fecha_ini

  delete #clientes_sin_mov
  from   #borrar_cartera,
         #clientes_sin_mov
  where  producto    = dp_producto
     and banco       = dp_cuenta
     and dp_producto = 7

  select
    tot_del_cca = count(1)
  from   #borrar_cartera
  select
    uni_del_cca = count(1)
  from   #clientes_sin_mov

  --ELIMINA OPERACIONES CASTIGADAS
  select
    producto = dp_producto,
    banco = dp_cuenta
  into   #borrar_castigos_sm
  from   #clientes_sin_mov,
         cob_cartera..ca_transaccion with (nolock),
         cob_cartera..ca_operacion with (nolock)
  where  tr_banco     = dp_cuenta
     and op_banco     = tr_banco
     and tr_tran      = 'CAS'
     and tr_estado    <> 'RV'
     and op_estado    = 4
     and dp_producto  = 7
     and (tr_fecha_ref < @w_fecha_ini
           or tr_fecha_ref > @w_fecha_fin)

  insert into #borrar_castigos_sm
    select
      producto = dp_producto,banco = dp_cuenta
    from   #clientes_sin_mov,
           cob_cartera..ca_transaccion_bancamia with (nolock),
           cob_cartera..ca_operacion with (nolock)
    where  tr_banco     = dp_cuenta
       and tr_banco     = op_banco
       and tr_tran      = 'CAS'
       and tr_estado    <> 'RV'
       and op_estado    = 4
       and dp_producto  = 7
       and (tr_fecha_ref < @w_fecha_ini
             or tr_fecha_ref > @w_fecha_fin)

  insert into #borrar_castigos_sm
    select
      producto = 7,banco = op_banco
    from   #clientes_sin_mov,
           cob_cartera..ca_operacion with (nolock)
    where  op_toperacion in ('ALT_FNG', 'BALIQCPAS', 'BAPROGRPAS')
       and dp_cuenta = op_banco

  delete #clientes_sin_mov
  from   #borrar_castigos_sm
  where  producto    = dp_producto
     and banco       = dp_cuenta
     and dp_producto = 7

  select
    tot_del_cas_cca = count(1)
  from   #borrar_castigos_sm
  select
    uni_del_cas_cca = count(1)
  from   #clientes_sin_mov

  select
    producto = dp_producto,
    banco = dp_cuenta
  into   #borrar_pfijo
  from   #clientes_sin_mov,
         cob_pfijo..pf_operacion with (nolock)
  where  dp_cuenta                                    = op_num_banco
     and dp_producto                                  = 14
     and isnull(op_ult_fecha_calculo,
                @w_fecha_ultpro) < @w_fecha_ini

  delete #clientes_sin_mov
  from   #borrar_pfijo
  where  producto    = dp_producto
     and banco       = dp_cuenta
     and dp_producto = 14

  select
    tot_del_dpf = count(1)
  from   #borrar_pfijo
  select
    uni_del_dpf = count(1)
  from   #clientes_sin_mov
  select
    count(distinct cl_cliente)
  from   #clientes_sin_mov

  select
    Oficina = of_oficina,
    SinMarca = convert(int, 0),
    CorreoElectronico = convert(int, 0),
    RetenerOficina = convert(int, 0),
    DirFisica = convert(int, 0),
    Total = convert(int, 0)
  into   #AvanceC012_SinMov
  from   cobis..cl_oficina
  where  of_subtipo = 'O'

  select
    Oficina1 = isnull(en_oficina_prod,
                      en_oficina),
    SinMarca1 = count(distinct cl_cliente)
  into   #sinmarca_ni_mov
  from   #clientes_sin_mov,
         cobis..cl_ente with (nolock)
  where  cl_cliente not in (select
                              fe_cliente
                            from   #cl_forma_extractos)
     and cl_cliente = en_ente
  group  by isnull(en_oficina_prod,
                   en_oficina)

  update #AvanceC012_SinMov
  set    SinMarca = SinMarca1
  from   #sinmarca_ni_mov
  where  Oficina = Oficina1

  select
    Oficina2 = isnull(en_oficina_prod,
                      en_oficina),
    FormaEnt = fe_forma_entrega,
    Marcados = count(distinct cl_cliente)
  into   #Marcados_SinMov
  from   #clientes_sin_mov,
         #cl_forma_extractos with (nolock),
         cobis..cl_ente with (nolock)
  where  cl_cliente = fe_cliente
     and cl_cliente = en_ente
  group  by isnull(en_oficina_prod,
                   en_oficina),
            fe_forma_entrega

  update #AvanceC012_SinMov
  set    CorreoElectronico = Marcados
  from   #Marcados_SinMov
  where  Oficina  = Oficina2
     and FormaEnt = 'C'

  update #AvanceC012_SinMov
  set    RetenerOficina = Marcados
  from   #Marcados_SinMov
  where  Oficina  = Oficina2
     and FormaEnt = 'R'

  update #AvanceC012_SinMov
  set    RetenerOficina = RetenerOficina + Marcados
  from   #Marcados_SinMov
  where  Oficina  = Oficina2
     and FormaEnt = 'O'

  update #AvanceC012_SinMov
  set    DirFisica = Marcados
  from   #Marcados_SinMov
  where  Oficina  = Oficina2
     and FormaEnt = 'D'

  update #AvanceC012_SinMov
  set    Total = DirFisica + RetenerOficina + CorreoElectronico + SinMarca

  delete #AvanceC012_SinMov
  where  DirFisica + RetenerOficina + CorreoElectronico + SinMarca = 0

  insert into cobis..cl_rep_c012
    select
      convert(varchar(20), Oficina),convert(varchar(20), SinMarca),convert(
      varchar
      (
      20), CorreoElectronico),convert(varchar(20), RetenerOficina),convert(
      varchar
      (
      20), DirFisica),
      convert(varchar(20), Total)
    from   #AvanceC012_SinMov

  if @@rowcount = 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR INSERTANDO EN LA TABLA cl_rep_c012'
    goto ERROR_INF
  end

  insert into cobis..cl_rep_c012
    select
      'Total',sum(SinMarca),sum (CorreoElectronico),sum(RetenerOficina),sum(
      DirFisica),
      sum (Total)
    from   #AvanceC012_SinMov

  if @@rowcount = 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR INSERTANDO EN LA TABLA cl_rep_c012_sum'
    goto ERROR_INF
  end

  select
    @w_sp_name_batch = 'cobis..sp_rep_c012'

  /* Obtiene el path donde se va a generar el informe : VBatch\Clientes\Listados */
  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_arch_fuente = @w_sp_name_batch

  if @@rowcount = 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR EN LA BUSQUEDA DEL PATH EN LA TABLA ba_batch'
    goto ERROR_INF
  end

  /* Obtiene el parametro de la ubicacion del kernel\bin en el servidor */
  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  if @@rowcount = 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR AL OBTENER EL PARAMETRO GENERAL S_APP DE ADM'
    goto ERROR_INF
  end

  /* Obtiene los nombres de los informes */
  select
    @w_fecha_arch = convert(char(10), @w_fecha, 112)
  print 'Fecha Archivo ->' + convert(varchar(10), @w_fecha_arch)
  select
    @w_fecha_arch = substring(@w_fecha_arch, 7, 2) + substring(@w_fecha_arch, 5,
                    2
                    )
                    + substring(@w_fecha_arch, 1, 4)
  print @w_fecha_arch
  select
    @w_nombre_arch_txt = @w_path + 'C012_' + @w_fecha_arch + '.txt'
  select
    @w_nombre_arch_err = @w_nombre_arch_txt + '.err'
  select
    @w_errores = @w_path + @w_nombre_arch_err
  select
    @w_cmd = @w_s_app + 's_app bcp -auto -login cobis..cl_rep_c012 out '
  select
       @w_comando = @w_cmd + @w_nombre_arch_txt + ' -c -e' + @w_nombre_arch_err
                    +
                    ' -t"|" '
    +
                    '-config '
    + @w_s_app
                 + 's_app.ini'
  print @w_comando
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR GENERANDO ARCHIVO PLANO: '
    print @w_comando
    goto ERROR_INF
  end

  drop table cobis..cl_rep_c012

  if @@error <> 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR ELIMINANDO cl_rep_c012'
    goto ERROR_INF
  end

  return 0

  ERROR_INF:

  exec cobis..sp_errorlog
    @i_fecha       = @w_fecha_rep,
    @i_error       = '28010',
    @i_usuario     = 'op-batch',
    @i_tran        = 1,
    @i_tran_name   = 'I',
    @i_descripcion = @w_msg,
    @i_rollback    = 'N'

  print @w_msg

  return @w_error

go

