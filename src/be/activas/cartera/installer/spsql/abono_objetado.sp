/************************************************************************/
/*  Archivo:              sp_abono_objetado.sp                         */
/*  Stored procedure:     sp_abono_objetado                            */
/*  Base de datos:        cob_cartera                                   */
/*  Producto:             Cartera                                       */
/*  Disenado por:         Andy Gonzalez         .                       */
/*  Fecha de escritura:   17/Diciembre/2002                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA'.                                                           */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
 

use cob_cartera  
go
 
if exists (select 1 from sysobjects where name = 'sp_abono_objetado')
   drop proc sp_abono_objetado
go

create proc sp_abono_objetado (
@s_date               datetime     = null ,
@s_user               login        = null,
@s_ofi                INT          = null,
@s_term               descripcion  = null,
@i_operacion          char(2)      = null, 
@i_criterio           char(1)      = null,  --puede ser cliente/grupo
@i_valor_busqueda     int          = null,
@i_secuencial         int          = null,
@i_formato_fecha      int          = 103 ,
@i_idPago             int          = null,
@i_banco              varchar(64)  = null,         
@i_toperacion         catalogo     = null,
@i_monto_pago         money        = null,
@i_fecha_valor        datetime     = null,
@i_forma_pago         catalogo     = null 
 )as
declare 
@w_fpago_objetado          varchar(10) ,
@w_sp_name           varchar(10),
@w_error             int,
@w_total_registros   int ,
@w_commit            char(1),
@w_msg               varchar(255),
@w_sec_ing           int ,
@w_cuenta_origen     cuenta,
@w_cuenta_destino    cuenta,
@w_monto_traslado    money ,
@w_operacionca       int ,
@w_banco             cuenta,
@w_cliente           int ,
@w_secuencial_pag    int ,
@w_sec_rpa           int ,
@w_oficina           int ,
@w_toperacion        varchar(100),
@w_secuencial        int , 
@w_fecha_proceso     datetime ,
@w_moneda            int,
@w_fecha_ult_proceso datetime, 
@w_oficial           int,
@w_cod_valor         int,
@w_codvalor_objetado int ,
@w_secuencial_ing    int ,
@w_monto_pago        money,
 @w_secuencial_rpa   int 

select 
@w_fpago_objetado    = cp_producto,
@w_codvalor_objetado = cp_codvalor
from ca_producto where cp_producto = 'OBJETADO'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_commit = 'N'


if @i_operacion = 'B' begin   --OPCION DE BUSQUEDA 

   
   if @i_criterio = 'I'  begin--BUSQUEDA INDIVIDUAL


      select 
      operacion     =op_operacion,
      tipo_operacion=op_toperacion,
      banco         = op_banco  		 
      into #operaciones 
      from ca_operacion 
      where op_cliente = @i_valor_busqueda  
	 
   
      if @i_secuencial = 0  begin 
	  
	  
	     delete ca_qry_abono_objetado where ao_usuario = @s_user
		 delete ca_abono_objetado     where ao_usuario = @s_user
	     
         
         insert into ca_qry_abono_objetado
         select
         ao_operacion   = ab_operacion,
         ao_id_pago     = ab_secuencial_pag,
         ao_id_ing      = ab_secuencial_ing,
         ao_toperacion  = null,
         ao_monto_pago  = abd_monto_mpg,
         ao_fecha_valor = null,
         ao_usuario     = @s_user 
         from  ca_abono,ca_abono_det
         where ab_operacion in ( select operacion from #operaciones) 
         and   ab_operacion      = abd_operacion
         and   ab_secuencial_ing = abd_secuencial_ing
         and   abd_concepto      = @w_fpago_objetado
         and   ab_estado not in ( 'RV','E')
         
 
	     
         update ca_qry_abono_objetado set 
         ao_fecha_valor = tr_fecha_mov
         from ca_transaccion
         where ao_id_pago    = tr_secuencial 
         and   ao_operacion  =  tr_operacion 
         and   tr_tran       = 'PAG' 
         and   tr_secuencial   >0 
         and   tr_estado       <> 'RV'
		 
		 
	     update ca_qry_abono_objetado set 
         ao_toperacion = tipo_operacion
         from #operaciones 
         where operacion = ao_operacion

         delete ca_qry_abono_objetado 
         from ca_qry_abono_objetado, ca_corresponsal_det
         where ao_operacion = cd_operacion 
         and   ao_id_ing    = cd_sec_ing 		 
		 
      end 
	  
	  
	     set rowcount 20
         
         select 
         'sec'               = ao_id,
         'ID._PAGO'          = ao_id_pago,
         'TIPO_PRESTAMO'     = ao_toperacion,
         'MONTO_REGULARIZAR' = ao_monto_pago,
         'FECHA_VALOR'       = ao_fecha_valor,
         'ID_PRESTAMO'       = (select banco from #operaciones where operacion= ao_operacion) 
         from  ca_qry_abono_objetado a
         where ao_id      > @i_secuencial
         and   ao_usuario = @s_user 
         order by ao_id
         
         set rowcount 0
		 
   end  --FIN INDIVIDUAL
   
   
   if @i_criterio = 'G'  begin
   
   
      if @i_secuencial = 0 begin 
	  
         delete ca_qry_abono_objetado where ao_usuario = @s_user
         delete ca_abono_objetado     where ao_usuario = @s_user
         
         ---OBTENGO DE LA CORRESPONSAL LOS PAGOS PROCESADOS NO REVERSADOS
         
         select
         operacion_padre= co_codigo_interno,
         secuencial     = co_secuencial
         into #corresponsal_trn 
         from  ca_corresponsal_trn  
         where co_estado in ('P')
         and co_accion in ( 'I', 'R')
         and co_codigo_interno in ( select ci_operacion from ca_ciclo  where ci_grupo = @i_valor_busqueda )
		 and co_corresponsal = @w_fpago_objetado
         
         if @@rowcount = 0 begin 
            select 
            @w_error = 70002,
            @w_msg   = 'ERROR NO SE ENCUENTRA GRUPO EN LA CORRESPONSAL TRN PROCESADO'
            GOTO ERRORFIN
         
         end 
		 
		 select 
		 operacion      = cd_operacion,
		 secuencial_ing = cd_sec_ing,
		 secuencial_pag = convert(int, null), 
		 tipo_operacion = convert(varchar,null),
		 monto_pag      = convert(money,null), 
		 fecha_valor    = convert(datetime, null),
     concepto       = convert(varchar,null)
		 into #pagos_grupales 
		 from ca_corresponsal_det
		 where cd_secuencial in ( select secuencial from #corresponsal_trn)
	
         
         --ACTUALIZAMOS EL SECUENCIAL PAG REGISTRADO EN LA CA_ABONO 
         
         update #pagos_grupales set 
         secuencial_pag = isnull(ab_secuencial_pag, 0) 
         from ca_abono 
         where ab_operacion     = operacion 
         and ab_secuencial_ing  = secuencial_ing
         and ab_estado not in ( 'RV', 'E')
         
         --ACTUAIZAMOS EL TIPO OPERACION 
         update #pagos_grupales set 
         tipo_operacion = op_toperacion 
         from ca_operacion 
         where operacion = op_operacion 
         
         --ACTUALIZAMOS LOS MONTOS INDIVIDUALES
         
         update #pagos_grupales set 
         monto_pag    = abd_monto_mpg,
         concepto     = abd_concepto
         from ca_abono_det 
         where abd_secuencial_ing = secuencial_ing
         and   abd_operacion      = operacion 
         
         --ACTUALIZAMOS FECHA VALOR 
         
         update #pagos_grupales set 
         fecha_valor = tr_fecha_mov
         from ca_transaccion
         where secuencial_pag   = tr_secuencial 
         and   operacion        =  tr_operacion 
         and   tr_tran       = 'PAG' 
         and   tr_secuencial   >0 
         and   tr_estado       <> 'RV'
         
         delete #pagos_grupales 
         where concepto not in ( @w_fpago_objetado)  
         
         
         insert into ca_qry_abono_objetado
         select
         ao_operacion   = operacion,
         ao_id_pago     = secuencial_pag,
         ao_id_ing      = secuencial_ing,
         ao_toperacion  = tipo_operacion ,
         ao_monto_pago  = monto_pag,
         ao_fecha_valor = fecha_valor,
         ao_usuario     = @s_user 
         from #pagos_grupales

		 
      end 	


      
      select top 20
      'sec'               = ao_id,
      'ID_PAGO'           = ao_id_pago,
      'TIPO_PRESTAMO'     = ao_toperacion,
      'MONTO_REGULARIZAR' = ao_monto_pago,
      'FECHA_VALOR'       = ao_fecha_valor,
      'ID_PRESTAMO'       = (select op_banco from ca_operacion where op_operacion = ao_operacion)
      from  ca_qry_abono_objetado a
      where ao_id    > @i_secuencial
      and   ao_usuario = @s_user 
      order by ao_id
      
       
   
   
   end 


end 


if @i_operacion = 'I' begin 


   select  @w_operacionca = op_operacion 
   from ca_operacion 
   where op_banco = @i_banco


   select 
   @w_sec_ing = ab_secuencial_ing,
   @w_sec_rpa = ab_secuencial_rpa
   from ca_abono 
   where ab_operacion     = @w_operacionca
   and  ab_secuencial_pag = @i_idPago
   and   ab_estado  not in ('E', 'RV') 
   
   if @@rowcount = 0 begin
      select 
	  @w_error = 70001,
	  @w_msg   = 'ERROR ABONO NO EXISTE O ESTADO NO PERMITE ACTUALIZACION'
      GOTO ERRORFIN   
   end 


   insert into ca_abono_objetado (
   ao_operacion   , ao_id_pago     ,ao_toperacion  ,
   ao_monto_pago  ,ao_fecha_valor  , ao_usuario ,
   ao_sec_ing , ao_sec_rpa )
   values (
   @w_operacionca ,@i_idPago       ,@i_toperacion,
   @i_monto_pago  ,@i_fecha_valor  ,@s_user,
   @w_sec_ing     ,@w_sec_rpa )
   
   if @@error <> 0 begin 
      select 
	  @w_error = 70001,
	  @w_msg   = 'ERROR AL INSERTAR DATOS EN LA TABLA OBJETADOS'
      GOTO ERRORFIN
   end 
   
   
end 

if @i_operacion = 'R' begin 

   if not exists (select 1 from ca_producto where cp_producto = @i_forma_pago and cp_producto not in ('QUEBRANTO', 'OBJETADO')) begin 
      select 
	  @w_error = 70002,
	  @w_msg   = 'ERROR FORMA DE PAGO NO VALIDA '
      GOTO ERRORFIN
   end 
   
   select @w_operacionca = op_operacion 
   from ca_operacion 
   where op_banco = @i_banco
   
   select @w_cod_valor = cp_codvalor from ca_producto where cp_producto = @i_forma_pago
   
   
   select @w_cuenta_origen = re_substring 
   from cob_conta..cb_relparam 
   where re_parametro = 'F_PAGO' 
   and  re_clave = @w_fpago_objetado  --CUENTA ORIGEN
   
   if @@rowcount = 0 begin 
      select 
      @w_error = 70002,
      @w_msg   = 'ERROR NO SE ENCUENTRA LA FORMA DE PAGO ORIGEN EN LA REL PARAM '
      GOTO ERRORFIN
   
   end 
	
   select @w_cuenta_destino = re_substring 
   from cob_conta..cb_relparam 
   where re_parametro = 'F_PAGO' 
   and  re_clave = @i_forma_pago  --CUENTA DESTINO
	
   if @@rowcount = 0 begin 
      select 
      @w_error = 70002,
      @w_msg   = 'ERROR NO SE ENCUENTRA LA FORMA DE PAGO DESTINO EN LA REL PARAM'
      GOTO ERRORFIN
   
   end 
   
   
   --DATOS PRINCIPALES DE LOS ABONOS OBJETADOS
   select 
   operacion      = ao_operacion,
   banco          = convert(varchar, null),
   cliente        = convert(int, null) ,
   oficina        = convert(int, null),
   tipo_oper      = convert(varchar, null),
   moneda         = convert(int, null),
   ult_proceso    = convert(datetime , null),
   oficial        = convert(int, null), 
   monto_pago     = ao_monto_pago,
   usuario        = ao_usuario,
   secuencial_pag = ao_id_pago,
   secuencial_ing = ao_sec_ing
   into #ca_abono_objetado
   from ca_abono_objetado
   where ao_usuario = @s_user 
   
   
   update #ca_abono_objetado set 
   banco     = op_banco ,
   cliente   = op_cliente ,
   oficina   = op_oficina ,
   tipo_oper = op_toperacion,
   moneda    = op_moneda,
   ult_proceso = op_fecha_ult_proceso,
   oficial   =op_oficial
   from ca_operacion    
   where op_operacion = operacion 
   
   --SELECCIONAMOS UNIVERSOS DE ABONOS
   select * into #ca_abono     from ca_abono     where ab_operacion  in ( select operacion from #ca_abono_objetado)
   select * into #ca_abono_det from ca_abono_det  where abd_operacion in ( select operacion from #ca_abono_objetado)
   
   
   
   
   /* INICIO DE LA ATOMICIDAD DE LA TRANSACCION */
   if @@trancount = 0 begin
      select @w_commit = 'S'
      begin tran
   end
   
   
   select 
   @w_operacionca   = 0
   

   while (1= 1 ) begin  --CURSOR QUE LEE LAS OPERACIONES OBJETADAS
   
   
      select top 1
      @w_operacionca        = operacion,
      @w_banco              = banco,
      @w_cliente            = cliente,
	  @w_oficina            = oficina,
      @w_toperacion         = tipo_oper,
      @w_moneda             = moneda ,
      @w_fecha_ult_proceso  = ult_proceso ,
      @w_oficial            = oficial,
      @w_secuencial_ing     = secuencial_ing	,
	  @w_secuencial_pag     = secuencial_pag,
      @w_monto_pago         = monto_pago	  
      from #ca_abono_objetado
      where usuario  = @s_user
      order by operacion, secuencial_ing
      
      if @@rowcount = 0 break 
      
	  delete #ca_abono_objetado where usuario = @s_user and operacion =  @w_operacionca and secuencial_ing = @w_secuencial_ing
   
      select 
	  @w_secuencial_rpa = ab_secuencial_rpa
	  from ca_abono
	  where ab_operacion      =   @w_operacionca
	  and   ab_secuencial_ing =   @w_secuencial_ing
	  and   ab_estado  not in ('E', 'RV')
	  
	 
	  if  exists ( select 1 from ca_transaccion where tr_operacion = @w_operacionca and tr_secuencial= @w_secuencial_rpa  and tr_estado = 'CON')  begin 
		 --NUEVA TRANSACCION DE REGULARIZACION  
      
         exec @w_secuencial  = sp_gen_sec
         @i_operacion        = @w_operacionca

		 
		 -- INSERCION DE CABECERA CONTABLE DE CARTERA  (REVISAR FV)
         insert into ca_transaccion  with (rowlock)(
         tr_fecha_mov,         tr_toperacion,     tr_moneda,
         tr_operacion,         tr_tran,           tr_secuencial,
         tr_en_linea,          tr_banco,          tr_dias_calc,
         tr_ofi_oper,          tr_ofi_usu,        tr_usuario,
         tr_terminal,          tr_fecha_ref,      tr_secuencial_ref,
         tr_estado,            tr_gerente,        tr_gar_admisible,
         tr_reestructuracion,  tr_calificacion,   tr_observacion,
         tr_fecha_cont,        tr_comprobante)
         values(
         @w_fecha_proceso,     @w_toperacion,       @w_moneda,
         @w_operacionca,      'REG',                @w_secuencial,
         'N',                 @w_banco,             0,
         @w_oficina,          @w_oficina,           'usrbatch',
         'regularizar',       @w_fecha_ult_proceso, @w_secuencial_pag, 
         'ING',               @w_oficial,           '',
         'N',                 '',                   'REG. OBJETADO',
         @s_date,             0)
         
         if @@error <> 0 begin
            select 
            @w_error = 710001,
            @w_msg   = 'ERROR AL CREAR LA TRANSACCION REG'
            goto ERRORFIN
         end
         
         
                --- REGISTRAR VALORES QUE SALEN DE LA OFICINA ORIGEN 
         insert into ca_det_trn(
         dtr_secuencial   ,                   dtr_operacion ,       dtr_dividendo    ,
         dtr_concepto     ,                   dtr_periodo   ,       dtr_estado       ,
         dtr_monto        ,                   dtr_monto_mn  ,       dtr_codvalor     ,
         dtr_moneda       ,                   dtr_cotizacion,       dtr_tcotizacion  ,
         dtr_cuenta       ,                   dtr_afectacion,       dtr_beneficiario ,
         dtr_monto_cont)
         select 
         @w_secuencial,                       @w_operacionca,       0,
         abd_concepto,                        0,                    1,
         -1*abd_monto_mpg,                    -1*abd_monto_mpg,     @w_codvalor_objetado, 
         @w_moneda,                           1,                    'N',
         @w_cuenta_origen,                    'D',                   '',
         0
         from  #ca_abono_det 
		 where  abd_operacion      = @w_operacionca
		 and    abd_secuencial_ing = @w_secuencial_ing
         and    abd_concepto       = @w_fpago_objetado  

   
         if @@error <> 0  begin
            select @w_error = 708165, @w_msg = 'ERROR AL REGISTRAR DETALLES DE SALIDA: ' + @w_banco
            goto ERRORFIN
         end
   
                 --- REGISTRAR VALORES QUE ENTRAN ALA OFICINA DESTINO
         insert into ca_det_trn(
         dtr_secuencial   ,                   dtr_operacion ,       dtr_dividendo    ,
         dtr_concepto     ,                   dtr_periodo   ,       dtr_estado       ,
         dtr_monto        ,                   dtr_monto_mn  ,       dtr_codvalor     ,
         dtr_moneda       ,                   dtr_cotizacion,       dtr_tcotizacion  ,
         dtr_cuenta       ,                   dtr_afectacion,       dtr_beneficiario ,
         dtr_monto_cont)
         select 
         @w_secuencial,                       @w_operacionca,       0,
         @i_forma_pago,                       0,                    1,
         abd_monto_mpg,                       abd_monto_mpg,         @w_cod_valor, 
         @w_moneda,                           1,                    'N',
         @w_cuenta_destino,                   'D',                   '',
         0
         from #ca_abono_det 
		 where  abd_operacion      = @w_operacionca
		 and    abd_secuencial_ing = @w_secuencial_ing
         and    abd_concepto       = @w_fpago_objetado 

   
         if @@error <> 0  begin
            select @w_error = 708165, @w_msg = 'ERROR AL REGISTRAR DETALLES DE SALIDA: ' + @w_banco
            goto ERRORFIN
         end
             
      end --if 
	    
  
  end --(1=1) 	  
	  

   
   
   
   update ca_abono_det set 
   abd_concepto = @i_forma_pago 
   from ca_abono_objetado a 
   where ao_operacion      = abd_operacion 
   and   ao_sec_ing        = abd_secuencial_ing
   and   ao_usuario        = @s_user 
   and   abd_concepto      = @w_fpago_objetado
   and   abd_operacion     in( select ab_operacion from #ca_abono)
   
   if @@error <> 0 begin 
     select 
     @w_error = 70003,
     @w_msg   = 'ERROR AL ACTUALIZAR LA ABONO DET '
     GOTO ERRORFIN
   end 
   
   
   update ca_det_trn set 
   dtr_concepto   = @i_forma_pago, 
   dtr_codvalor   = @w_cod_valor
   from ca_abono_objetado   a 
   where ao_operacion = dtr_operacion 
   and   ao_sec_rpa   = dtr_secuencial
   and   dtr_concepto = @w_fpago_objetado
   and   ao_usuario   = @s_user
   and   dtr_operacion  in( select ab_operacion from #ca_abono)
   
   if @@error <> 0 begin 
      select 
      @w_error = 70003,
      @w_msg   = 'ERROR AL ACTUALIZAR LA TABLA DE DETALLES DE TRX'
      GOTO ERRORFIN
   end 
   
   
   delete ca_abono_objetado where ao_usuario = @s_user

   if @w_commit = 'S' begin
      commit tran
      select @w_commit = 'N'
   end
   

end -- fin opcion R



return 0

ERRORFIN:

if @w_commit = 'S' begin
   rollback tran
   select @w_commit = 'N'
end

delete ca_abono_objetado where ao_usuario = @s_user

exec cobis..sp_cerror
   @t_debug = 'N',
   @t_from  = @w_sp_name,
   @i_num   = @w_error,
   @i_msg   = @w_msg
return @w_error
                        


GO

