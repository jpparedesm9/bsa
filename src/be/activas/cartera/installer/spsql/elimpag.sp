/************************************************************************/
/*   Archivo          :       elimpag.sp                                */
/*   Stored procedure :       sp_eliminar_pagos                         */
/*   Base de datos    :       cob_cartera                               */
/*   Producto         :       Cartera                                   */
/*   Disenado por     :       Francisco Yacelga                         */
/*   Fecha de escritura:      18/Nov/97                                 */
/************************************************************************/
/*                      IMPORTANTE                                      */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                    PROPOSITO                                         */
/*   Eliminar Pagos No Aplicados                                        */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA            AUTOR          MODIFICACION                        */
/* JUL-2004          Elcira Pelaez  Reverso con forma correcta          */
/* junio-2006        Elcira Pelaez  def 6737 BAC                        */
/* junio-2006        Elcira Pelaez  def 6767 BAC                        */
/* julio-24-2006     Elcira Pelaez  def 6780 BAC                        */
/* 23/abr/2010       Fdo Carvajal   INTERFAZ AHORROS                    */
/* 04/10/2010        Yecid Martinez Fecha valor baja Intensidad         */
/*                                  NYMR 7x24                           */
/* 19/01/2012        G. Cuesta      Reverso pagoc canales externos CNB  */
/*                                  i_operacion= 'D'                    */
/************************************************************************/
use cob_cartera
go
 
if exists (select 1 from sysobjects where name = 'sp_eliminar_pagos')
   drop proc sp_eliminar_pagos
   
   
   
go
create proc sp_eliminar_pagos (
   @s_ssn               int         = null,
   @s_srv               varchar(30) = null,
   @s_date              datetime    = null,
   @s_user              login       = null,
   @s_term              descripcion = null,
   @s_corr              char(1)     = null,
   @s_ssn_corr          int         = null,
   @s_ofi               smallint    = null,
   @t_rty               char(1)     = null,
   @t_debug             char(1)     = 'N',
   @t_file              varchar(14) = null,
   @t_trn               smallint    = null,
   @i_banco             cuenta      = null,
   @i_operacion         char(1)     = null,
   @i_secuencial_ing    int         = null,
   @i_formato_fecha     int         = null,
   @i_en_linea          char(1)     = 'S',
   @i_pago_ext          char(1)     = 'N'

   )
   as
   declare
   
   @w_sp_name              varchar(32),
   @w_return               int,
   @w_error                int,
   @w_operacionca          int,
   @w_estado               varchar(3),
   @w_secuencial_rpa       int,
   @w_secuencial           int,
   @w_prod_rev             catalogo,
   @w_abd_monto_mpg        money,
   @w_abd_moneda           smallint,
   @w_abd_tipo             varchar(3) ,
   @w_gar_admisible        char(1),
   @w_reestructuracion     char(1),
   @w_calificacion         char(1),
   @w_abd_cuenta           cuenta,
   @w_tipo_oficina_ifase   char(1),
   @w_oficina_ifase        int,
   @w_codvalor             int,
   @w_oficina_op           int,
   @w_toperacion           catalogo,
   @w_forma_reversa        catalogo,
   @w_forma_original       catalogo,
   @w_registro             char(50),
   @w_banco_alterno        cuenta,
   @w_forma_pago           catalogo,
   @w_linea_fpago          catalogo,
   @w_op_tipo              catalogo,
   @w_secuencial_retro     int,
   @w_cliente              int,
   @w_cp_pcobis            smallint

   select 
   @w_sp_name = 'sp_eliminar_pagos'
   
   select 
   @w_operacionca      = op_operacion,
   @w_gar_admisible    = op_gar_admisible,    
   @w_reestructuracion = op_reestructuracion,   
   @w_calificacion     = op_calificacion,    
   @w_oficina_op       = op_oficina,
   @w_toperacion       = op_toperacion,
   @w_op_tipo          = op_tipo,
   @w_cliente          = op_cliente
   from   ca_operacion
   where  op_banco = @i_banco
   
   -- CONSULTA DE LOS PAGOS 
   
   if @i_operacion='Q'
   begin
   
      if @i_en_linea = 'S' 
      begin     
         --PRINT '--elimpag INICIO NYMR 7x24 Ejecuto FECHA VALOR BAJA INTENSIDAD ' + CAST(@w_operacionca as varchar)
         EXEC @w_return = sp_validar_fecha
         @s_user                  = @s_user,
         @s_term                  = @s_term,
         @s_date                  = @s_date ,
         @s_ofi                   = @s_ofi,
         @i_operacionca           = @w_operacionca,
         @i_debug                 = 'N' 

         if @w_return <> 0 
         begin
            select @w_error = @w_return 
            goto ERROR
         end
      end
   
      select 
      'SECUENCIAL'     = convert(varchar(12),ab_secuencial_ing), 
      'FECHA'          = convert(varchar(12),ab_fecha_ing,@i_formato_fecha), 
      'USUARIO'        = ab_usuario,
      'OFICINA'        = ab_oficina,
      'RETENCION'      = ab_dias_retencion, 
      'CUOTA COMPLETA' = ab_cuota_completa,
      'ANTICIPOS'      = ab_aceptar_anticipos,
      'TIPO REDUCCION' = ab_tipo_reduccion, 
      'TIPO COBRO'     = ab_tipo_cobro
      from   ca_abono
      where  ab_operacion = @w_operacionca
      and    ab_estado    in ('ING', 'NA')
      order by ab_secuencial_ing
   end
   
   -- CONSULTA DEL DETALLE DEL PAGO 
   
   if @i_operacion='S'
   begin
      select 
      'TIPO'       = abd_tipo,
      'CONCEPTO'   = abd_concepto,
      'CUENTA'     = abd_cuenta,
      'MONEDA '    = abd_moneda,
      'MONTO MPG'  = convert(float, abd_monto_mpg), 
      'MONTO MOP'  = convert(float, abd_monto_mop)
      from   ca_abono_det
      where  abd_secuencial_ing = @i_secuencial_ing
      and    abd_operacion      = @w_operacionca
      
      if @@rowcount = 0
      begin
         select @w_error = 710023
         goto ERROR
      end
   end
   
   -- ELIMINACION DEL PAGO 
   
   if @i_operacion = 'D' 
   begin  ---(1)
      BEGIN TRAN
      
      if @w_op_tipo = 'R'
      begin 
         if exists (select 1
         from   ca_prepagos_pasivas
         where  pp_banco =  @i_banco
         and    pp_estado_registro = 'I'
         and    pp_secuencial_ing =    @i_secuencial_ing)
         begin
            update ca_prepagos_pasivas set    
            pp_estado_registro = 'I',
            pp_estado_aplicar  = 'P', --Rechazado
            pp_secuencial_ing  = @i_secuencial_ing
            where pp_banco =  @i_banco
            and   pp_secuencial_ing =    @i_secuencial_ing
            and   pp_estado_registro = 'I'
         end  
      end 
      
      --SACAR LA FORMA DE PAGO PARA VER SI ES DE RECONOCIMIENTO DE GARANTIA ESPECIAL
      select 
      @w_forma_pago     = abd_concepto,
      @w_estado         = ab_estado,
      @w_secuencial_rpa = ab_secuencial_rpa
      from   ca_abono_det, ca_abono
      where  ab_operacion       = @w_operacionca
      and    ab_secuencial_ing  = @i_secuencial_ing
      and    abd_operacion      = ab_operacion
      and    abd_tipo           = 'PAG'
      and    ab_secuencial_ing  = abd_secuencial_ing
      
      if @w_estado = 'ING' or  @w_estado = 'NA'
      begin 
         ---SI LA FORMA DE PAGO EXISTE EN LAS RELACIONADAS CON LAS LINEAS ESPECIALES
         select @w_linea_fpago = valor
         from   cobis..cl_catalogo
         where  tabla = (select codigo
                         from   cobis..cl_tabla
                         where  tabla = 'ca_especiales')
         and    codigo = @w_forma_pago
         
         if @@rowcount > 0
         begin 
            ---SE VALIDA LA EXISTENCIA DE LA OBLIGACION ALTERNA
            select @w_banco_alterno = op_banco
            from   ca_operacion
            where  op_anterior = @i_banco
            and    op_tipo     = 'G'
            and    op_estado   <> 6
            and    op_toperacion = @w_linea_fpago
            
            if @@rowcount > 0
            begin
--               PRINT ' TOME NOTA  (  %1!  ) Debe ANULAR este credito Alterno para poder continuar' + @w_banco_alterno
               select @w_error = 710521
               goto ERROR
            end 
         end 
      end 
      
      if @w_estado = 'NA'
      begin  
         select @w_estado = tr_estado
         from   ca_transaccion
         where  tr_secuencial = @w_secuencial_rpa
         and    tr_operacion  = @w_operacionca
         
         if @w_estado = 'ING'
         begin 
            update ca_transaccion
            set    tr_estado = 'RV'
            where  tr_secuencial = @w_secuencial_rpa
            and    tr_operacion  = @w_operacionca
            
            if @@rowcount = 0
            begin 
               select @w_error = 710002
               goto ERROR
            end 
         end 
         
         if @w_estado = 'CON' 
         begin 
            select @w_forma_original = abd_concepto
            from   ca_abono_det
            where  abd_operacion      = @w_operacionca
            and    abd_secuencial_ing = @i_secuencial_ing
            and    abd_tipo = 'PAG'
            
            select @w_forma_reversa = cp_producto_reversa
            from   ca_producto
            where  cp_producto = @w_forma_original
            
            if @@rowcount = 0
               select  @w_forma_reversa = @w_forma_original
            
            insert into ca_transaccion
            (
            tr_secuencial,                     tr_fecha_mov,                     tr_toperacion,
            tr_moneda,                         tr_operacion,                     tr_tran,
            tr_en_linea,                       tr_banco,                         tr_dias_calc,
            tr_ofi_oper,                       tr_ofi_usu,                       tr_usuario,
            tr_terminal,                       tr_fecha_ref,                     tr_secuencial_ref,
            tr_estado,                         tr_gerente ,                      tr_gar_admisible,
            tr_reestructuracion,               tr_calificacion,                  
            tr_observacion,                    tr_fecha_cont,                    tr_comprobante
            )                                                                    
            select                                                               
            -1*tr_secuencial,                  @s_date,                          tr_toperacion,
            tr_moneda,                         tr_operacion,                     tr_tran,
            tr_en_linea,                       tr_banco,                         tr_dias_calc,
            tr_ofi_oper,                       @s_ofi,                           @s_user,
            @s_term,                           tr_fecha_ref,                     tr_secuencial,
            'ING',                             tr_gerente ,                      isnull(tr_gar_admisible,''),
            isnull(tr_reestructuracion,''),    isnull(tr_calificacion,''),
            isnull(tr_observacion,''),         tr_fecha_cont,                    tr_comprobante
            from   ca_transaccion
            where  tr_secuencial = @w_secuencial_rpa
            and    tr_operacion  = @w_operacionca
            
            if @@rowcount <> 0
            begin 
               insert into ca_det_trn
               (
               dtr_secuencial,     dtr_operacion,    dtr_dividendo,
               dtr_concepto,
               dtr_estado,         dtr_periodo,      dtr_codvalor,
               dtr_monto,          dtr_monto_mn,     dtr_moneda,
               dtr_cotizacion,     dtr_tcotizacion,  dtr_afectacion,
               dtr_cuenta,         dtr_beneficiario, dtr_monto_cont
               )
               select 
               -1*dtr_secuencial,  dtr_operacion,    dtr_dividendo,
               dtr_concepto,
               dtr_estado,         dtr_periodo,      dtr_codvalor,
               dtr_monto,          dtr_monto_mn,     dtr_moneda,
               dtr_cotizacion,     'N',              dtr_afectacion,
               dtr_cuenta,         dtr_beneficiario, 0
               from   ca_det_trn 
               where  dtr_secuencial = @w_secuencial_rpa
               and    dtr_operacion  = @w_operacionca
               
               if @@rowcount = 0
               begin 
                  select @w_error = 710001
                  goto ERROR
               end 
            end 
            ELSE
            if @@rowcount = 0
            begin 
               select @w_error = 710001
               goto ERROR
            end 
            
            -- ACTUALIZO EL ESTADO DEL RPA
            update ca_transaccion
            set    tr_estado = 'RV'
            where  tr_secuencial = @w_secuencial_rpa
            and    tr_operacion  = @w_operacionca
            
            if @@rowcount = 0
            begin 
               select @w_error = 710001
               goto ERROR
            end 
            
            -- ACTUALIZAR LA TRANSACCION REV CON LA FORMA DE REVERSA PARAMETRIZADA
            update ca_det_trn set   
            dtr_concepto = cp_producto_reversa,
            dtr_codvalor = (select cp_codvalor
                            from   ca_producto
                            where  cp_producto = orig.cp_producto_reversa)
            from   ca_producto orig
            where  dtr_operacion  = @w_operacionca
            and    dtr_secuencial = -@w_secuencial_rpa
            and    dtr_concepto   = cp_producto
            and    dtr_codvalor    < 1000
         end  
         
         -- CURSOR PARA  SACAR LOS PRODUCTOS 
         declare
            cursor_afecta_productos cursor
            for select cp_producto_reversa, abd_tipo,   abs(abd_monto_mpg),
                       abd_moneda,          abd_cuenta, cp_codvalor,   cp_pcobis
                from   ca_abono_det,ca_producto
                where  abd_secuencial_ing = @i_secuencial_ing
                and    abd_operacion      = @w_operacionca
                and    abd_concepto       = cp_producto
            for read only
         
         open cursor_afecta_productos 
         fetch cursor_afecta_productos
         into  @w_prod_rev,   @w_abd_tipo,   @w_abd_monto_mpg,
               @w_abd_moneda, @w_abd_cuenta, @w_codvalor, @w_cp_pcobis
         
         while (@@fetch_status = 0)
         begin 
            select @w_oficina_ifase = @s_ofi

            if @w_abd_tipo in ('PAG','SEG')
            begin
               select @w_tipo_oficina_ifase = dp_origen_dest
               from   ca_trn_oper, cob_conta..cb_det_perfil
               where  to_tipo_trn = 'RPA'
               and    to_toperacion = @w_toperacion
               and    dp_empresa    = 1
               and    dp_producto   = 7
               and    dp_perfil     = to_perfil
               and    dp_codval     = @w_codvalor
               
               if @@rowcount = 0
               begin 
                  close cursor_afecta_productos 
                  deallocate cursor_afecta_productos

                  select @w_error = 710446
                  goto ERROR
               end 
            end 
            
            if @w_tipo_oficina_ifase = 'C'
            begin 
               select @w_oficina_ifase = pa_int
               from   cobis..cl_parametro
               where  pa_nemonico = 'OFC'
               and    pa_producto = 'CON'
               set transaction isolation level read uncommitted
            end 
            
            if @w_tipo_oficina_ifase = 'D'
                 select @w_oficina_ifase = @w_oficina_op
 
            
            if @w_cp_pcobis = 48
            begin  
                 select @w_secuencial_retro = ab_secuencial_pag
                 from ca_abono
                 where ab_operacion = @w_operacionca
                 and  ab_secuencial_ing = @i_secuencial_ing
                
               --REVERSO DE SOBRANTES EN SIDAC PRO PAGOS
               
               
               exec @w_error = sp_reversos_sob_sidac
               @s_ssn              = @s_ssn,
               @s_date             = @s_date,
               @s_user             = @s_user,
               @s_srv              = @s_srv,
               @s_term             = @s_term,
               @s_ofi              = @s_ofi,
               @t_rty              = @t_rty,
               @t_trn              = 32556,
               @i_oficina          = @w_oficina_op,  
               @i_operacionca      = @w_operacionca,
               @i_banco            = @i_banco,
               @i_cliente          = @w_cliente,
               @i_secuencial_retro = @w_secuencial_retro,
               @i_proceso          = 'R'   --def 6780
               
               if @@error <> 0 or @@trancount = 0 or @w_error <> 0
               begin          
                  close cursor_afecta_productos 
                  deallocate cursor_afecta_productos
                  select @w_error = 710522
                  goto ERROR
               end    
                    --FIN DE REVERSO SOBRANTESEN SIDA
                       
            end 
            else
            begin  
               exec @w_return = sp_afect_prod_cobis
               @s_ssn          = @s_ssn,
               @s_sesn         = @s_ssn,
               @s_srv          = @s_srv,
               @s_user         = @s_user, 
               @s_ofi          = @w_oficina_ifase,
               @i_fecha        = @s_date,
               @i_cuenta       = @w_abd_cuenta,
               @i_producto     = @w_prod_rev,
               @i_monto        = @w_abd_monto_mpg,
               @i_mon          = @w_abd_moneda,
               @i_operacionca  = @w_operacionca,
               @i_alt          = @w_operacionca,
               @i_sec_tran_cca = @w_secuencial_rpa, -- FCP Interfaz Ahorros
               @i_en_linea     = @i_en_linea,
			   @i_reversa      = 'S'                -- SVA
               
               if @w_return <> 0
               begin ---(22)
                  close cursor_afecta_productos 
                  deallocate cursor_afecta_productos
                  select @w_error = @w_return
                  goto ERROR
               end ---(22)
            end 
            
            fetch cursor_afecta_productos
            into  @w_prod_rev,   @w_abd_tipo,   @w_abd_monto_mpg,
                  @w_abd_moneda, @w_abd_cuenta, @w_codvalor,@w_cp_pcobis
         end --- END WHILE
         close cursor_afecta_productos 
         deallocate cursor_afecta_productos 
      end   --END 'NA'

      
      ---def. 6780 Final mente se coloca en estado E para no eliminar el registro      
      update ca_abono
      set    ab_estado = 'E'
      where  ab_secuencial_ing = @i_secuencial_ing
      and    ab_operacion      = @w_operacionca
      
      if @@rowcount = 0
      begin 
         select @w_error = 710002
         goto ERROR
      end 

      select @w_registro = 'elimpag.sp USUARIO:'  + ' ' +  @s_user   + ' ' +  @s_term  + '' +  'LINEA  = S'
      update ca_abono_det
      set    abd_beneficiario = @w_registro
      where  abd_secuencial_ing = @i_secuencial_ing
      and    abd_operacion      = @w_operacionca
      
      -- REQ 089 - ACUERDO DE PAGO - 11/ENE/2011
      update cob_credito..cr_acuerdo
      set ac_secuencial_rpa = null
      where ac_banco          = @i_banco
      and   ac_estado         = 'V'
      and   ac_secuencial_rpa = @w_secuencial_rpa
      
      if @@error <> 0
      begin
         select @w_error = 710568 -- Error en la Actualizacion del registro!!! 
         goto ERROR
      end

      /* Elimina la condonacion en caso que el pago sea por este motivo */
      if exists (select 1 from ca_condonacion
                 where co_operacion  = @w_operacionca
      and    co_secuencial = @i_secuencial_ing
      and    co_estado     = 'V')
      begin
         update ca_condonacion
         set    co_estado     = 'E'
         where  co_operacion  = @w_operacionca
         and    co_secuencial = @i_secuencial_ing
         and    co_estado     = 'V'
    
         if @@error <> 0 begin
            select @w_error = 705064
            goto ERROR
         end
      end

      COMMIT TRAN
   end  ---(1)

   return 0

ERROR:
   
   if @i_pago_ext = 'N'
   begin
      exec cobis..sp_cerror
      @t_debug = 'N',
      @t_from  = @w_sp_name,
      @i_num   = @w_error
   end
   
   return @w_error

go
