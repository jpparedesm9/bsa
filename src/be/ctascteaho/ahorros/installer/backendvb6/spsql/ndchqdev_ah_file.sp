/************************************************************************/
/*  Archivo:                ndchqdev_ah_file.sp                         */
/*  Stored procedure:       sp_ndchqdev_ah_file                         */
/*  Base de datos:          cob_ahorros                                 */
/*  Producto:               Cuentas de Ahorros                          */
/*  Disenado por:           Julio Navarrete V.                          */
/*  Fecha de escritura:     25-Nov-1994                                 */
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
/*                              PROPOSITO                               */
/*  Este programa procesa la transaccion de nota de debito por          */
/*  cheque devuelto enn forma sequencial.(Logica de la transaccion)     */
/*  2502 = Nota de debito por cheque devuelto.                          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA       AUTOR           RAZON                                   */
/*  25/Nov/1994 Guadalupe V.    Validacion                              */
/*              PERSONALIZACION BANCO DE PRESTAMOS                      */
/*  24/Feb/2010 JLoyo           Invoca directamente desde VBatch        */
/*  02/May/2016   Juan Tagle    Migración a CEN                         */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_ndchqdev_ah_file')
   drop proc sp_ndchqdev_ah_file
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_ndchqdev_ah_file (
    @s_rol          smallint    = 1,
    @s_user         varchar(10) = null,
    @s_term         varchar(10) = 'consola',
    @t_show_version bit = 0,
    @i_fecha        datetime    = null,
    @i_dpto         tinyint     = 1,
    @i_turno        smallint    = null,
    @i_canal        smallint    = 4,
    @i_param1       datetime    = null, -- Fecha de proceso
    @o_procesadas   int         = null out
)
as
declare
@w_return           int,
@w_sp_name          varchar(30),
@w_alicuota         float,
@w_alic             money,
@w_disponible       money,
@w_contable         money,
@w_promedio1        money,
@w_prom_disp        money,
@w_12h              money,
@w_numdeci          tinyint,
@w_ssn              int,
@w_mensaje          mensaje,
@w_tipo_bloqueo     varchar(3),
@w_tipo_prom        char(1),
@w_fldeci           char(1),
@w_trx              int,
@w_categoria        char(1),
@w_tipo_ente        char(1),
@w_rol_ente         char(1),
@w_tipo_def         char(1),
@w_prod_banc        smallint,
@w_producto         tinyint,
@w_tipo             char(1),
@w_reentry          varchar(255),
@w_codigo           int,
@w_personaliza      char(1),
@w_comision         money,
@w_cuenta           int,
@w_factor           int,
@w_prod             int,
@w_filial           tinyint,
@w_oficina          smallint,
@w_ofiori           smallint,
@w_oficina_p        smallint,
@w_control          smallint,
@w_promedio         char(1),
@w_flag             smallint,
@w_signo            char(1),
@w_clase_clte       char(1),
@w_fecdia           smalldatetime,
@w_debmes           money,
@w_debhoy           money,
@w_ult              tinyint,
@w_24h              money,
@w_48h              money,
@w_remesas          money,
@w_cta_depositada   int,
@w_contador         int,
@w_total            money,
@w_moneda           tinyint,
@w_cta_banco        cuenta,
@w_cta              int,
@w_cliente          int,
@w_lp_sec           int,
@w_estado           char(1),
@w_sucursal         smallint,
@w_lineas           smallint,
@w_cheque_rec       int,
@w_monto            money ,
@w_tipo_atributo    char(1),
@w_tipo_cheque      char(1),
@w_causa            varchar(3),
@w_tipocta_super    char(1),
@w_ciudad           int,
@w_codigo_pais      catalogo,
@w_srv              varchar(30),
@w_debug            char(1),
@w_error            int,
@w_cta_girada       cuenta,
@w_fecha_depo       datetime,
@w_num_cheque       int

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_ndchqdev_file'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

/* Lectura para login operador batch*/
select @s_user = pa_char from cobis..cl_parametro
where pa_nemonico = 'LOB'
and pa_producto = 'ADM'

select  @w_debug = 'N'

if @i_param1 is null and @i_fecha is null
begin
   --Falta parametro obligatorio
   exec cobis..sp_cerror
   @i_num       = 101114
   return 101114
end

if @i_fecha is null
   select @i_fecha = @i_param1

create table #registros_error (cta int , cheque_rec int)

if @i_turno is null
    select @i_turno = @s_rol

select @w_contador = 0
begin tran

  /* Encuentra el SSN inicial */
  select @w_ssn = se_numero
  from   cobis..ba_secuencial

  if @@rowcount <> 1
  begin
    /* Error en lectura de SSN */
    exec cobis..sp_cerror
         @i_num       = 201163
    return 201163
  end

  update cobis..ba_secuencial
  set    se_numero = @w_ssn + 10000

  if @@rowcount <> 1
  begin
     /* Error en actualizacion de SSN */
     exec cobis..sp_cerror
     @i_num       = 205031
     return 205031
  end

  select @w_codigo_pais = pa_char
  from  cobis..cl_parametro
  where pa_nemonico = 'ABPAIS'
  and   pa_producto = 'ADM'

  if @@rowcount = 0
  begin
     /** No existe parametro de pais local **/
     exec cobis..sp_cerror
     @t_debug  = null,
     @t_file   = null,
     @t_from   = @w_sp_name,
     @i_num    = 101190
     return 101190
  end


commit tran

select @w_fecdia = convert(varchar(10),@i_fecha,101)

select @w_srv = nl_nombre
from   cobis..ad_nodo_oficina
where  nl_nodo = 1

declare ndchqdev cursor
for select cr_cta_depositada,
       cr_valor,
       cr_oficina,
       cr_tipo_cheque,
       cr_cau_devolucion,
       cr_cheque_rec,
       cr_ciudad_p,
       cr_oficina_p,
       cr_cta_girada,
       cr_num_cheque
from cob_remesas..re_cheque_rec
where cr_fecha_ing   = @w_fecdia
  and cr_producto    = 4
  and cr_status      = 'D'
  and cr_estado      in ('N','E')
  and cr_tipo_cheque in ('T', 'L')

open ndchqdev
fetch ndchqdev into
      @w_cta_depositada,
      @w_total,
      @w_ofiori,
      @w_tipo_cheque,
      @w_causa,
      @w_cheque_rec,
      @w_ciudad,
      @w_oficina_p,
      @w_cta_girada,
      @w_num_cheque
if @@fetch_status = -2
begin
     print ' No inicio el cursor'
     close ndchqdev
     deallocate ndchqdev
     exec cobis..sp_cerror
     @i_num  = 201154
     select  @o_procesadas = @w_contador
     return 201154
end
else
if  @@fetch_status <> 0
begin
   close ndchqdev
   deallocate ndchqdev
   select  @o_procesadas = @w_contador
   return 0
end
while @@fetch_status = 0
begin
   /* Validacion de la causa de la devolucion */
   if (@w_causa is null) or (ltrim(@w_causa) = '') or (rtrim(@w_causa) = '')
   begin
      select @w_cta_banco = convert(varchar(24), @w_cta_depositada)
      insert #registros_error values (@w_cta_depositada, @w_cheque_rec)

      select
      @w_error   = 0,
      @w_mensaje = 'CAUSA DE DEVOLUCION NO VALIDA'
      goto ERROR
   end

   print '===> Cuenta :  ' + cast ( @w_cta_depositada as varchar) + ' Valor cheque  ' + cast ( @w_total as varchar)
   /* Modo de correccion */
   select @w_factor = 1, @w_signo = 'D'
   /* Encuentra datos de trabajo de la cuenta */
   select
   @w_cliente       = ah_cliente,
   @w_tipo_prom     = ah_tipo_promedio,
   @w_12h           = ah_12h,
   @w_disponible    = ah_disponible,
   @w_promedio1     = ah_promedio1,
   @w_prom_disp     = ah_prom_disponible,
   @w_categoria     = ah_categoria,
   @w_tipo_ente     = ah_tipocta,
   @w_rol_ente      = ah_rol_ente,
   @w_tipo_def      = ah_tipo_def,
   @w_prod_banc     = ah_prod_banc,
   @w_producto      = ah_producto,
   @w_tipo          = ah_tipo,
   @w_codigo        = ah_default,
   @w_personaliza   = ah_personalizada,
   @w_trx           = ah_contador_trx,
   @w_debmes        = ah_debitos,
   @w_debhoy        = ah_debitos_hoy,
   @w_24h           = ah_24h,
   @w_remesas       = ah_remesas,
   @w_48h           = ah_48h,
   @w_moneda        = ah_moneda,
   @w_cta_banco     = ah_cta_banco,
   @w_clase_clte    = ah_clase_clte,
   @w_lineas        = ah_linea,
   @w_tipocta_super = ah_tipocta_super
   from   cob_ahorros..ah_cuenta
   where  ah_cuenta = @w_cta_depositada

   /* Determinacion de vigencia de cuenta */
   exec @w_return = cob_ahorros..sp_ctah_vigente
   @i_cta_banco    = @w_cta_banco,
   @i_moneda       = @w_moneda,
   @o_cuenta       = @w_cta out,
   @o_filial       = @w_filial out,
   @o_oficina      = @w_oficina out,
   @o_tpromedio    = @w_promedio out

   if @w_return <> 0
   begin
     print 'Procesando...1'
     insert #registros_error values (@w_cta_depositada, @w_cheque_rec)

     select @w_mensaje = mensaje, @w_error = numero
     from   cobis..cl_errores
     where  numero = @w_return

      if @w_mensaje is null
         select @w_mensaje = 'ERROR EN SP DE CUENTA VIGENTE', @w_error = 0

     goto ERROR
   end

   if @w_codigo_pais = 'CO' -- Colombia
      select @w_contable = @w_disponible + @w_12h + @w_24h + @w_48h
   else
      select @w_contable = @w_disponible + @w_12h + @w_24h + @w_48h + @w_remesas


   /* Encuentra los decimales a utilizar */
   select @w_fldeci = mo_decimales
     from cobis..cl_moneda
    where mo_moneda = @w_moneda

   if @w_fldeci = 'S'
      select @w_numdeci = pa_tinyint
        from cobis..cl_parametro
       where pa_producto = 'AHO'
         and pa_nemonico = 'DCI'
   else
      select @w_numdeci = 0

   /*  Determinacion de bloqueo de cuenta  */

   select  @w_tipo_bloqueo = cb_tipo_bloqueo
     from  cob_ahorros..ah_ctabloqueada
    where  cb_cuenta = @w_cta_depositada
      and  cb_estado = 'V'
      and  (cb_tipo_bloqueo = '2'
       or  cb_tipo_bloqueo = '3')
   if @@rowcount <> 0
   begin
      print 'Procesando...2'
      insert #registros_error values (@w_cta_depositada, @w_cheque_rec)

      select @w_mensaje = mensaje, @w_error = numero
      from   cobis..cl_errores
      where  numero = 201008

      if @w_mensaje is null
         select @w_mensaje = 'CUENTA BLOQUEADA', @w_error = 201008

      goto ERROR
   end

   /* Encuentra alicuota del promedio */
   select  @w_alicuota      = fp_alicuota
     from  cob_ahorros..ah_fecha_promedio
    where  fp_tipo_promedio = @w_tipo_prom
      and  fp_fecha_inicio  = @w_fecdia
   if @@rowcount = 0
   begin
      print 'Procesando...3'
      insert #registros_error values (@w_cta_depositada, @w_cheque_rec)

      select @w_mensaje = mensaje, @w_error = numero
      from   cobis..cl_errores
      where  numero = 201060

      if @w_mensaje is null
         select @w_mensaje = 'ERROR EN TABLA DE FECHAS PROMEDIO', @w_error = 201060

      goto ERROR
   end

   /* Validar Fondos */
   /* Debita del disponible tenga o no fondos suficientes */
   if @w_total > @w_12h
   begin
      if @w_total > @w_disponible
      begin
         print 'Procesando...4'
         insert #registros_error values (@w_cta_depositada, @w_cheque_rec)

         select @w_mensaje = mensaje, @w_error = numero
         from   cobis..cl_errores
         where  numero = 251027

         if @w_mensaje is null
            select @w_mensaje = 'CUENTA SIN FONDOS DISPONIBLES', @w_error = 251027

         goto ERROR
      end
      else
      begin
         select @w_disponible = @w_disponible - @w_total,
                @w_flag       = 1
      end
   end
   else
      select @w_12h  = @w_12h - @w_total,
             @w_flag = 2

    /* Actualizacion de tabla de cuentas de ahorros */
   select @w_alic = convert (money , round((@w_total * @w_alicuota), @w_numdeci))
   --select @w_promedio1 = @w_promedio1 - @w_alic * @w_factor
   if @w_flag = 1
   begin
      select @w_promedio1 = @w_promedio1 - @w_alic * @w_factor
      select @w_prom_disp = @w_prom_disp - @w_alic * @w_factor
   end

   select @w_debmes = @w_debmes + @w_total * @w_factor,
          @w_debhoy = @w_debhoy + @w_total * @w_factor

   select @w_contable = @w_contable - @w_total * @w_factor
   select @w_trx = @w_trx + 1

   --/* Cambio a la bandera flag para la contabilizacion automatica */
   --if @w_tipo_cheque <> 'L'
   --    select @w_flag = 1
   --else
   --    select @w_flag = 2

   if @w_debug = 'S'
   begin
      select
      ah_cta_banco,   ah_disponible,    ah_promedio1,    ah_prom_disponible,
      ah_12h,         ah_fecha_ult_mov, ah_contador_trx, ah_debitos,
      ah_debitos_hoy, ah_linea, ah_cuenta
      from cob_ahorros..ah_cuenta
      where ah_cuenta = @w_cta_depositada

      select cd_cuenta, cd_ciudad, cd_fecha_efe, cd_valor_efe
      from   cob_ahorros..ah_ciudad_deposito
      where  cd_cuenta    = @w_cta_depositada
      and    cd_ciudad    = (select of_ciudad from cobis..cl_oficina where of_oficina = @w_oficina_p )  -- @w_ciudad
      and    cd_fecha_efe = @i_fecha
   end

   begin tran
      select @w_lineas = @w_lineas + 1,
             @w_ssn    = @w_ssn + 1
      update cob_ahorros..ah_cuenta
        set ah_disponible     = @w_disponible,
            ah_promedio1      = @w_promedio1,
            ah_prom_disponible= @w_prom_disp,
            ah_12h            = @w_12h,
            ah_fecha_ult_mov  = @w_fecdia,
            ah_contador_trx   = @w_trx,
            ah_debitos        = @w_debmes,
            ah_debitos_hoy    = @w_debhoy,
            ah_linea          = @w_lineas
      where ah_cuenta = @w_cta_depositada
      if @@rowcount <> 1
      begin
         print 'Procesando...5'
         rollback
         insert #registros_error values (@w_cta_depositada, @w_cheque_rec)

         select @w_mensaje = mensaje, @w_error = numero
         from   cobis..cl_errores
         where  numero = 205000

         if @w_mensaje is null
            select @w_mensaje = 'ERROR EN ACTUALIZACION DE CUENTA', @w_error = 205000

         goto ERROR
      end

      if @w_flag = 2
      begin

         select @w_fecha_depo = max(lc_fecha_proc)
         from  cob_remesas..pd_locales
         where lc_cta_depositada = @w_cta_banco
         and   lc_num_cheque     = @w_num_cheque
         and   lc_valor          = @w_total
         and   lc_oficina        = @w_oficina_p
         and   lc_producto       = 4
         and   lc_cta_girada     = @w_cta_girada

         update cob_ahorros..ah_ciudad_deposito
         set   cd_valor_efe  = cd_valor_efe - @w_total
         where cd_cuenta     = @w_cta_depositada
         and   cd_ciudad     = (select of_ciudad from cobis..cl_oficina where of_oficina = @w_oficina_p )  --  @w_ciudad
         and   cd_fecha_efe  = @i_fecha
         and   cd_fecha_depo = @w_fecha_depo

         if @@rowcount <> 1 or @@error <> 0
         begin
            print 'cta_depositada ' + cast (@w_cta_depositada  as varchar) + ' @w_ciudad ' + cast (@w_ciudad as varchar )  + '  fecha ' + cast (@i_fecha   as varchar)
            print 'Valor a restar ' + cast (@w_total as varchar)
            print 'Procesando...6'
            rollback
            insert #registros_error values (@w_cta_depositada, @w_cheque_rec)

            select @w_mensaje = mensaje, @w_error = numero
            from   cobis..cl_errores
            where  numero = 205049

            if @w_mensaje is null
               select @w_mensaje = 'ERROR AL ACTUALIZAR TABLA DE CIUDAD DEPOSITO', @w_error = 205049

            goto ERROR
         end
      end


      /* Grabacion de Linea Pendiente por monto de cheque Devuelto*/
      /* Genera numero de Control para linea de libreta */
      exec @w_return = cobis..sp_cseqnos
      @t_from        = @w_sp_name,
      @i_tabla       = 'ah_control',
      @o_siguiente   = @w_control out
      if @w_return <> 0
         return @w_return
      if @w_control > 9999
      begin
           select @w_control = 0

           update cobis..cl_seqnos
           set    siguiente = 0
           where  tabla     = 'ah_control'

           if @@rowcount = 0 or @@error <> 0
           begin
              print 'Procesando...7'
              rollback
              insert #registros_error values (@w_cta_depositada, @w_cheque_rec)

              select @w_mensaje = mensaje, @w_error = numero
              from   cobis..cl_errores
              where  numero = 255005

              if @w_mensaje is null
                 select @w_mensaje = 'NO ACTUALIZANDO SEQNOS PARA TABLA ah_control', @w_error = 255005

              goto ERROR
           end
      end

      /* Genera numero de linea Pendiente */
      exec @w_return = cobis..sp_cseqnos
           @t_from      = @w_sp_name,
           @i_tabla     = 'ah_lpendiente',
           @o_siguiente = @w_lp_sec out
      if @w_return <> 0
         return @w_return
      if @w_lp_sec  > 2147483640
      begin
           select @w_lp_sec  = 1
           update cobis..cl_seqnos
           set   siguiente = @w_lp_sec
           where tabla = 'ah_lpendiente'
           if @@error <> 0
           begin
              print 'Procesando...8'
              rollback
              insert #registros_error values (@w_cta_depositada, @w_cheque_rec)

              select @w_mensaje = mensaje, @w_error = numero
              from   cobis..cl_errores
              where  numero = 105001

              if @w_mensaje is null
                 select @w_mensaje = 'NO ACTUALIZANDO SEQNOS PARA TABLA ah_lpendiente', @w_error = 105001

              goto ERROR
           end
      end

      /* Inserta en Lineas Pendientes */
      insert into cob_ahorros..ah_linea_pendiente
             (lp_cuenta, lp_linea, lp_nemonico, lp_valor,
              lp_fecha, lp_control, lp_signo, lp_enviada)
      values (@w_cta_depositada, @w_lp_sec, 'NDDA', @w_total,
              @i_fecha, @w_control, @w_signo, 'N')
      if @@rowcount <> 1
      begin
         print 'Procesando...9'
         rollback
         insert #registros_error values (@w_cta_depositada, @w_cheque_rec)

         select @w_mensaje = mensaje, @w_error = numero
         from   cobis..cl_errores
         where  numero = 205001

         if @w_mensaje is null
            select @w_mensaje = 'ERROR CREANDO LINEAS PENDIENTES', @w_error = 205001

         goto ERROR
      end

      /* Transaccion Monetaria */
      /* campo vcomision, @w_comision inexistente, borrado */
      insert into cob_ahorros..ah_notcredeb
             (secuencial,     ssn_branch,   tipo_tran,  oficina,   alterno,
              usuario,        terminal,     correccion,
              sec_correccion, reentry,      origen,
              nodo,           fecha,        cta_banco,  signo,     causa,     val_cheque,
              valor,          remoto_ssn,   moneda,     saldocont, indicador,
              saldodisp,      departamento, filial,
              banco,          oficina_cta,  prod_banc,  categoria,
              tipocta_super,  turno,        hora,
              canal,          cliente,      clase_clte)
      values (@w_ssn,           @w_ssn,     240,          @w_ofiori, 1,
              @s_user,          @s_term,    'N',
              null,             'N',        'L',
              @w_srv,           @w_fecdia,  @w_cta_banco, @w_signo, @w_causa, @w_total,
              @w_total,         null,       @w_moneda,    @w_contable, @w_flag,
              @w_disponible,    @i_dpto,    @w_filial,
              null,             @w_oficina, @w_prod_banc, @w_categoria,
              @w_tipocta_super, @i_turno,   getdate(),
              @i_canal,         @w_cliente, @w_clase_clte)
      if @@error <> 0
      begin
         print 'Procesando...10'
         rollback
         insert #registros_error values (@w_cta_depositada, @w_cheque_rec)

         select @w_mensaje = mensaje, @w_error = numero
         from   cobis..cl_errores
         where  numero = 203000

         if @w_mensaje is null
            select @w_mensaje = 'ERROR INSERTANDO TRANSACCION MONETARIA', @w_error = 203000

         goto ERROR
      end
      select @w_return = 0

      if @w_personaliza = 'N'
      begin
         select @w_sucursal = isnull(of_regional,of_oficina)
         from  cobis..cl_oficina
         where of_oficina = @w_oficina

         select @w_tipo_atributo = tipo_atributo
         from   tempdb..pe_tipo_atributo
         where  filial          = @w_filial
         and    sucursal        = @w_sucursal
         and    producto        = 4
         and    moneda          = @w_moneda
         and    pro_bancario    = @w_prod_banc
         and    tipo_cta        = @w_tipo_ente
         and    servicio        = 'CDEV'
         and    rubro           = '11'

         if @@rowcount <> 1
         begin
            print ' oficina ' + cast (@w_oficina  as varchar)
            print 'Procesando...11'
            rollback
            insert #registros_error values (@w_cta_depositada, @w_cheque_rec)

            select @w_mensaje = 'ERROR AL BUSCAR EL TIPO DE ATRIBUTO', @w_error = 0

            goto ERROR
         end

         if @w_tipo_atributo = 'B' /* Saldo promedio */
            select @w_monto = @w_promedio1
         else
         if @w_tipo_atributo = 'C' /* Saldo Contable */
            select @w_monto =  @w_contable
         else
         if @w_tipo_atributo = 'A' /* Saldo Disponible */
            select @w_monto =  @w_disponible
         else
         if @w_tipo_atributo = 'E' /* Promedio Disponible */
            select @w_monto =  @w_prom_disp
         else
            select @w_monto = $1

         select @w_comision =  valor
         from   tempdb..cdev4
         where  tipo_ente     = @w_tipo_ente
         and    pro_bancario  = @w_prod_banc
         and    filial        = @w_filial
         and    sucursal      = @w_sucursal
         and    producto      = 4
         and    moneda        = @w_moneda
         and    categoria     = @w_categoria
         and    servicio_dis  = 'CDEV'
         and    rubro         = '11'
         and    tipo_atributo = @w_tipo_atributo
         and    rango_desde  <= @w_monto
         and    rango_hasta   > @w_monto

         if @@rowcount <> 1
         begin
            print 'Procesando...12'
            rollback
            insert #registros_error values (@w_cta_depositada, @w_cheque_rec)

            select @w_mensaje = 'ERROR EN TABLA TMP DE PERSONALIZACION', @w_error = 0

            goto ERROR
         end
      end
      else
      begin
         exec @w_return = cob_remesas..sp_genera_costos
         @t_debug        = null,
         @t_file         = null,
         @t_from         = @w_sp_name,
         @i_valor        = 1,
         @i_fecha        = @w_fecdia,
         @i_categoria    = @w_categoria,
         @i_tipo_ente    = @w_tipo_ente,
         @i_rol_ente     = @w_rol_ente,
         @i_tipo_def     = @w_tipo_def,
         @i_prod_banc    = @w_prod_banc,
         @i_producto     = @w_producto,
         @i_moneda       = @w_moneda,
         @i_tipo         = @w_tipo,
         @i_codigo       = @w_codigo,
         @i_servicio     = 'CDEV',
         @i_rubro        = '11',
         @i_disponible   = @w_disponible,
         @i_contable     = @w_contable,
         @i_promedio     = @w_promedio1,
         @i_prom_disp    = @w_prom_disp,
         @i_personaliza  = @w_personaliza,
         @i_filial       = @w_filial,
         @i_oficina      = @w_oficina,
         @o_valor_total  = @w_comision out
         if @w_return <> 0
         begin
            print 'Procesando...13'
            rollback
            insert #registros_error values (@w_cta_depositada, @w_cheque_rec)

            select @w_mensaje = 'ERROR AL HALLAR COMISION', @w_error = @w_return

            goto ERROR
         end
      end

      -- print ' Comision ' +  cast ( @w_comision as varchar)
      if @w_comision > 0
      begin
         select @w_ssn = @w_ssn + 1
         exec @w_return = cob_ahorros..sp_ahndc_automatica
         @s_srv         = @w_srv,
         @s_ssn         = @w_ssn,
         @s_ssn_branch  = @w_ssn,
         @s_ofi         = @w_ofiori,
         @s_rol         = @s_rol,
         @s_user        = @s_user,
         @s_term        = @s_term,
         @t_trn         = 264,
         @i_cta         = @w_cta_banco,
         @i_val         = @w_comision,
         @i_cau         = '4',
         @i_mon         = @w_moneda,
         @i_fecha       = @w_fecdia,
         @i_imp         = 'S',
         @i_turno       = @i_turno
         if @w_return <> 0
         begin
            print 'Procesando...14'
            rollback
            insert #registros_error values (@w_cta_depositada, @w_cheque_rec)

            select @w_mensaje = mensaje, @w_error = @w_return
             from cobis..cl_errores
            where numero = @w_return

            if @w_mensaje is null
               select @w_mensaje = 'ERROR AL COBRAR COMISION', @w_error = @w_return

            goto ERROR
         end
      end
      select @w_contador = @w_contador + 1,
             @w_ssn      = @w_ssn + 1

   if @w_debug = 'S'
   begin
      select
      ah_cta_banco,   ah_disponible,    ah_promedio1,    ah_prom_disponible,
      ah_12h,         ah_fecha_ult_mov, ah_contador_trx, ah_debitos,
      ah_debitos_hoy, ah_linea, ah_cuenta
      from cob_ahorros..ah_cuenta
      where ah_cuenta = @w_cta_depositada

      select cd_cuenta, cd_ciudad, cd_fecha_efe, cd_valor_efe
      from   cob_ahorros..ah_ciudad_deposito
      where  cd_cuenta    = @w_cta_depositada
      and    cd_ciudad    = (select of_ciudad from cobis..cl_oficina where of_oficina = @w_oficina_p) -- @w_ciudad
      and    cd_fecha_efe = @i_fecha

      select * from cob_ahorros..ah_notcredeb where cta_banco = @w_cta_banco

      rollback
   end
   else
      commit tran
   goto LEER

   ERROR:

   print @w_mensaje

   exec sp_errorlog
   @i_fecha        = @i_fecha,
   @i_error        = @w_error,
   @i_usuario      = 'batch',
   @i_tran         = 0,
   @i_cuenta       = @w_cta_banco,
   @i_descripcion  = @w_mensaje,
   @i_programa     = @w_sp_name

   LEER:
      fetch ndchqdev into
      @w_cta_depositada,
      @w_total,
      @w_ofiori,
      @w_tipo_cheque,
      @w_causa,
      @w_cheque_rec,
      @w_ciudad,
      @w_oficina_p,
      @w_cta_girada,
      @w_num_cheque

   if @@fetch_status = -2
   begin
      close ndchqdev
      deallocate ndchqdev
      exec cobis..sp_cerror
      @i_num       = 351037
      select  @o_procesadas = @w_contador
      return 351037
   end
end

close ndchqdev
deallocate ndchqdev

print ' Actualizacion estado de re_cheque_rec '
begin tran
declare act_estado cursor
    for
 select cr_cta_depositada,
        cr_estado,
        cr_cheque_rec
   from cob_remesas..re_cheque_rec
  where cr_fecha_ing = @w_fecdia
    and cr_producto = 4
    and cr_status = 'D'
    and cr_estado in ('N','E')
    and cr_tipo_cheque in ('T','L')
    for
 update of cr_estado

open act_estado

fetch act_estado into
      @w_cta_depositada,
      @w_estado  ,
      @w_cheque_rec

if @@fetch_status = -1
begin
   close act_estado
   deallocate act_estado
   exec cobis..sp_cerror
   @i_num  = 201154
   select  @o_procesadas = @w_contador
   return 201154
end
else
   if  @@fetch_status <> 0
   begin
      close act_estado
      deallocate act_estado
      select  @o_procesadas = @w_contador
      return 0
   end

while @@fetch_status = 0
begin
    if exists (select 1
                 from #registros_error
                where cta        = @w_cta_depositada
                  and cheque_rec = @w_cheque_rec)

       update cob_remesas..re_cheque_rec
          set cr_estado = 'E'
        where current of act_estado

    else

       update cob_remesas..re_cheque_rec
          set cr_estado = 'P'
        where current of act_estado

    fetch act_estado into
          @w_cta_depositada,
          @w_estado,
          @w_cheque_rec
end
commit tran
close act_estado
deallocate act_estado

drop table #registros_error
select  @o_procesadas = @w_contador
return 0

go

