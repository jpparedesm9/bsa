/************************************************************************/
/*   Archivo:             sp_carga_traslado.sp                          */
/*   Stored procedure:    carga_traslado                                */
/*   Base de datos:       cobis                                         */
/*   Producto:            Pasivas                                       */
/*   Disenado por:        Pedro Rojas                                   */
/*   Fecha de escritura:  Mar 2015.                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/***********************************************************************/
/*                              PROPOSITO                               */
/*   Este programa permite carga en las tablas que permiten trasladar   */
/*   los productos pasivas de una oficina a otra                        */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA             AUTOR         RAZON                             */
/*    May/02/2016     DFu             Migracion CEN                     */
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
           where  name = 'sp_carga_traslado')
  drop proc sp_carga_traslado
go

create proc sp_carga_traslado
(
  @i_param1       int = null,--Oficina Origen
  @i_param2       int = null,--Oficina Destino
  @i_param3       varchar(256) = null,--Nombre archivo a procesar
  @i_param4       varchar(256),--Tipo traslado
  @t_show_version bit = 0
)
as
  declare
    @w_error           int,
    @w_sp_name         varchar(64),
    @w_fecha_proceso   datetime,
    @w_commit          char(1),
    @w_msg             varchar(255),
    @w_ofiorig         int,
    @w_ofidest         int,
    @w_nom_archiv      varchar(60),
    @w_tipo_tras       varchar(255),
    @w_s_app           varchar(50),
    @w_mensaje         varchar(255),
    @w_path            varchar(60),
    @w_path_salida     varchar(60),
    @w_cmd             varchar(500),
    @w_ruta            varchar(300),
    @w_errores         varchar(500),
    @w_sql             nvarchar(4000),
    @w_tip_ide         varchar(2),
    @w_num_ide         varchar(20),
    @w_cliente         int,
    @w_cuenta          int,
    @w_cta_banco       varchar(16),
    @w_estado          char(1),
    @w_ofi_prod        int,
    @w_tipo_oper       int,
    @w_fecha_aper      datetime,
    @w_canje           money,
    @w_secuencial      int,
    @w_saldo_dispo     money,
    @w_saldo_total     money,
    @w_cant_ctas       int,
    @w_cant_cdt        int,
    @w_cta_cobis       int,
    @w_nom_archiv_sali varchar(100),
    @w_comando         varchar(500),
    @w_error_tmp       int,
    @w_nchql           varchar(20),
    @w_nefec           varchar(20),
    @w_ndias           tinyint,
    @w_vxp             varchar(11)

  select
    @w_sp_name = 'sp_carga_traslado'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* CARGA INICIAL DE VARIABLES DE TRABAJO */

  select
    @w_commit = 'N'

  /* CARGA DE PARAMETROS GENERALES*/

  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @w_ofiorig = @i_param1,
    @w_ofidest = @i_param2,
    @w_nom_archiv = @i_param3,
    @w_tipo_tras = @i_param4,
    @w_mensaje = 'PROCESADO'

  /* VALIDA QUE EL TIPO DE TRASLADO SEA VALIDO */

  if @w_tipo_tras not in ('COM', 'CIE')
  begin
    select
      @w_error = 2600099,
      @w_mensaje = 'ERROR, TIPO TRASLADO NO PERMITIDO O NO EXISTE'
    goto ERRORFIN
  end

  /* CARGA EN UNA TMPORAL LOS CDTS ACTIVOS QUE FUERON APERTURADOS CON CANJE */

  select
    @w_vxp = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'PFI'
     and pa_nemonico = 'VXP'

  select
    @w_nefec = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'PFI'
     and pa_nemonico = 'NEFE'

  select
    @w_nchql = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'PFI'
     and pa_nemonico = 'NCHQL'

  --Dias para realizar canje
  select
    @w_ndias = pa_tinyint
  from   cobis..cl_parametro
  where  pa_nemonico = 'DCP'
     and pa_producto = 'PFI'

  select distinct
    op_operacion,
    td_monto
  into   #cdt_ape_chql
  from   cob_pfijo..pf_transaccion,
         cob_pfijo..pf_transaccion_det,
         cob_pfijo..pf_operacion
  where  op_estado      = 'ACT'
     and op_operacion   = tr_operacion
     and tr_operacion   = td_operacion
     and tr_secuencial  = td_secuencial
     and tr_tran        = 14901
     --and   tr_estado    = 'CON'
     and td_concepto    = @w_nchql
     and op_fecha_valor >= dateadd(dd,
                                   @w_ndias * -1,
                                   @w_fecha_proceso)

  /* VALIDA SI EL TRASLADO ES COMERCIAL O TOTAL */

  if @w_tipo_tras = 'COM'
  begin
    /* VALIDA QUE SE HALLA INGRESADO NOMBRE DE ARCHIVO A CARGAR */
    if @w_nom_archiv is null
    begin
      select
        @w_mensaje = 'NO SE DIGITO NOMBRE DE ARCHIVO',
        @w_error = 2805081
      goto ERRORFIN
    end

    /* CARGA VARIABLES PARA IMPORTAR EL ARCHIVO A UNA TABLA TEMPORAL */
    select
      @w_s_app = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'ADM'
       and pa_nemonico = 'S_APP'

    if @w_s_app is null
    begin
      select
        @w_mensaje = 'ERROR CARGANDO PARAMETRO BCP',
        @w_error = 1000002
      goto ERRORFIN
    end

    select
      @w_path = ba_path_destino
    from   ba_batch
    where  ba_batch = 2159

    if @w_path is null
    begin
      select
        @w_mensaje =
        'ERROR CARGANDO LA RUTA BATCH DE DESTINO, REVISAR PARAMETRIZACION',
        @w_error = 1000003
      goto ERRORFIN
    end

    select
      @w_ruta = @w_path + @w_nom_archiv + '.txt'

    /* CREACION DE LA TABLA DONDE SE CARGARA EL ARCHIVO */
    if exists(select
                1
              from   sysobjects
              where  name = 'temp_com')
      drop table temp_com

    create table temp_com
    (
      tipo_ide varchar(2),
      num_ide  varchar(20),
      ofi_org  int,
      ofi_dest int
    )

    set @w_sql = 'BULK INSERT cobis..temp_com FROM ''' + @w_ruta + ''' ' +
                 '     WITH ( 
               FIRSTROW = 2,
               FIELDTERMINATOR = ''|'',
               ROWTERMINATOR = ''\n''
            ) '

    begin try
      exec @w_error = sp_executesql
        @w_sql;
    end try
    begin catch
      --Validaci¾n error cargando archivo
      select
        @w_mensaje = 'ERROR CARGANDO EL ARCHIVO PLANO ' + @w_nom_archiv + '' +
                     '!!!!!'
        ,
        @w_error = 2805097
      goto ERRORFIN
    end catch

    /* ACTUALIZA LOS CODIGOS DE CLIENTE */

    select
      t.*,
      en_ente,
      'observacion' = convert(varchar(255), null)
    into   #clientes_procesar
    from   temp_com t
           left join cl_ente c
                  on t.num_ide = c.en_ced_ruc
                     and t.tipo_ide = c.en_tipo_ced
    order  by t.num_ide,
              t.tipo_ide

    /* ACTUALIZA LA OBSERVACION PARA EL CLIENTE QUE NO EXISTE */
    update #clientes_procesar
    set    observacion = 'CLIENTE NO EXISTE'
    where  en_ente is null

    /* CICLO PARA PROCESAR LOS DATOS QUE VENIAN DEL ARCHIVO */
    while 1 = 1
    begin
      select
        @w_mensaje = 'CLIENTE CARGADO PARA TRASLADO',
        @w_commit = 'S',
        @w_cant_ctas = 0,
        @w_cant_cdt = 0

      select top 1
        @w_tip_ide = tipo_ide,
        @w_num_ide = num_ide,
        @w_ofiorig = ofi_org,
        @w_ofidest = ofi_dest,
        @w_cliente = en_ente
      from   #clientes_procesar
      where  observacion is null
      order  by num_ide,
                tipo_ide

      if @@rowcount = 0
        break

      begin tran
      /*VALIDA LA EXISTENCIA DE UNA SOLICITUD VIGENTE*/
      if exists(select
                  1
                from   cobis..cl_traslado
                where  tr_ente   = @w_cliente
                   and (tr_estado = 'I'
                         or tr_estado = 'A'))
      begin
        select
          @w_error = 101262,
          @w_mensaje = 'YA EXISTE UNA SOLICITUD DE TRASLADO VIGENTE'
        goto SIGCLIENTE
      end
      /* VALIDA LA EXISTENCIA DE LAS OFICINAS */

      if (select
            count(1)
          from   cobis..cl_oficina
          where  of_oficina = @w_ofiorig) = 0
      begin
        select
          @w_error = 190519,
          @w_mensaje = 'OFICINA ORIGEN NO EXISTE'
        goto SIGCLIENTE
      end

      if (select
            count(1)
          from   cobis..cl_oficina
          where  of_oficina = @w_ofidest) = 0
      begin
        select
          @w_error = 190519,
          @w_mensaje = 'OFICINA (ADMIN) DESTINO NO EXISTE'
        goto SIGCLIENTE
      end

      /* CREA EL SECUENCIAL AUTOMATICO */
      exec sp_cseqnos
        @i_tabla     = 'cl_traslado',
        @o_siguiente = @w_secuencial out

      /* ACTUALIZA LA TABLA MAESTRO DE TRASLADOS */
      insert into cobis..cl_traslado
                  (tr_solicitud,tr_ente,tr_tipo_traslado,tr_estado,tr_fecha_sol,
                   tr_usr_ingresa,tr_oficina_dest,tr_ofi_solicitud,
                   tr_usr_autoriza
                   ,
                   tr_ofi_autoriza)
      values      (@w_secuencial,@w_cliente,@w_tipo_tras,'A',@w_fecha_proceso,
                   'optbatch',@w_ofidest,4069,'optbatch',4069)

      if @@error <> 0
      begin
        select
          @w_commit = 'N',
          @w_mensaje = 'ERROR AL INGRESAR LA SOLICITUD',
          @w_error = 101263
        goto SIGCLIENTE
      end

      /* transaccion de servicio */
      insert into cobis..cl_tran_servicio
                  (ts_secuencial,ts_cod_alterno,ts_ente,ts_fecha,ts_usuario,
                   ts_terminal,ts_oficina,ts_estado,ts_toperacion,ts_clase,
                   ts_fecha_registro,ts_tipo_transaccion)
      values      (@w_secuencial,1,@w_cliente,@w_fecha_proceso,'optbatch',
                   'consola',1,'A','I','N',
                   getdate(),1631)

      if @@error <> 0
      begin
        select
          @w_commit = 'N',
          @w_mensaje = 'ERROR AL INSERTAR TRANSACCION EN LOG',
          @w_error = 101264
        goto SIGCLIENTE
      end

    /* INGRESA EL DETALLE DE LA NUEVA SOLICITUD DE TRANSLADO */
      /* Ahorros */

      if exists(select
                  1
                from   sysobjects
                where  name = 'temp_cuentas_cliente')
        drop table temp_cuentas_cliente

      select
        *
      into   temp_cuentas_cliente
      from   cob_ahorros..ah_cuenta
      where  ah_cliente = @w_cliente
         and ah_estado in ('A', 'I', 'C', 'G')
         and ah_oficina = @w_ofiorig

      select
        @w_cant_ctas = @@rowcount

      /*ciclo que recorre cada cuenta y toma el valor total del saldo*/

      while 2 = 2
      begin
        select top 1
          @w_cuenta = ah_cuenta,
          @w_cta_banco = ah_cta_banco,
          @w_estado = ah_estado,
          @w_ofi_prod = ah_oficina,
          @w_tipo_oper = ah_prod_banc,
          @w_fecha_aper = ah_fecha_aper,
          @w_canje = (ah_12h + ah_24h + ah_48h)
        from   temp_cuentas_cliente

        if @@rowcount = 0
          break

        delete temp_cuentas_cliente
        where  ah_cuenta = @w_cuenta

        /* SI LA CUENTA ESTA CANCELADA, VALIDA QUE TENGA ORDEN DE PAGO */
        if @w_estado = 'C'
        begin
          if not exists(select
                          1
                        from   cob_remesas..re_orden_caja
                        where  oc_ref3   = @w_cta_banco
                           and oc_estado = 'I'
                           and (oc_tipo   = 'P'
                                and oc_causa in ('035', '014', '012')))
          begin
            goto SIGUIENTE
          end
        end
        /* EJECUTA EL SP QUE PROPORCIONA EL VALOR DEL SALDO TOTAL Y DISPONIBLE */
        exec cob_ahorros..sp_ahcalcula_saldo
          @i_fecha            = @w_fecha_proceso,
          @i_cuenta           = @w_cuenta,
          @o_saldo_para_girar = @w_saldo_dispo out,
          @o_saldo_contable   = @w_saldo_total out

        /* INSERTA EN LA TABLA DEL DETALLE */
        insert into cobis..cl_traslado_detalle
                    (td_solicitud,td_producto,td_ofi_orig,td_ofi_dest,
                     td_operacion
                     ,
                     td_tipo_operacion,td_estado_ope,
                     td_saldo_total,td_saldo_dispo,
                     td_fecha_cons,
                     td_fecha_ven,td_monto,td_intereses,td_encanje,
                     td_estado_batch
        )
        values      (@w_secuencial,'4',@w_ofi_prod,@w_ofidest,@w_cta_banco,
                     convert(varchar(2), @w_tipo_oper),@w_estado,@w_saldo_total,
                     @w_saldo_dispo,@w_fecha_aper,
                     null,null,null,@w_canje,'I')

        if @@error <> 0
        begin
          select
            @w_commit = 'N',
            @w_mensaje = 'ERROR AL INSERTAR El DETALLE DE LAS CUENTAS',
            @w_error = 101265
          goto SIGCLIENTE
        end
        SIGUIENTE:
      end /* end while 2=2 */

      /* CDTS */

      insert into cobis..cl_traslado_detalle
                  (td_solicitud,td_producto,td_ofi_orig,td_ofi_dest,td_operacion
                   ,
                   td_tipo_operacion,td_estado_ope,
                   td_saldo_total,td_saldo_dispo,
                   td_fecha_cons,
                   td_fecha_ven,td_monto,td_intereses,td_estado_batch,td_encanje
      )
        select
          @w_secuencial,'14',op_oficina,@w_ofidest,op_num_banco,
          convert(varchar(3), p.op_toperacion),op_estado,null,null,
          op_fecha_ingreso,
          op_fecha_ven,op_monto,op_int_ganado,'I',isnull(t.td_monto,
                 0)
        from   cob_pfijo..pf_operacion p
               left join #cdt_ape_chql t
                      on t.op_operacion = p.op_operacion
        where  op_ente    = @w_cliente
           and op_estado in ('ACT', 'VEN')
           --and   op_operacion not in (select op_operacion from #cdt_ape_chql)
           and op_oficina = @w_ofiorig

      select
        @w_cant_cdt = @@rowcount

      insert into cobis..cl_traslado_detalle
                  (td_solicitud,td_producto,td_ofi_orig,td_ofi_dest,td_operacion
                   ,
                   td_tipo_operacion,td_estado_ope,
                   td_saldo_total,td_saldo_dispo,
                   td_fecha_cons,
                   td_fecha_ven,td_monto,td_intereses,td_estado_batch)
        select distinct
          @w_secuencial,'14',op_oficina,@w_ofidest,op_num_banco,
          convert(varchar(3), op_toperacion),op_estado,null,null,
          op_fecha_ingreso,
          op_fecha_ven,op_monto,op_int_ganado,'I'
        from   cob_pfijo..pf_emision_cheque,
               cob_pfijo..pf_mov_monet,
               cob_pfijo..pf_operacion
        where  op_ente      = @w_cliente
           and op_estado    = 'CAN'
           and op_oficina   = @w_ofiorig
           and op_operacion = mm_operacion
           and mm_operacion = ec_operacion
           and mm_secuencia = ec_secuencia
           and ((mm_tran in (14543, 14903, 14919, 14905)
                 and mm_producto  = @w_vxp) -- falta validar 14919
                 or (mm_tran in (14543, 14903, 14919, 14905)
                     and mm_producto  = @w_nefec)-- falta validar 14919
               )
           and ec_estado is null

      select
        @w_cant_cdt = @w_cant_cdt + @@rowcount

      if @w_cant_ctas + @w_cant_cdt = 0
      begin
        select
          @w_commit = 'N',
          @w_mensaje =
          'CLIENTE SIN PRODUCTOS EN ESTADOS DISPONIBLES PARA TRASLADAR'

        --Se elimina solicitud que no genero detalle
        delete from cobis..cl_traslado
        where  tr_solicitud = @w_secuencial

      end

      SIGCLIENTE:

      if @w_commit = 'S'
        commit tran
      else
        rollback tran

      update #clientes_procesar
      set    observacion = cast(@w_mensaje as varchar(255))
      where  tipo_ide = @w_tip_ide
         and num_ide  = @w_num_ide
         and ofi_org  = @w_ofiorig
         and ofi_dest = @w_ofidest
         and en_ente  = @w_cliente

    end --while 1=1

    /* CREACION DEL ARCHIVO DE LOG */
    select
      @w_nom_archiv_sali = 'CARGA_TRAS_PASIV_' + replace(convert(varchar(10),
                           103)
                           ,
                                  '/', '_') + '.txt'

    select
      @w_path_salida = ba_path_destino
    from   cobis..ba_batch
    where  ba_batch = 2159

    if exists(select
                1
              from   sysobjects
              where  name = 'archivo_salida')
      drop table archivo_salida

    create table archivo_salida
    (
      registro varchar(5000),
    )

    insert into archivo_salida
    values     (
'TIPO IDENTIFICACION|NUMERO IDENTIFICACION|OFICINA ORIGEN|OFICINA DESTINO|OBSERVACIONES'
  )

  insert into archivo_salida
    select
      convert(varchar(2), isnull(tipo_ide, ' ')) + '|'
      + convert(varchar(25), isnull(num_ide, ' ')) + '|'
      + convert(varchar(6), isnull(ofi_org, ' ')) + '|'
      + convert(varchar(6), isnull(ofi_dest, ' ')) + '|'
      + convert(varchar(255), isnull(observacion, ' '))
    from   #clientes_procesar

  select
    @w_cmd = @w_s_app + 's_app bcp -auto -login cobis..archivo_salida out '

  select
    @w_path_salida = @w_path_salida + @w_nom_archiv_sali,
    @w_errores = @w_path_salida + '.err'

  select
    @w_comando = @w_cmd + @w_path_salida + ' -b5000  -c -e' + @w_errores +
                 ' -t"|" '
                                                                 + '-config '
                                                                 + @w_s_app
                 + 's_app.ini'

  print @w_comando
  exec @w_error_tmp = xp_cmdshell
    @w_comando

end --tipo traslado COM

  if @w_tipo_tras = 'CIE'
  begin
    /* VALIDA LA EXISTENCIA DE LAS OFICINAS */

    if (select
          count(1)
        from   cobis..cl_oficina
        where  of_oficina = @w_ofiorig) = 0
    begin
      select
        @w_error = 190519,
        @w_mensaje = 'OFICINA ORIGEN NO EXISTE'
      goto ERRORFIN
    end

    if (select
          count(1)
        from   cobis..cl_oficina
        where  of_oficina = @w_ofidest) = 0
    begin
      select
        @w_error = 190519,
        @w_mensaje = 'OFICINA (ADMIN) DESTINO NO EXISTE'
      goto ERRORFIN
    end

    /*UNIVERSO DE CLIENTES A PROCESAR */

    select
      *,
      'ente' = null,
      'cta_cobis' = null
    into   #temp_detalle
    from   cobis..cl_traslado_detalle
    where  1 = 2

    /* CUENTAS CANCELADAS CON ORDENES DE PAGO */
    insert into #temp_detalle
                (td_solicitud,td_producto,td_ofi_orig,td_ofi_dest,td_operacion,
                 td_tipo_operacion,td_estado_ope,td_saldo_total,td_saldo_dispo,
                 td_fecha_cons,
                 ente)
      select
        null,'4',@w_ofiorig,@w_ofidest,ah_cta_banco,
        ah_prod_banc,ah_estado,null,null,ah_fecha_aper,
        ah_cliente
      from   cob_ahorros..ah_cuenta,
             cob_remesas..re_orden_caja
      where  ah_estado    = 'C'
         and ah_oficina   = @w_ofiorig
         and ah_cta_banco = oc_ref3
         and oc_estado    = 'I'
         and (oc_tipo      = 'P'
              and oc_causa in ('035', '014', '012'))

    --CUENTAS ACTIVAS, INACTIVAS o INGRESADAS
    insert into #temp_detalle
                (td_solicitud,td_producto,td_ofi_orig,td_ofi_dest,td_operacion,
                 td_tipo_operacion,td_estado_ope,td_saldo_total,td_saldo_dispo,
                 td_fecha_cons,
                 td_encanje,ente,cta_cobis)
      select
        null,'4',@w_ofiorig,@w_ofidest,ah_cta_banco,
        ah_prod_banc,ah_estado,null,null,ah_fecha_aper,
        (ah_12h + ah_24h + ah_48h),ah_cliente,ah_cuenta
      from   cob_ahorros..ah_cuenta
      where  ah_estado in ('A', 'I', 'G')
         and ah_oficina = @w_ofiorig

    --CDTS ACTIVOS
    insert into #temp_detalle
                (td_solicitud,td_producto,td_ofi_orig,td_ofi_dest,td_operacion,
                 td_tipo_operacion,td_estado_ope,td_saldo_total,td_saldo_dispo,
                 td_fecha_cons,
                 td_fecha_ven,td_monto,td_intereses,ente,td_encanje)
      select
        @w_secuencial,'14',op_oficina,@w_ofidest,op_num_banco,
        convert(varchar(3), p.op_toperacion),op_estado,null,null,
        op_fecha_ingreso,
        op_fecha_ven,op_monto,op_int_ganado,op_ente,isnull(t.td_monto,
               0)
      from   cob_pfijo..pf_operacion p
             left join #cdt_ape_chql t
                    on t.op_operacion = p.op_operacion
      where  op_estado in ('ACT', 'VEN')
             --and   op_operacion not in (select op_operacion from #cdt_ape_chql)
             and op_oficina = @w_ofiorig

    insert into #temp_detalle
                (td_solicitud,td_producto,td_ofi_orig,td_ofi_dest,td_operacion,
                 td_tipo_operacion,td_estado_ope,td_saldo_total,td_saldo_dispo,
                 td_fecha_cons,
                 td_fecha_ven,td_monto,td_intereses,ente)
      select distinct
        @w_secuencial,'14',op_oficina,@w_ofidest,op_num_banco,
        convert(varchar(3), op_toperacion),op_estado,null,null,op_fecha_ingreso,
        op_fecha_ven,op_monto,op_int_ganado,op_ente
      from   cob_pfijo..pf_emision_cheque,
             cob_pfijo..pf_mov_monet,
             cob_pfijo..pf_operacion
      where  op_estado    = 'CAN'
         and op_oficina   = @w_ofiorig
         and op_operacion = mm_operacion
         and mm_operacion = ec_operacion
         and mm_secuencia = ec_secuencia
         and ((mm_tran in (14543, 14903, 14919)
               and mm_producto  = @w_vxp)
               or (mm_tran in (14905, 14919)
                   and mm_producto  = @w_nefec))
         and ec_estado is null

    /* UNVERSO DE CLIENTES A PROCESAR */
    select distinct
      ente
    into   #clientes_procesar_of
    from   #temp_detalle
    order  by ente

    /* INSERTA LA SOLICITUD DE CADA CLIENTE */

    while 1 = 1
    begin
      select
        @w_cliente = null

      select top 1
        @w_cliente = ente
      from   #clientes_procesar_of

      if @@rowcount = 0
        break

      delete #clientes_procesar_of
      where  ente = @w_cliente

      /* VALIDA SI EL CLIENTE YA CUENTA CON UNA SOLICITUD VIGENTE */

      if exists(select
                  1
                from   cobis..cl_traslado
                where  tr_ente   = @w_cliente
                   and (tr_estado = 'I'
                         or tr_estado = 'A'))
      begin
        select
          @w_error = 101262,
          @w_mensaje = 'YA EXISTE UNA SOLICITUD DE TRASLADO VIGENTE'
        goto SIGCLIENTE_OF
      end

      /* CREA EL SECUENCIAL AUTOMATICO */
      exec sp_cseqnos
        @i_tabla     = 'cl_traslado',
        @o_siguiente = @w_secuencial out

      insert into cobis..cl_traslado
                  (tr_solicitud,tr_ente,tr_tipo_traslado,tr_estado,tr_fecha_sol,
                   tr_usr_ingresa,tr_oficina_dest,tr_ofi_solicitud,
                   tr_usr_autoriza
                   ,
                   tr_ofi_autoriza)
      values      (@w_secuencial,@w_cliente,@w_tipo_tras,'A',@w_fecha_proceso,
                   'optbatch',@w_ofidest,4069,'optbatch',4069)

      if @@error <> 0
      begin
        select
          @w_commit = 'N',
          @w_mensaje = 'ERROR AL INGRESAR LA SOLICITUD',
          @w_error = 101263
        goto SIGCLIENTE_OF
      end

      /* ACTUALIZA LOS SALDOS SI EL CLIENTE TIENE CUENTAS A,I */
      if exists(select
                  1
                from   sysobjects
                where  name = 'temp_ctas_act')
        drop table temp_ctas_act

      select
        cta_cobis
      into   temp_ctas_act
      from   #temp_detalle
      where  ente        = @w_cliente
         and td_producto = '4'
         and td_estado_ope in ('A', 'I')
      order  by cta_cobis

      if @@rowcount > 0
      begin
        /*  TIENE CUENTAS PARA CONSULTAR SALDOS */
        while 2 = 2
        begin
          select
            @w_cuenta = cta_cobis
          from   temp_ctas_act

          if @@rowcount = 0
            break

          delete temp_ctas_act
          where  cta_cobis = @w_cuenta

          /* CONSULTA LOS SALDOS DE LA CUENTA */
          exec cob_ahorros..sp_ahcalcula_saldo
            @i_fecha            = @w_fecha_proceso,
            @i_cuenta           = @w_cuenta,
            @o_saldo_para_girar = @w_saldo_dispo out,
            @o_saldo_contable   = @w_saldo_total out

          /* ACTUALIZA LA TABLA TEMPORAL CON LOS SALDOS ENCONTRADOS */
          update #temp_detalle
          set    td_saldo_total = @w_saldo_total,
                 td_saldo_dispo = @w_saldo_dispo
          where  cta_cobis = @w_cuenta

        end -- while 2=2
      end --cuentas para actualizar saldos

      /* INSERTA EN LA TABLA DE DETALLE LO QUE SE ENCUENTRA EN LA TEMPORAL */

      insert into cobis..cl_traslado_detalle
                  (td_solicitud,td_producto,td_ofi_orig,td_ofi_dest,td_operacion
                   ,
                   td_tipo_operacion,td_estado_ope,
                   td_saldo_total,td_saldo_dispo,
                   td_fecha_cons,
                   td_fecha_ven,td_monto,td_intereses,td_encanje,td_estado_batch
      )
        select
          @w_secuencial,td_producto,td_ofi_orig,td_ofi_dest,td_operacion,
          td_tipo_operacion,td_estado_ope,td_saldo_total,td_saldo_dispo,
          td_fecha_cons,
          td_fecha_ven,td_monto,td_intereses,td_encanje,'I'
        from   #temp_detalle
        where  ente = @w_cliente

      SIGCLIENTE_OF:
    end --while 1=1

  end --tipo traslado COM

  /***************************************************************************/
  return 0 -- si el programa llega a este punto, es que termin¾ exitosamente.

  ERRORFIN:

  print @w_mensaje + cast(@w_error as varchar(50))

  exec sp_errorlog
    @i_fecha     = @w_fecha_proceso,
    @i_error     = @w_error,
    @i_tran_name = @w_sp_name,
    @i_usuario   = 'optbatch',
    @i_tran      = @w_error,
    @i_rollback  = 'N'

  return @w_error

go

