/****************************************************************************/
/*     Archivo:             peparcom.sp                                     */
/*     Stored procedure:    sp_cobcom_profinal                              */
/*     Base de datos:       cob_remesas                                     */
/*     Producto:            Sub-Modulo de Personalizacion                   */
/*     Disenado por:        Carlos Munoz                                    */
/*     Fecha de escritura:  14 de Enero de 2010                             */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*   Este programa administra las operaciones de Insercion, Actualizacion   */
/*   Eliminacion, Busqueda  de la pantalla de parametrizacion de comisiones */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     14/01/2010      Carlos Munoz     Emision Inicial                     */
/*     04/04/2012      Luis C. Moreno   RQ 203 - Adición tipo de cobro por  */
/*                                      Transaccion                         */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/

use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_cobcom_profinal')
  drop proc sp_cobcom_profinal
go

create proc sp_cobcom_profinal
(
  @s_ssn           int = null,
  @s_user          login = null,
  @s_sesn          int = null,
  @s_term          varchar(30) = null,
  @s_date          datetime = null,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_rol           smallint = null,
  @s_ofi           smallint = null,
  @s_org_err       char(1) = null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           descripcion = null,
  @s_org           char(1) = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_trn           smallint = null,
  @t_show_version  bit = 0,
  @i_oper          char(3),
  @i_cons_profinal char(1) = 'N',
  @i_cons_cta      char(1) = 'N',
  @i_profinal      smallint = null,
  @i_categoria     char(3) = null,
  @i_posteo        char(1) = 'N',
  @i_pro_bancario  smallint = null,
  @i_tipo_ente     char(1) = null,
  @i_producto      tinyint = null,
  @i_moneda        tinyint = null,
  @i_filial        tinyint = null,
  @i_oficina       smallint = null,
  @i_cuenta        char(16) = null,
  @i_tipo_cta      char(3) = null,
  @i_tipo          char(1) = null,
  @i_numtot        smallint = null,
  @i_numcre        smallint = null,
  @i_numdeb        smallint = null,
  @i_numco         smallint = null,
  @i_fechavig      datetime = null,
  @i_formato_fecha tinyint = 101,
  @i_estado        char(1) = null,
  @i_opcion        char(1) = null,

  --REQ-203 - T = Administracion por transaccion,
  @i_transaccion   int = null,--REQ-203 - Codigo de la transaccion
  @i_numtrn        int = null,--REQ-203 - Numero de transacciones permitidas
  @i_canal         varchar(10) = null,--REQ-371 -
  @i_causa         varchar(10) = null,--REQ-371 -
  @i_monto         money = null --REQ-371 -

)
as
  declare
    @w_sp_name      varchar(32),
    @w_return       int,
    @w_error        int,
    @w_profinal     smallint,
    @w_posteo       char(1),
    @w_pro_bancario smallint,
    @w_tipo_ente    char(1),
    @w_producto     tinyint,
    @w_moneda       tinyint,
    @w_oficina      smallint,
    @w_sucursal     smallint,
    @w_filial       tinyint,
    @w_filas_return int,--MVE Mexicanizacion
    @w_tipo         char(1),
    @w_msg          mensaje

  -- VERSION VSS 4 --

  /* CARGA INICIAL DE VARIABLES DE TRABAJO */
  select
    @w_sp_name = 'sp_cobcom_profinal'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Validar el codigo de transaccion */
  if (@i_oper = 'I'
      and @t_trn <> 4110)
      or (@i_oper = 'D'
          and @t_trn <> 4112)
      or (@i_oper = 'U'
          and @t_trn <> 4111)
      or (@i_oper = 'S'
          and @t_trn <> 4109)
  begin
    select
      @w_error = 151051
    goto ERROR
  end

  /* ** Insert ** */
  if @i_oper = 'I'
  begin
    /* INGRESA REGISTRO DE TIPO DE TRANSACCION */
    if @i_opcion = 'T'
    begin
      /* VERIFICA EXISTENCIA DEL TIPO DE COBRO */
      if not exists (select
                       1
                     from   cob_remesas..pe_par_comision with (nolock)
                     where  pc_profinal  = @i_profinal
                        and pc_categoria = @i_categoria)
      begin
        select
          @w_error = 351564,
          @w_msg = 'LA COMISION PARA EL PRODUCTO ' + cast(@i_profinal as varchar
                   )
                   +
                   '-'
                   +
                   @i_categoria
                   + 'NO EXISTE'
        goto ERROR
      end

             
      /* VERIFICA EXISTENCIA DE LA TRANSACCION ASOCIADA AL TIPO DE COBRO */
      
      if exists (select
                   1
                 from   cob_remesas..pe_par_com_trn with (nolock)
                 where  pct_profinal    = @i_profinal
                    and pct_categoria   = @i_categoria
                    and pct_transaccion = @i_transaccion
                    and isnull(pct_causa,'0') = isnull(@i_causa, '0')
                    and isnull(pct_canal,'0') = isnull(@i_canal, '0')     
                    and pct_estado      <> 'E')
      --No tomar en cuenta las transacciones que ya se eliminaron
      begin
        select
          @w_error = 351563,
          @w_msg = 'LA TRANSACCION ' + cast(@i_transaccion as varchar) +
                   ' DEL PRODUCTO '
                   + cast(@i_profinal as varchar) + '-' + 'Y CATEGORIA' + @i_categoria +
                   'YA EXISTE'
        goto ERROR
      end
      begin tran
      /* INGRESA PARAMETRIZACION DE LA TRANSACCION */
      insert into pe_par_com_trn
                  (pct_profinal,pct_categoria,pct_transaccion,pct_numtrn,
                   pct_canal
                   ,
                   pct_causa,pct_monto,pct_estado,pct_fecha_crea
                   ,pct_fecha_mod)
      values      (@i_profinal,@i_categoria,@i_transaccion,@i_numtrn,@i_canal,
                   @i_causa,@i_monto,'V',getdate(),null)

      if @@error <> 0
      begin
        select
          @w_error = 353516,
          @w_msg = 'ERROR AL INSERTAR LA TRANSACCION ' + cast(@i_transaccion as
                   varchar)
                   + ' DEL PRODUCTO ' + cast(@i_profinal as varchar) + '-' +
                   @i_categoria
        goto ERROR
      end

      insert into pe_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                   ts_terminal,
                   ts_cod_alterno,ts_categoria,ts_tipo_rango,ts_operacion,
                   ts_tipo,
                   ts_val_medio,ts_fecha,ts_pro_final,ts_servicio_dis,ts_rubro,
                   ts_hora)
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   convert(int, @i_canal),@i_categoria,@i_numtrn,@i_oper,
                   @i_estado
                   ,
                   @i_monto,@s_date,@i_profinal,@i_transaccion,
                   @i_causa,
                   getdate() )

      if @@error <> 0
      begin
        select
          @w_error = 353516,
          @w_msg = 'ERROR AL INSERTAR EN LA TRANSACCION DE SERVICIO'
        goto ERROR
      end
      commit tran
      goto FIN
    end
    else
    /* INGRESA REGISTRO DE TIPO DE COBRO */
    begin
      /* VERIFICA EXISTENCIA DEL TIPO DE COBRO */
      if exists (select
                   1
                 from   cob_remesas..pe_par_comision with (nolock)
                 where  pc_profinal  = @i_profinal
                    and pc_categoria = @i_categoria)
      begin
        select
          @w_error = 351563,
          @w_msg = 'LA COMISION PARA EL PRODUCTO ' + cast(@i_profinal as varchar
                   )
                   +
                   '-'
                   +
                   @i_categoria
                   + 'YA EXISTE'
        goto ERROR
      end

      begin tran
      /* INGRESA PARAMETRIZACION DEL TIPO DE COBRO */
      insert into pe_par_comision
                  (pc_profinal,pc_categoria,pc_tipo,pc_numtot,pc_numcre,
                   pc_numdeb,pc_numco,pc_fechavig,pc_estado)
      values      (@i_profinal,@i_categoria,@i_tipo,@i_numtot,@i_numcre,
                   @i_numdeb,@i_numco,@i_fechavig,@i_estado)

      if @@error <> 0
      begin
        select
          @w_error = 353516,
          @w_msg = 'ERROR AL INSERTAR LA COMISION DEL PRODUCTO ' + cast(
                   @i_profinal
                   as
                   varchar) +
                   '-'
                   + @i_categoria
        goto ERROR
      end

      commit tran
      goto FIN
    end
  end

  /* ** Delete ** */
  if @i_oper = 'D'
  begin
    /* VERIFICA EXISTENCIA DEL TIPO DE COBRO */
    if not exists (select
                     1
                   from   cob_remesas..pe_par_comision with (nolock)
                   where  pc_profinal  = @i_profinal
                      and pc_categoria = @i_categoria)
    begin
      select
        @w_error = 351564,
        @w_msg = 'LA COMISION PARA EL PRODUCTO ' + cast(@i_profinal as varchar)
                 +
                 '-'
                 +
                 @i_categoria
                 + 'NO EXISTE'
      goto ERROR
    end

    if @i_opcion = 'T'
    begin
    /* VERIFICA EXISTENCIA DE LA TRANSACCION ASOCIADA AL TIPO DE COBRO */
      --Req 371 -- Se valida que el estado sea vigente
      if not exists (select
                       1
                     from   cob_remesas..pe_par_com_trn with (nolock)
                     where  isnull(pct_canal,
                                   '0') = isnull(@i_canal,
                                                 '0')
                        and isnull(pct_causa,
                                   '0') = isnull(@i_causa,
                                                 '0')
                        and pct_profinal          = @i_profinal
                        and pct_categoria         = @i_categoria
                        and pct_transaccion       = @i_transaccion
                        and pct_estado in ('V', 'M'))
      --IB 20/01/2013 Req. 371 Modificacion para eliminar registros con estado M
      begin
        select
          @w_error = 351564,
          --Se cambia mensaje por el requerido en el req 371
          --@w_msg   = 'LA TRANSACCION ' + cast(@i_transaccion as varchar) + ' DEL PRODUCTO ' + cast(@i_profinal as varchar) + '-' + 'Y CATEGORIA' + @i_categoria + 'NO EXISTE'
          @w_msg =
        'LA TRANSACCION A ELIMINAR NO EXISTE O NO SE ENCUENTRA VIGENTE'
        goto ERROR
      end

      begin tran
    /* ELIMINA INFORMACION DE LA TRANSACCION ASOCIADA AL TIPO DE COBRO */
      --Req 371 - Eliminaci¾n logica

      update pe_par_com_trn
      set    pct_estado = 'E',
             pct_fecha_mod = getdate()
      where  isnull(pct_canal,
                    '0') = isnull(@i_canal,
                                  '0')
         and isnull(pct_causa,
                    '0') = isnull(@i_causa,
                                  '0')
         and pct_profinal          = @i_profinal
         and pct_categoria         = @i_categoria
         and pct_transaccion       = @i_transaccion

      if @@error <> 0
      begin
        select
          @w_error = 353516,
          @w_msg = 'ERROR AL ELIMINAR LA TRANSACCION ' + cast(@i_transaccion as
                   varchar)
                   + ' DEL PRODUCTO ' + cast(@i_profinal as varchar) + '-' +'Y CATEGORIA' + 
                   @i_categoria
        goto ERROR
      end

      insert into pe_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                   ts_terminal,
                   ts_cod_alterno,ts_categoria,ts_tipo_rango,ts_operacion,
                   ts_tipo,
                   ts_val_medio,ts_fecha,ts_pro_final,ts_servicio_dis,ts_rubro,
                   ts_hora)
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   convert(int, @i_canal),@i_categoria,@i_numtrn,@i_oper,
                   @i_estado
                   ,
                   @i_monto,@s_date,@i_profinal,@i_transaccion,
                   @i_causa,
                   getdate() )

      if @@error <> 0
      begin
        select
          @w_error = 353516,
          @w_msg = 'ERROR AL INSERTAR EN LA TRANSACCION DE SERVICIO'
        goto ERROR
      end

      commit tran
      goto FIN
    end
    else
    begin
      begin tran
      /* ELIMINA INFORMACION DEL TIPO DE COBRO */
      delete pe_par_comision
      where  pc_profinal  = @i_profinal
         and pc_categoria = @i_categoria

      if @@error <> 0
      begin
        select
          @w_error = 353516,
          @w_msg = 'ERROR AL ELIMINAR LA COMISION DEL PRODUCTO ' + cast(
                   @i_profinal
                   as
                   varchar) +
                   '-'
                   + @i_categoria
        goto ERROR
      end

      delete pe_par_com_trn
      where  pct_profinal  = @i_profinal
         and pct_categoria = @i_categoria

      if @@error <> 0
      begin
        select
          @w_error = 353516,
          @w_msg = 'ERROR AL ELIMINAR LA TRANSACCION ' + cast(@i_transaccion as
                   varchar)
                   + ' DEL PRODUCTO ' + cast(@i_profinal as varchar) + '-' + 'Y CATEGORIA' +
                   @i_categoria
        goto ERROR
      end

      commit tran
      goto FIN
    end
  end

  /* ** Update ** */
  if @i_oper = 'U'
  begin
    /* VERIFICA EXISTENCIA DEL TIPO DE COBRO */
    if not exists (select
                     1
                   from   cob_remesas..pe_par_comision with (nolock)
                   where  pc_profinal  = @i_profinal
                      and pc_categoria = @i_categoria
                       or @i_categoria is null)
    begin
      select
        @w_error = 351564,
        @w_msg = 'LA COMISION PARA EL PRODUCTO ' + cast(@i_profinal as varchar)
                 +
                 '-'
                 +
                 @i_categoria
                 + 'NO EXISTE'
      goto ERROR
    end

    if @i_opcion = 'T'
    begin--Req 371 Se valida el canal y causa
      if not exists (select
                       1
                     from   pe_par_com_trn with (nolock)
                     where  isnull(pct_canal,
                                   '0') = isnull(@i_canal,
                                                 '0')
                        and isnull(pct_causa,
                                   '0') = isnull(@i_causa,
                                                 '0')
                        and pct_profinal          = @i_profinal
                        and pct_categoria         = @i_categoria
                        and pct_transaccion       = @i_transaccion
                        and pct_estado            = 'V')
      begin
        select
          @w_error = 351564,
          --Se cambia mensaje por el requerido en el req 371
          --@w_msg   = 'LA TRANSACCION ' + cast(@i_transaccion as varchar) + ' DEL PRODUCTO ' + cast(@i_profinal as varchar) + '-' + 'Y CATEGORIA' + @i_categoria + 'NO EXISTE'
          @w_msg =
        'LA TRANSACCION A ELIMINAR NO EXISTE O NO SE ENCUENTRA VIGENTE'
        goto ERROR
      end
      begin tran
      /* ACTUALIZA INFORMACION DE LA TRANSACCION ASOCIADA AL TIPO DE COBRO */
      update pe_par_com_trn
      set    pct_numtrn = @i_numtrn,
             pct_monto = @i_monto,
             pct_estado = 'M',
             pct_fecha_mod = getdate()
      where  isnull(pct_canal,
                    '0') = isnull(@i_canal,
                                  '0')
         and isnull(pct_causa,
                    '0') = isnull(@i_causa,
                                  '0')
         and pct_profinal          = @i_profinal
         and pct_categoria         = @i_categoria
         and pct_transaccion       = @i_transaccion

      if @@error <> 0
      begin
        select
          @w_error = 355519,
          @w_msg = 'ERROR AL ACTUALIZAR LA TRANSACCION ' + cast(@i_transaccion
                   as
                   varchar)
                   + ' DEL PRODUCTO ' + cast(@i_profinal as varchar) + '-' + 'Y CATEGORIA' +
                   @i_categoria
        goto ERROR
      end

      insert into pe_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                   ts_terminal,
                   ts_cod_alterno,ts_categoria,ts_tipo_rango,ts_operacion,
                   ts_tipo,
                   ts_val_medio,ts_fecha,ts_pro_final,ts_servicio_dis,ts_rubro,
                   ts_hora)
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   convert(int, @i_canal),@i_categoria,@i_numtrn,@i_oper,
                   @i_estado
                   ,
                   @i_monto,@s_date,@i_profinal,@i_transaccion,
                   @i_causa,
                   getdate() )

      if @@error <> 0
      begin
        select
          @w_error = 353516,
          @w_msg = 'ERROR AL INSERTAR EN LA TRANSACCION DE SERVICIO'
        goto ERROR
      end

      commit tran
      goto FIN
    end
    else
    begin
      begin tran
      /* OBTIENE EL TIPO DE COBRO ANTERIOR */
      select
        @w_profinal = pc_profinal,
        @w_tipo = pc_tipo
      from   pe_par_comision with (nolock)
      where  pc_profinal  = @i_profinal
         and (pc_categoria = @i_categoria
               or @i_categoria is null)

      if @@rowcount = 0
      begin
        select
          @w_error = 351564,
          @w_msg = 'NO SE ENCONTRO INFORMACION DE LA COMISION PARA EL PRODUCTO '
                   + cast(@i_profinal as varchar) + '-' + 'Y CATEGORIA' + @i_categoria
        goto ERROR
      end

      /*
      SI EL TIPO DE COBRO ANTERIOR ES DIFERENTE AL NUEVO ELIMINA LA INFORMACION
      DE LAS TRANSACCIONES ASOCIADAS AL ANTERIOR TIPO DE COBRO
      */
      if @w_tipo <> @i_tipo
      begin
        delete pe_par_com_trn
        where  pct_profinal  = @i_profinal
           and pct_categoria = @i_categoria

        if @@error <> 0
        begin
          select
            @w_error = 351564,
            @w_msg = 'LA TRANSACCION ' + cast(@i_transaccion as varchar) +
                     ' DEL PRODUCTO '
                     + cast(@i_profinal as varchar) + '-' + 'Y CATEGORIA' + @i_categoria +
                     'NO EXISTE'
          goto ERROR
        end
      end

      /* ACTUALIZA INFORMACION DEL TIPO DE COBRO */
      update pe_par_comision
      set    pc_tipo = @i_tipo,
             pc_numtot = @i_numtot,
             pc_numcre = @i_numcre,
             pc_numdeb = @i_numdeb,
             pc_numco = @i_numco,
             pc_fechavig = @i_fechavig,
             pc_estado = @i_estado
      where  pc_profinal  = @i_profinal
         and pc_categoria = @i_categoria

      if @@error <> 0
      begin
        select
          @w_error = 355519,
          @w_msg = 'ERROR AL ACTUALIZAR LA COMISION DEL PRODUCTO ' + cast(
                   @i_profinal
                   as
                   varchar)
                   + '-'
                   + @i_categoria
        goto ERROR
      end

      commit tran
      goto FIN
    end
  end

  /* Search */
  if @i_oper = 'S'
  begin
    /* CONSULTA LA INFORMACION DEL TIPO DE COBRO Y DE LAS TRANSACCIONES */
    select
      '1650' = pc_profinal,
      '1063' = pc_categoria,
      '1745' = pc_tipo,
      '1786' = pc_numtot,
      '1127' = pc_numcre,
      '1181 ' = pc_numdeb,
      '1491' = pc_numco,
      '1365' = convert(char(10), pc_fechavig, @i_formato_fecha),
      '1333' = pc_estado
    from   pe_par_comision
    where  pc_profinal  = @i_profinal
       and (pc_categoria = @i_categoria
             or @i_categoria is null)

    if @@rowcount = 0
    begin
      select
        @w_error = 351564
      goto ERROR
    end

    select
      '1789' = pct_transaccion,
      '1055' = pct_numtrn,
      '1205' = c.valor,
      '1042' = pct_canal,
      '1190' = (select
                               valor
                             from   cobis..cl_catalogo
                             where  tabla  = (select
                                                codigo
                                              from   cobis..cl_tabla
                                              where  tabla = 're_canales')
                                and codigo = pct_canal),
      '1072' = pct_causa,
      '1191' = case pct_transaccion
                              when '264' then (select
                                                 valor
                                               from   cobis..cl_catalogo
                                               where  tabla  =
                                              (select
                                                 codigo
                                               from   cobis..cl_tabla
                                               where  tabla = 'ah_causa_nd')
                                                  and codigo = pct_causa)
                              when '253' then (select
                                                 valor
                                               from   cobis..cl_catalogo
                                               where  tabla  =
                                              (select
                                                 codigo
                                               from   cobis..cl_tabla
                                               where  tabla = 'ah_causa_nc')
                                                  and codigo = pct_causa)
                            end,
      '1484' = pct_monto,
      '1333' = pct_estado,
      '1192' = case pct_estado
                                  when 'V' then 'VIGENTE'
                                  when 'E' then 'ELIMINADO'
                                  when 'M' then 'MODIFICADO'
                                end,
      '1357' = convert(char(10), pct_fecha_crea, @i_formato_fecha),
      '1359' = convert(char(10), pct_fecha_mod, @i_formato_fecha)
    from   pe_par_com_trn with (nolock),
           cobis..cl_tabla t with (nolock),
           cobis..cl_catalogo c with (nolock)
    where  pct_profinal  = @i_profinal
       and (pct_categoria = @i_categoria
             or @i_categoria is null)
       and t.tabla       = 'pe_transaccion'
       and c.tabla       = t.codigo
       and c.codigo      = pct_transaccion
    goto FIN

  end

  FIN:
  return 0

  ERROR:
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = @w_error,
    @i_msg   = @w_msg
  return @w_error

GO 
