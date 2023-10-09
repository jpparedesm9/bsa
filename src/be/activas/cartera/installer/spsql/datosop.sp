/************************************************************************/
/*   Archivo:                datosop.sp                                 */
/*   Stored procedure:       sp_datos_operacion                         */
/*   Base de datos:          cob_cartera                                */
/*   Producto:               Cartera                                    */
/*   Disenado por:           Francisco Yacelga                          */
/*   Fecha de escritura:     25/Nov./1997                               */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/  
/*                            PROPOSITO                                 */
/*   Consulta de los datos de una operacion                             */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*   FECHA               AUTOR       CAMBIO                             */
/*   JUN-09-2010    Elcira Pelaez    Quitar Codigo Causacion Pasivas    */
/*   ENE-18-2012    Luis C. Moreno   RQ293 Consulta valor por amortizar */
/*                                   pago por reconocimiento            */
/* 15/May/2019        AGO                Req 113305                     */
/* 22/May/2019        AGO                Req 113305 -nuevo patch        */
/* 30/May/2019        AGO                Req 113305 -Ajuste a las TRX   */
/* 05/Jun/2019        AGO                Req 113305 -Ajust al det TRX   */
/* 06/Jun/2019        AGO                Req 113305 -Ajust a Abonos     */
/* 17/Jul/2019        AGO                Req 113305 -Ajust a trx DES    */
/* 26/Ago/2019        PRO                Req 115252    -DESCUENTO TASA  */
/* 11/Oct/2019        MTA                Caso 127226- Cambiar etiqueta  */
/* 03/Sep/2020        ACH                Caso 142136 -modifica para gar */
/* 28/Jun/2021        DCU                Caso: 161476 - Error consultas */
/* 13/Abr/2022        DCU                Caso: 169648 - REVERSOS        */
/************************************************************************/

use cob_cartera
go

set ansi_nulls off
go
 
if exists (select 1 from sysobjects where name = 'sp_datos_operacion')
   drop proc sp_datos_operacion
go
---Inc 88842 pariendo de la Ver. 20
create proc sp_datos_operacion (
   @s_ssn               int              = null,
   @s_date              datetime         = null,
   @s_user              login            = null,
   @s_term              descripcion      = null,
   @s_corr              char(1)          = null,
   @s_ssn_corr          int              = null,
   @s_ofi               smallint         = null,
   @t_rty               char(1)          = null,
   @t_debug             char(1)          = 'N',
   @t_file              varchar(14)      = null,
   @t_trn               smallint         = null,  
   @i_banco             cuenta           = null,
   @i_operacion         char(1)          = null,
   @i_formato_fecha     int              = null,
   @i_secuencial_ing    int              = null,
   @i_toperacion        catalogo         = null,
   @i_moneda            int              = null,
   @i_siguiente         int              = null,
   @i_dividendo         int              = null,
   @i_numero            int              = null,
   @i_sucursal          int              = null,
   @i_filial            int              = null,
   @i_oficina           smallint         = null,
   @i_concepto          catalogo         = '',
   @i_fecha_abono       datetime         = null,
   @i_opcion            tinyint          = null,
   @i_tramite           int              = null,
   @i_sec_detpago       int              = 0,
   @i_tran              catalogo         = null


)

as
declare 
   @w_sp_name             varchar(32),
   @w_return              int,
   @w_error               int,
   @w_operacionca         int,
   @w_det_producto        int,
   @w_tipo                char(1),
   @w_tramite             int,
   @w_count               int,
   @w_filas               int,
   @w_filas_rubros        int,
   @w_primer_des          int,
   @w_bytes_env           int,
   @w_buffer              int,
   @w_secuencial_apl      int,
   @w_fecha_u_proceso     datetime,
   @w_moneda              int,
   @w_moneda_nacional     tinyint,
   @w_cotizacion          money,
   @w_op_moneda           tinyint,
   @w_contador            int,
   @w_dtr_dividendo       int,
   @w_dtr_concepto        catalogo,
   @w_dtr_estado          char(20),
   @w_dtr_cuenta          cuenta,
   @w_dtr_moneda          char(20),
   @w_dtr_monto           money,
   @w_dtr_monto_mn        money,
   @w_op_operacion        int,
   @w_op_migrada          varchar(20),
   @w_total_reg           int,
   @w_dist_gracia         char(1),                                   -- REQ 175: PEQUEÑA EMPRESA
   @w_gracia_int          smallint,                                  -- REQ 175: PEQUEÑA EMPRESA
   @w_vlr_x_amort         money ,--REQ 293 - LCM,
   @w_resumen_grupal      char(1) ,
   @w_cliente             int ,
   @w_secuencia           int ,
   @w_monto_gar           money,
   @w_oficina             int ,
   @w_tramite_grupal      int,
   @w_grupo               int,
   @w_cont                int    
                               

                               
select @w_resumen_grupal  = 'N'
--- Captura nombre de Stored Procedure  
select   
@w_sp_name = 'sp_datos_operacion',
@w_buffer  = 2500   --TAMANIO MAXIMO DEL BUFFER DE RED


create table #detalles_pago (
codigo    int            null,
banco     varchar(30)   null,
estado    varchar(30)    null,
monto_mn  money          null,
cuenta    varchar(30)    null,
moneda    varchar(30)    null,
secuencia  int           null
)


if (exists (select 1 from ca_det_ciclo where dc_referencia_grupal = @i_banco) 
or exists (select 1 from cob_credito..cr_tramite_grupal where tg_referencia_grupal = @i_banco) )  select  @w_resumen_grupal = 'S'



select 
operacion = dc_operacion, 
banco     = convert(varchar(20), null),
tramite   = convert(int, null)
into #operaciones 
from ca_det_ciclo 
where dc_referencia_grupal = @i_banco 


select @w_tramite_grupal = tg_tramite , @w_grupo  = tg_grupo from cob_credito..cr_tramite_grupal where tg_referencia_grupal = @i_banco


select 
cliente = convert(varchar,tg_cliente)
into #clientes
from  cob_credito..cr_tramite_grupal 
where tg_referencia_grupal = @i_banco
and  tg_tramite   = @w_tramite_grupal
and tg_participa_ciclo = 'S'


update #operaciones set 
banco   = op_banco ,
tramite = op_tramite   
from ca_operacion 
where op_operacion = operacion
 
 
      
-- CODIGO DE LA MONEDA LOCAL
select @w_moneda_nacional = pa_tinyint
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'MLO'
set transaction isolation level read uncommitted

--- DETERMINAR ULTIMO TRAMITE DE LA OPERACION
select @w_tramite = max(tr_tramite)
from cob_credito..cr_tramite
where tr_numero_op_banco = @i_banco
and   tr_estado <> 'Z'
and   tr_tipo = 'E'

--- CHEQUEO QUE EXISTA LA OPERACION 

select 
@w_operacionca        = op_operacion,
@w_cliente            = op_cliente,   
@w_tramite            = isnull( @w_tramite, op_tramite ),
@w_op_migrada         = op_migrada,
@w_tipo               = op_tipo,
@w_fecha_u_proceso    = op_fecha_ult_proceso,
@w_moneda             = op_moneda,
@w_dist_gracia        = op_dist_gracia,
@w_gracia_int         = op_gracia_int,
@w_oficina            = op_oficina 
from   ca_operacion
where  op_banco = @i_banco

if @@rowcount = 0
begin
   select @w_error = 710022
   goto ERROR
end  

--- DETERMINAR EL VALOR DE COTIZACION DEL DIA 
if @w_moneda = @w_moneda_nacional
   select @w_cotizacion = 1.0
else
begin
   exec sp_buscar_cotizacion
   @i_moneda     = @w_moneda,
   @i_fecha      = @w_fecha_u_proceso,
   @o_cotizacion = @w_cotizacion output
end

--- CONSULTAR ABONOS
if @i_operacion='A' begin   --operacion hija grupal o lcr
   if @w_resumen_grupal = 'N' begin
      if @i_secuencial_ing  = 0 begin
         delete ca_qry_consulta_abono where s_user = @s_user
         
         insert into ca_qry_consulta_abono
         select 
         ab_operacion,
         ab_secuencial_ing,--iD_PAGO
         ab_secuencial_pag,--sEC pAG
         abd_concepto,
         convert(datetime ,ab_fecha_ing), -- fecha mov
         convert(datetime ,ab_fecha_pag),   -- fecha valor
         ab_oficina,
         abd_monto_mpg, 
         abd_moneda,
         convert(varchar(24), null), 
         ab_estado,
         ab_usuario,
         convert(varchar(255), null) ,
         @s_user 
         from  ca_abono,
         ca_abono_det
         where ab_operacion = @w_operacionca
         and   ab_operacion = abd_operacion
         and   ab_secuencial_ing = abd_secuencial_ing
         and   ab_estado <>  'E'
         
         update ca_qry_consulta_abono set 
         [Fecha de Ingreso] = tr_fecha_mov
         from ca_transaccion
         where secuencial_pag   = tr_secuencial 
         and   Operacion        =  tr_operacion 
         and   tr_tran          = 'PAG' 
         and   tr_secuencial   >0 
        -- and   tr_estado       <> 'RV'
         AND   s_user = @s_user
         
         
         update ca_qry_consulta_abono  set
         [Id_Corresponsal] = co_trn_id_corresp ,
         [Mensaje]         = co_error_msg 
         from ca_corresponsal_det, ca_corresponsal_trn
         where  s_user = @s_user
         and   [Operacion]   = cd_operacion 
         and   co_secuencial = cd_secuencial 
         AND   [Id_Pago]     = cd_sec_ing 
		 
	 update ca_qry_consulta_abono set
	 Usuario = fv_usuario
	 from ca_log_fecha_valor
	 where s_user   = @s_user 
         and   fv_operacion = Operacion
         and   fv_secuencial_retro = secuencial_pag
         and   fv_tipo = 'R'
		 
         
    end 
      
      set rowcount 17 
      
      select 
      id_abono,
      Id_Pago,
      'Sec_Pag' = [secuencial_pag]    ,
      [Forma de Pago] = convert(varchar(10),[Forma de Pago],@i_formato_fecha),
      [Fecha de Ingreso]=convert(varchar(10),[Fecha de Ingreso] ,@i_formato_fecha),
      [Fecha Valor]=convert(varchar(10),[Fecha Valor] ,@i_formato_fecha) ,
      Oficina          ,
      Monto            ,
      Moneda           ,
      Id_Corresponsal  ,
      Estado           ,
      Usuario          ,
      Mensaje          
      from  ca_qry_consulta_abono
      where id_abono > @i_secuencial_ing 
      and s_user = @s_user 
      order by id_abono
      
      set rowcount 0
      
   end else begin 
       if @i_secuencial_ing  = 0 begin
       
         delete ca_qry_consulta_abono where s_user = @s_user
             
         --TRATAMIENTO PARA PAGOS DESDE QUE NO SON CORRESPONSALES 
         select 
         Operacion         = ab_operacion ,
         Id_Pago           = ab_secuencial_ing,--iD_PAGO
         secuencial_pag    = max(ab_secuencial_pag),--sEC pAG
         [Forma de Pago]   = abd_concepto,
         [Fecha de Ingreso]= max(ab_fecha_ing),
         dividendo         = ab_dividendo ,
         cuenta            = abd_cuenta,
         [Fecha Valor]     = max(ab_fecha_ing), 
         Oficina           = ab_oficina,
         Monto             = sum(abd_monto_mpg), 
         Moneda            = abd_moneda,
         Id_Corresponsal   = convert(varchar(24), null), 
         Estado            = ab_estado,
         Usuario           = ab_usuario,
         Mensaje           = convert(varchar(255), null) ,
         s_user            = @s_user 
         into #ca_qry_consulta_abono 
         from  ca_abono,ca_abono_det
         where ab_operacion in (select operacion from #operaciones)
         and   ab_operacion = abd_operacion
         and   ab_secuencial_ing = abd_secuencial_ing
         and   ab_estado <>  'E'
         -- and  ab_secuencial_ing  not in ( select cd_sec_ing from ca_corresponsal_det where cd_operacion in (select operacion from #operaciones))
         and  not exists ( select 1 from ca_corresponsal_det  where ab_secuencial_ing = cd_sec_ing  and ab_operacion = cd_operacion)
         group by ab_operacion,ab_secuencial_ing,ab_dividendo,ab_secuencial_pag,abd_cuenta,abd_concepto,ab_oficina,abd_moneda,ab_oficina,ab_estado,ab_usuario

        ------------------------------------------------------------------------------
         --INSERCION PAGOS COORESPONSALES
         insert into ca_qry_consulta_abono
         select    
         @w_operacionca ,       
         co_secuencial, --aqui va 0 --iD_PAGO
         co_secuencial,  --sEC_PAG
         co_corresponsal,    
         co_fecha_proceso,
         co_fecha_valor, 
         convert(int,0),        
         co_monto ,            
         co_moneda,          
         co_trn_id_corresp,
         case when co_accion in ( 'I' ,'P') then 'A' else 'RV' end,           
         isnull(co_login,'') ,
         co_error_msg ,
         @s_user
         from  ca_corresponsal_trn
         where co_tipo   like 'P%'
         and co_estado in ('P','RV','I')
         and co_accion in ( 'I', 'R')
         and co_codigo_interno = @w_operacionca
         order by co_fecha_proceso
                         
         update #ca_qry_consulta_abono set 
         [Fecha de Ingreso] = tr_fecha_mov,
         [Fecha Valor] = tr_fecha_ref
         from ca_transaccion
         where secuencial_pag   = tr_secuencial 
         and   Operacion        =  tr_operacion 
         and   tr_tran          = 'PAG' 
         and   tr_secuencial   > 0 
         AND   s_user = @s_user
                          
         insert into ca_qry_consulta_abono 
         select 
         0                   ,             
         0                   ,
         secuencial_pag      ,
         [Forma de Pago]     ,
         [Fecha de Ingreso]  ,
         [Fecha Valor]       ,
         Oficina             ,
         sum(Monto)          ,  
         Moneda              ,
         Id_Corresponsal     ,
         Estado              ,
         Usuario             ,
         Mensaje             ,
         s_user              
         from #ca_qry_consulta_abono
         group by secuencial_pag, [Forma de Pago],[Fecha de Ingreso],[Fecha Valor] ,Oficina,Moneda,
         Id_Corresponsal,Estado,Usuario,Mensaje,s_user
         order by  [Fecha de Ingreso]
         
         update ca_qry_consulta_abono set
         Oficina = @w_oficina
         where  s_user = @s_user
         
         update ca_qry_consulta_abono set 
         [Id_Corresponsal] = co_trn_id_corresp ,
         [Mensaje]         = co_error_msg 
         from ca_corresponsal_trn , ca_corresponsal_det
         where [Id_Pago]     = cd_sec_ing 
         and   [Operacion]   = cd_operacion 
         and   co_secuencial = cd_secuencial 
         and   s_user = @s_user
         
          ---Elimina todo lo del usuario para insertar nuevamente ESTO ES PARA EL DETALLE 
         delete  ca_consulta_rec_pago_tmp
         where usuario = @s_user
         
          --DETALLES DE PAGOS PARA CORRESPONSALES 
         insert into #detalles_pago
         select  
         codigo = ab_dividendo,
         banco  = cd_banco,
         estado = ab_estado,
         monto_mn = abd_monto_mn,
         cuenta   = abd_cuenta,
         moneda  = substring((select convert(varchar(2),mo_moneda) + '-' + mo_descripcion from cobis..cl_moneda where mo_moneda = ca_abono_det.abd_moneda),1,10),
         secuencia = cd_secuencial
         from ca_abono , ca_abono_det , ca_corresponsal_det
         where  ab_operacion       = abd_operacion 
         and    cd_operacion       = abd_operacion 
         and    cd_operacion       in (select operacion from #operaciones)
         and    cd_sec_ing         = ab_secuencial_ing 
         and    ab_secuencial_ing  = abd_secuencial_ing
         
         --DETALLES DE PAGOS PARA PAGOS DIRECTOS AL MODULO  
         select  
         operacion = Operacion,
         codigo   = dividendo,
         banco    = convert(varchar(30),null),
         estado   = Estado,
         monto_mn = Monto,
         cuenta   = cuenta,
         moneda   = substring((select convert(varchar(2),mo_moneda) + '-' + mo_descripcion from cobis..cl_moneda where mo_moneda = a.Moneda),1,10),
         secuencia = secuencial_pag
         into #detalles_pago2
         from #ca_qry_consulta_abono a
  
         update #detalles_pago2 set 
         banco = op_banco
         from ca_operacion 
         where operacion = op_operacion       
      
         insert into #detalles_pago  
         select 
         codigo     ,
         banco      ,
         estado     ,
         monto_mn   ,
         cuenta     ,
         moneda     ,
         secuencia
         from #detalles_pago2
   
         
         update #detalles_pago set 
         estado = (select es_descripcion from ca_estado  where es_codigo = op_estado) 
         from ca_operacion 
         where op_banco = banco
         
         
         insert into ca_consulta_rec_pago_tmp
         select 
         'DOP',
         secuencia,
         @s_user,
         banco,
         codigo,
         0,
         null,
         null,
         convert(float, monto_mn),
         convert(float, monto_mn),
         0,
         moneda,
         estado,
         null,
         cuenta,
         0
         from #detalles_pago
     
         select @w_cont = 0
         update ca_consulta_rec_pago_tmp  
         set   secuencial_pag = @w_cont,
         @w_cont       = @w_cont + 1
         where  usuario         = @s_user
      
      end 
      set rowcount 17 
      
      select 
      id_abono,
      Id_Pago,
      'Sec_Pag' = [secuencial_pag]    ,
      [Forma de Pago] = convert(varchar(10),[Forma de Pago],@i_formato_fecha),
      [Fecha de Ingreso]=convert(varchar(10),[Fecha de Ingreso] ,@i_formato_fecha),
      [Fecha Valor]=convert(varchar(10),[Fecha Valor] ,@i_formato_fecha) ,
      Oficina          ,
      Monto            ,
      Moneda           ,
      Id_Corresponsal  ,
      Estado           ,
      Usuario          ,
      Mensaje          
      from  ca_qry_consulta_abono
      where id_abono > @i_secuencial_ing 
      and s_user = @s_user 
      order by id_abono
      
      set rowcount 0
      
   end 
   
end

--- CONSULTA DEL DETALLE DEL ABONO 
if @i_operacion = 'D' 
begin



   if @i_sec_detpago = 0 and @w_op_migrada is null
   begin

      ---Elimina todo lo del usuario para insertar nuevamente
      if @w_resumen_grupal = 'N' delete from ca_consulta_rec_pago_tmp where usuario = @s_user

      select @w_secuencial_apl = ab_secuencial_pag
      from   ca_abono
      where  ab_secuencial_ing = @i_secuencial_ing
      and    ab_operacion = @w_operacionca
     
     select @w_contador = @i_secuencial_ing

      declare cursor_operacion cursor 
      for select dtr_dividendo,               
                 dtr_concepto,               
                 substring((select es_descripcion from ca_estado  where es_codigo = ca_det_trn.dtr_estado),1,10),
                 rtrim(ltrim(dtr_cuenta)),      
                 substring((select convert(varchar(2),mo_moneda) + '-' + mo_descripcion from cobis..cl_moneda
                            where mo_moneda = ca_det_trn.dtr_moneda),1,10),
                 convert(float, dtr_monto),   convert(float, dtr_monto_mn)
          from  ca_det_trn
          where dtr_secuencial = @w_secuencial_apl 
          and   dtr_operacion  = @w_operacionca
          and   dtr_codvalor <> 10099

      open cursor_operacion
      fetch cursor_operacion
      into @w_dtr_dividendo,   
           @w_dtr_concepto,
           @w_dtr_estado,
           @w_dtr_cuenta,
           @w_dtr_moneda,
           @w_dtr_monto,
           @w_dtr_monto_mn

      while @@fetch_status = 0
      begin   

         select @w_contador = @w_contador + 1

         ---cargar la tabla temporal
         insert into ca_consulta_rec_pago_tmp (
         identifica,     secuencial,    usuario,
         descripcion,    cuota,         dias,
         fecha_ini,      fecha_fin,     monto,
         monto_mn,       tasa,          des_moneda,
         des_estado,     operacion,     cuenta
         )
         values 
         (
         'DOP',            @w_contador,       @s_user,
         @w_dtr_concepto,  @w_dtr_dividendo,  0,
         @s_date,          @s_date,           @w_dtr_monto,
         @w_dtr_monto_mn,  0,                 @w_dtr_moneda,
         @w_dtr_estado,    @w_operacionca,    @w_dtr_cuenta
         )

         fetch cursor_operacion
         into @w_dtr_dividendo,   
              @w_dtr_concepto,
              @w_dtr_estado,
              @w_dtr_cuenta,
              @w_dtr_moneda,
              @w_dtr_monto,
              @w_dtr_monto_mn
      end
      close cursor_operacion
      deallocate cursor_operacion
 
   end --secuencial = 0 

---borrado por usuario
 
   delete ca_consulta_rec_pago_tmp 
   where descripcion = 'VAC0'
   and usuario  = @s_user
   
   
   
   
   if @w_resumen_grupal = 'S' begin 
   
       
       set rowcount 20 
       
       select 
      
      'Dividendo'  = cuota,
      'Concepto'   = descripcion,
      'Estado'     = des_estado,
      'Cuenta'     = cuenta,
      'Moneda'       =des_moneda,
      'Monto MOP'  = convert(float, monto_mn),
      'Monto MLE'  = convert(float, monto_mn),
      'Sec'        = secuencial_pag
      from ca_consulta_rec_pago_tmp
      where   secuencial = @i_secuencial_ing
      and usuario = @s_user 
      and   secuencial_pag > @i_sec_detpago
      order by secuencial_pag
      
      set rowcount 0
      
      
   end else  begin 
    
      set rowcount 20
      select 'Dividendo'  = cuota,
             'Concepto'   = descripcion,
             'Estado'     = des_estado,
             'Cuenta'     = cuenta,
             'Moneda'       = des_moneda,
             'Monto MOP'  = convert(float, monto),
             'Monto MLE'  = convert(float, monto_mn),
             'Sec'        = secuencial
      from ca_consulta_rec_pago_tmp 
      where usuario  = @s_user
      and   identifica in( 'DOP','TOTALES')
      and   operacion  = @w_operacionca
      and   secuencial > @i_sec_detpago
      set rowcount 0
   end 

end --- operacion D

if @i_operacion = 'X'
begin
   delete from ca_consulta_rec_pago_tmp
   where usuario = @s_user
end

--- CONDICIONES DE PAGO 
if @i_operacion='P'
begin
   select op_tipo_cobro,
          op_aceptar_anticipos,
          op_tipo_reduccion,
          op_tipo_aplicacion,
          op_cuota_completa,
          op_fecha_fin,
          op_pago_caja,
          op_calcula_devolucion
   from ca_operacion, 
        ca_estado
   where op_operacion = @w_operacionca
   and   es_codigo     = op_estado
end

--- CONSULTA TASAS 

if @i_operacion='T' 
begin
   select @i_siguiente = isnull(@i_siguiente,0)

   --set rowcount 20   
   select 'Secuencial'             = ts_secuencial,
          'Fecha Mod.'             = convert(varchar(12),ts_fecha,@i_formato_fecha),
          'No.Cuota'               = ts_dividendo,
          'Rubro'                  = ts_concepto,
          'Valor Aplicar'          = ts_referencial,
          'Signo Aplicar'          = ts_signo,
          'Spread Aplicar'         = convert(varchar(25), ts_factor),
          'Tasa Actual'            = max(ts_porcentaje),
          'Tasa Efectiva Anual'    = ts_porcentaje_efa,
          'Tasa Referencial'       = ts_tasa_ref,
          'Fecha Tasa Referencial' = convert(varchar(12),ts_fecha_referencial,@i_formato_fecha),
          'Valor Tasa Referencial' = ts_valor_referencial
   from  ca_tasas --X
   where ((@w_resumen_grupal = 'S' and ts_operacion in( select operacion from #operaciones )) or (@w_resumen_grupal = 'N' and ts_operacion    = @w_operacionca ))
   and   ts_dividendo > @i_siguiente  
   group by ts_secuencial,ts_fecha,ts_dividendo,ts_concepto,ts_referencial,ts_signo,ts_factor,ts_porcentaje_efa,ts_tasa_ref,ts_fecha_referencial,ts_valor_referencial
   order by ts_fecha, ts_dividendo, ts_secuencial
end



--- DEUDORES Y CODEUDORES DE UNA OPERACION*
if @i_operacion = 'E' 
begin
   set rowcount 20
    ---Mroa: NUEVA RUTINA PARA TRAER LOS DEUDORES DE LA OPERACION 
    select 'Codigo'      = de_cliente,
           'CE./NIT.'    = en_ced_ruc,
           'Rol'         = de_rol,
           'Nombre'      = en_nomlar,
           'Telefono'    = isnull((select top 1 te_valor
                                   from cobis..cl_telefono
                                   where te_ente = de_cliente),'SIN TELEFONO'),
           'Direccion'   = isnull((select top 1 di_descripcion
                                   from cobis..cl_direccion
                                   where di_direccion = de_cliente),'SIN DIRECCION'),
           'Cob/Central' = de_cobro_cen
    from   cob_credito..cr_deudores,
           cobis..cl_ente
    where ((@w_resumen_grupal = 'S' and de_tramite in( select tramite from #operaciones )) or (@w_resumen_grupal = 'N' and de_tramite    = @w_tramite ))
    and    en_ente       = de_cliente
    order by de_rol desc
    
    set rowcount 0

end


--- ESTADO ACTUAL 
if @i_operacion = 'S' 
begin
   ---SOLO PARA LA PRIMERA TRANSMISION 
   if @i_dividendo = 0 
   begin
      --- RUBROS QUE PARTICIPAN EN LA TABLA 
      select ro_concepto, co_descripcion, ro_tipo_rubro,ro_porcentaje
      from ca_rubro_op, ca_concepto
      where ro_operacion = @w_operacionca
      and   ro_fpago    in ('P','A','M','T')
      and   ro_concepto = co_concepto
      order by ro_concepto

      select @w_filas_rubros = @@rowcount
      
     
      if @w_filas_rubros <= 10 
         select @w_filas_rubros = @w_filas_rubros + 2

      select @w_bytes_env    = @w_filas_rubros * 90  --83  --BYTES ENVIADOS

      select @w_primer_des = isnull(min(dm_secuencial),0)
      from   ca_desembolso
      where  dm_operacion  = @w_operacionca      

      select dtr_dividendo, sum(isnull(dtr_monto,0)),'D' ---DESEMBOLSOS PARCIALES
      from   ca_det_trn, ca_transaccion, ca_rubro_op
      where  tr_banco      = @i_banco 
      and    tr_secuencial = dtr_secuencial
      and    tr_operacion  = dtr_operacion
      and    dtr_secuencial <> @w_primer_des
      and    ro_operacion = @w_operacionca
      and    ro_tipo_rubro= 'C'
      and    tr_tran    = 'DES'
      and    tr_estado    in ('ING','CON')
      and    ro_concepto  = dtr_concepto 
      group by dtr_dividendo
      union
      select dtr_dividendo, sum(isnull(dtr_monto,0)),'R'       ---REESTRUCTURACION
      from ca_det_trn, ca_transaccion, ca_rubro_op
      where  tr_banco      = @i_banco 
      and   ro_operacion = @w_operacionca
      and   ro_concepto  = dtr_concepto 
      and   ro_tipo_rubro= 'C'
      and   tr_tran      = 'RES'
      and   tr_estado    in ('ING','CON')
      and   tr_secuencial = dtr_secuencial
      and   tr_operacion  = dtr_operacion
      group by dtr_dividendo
       
      select @w_filas_rubros = @@rowcount
      
      select @w_bytes_env    = @w_bytes_env + (@w_filas_rubros * 13)
       
      select di_dias_cuota
      from ca_dividendo 
      where di_operacion = @w_operacionca
      and   di_dividendo > @i_dividendo 
      order by di_dividendo

      select @w_filas = @@rowcount
            
      select @w_bytes_env  = @w_bytes_env + (@w_filas * 4) --1) 
      
   end

   if @i_opcion = 0 
   begin      
   
      if @i_dividendo = 0 
         select @w_count = (@w_buffer - @w_bytes_env) / 38  
      else 
         select @w_count = @w_buffer / 38
            

      set rowcount @w_count

      --- FECHAS DE VENCIMIENTOS DE DIVIDENDOS Y ESTADOS
      select 
      convert(varchar(10),di_fecha_ven,@i_formato_fecha),
      substring(es_descripcion,1,20),
      0,
      di_prorroga
      from ca_dividendo, ca_estado
      where di_operacion = @w_operacionca
      and   di_dividendo > @i_dividendo 
      and   di_estado    = es_codigo
      order by di_dividendo

      select @w_filas = @@rowcount
      select @w_bytes_env    =  (@w_filas * 38)

      select @w_count
   end
   else 
   begin
      select 
      @w_filas = 0,
      @w_count = 1,
      @w_bytes_env = 0
   end

   if @w_filas < @w_count 
   begin
      select @w_total_reg = count(distinct convert(varchar, di_dividendo) + ro_concepto)
      from ca_rubro_op
      inner join ca_dividendo
      on   (   di_dividendo > @i_dividendo
            or (di_dividendo = @i_dividendo and ro_concepto > @i_concepto))
      and  ro_operacion  = @w_operacionca
      and  ro_fpago     in ('P','A','M','T')   
      and  di_operacion  = @w_operacionca
      left outer join ca_amortizacion
      on   ro_concepto   = am_concepto
      and  di_dividendo  = am_dividendo
      and  am_operacion  = @w_operacionca
      
      select @w_count = (@w_buffer - @w_bytes_env) / 21  -- Esta linea antes era 21, se cambio a 21 
                                                         -- Para corregir una consulta puntual  def.5043
      
      if @i_dividendo > 0 and @i_opcion = 0
         select @i_dividendo = 0
   
      set rowcount @w_count
      
      select 
      di_dividendo,
      ro_concepto,
      convert(float, isnull(sum(isnull(am_cuota,0) + isnull(am_gracia,0)),0))
      from ca_rubro_op
      inner join ca_dividendo
      on   (   di_dividendo > @i_dividendo
            or (di_dividendo = @i_dividendo and ro_concepto > @i_concepto))
      and  ro_operacion  = @w_operacionca                  
      and  ro_fpago     in ('P','A','M','T')  
      and  di_operacion  = @w_operacionca                           
      left outer join ca_amortizacion 
      on   ro_concepto   = am_concepto
      and  di_dividendo  = am_dividendo
      and  am_operacion  = @w_operacionca
      group by di_dividendo, ro_concepto
      order by di_dividendo, ro_concepto
      
       
      --if @w_total_reg = @w_count 
      --   select @w_count = @w_count + 1
     
      select @w_count 
   end

   exec @w_error = sp_pagxreco --RQ 293 - LCM
        @i_tipo_oper   = 'V',
        @i_operacionca = @w_operacionca,
        @o_vlr_x_amort = @w_vlr_x_amort  out

   select isnull(@w_vlr_x_amort,0)
end


--- ESTADO ACTUAL DETALLE 
if @i_operacion = 'L'
 begin
   select 'Rubro'              = am_concepto,
          'Estado'             = (SELECT es_descripcion FROM ca_estado WHERE es_codigo = am.am_estado),
          'Periodo'            = am_periodo,
          'Cuota            '  = convert(float, am_cuota),
          'Gracia           '  = convert(float, am_gracia),
          'Pagado           '  = convert(float, am_pagado),   
          'Acumulado        '  = convert(float, am_acumulado),
          'Secuencia   '       = am_secuencia
   from ca_amortizacion am,
           ca_dividendo di
       -- ca_estado
   where am_operacion = di_operacion
   and am_dividendo     = di_dividendo
   and am_operacion = @w_operacionca
   and   am_dividendo = @i_dividendo   
    
end

--- INSTRUCCIONES OPERATIVAS 

if @i_operacion = 'I' 
begin
   select @i_numero = isnull(@i_numero , 0)
   
   set rowcount 8
   select  'Numero'          = in_numero,
           'Tipo'            = in_codigo,
           'Instruccion'     = ti_descripcion,
           'Descripcion'     = in_texto,
           'Estado'          = in_estado,
           'Aprobado Por'    = fu_nombre,
           'Fecha Ejecucion' = convert(char(10), in_fecha_eje, 103),
           'Ejecutado Por'   = in_login_eje
            from cob_credito..cr_instrucciones
                 inner join cob_credito..cr_tinstruccion on
                           in_tramite = @w_tramite
                           and ti_codigo = in_codigo                                   
                           and in_numero > @i_numero  
                                   left outer join  cobis..cl_funcionario noholdlock on
                                   in_login_aprob = fu_login
   
   set rowcount 0
end


--- GARANTIAS

if @i_operacion = 'G' begin
   if @i_sucursal is null   
      select @i_sucursal = of_sucursal
      from cobis..cl_oficina
      where of_oficina = @i_oficina
      set transaction isolation level read uncommitted

set rowcount 20

   select 
      distinct  gp_garantia as GARANTIA,
                cu_estado as ESTADO_GAR,
                substring(cu_tipo,1,15)+'   '+substring(tc_descripcion,1,20) as DESCRIPCION,
                cg_ente as COD_CLIENTE,
                substring(cg_nombre,1,25) as NOMBRE_CLIENTE, 
                convert(float,cu_valor_inicial) as VALOR_ACTUAL,
                cu_moneda as MON,
                convert(varchar(10),cu_fecha_ingreso,103) as F_INGRESO
   from cob_custodia..cu_custodia,
        cob_custodia..cu_cliente_garantia,
        cob_custodia..cu_tipo_custodia,
        cob_credito..cr_gar_propuesta,
        cob_cartera..ca_operacion
   where ((@w_resumen_grupal = 'S' and op_banco in( select banco from #operaciones )) or (@w_resumen_grupal = 'N' and (op_banco = @i_banco or op_tramite = @i_tramite) ))
   and op_tramite           = gp_tramite 
   and cu_codigo_externo    = gp_garantia
   and cu_codigo_externo    = cg_codigo_externo
   and cu_tipo              = tc_tipo
   and cu_estado in ('V','F','P','C')
   and cg_principal  in ('D','S' )
   order by GARANTIA,
            ESTADO_GAR,
            DESCRIPCION,
            COD_CLIENTE,
            NOMBRE_CLIENTE, 
            VALOR_ACTUAL,
            MON,
            F_INGRESO
end

--- RUBROS 
if @i_operacion = 'R'  
begin

   select 'roperacion'         = ro_operacion,
   'Rubro'                     = ro_concepto,
   'Descripcion'               = substring(co_descripcion,1,30), 
   'Tipo Rubro'                = ro_tipo_rubro, 
   'F. de Pago'                = ro_fpago ,
   'Valor'                       = convert(money, null),---isnull((SELECT sum(am_cuota) FROM ca_amortizacion WHERE am_operacion = @w_operacionca AND am_concepto = co.co_concepto),0), 
   'Prioridad'                 = ro_prioridad, 
   'Paga Mora'                 = ro_paga_mora,
   'Causa'                     = ro_provisiona,
   'Referencia'                = ro_referencial,
   'Signo'                     = ro_signo ,
   'Valor/Puntos'              = round(ro_factor,2),              
   'Tipo/Puntos'               = ro_tipo_puntos,   
   'Valor/Tasa Total'          = ro_porcentaje,
   'Tasa Negociada'            = ro_porcentaje_aux,
   'Tasa Ef.Anual'             = ro_porcentaje_efa,
   'Signo reaj.'               = ro_signo_reajuste ,
   'Valor/Puntos de Reaj.'     = ro_factor_reajuste,     
   'Referencia de Reaj.'       = substring(ro_referencial_reajuste,1,10),
   'Gracia'                    = ro_gracia,
   'Base de calculo'           = ro_base_calculo,
   'Por./Cobrar/TIMBRE'        = ro_porcentaje_cobrar,
   'Tipo Garantia'             = ro_tipo_garantia,
   'Nro. Garantia'             = ro_nro_garantia, 
   '%Cobertura Gar.'           = ro_porcentaje_cobertura,
   'Valor Garantia'            = ro_valor_garantia,
   'Tipo Dividendo'            = ro_tperiodo,
   'No. Periodos Int.'         = ro_periodo,
   'Tabla Otras Tasas'         = ro_tabla
   into #rubros
   from ca_rubro_op ro, ca_concepto co
   where((@w_resumen_grupal = 'S' and ro_operacion in( select operacion  from #operaciones )) or (@w_resumen_grupal = 'N' and ro_operacion   = @w_operacionca ))   
   and   ro_concepto=co_concepto

   select 
   operacion = am_operacion ,
   concepto  = am_concepto,
   monto     = isnull(sum(am_cuota),0)
   into #valores
   from ca_amortizacion 
   where ((@w_resumen_grupal = 'S' and am_operacion in( select operacion  from #operaciones )) or (@w_resumen_grupal = 'N' and am_operacion   = @w_operacionca )) 
   group by am_operacion,am_concepto
   
   update #rubros set 
   Valor = monto
   from #valores
   where roperacion = operacion
   and   concepto   = Rubro
   
   update  #rubros set [Base de calculo] = null 
   
   select 
   [Rubro]                    ,
   [Descripcion]              ,
   [Tipo Rubro]               ,
   [F. de Pago]               ,
   isnull(sum([Valor]),0)     , 
   [Prioridad]                ,
   [Paga Mora]                ,
   [Causa]                    ,
   [Referencia]               ,
   [Signo]                    ,
   [Valor/Puntos]             ,
   [Tipo/Puntos]              ,
   [Valor/Tasa Total]         ,
   [Tasa Negociada]           ,
   [Tasa Ef.Anual]            ,
   [Signo reaj.]              ,
   [Valor/Puntos de Reaj.]    ,
   [Referencia de Reaj.]      ,
   [Gracia]                   ,
   [Base de calculo]          ,
   [Por./Cobrar/TIMBRE]       ,
   [Tipo Garantia]            ,
   [Nro. Garantia]            ,
   [%Cobertura Gar.]          ,
   [Valor Garantia]           ,
   [Tipo Dividendo]           ,
   [No. Periodos Int.]        ,
   [Tabla Otras Tasas]        
   from  #rubros 
   where Rubro > isnull(@i_concepto,'')
   group by [Rubro]         ,[Descripcion]     ,[Tipo Rubro]       ,[F. de Pago],                   
            [Prioridad]     ,[Paga Mora]       ,[Causa]            ,[Referencia],    
            [Signo]         ,[Valor/Puntos]    , [Tipo/Puntos]     , [Valor/Tasa Total],
            [Tasa Negociada],[Tasa Ef.Anual]   ,[Signo reaj.]      ,[Valor/Puntos de Reaj.],
            [Gracia]        ,[Base de calculo] ,[Por./Cobrar/TIMBRE],  [Referencia de Reaj.],
            [Tipo Garantia],[Nro. Garantia] ,[%Cobertura Gar.],[Valor Garantia] ,[Tipo Dividendo] ,
            [No. Periodos Int.] ,[Tabla Otras Tasas] 
   order by Rubro

 
end

--- OPERACIONES RENOVADAS                            
if @i_operacion = 'N'  
begin
   select 
      'Tramite'            = or_tramite,
      'Operacion Renovada' = or_num_operacion,     
      'Monto Original'     = or_monto_original,
      'Saldo Renovado'     = or_saldo_original,
      'Tipo Credito'       = or_toperacion,
      'Funcionario'        = or_login
   from ca_operacion, cob_credito..cr_op_renovar
   where op_operacion           = @w_operacionca
   and   or_tramite             = op_tramite
   and   or_finalizo_renovacion = 'S'
   order by or_num_operacion
end

-- INI - REQ 175: PEQUEÑA EMPRESA
-- CAPITALIZADO
if @i_operacion = 'C'
begin
   if @w_dist_gracia = 'C' and @w_gracia_int > 0
   begin
      select top 50
      dtr_dividendo,
      sum(isnull(dtr_monto,0))
      from ca_transaccion, ca_det_trn
      where tr_operacion   = @w_operacionca
      and   tr_tran        = 'CRC'
      and   tr_estado     <> 'RV'
      and   dtr_operacion  = tr_operacion
      and   dtr_secuencial = tr_secuencial
      and   dtr_concepto   = 'INT'
      and   dtr_dividendo  < @i_dividendo
      group by dtr_dividendo
      order by dtr_dividendo desc
   end
end
-- FIN - REQ 175: PEQUEÑA EMPRESA


--- CONSULTA DE TRANSACCIONES 
if @i_operacion='F' begin

   --SELECCIONAMOS LOS CONCEPTOS QUE NO APLIQUEN EN LIQUIDACION 
   select * into #conceptos 
   from cob_cartera..ca_concepto  
   where co_concepto in ( select ru_concepto from ca_rubro where ru_fpago <> 'L')
   
   --GENERANDO TRANSACCIONES 
   if  (@w_resumen_grupal = 'N')  begin 
   
      
      
      
      --TRANSACCIONES NORMALES 
      select
      oper           = tr_operacion,
      transaccion    = tr_tran,
      secuencial     = tr_secuencial,
      secuencial_ref = tr_secuencial_ref,
      fecha_Trn      = substring(convert(varchar,tr_fecha_mov, @i_formato_fecha),1,15),
      fecha_Ref      = substring(convert(varchar,tr_fecha_ref, @i_formato_fecha),1,15),
      oficina        = tr_ofi_oper,
      moneda         = tr_moneda , 
      concepto       = dtr_concepto ,
      codvalor       = dtr_codvalor,
      dividendo      = dtr_dividendo,
      corresponsal_id= convert(int,null),
      forma_pago     = convert(varchar,null),
      estado         = tr_estado,
      usuario        = tr_usuario,
      tramite        = @w_tramite, 
      observacion    = tr_observacion,
      monto          = sum(dtr_monto) 
      into #transacciones
      from  ca_transaccion  , ca_det_trn 
      where tr_operacion  = @w_operacionca
      and   tr_operacion  = dtr_operacion 
      and   tr_secuencial = dtr_secuencial 
      and   tr_tran not in ('REJ','CMO','REC','PRV','HFM') 
      and   (dtr_concepto in ( select co_concepto from #conceptos ) or dtr_concepto in (select co_nombre from ca_corresponsal))
      group by tr_operacion,tr_tran,tr_secuencial,tr_secuencial_ref,tr_ofi_oper,tr_moneda,tr_estado,tr_usuario,
      tr_observacion,tr_fecha_mov,tr_fecha_ref ,dtr_concepto,dtr_codvalor,dtr_dividendo
      
      select  @w_grupo = tg_grupo,@w_tramite = tg_tramite 
      from cob_credito..cr_tramite_grupal where tg_prestamo =@i_banco 
      
      select * into #ca_garantia_liquida from ca_garantia_liquida where gl_tramite = @w_tramite
      
      
      --TRANSACCIONES GAR 
      
      
      insert into #transacciones  
      select
      oper           = tr_operacion,
      transaccion    = tr_tran,
      secuencial     = tr_secuencial,
      secuencial_ref = tr_secuencial_ref,
      fecha_Trn      = substring(convert(varchar,tr_fecha_mov, @i_formato_fecha),1,15),
      fecha_Ref      = substring(convert(varchar,tr_fecha_ref, @i_formato_fecha),1,15),
      oficina        = tr_ofi_oper,
      moneda         = tr_moneda , 
      concepto       = dtr_concepto ,
      codvalor       = dtr_codvalor,
      dividendo      = dtr_dividendo,
      corresponsal_id= convert(int,null),
      forma_pago     = convert(varchar,null),
      estado         = tr_estado,
      usuario        = tr_usuario,
      tramite        = @w_tramite, 
      observacion    = tr_observacion,
      monto          = sum(dtr_monto) 
      from  ca_transaccion  , ca_det_trn  
      where tr_operacion  = -3
      and   tr_operacion  = dtr_operacion
      and   tr_banco      = @w_cliente          
      and   tr_secuencial = dtr_secuencial 
      and   tr_tran = 'GAR'
      and   tr_dias_calc  = @w_tramite 
      and   (dtr_concepto in ( select co_concepto from #conceptos ) or dtr_concepto in (select co_nombre from ca_corresponsal))
      group by tr_operacion,tr_tran,tr_secuencial,tr_secuencial_ref,tr_ofi_oper,tr_moneda,tr_estado,tr_usuario,
      tr_observacion,tr_fecha_mov,tr_fecha_ref ,dtr_concepto,dtr_codvalor,dtr_dividendo
      
      /*MOSTRAR TRANSACCIONES DSP*/
      insert into #transacciones  
      select
	   oper           = tr_operacion,
      transaccion    = tr_tran,
      secuencial     = tr_secuencial,
      secuencial_ref = tr_secuencial_ref,
      fecha_Trn      = substring(convert(varchar,tr_fecha_mov, @i_formato_fecha),1,15),
      fecha_Ref      = substring(convert(varchar,tr_fecha_ref, @i_formato_fecha),1,15),
      oficina        = tr_ofi_oper,
      moneda         = tr_moneda , 
      concepto       = 'INT' ,
      codvalor       = 0,
      dividendo      = 0,
      corresponsal_id= convert(int,null),
      forma_pago     = convert(varchar,null),
      estado         = tr_estado,
      usuario        = tr_usuario,
      tramite        = @w_tramite, 
      observacion    = tr_observacion,
      monto          = de_int_dsp 
      from  ca_transaccion,ca_desplazamiento  
      where  tr_operacion  = de_operacion
      and    tr_secuencial  = de_secuencial
      and    tr_operacion  = @w_operacionca    	  
      and    tr_tran       = 'DSP'
	  
	  
	  
	  
	  
	  /*MOSTRAR TRANSACCIONES RES*/
      insert into #transacciones  
      select
	  oper           = tr_operacion,
      transaccion    = tr_tran,
      secuencial     = tr_secuencial,
      secuencial_ref = tr_secuencial_ref,
      fecha_Trn      = substring(convert(varchar,tr_fecha_mov, @i_formato_fecha),1,15),
      fecha_Ref      = substring(convert(varchar,tr_fecha_ref, @i_formato_fecha),1,15),
      oficina        = tr_ofi_oper,
      moneda         = tr_moneda , 
      concepto       = 'CAP' ,
      codvalor       = 0,
      dividendo      = 0,
      corresponsal_id= convert(int,null),
      forma_pago     = convert(varchar,null),
      estado         = tr_estado,
      usuario        = tr_usuario,
      tramite        = @w_tramite, 
      observacion    = tr_observacion,
      monto          = 0 
      from  ca_transaccion  
      where  tr_operacion  = @w_operacionca    	  
      and    tr_tran       = 'RES'
	  
	/* DETERMINAR SALDO DE CAPITAL ANTES DEL PAGO */
      select 
      his_operacion = amh_operacion,
      his_secuencial= amh_secuencial,
      his_cap    = isnull(sum(amh_cuota - amh_pagado),0)
      into #saldo
      from ca_amortizacion_his, #transacciones 
      where amh_operacion  = @w_operacionca
	  and   amh_operacion  = oper
	  and   transaccion    = 'RES'
      and   amh_secuencial = secuencial
      and   amh_concepto   = 'CAP'
      group by amh_operacion, amh_secuencial
      
   
      
      /* DETERMINAR SALDO DE CAPITAL ANTES DEL PAGO */
      insert  into #saldo
      select 
      his_operacion = amh_operacion,
      his_secuencial= amh_secuencial,
      his_cap       = isnull(sum(amh_cuota - amh_pagado),0)
      from cob_cartera_his..ca_amortizacion_his, #transacciones 
      where amh_operacion  = @w_operacionca 
	  and   amh_operacion  = oper
	  and   transaccion    = 'RES'
      and   amh_secuencial = secuencial
      and   amh_concepto   = 'CAP'
      group by amh_operacion, amh_secuencial
	  
	  
	  update #transacciones set 
	  monto = his_cap
	  from #saldo  , #transacciones 
	  where his_operacion   = oper
	  and   his_secuencial  = secuencial
	  and   transaccion     = 'RES' 
	  and   his_operacion   = @w_operacionca
       
	  
	  
	  
	  
	  
      
      delete #transacciones from #ca_garantia_liquida where oper = -3 and tramite <> gl_tramite
      
      delete #transacciones where transaccion  = 'GAR'  and concepto in ( select co_concepto from #conceptos ) 
 
     

      --ACTUALIZANDO FORMA DE PAGO
      update #transacciones  set 
      forma_pago = isnull(abd_concepto, '')  
      from ca_abono,ca_abono_det 
      where ab_operacion      = abd_operacion 
      and   ab_secuencial_ing = abd_secuencial_ing        
      and   oper              = abd_operacion
      and   (ab_secuencial_rpa = secuencial_ref  or ab_secuencial_pag =abs(secuencial))                 
      and   transaccion   in (  'PAG', 'GAR', 'GAR_DEB')    

     --DETALLE DE LAS TRANSACCIONES 
      
      delete ca_qry_det_trn     where qd_usuario = @s_user
      
    
      insert into ca_qry_det_trn
      select
      qd_secuencial_trn   = secuencial,
      qd_concepto         = concepto,
      qd_estado           = 1,
      qd_cuota            = dividendo,
      qd_secuencia        = 0,
      qd_codigo_valor     = codvalor,
      qd_monto            = sum(monto),
      qd_usuario          = @s_user
      from #transacciones
      group by secuencial,concepto,estado,dividendo,codvalor
      order by dividendo
      
      select @w_secuencia = 0
      
      update  ca_qry_det_trn set 
      qd_secuencia    =    @w_secuencia, 
      @w_secuencia    =    @w_secuencia +1
      where qd_usuario =   @s_user 
    

      
     --SI ES PRIMERA VEZ ACTUALIZAMOS 
      if @i_secuencial_ing = 0  begin 
   
         delete ca_qry_transacciones where qt_usuario = @s_user
      
 
	 update #transacciones set
	 usuario = fv_usuario
	 from ca_log_fecha_valor
         where oper = fv_operacion
         and   secuencial = fv_secuencial_retro
         and   fv_tipo = 'R'
		               
      
         insert into ca_qry_transacciones 
         select 
         qt_transaccion     =transaccion ,
         qt_secuencial      =secuencial,  
         qt_fecha_Trn       =fecha_Trn,       
         qt_fecha_Ref       =fecha_Ref ,  
         qt_oficina         =oficina,     
         qt_monto           =sum(monto),     
         qt_moneda          =moneda  , 
         qt_corresponsal_id ='',      
         qt_forma_pago      =(case when transaccion = 'GAR'then  observacion else forma_pago end)  , 
         qt_estado          =estado ,     
         qt_usuario_trn     =usuario ,
         qt_tramite         =0    ,
         qt_usuario          =@s_user
         from #transacciones
         group by transaccion,secuencial,fecha_Trn,fecha_Ref,oficina,moneda,corresponsal_id,forma_pago,estado,usuario,tramite,observacion
         order by abs(secuencial), fecha_Ref asc
   
      end 
   
 
   
    set rowcount 20
   
    select 
     qt_id,
    'Tipo_tran'        = qt_transaccion ,
    'Id_tran'          = qt_secuencial,       
    'Fecha_Ingreso'    = qt_fecha_Trn,       
    'Fecha_Valor'      = qt_fecha_Ref ,  
    'Oficina'          = qt_oficina,     
    'Monto'            = qt_monto ,     
    'Moneda'           = qt_moneda  ,    
    'Id_Corresponsal'  = qt_corresponsal_id,
    'Forma_Pago'       = qt_forma_pago , 
    'Estado'           = qt_estado ,     
    'Usuario'          = qt_usuario_trn     
    from ca_qry_transacciones
    where qt_id >@i_secuencial_ing 
    and  qt_usuario = @s_user 
    order by qt_id 
    
    set rowcount 0 
    
   end else begin --RESUMEN GRUPAL DE LAS TRANSACCIONE = S
   
     ---GENERAMOS EN TEMPORALES EL UNIVERSO DE TRANSACCIONES PARA EVITAR RELECTURAS 
      
      select * into #ca_transaccion from ca_transaccion where tr_operacion in ( select operacion from #operaciones)
      select * into #ca_det_trn  from ca_det_trn where dtr_operacion in ( select operacion from #operaciones)      
      
      insert into #ca_transaccion  
      select * from ca_transaccion 
      where tr_operacion = -3 
      and tr_banco in (select cliente from #clientes) 
      
      insert into #ca_det_trn  
      select ca_det_trn.* 
      from ca_det_trn, #ca_transaccion
      where dtr_operacion = tr_operacion
      and   tr_secuencial = dtr_secuencial 
      and   tr_operacion   = -3 
      and   tr_tran         = 'GAR'
      
     
      
      --SUMARIZAMOS Y AGRUPAMOS TODAS LAS TRANSACCIONES REVERSADAS
      
      select
      oper           = min(tr_operacion),
      transaccion    = tr_tran,
      secuencial     = min(tr_secuencial),
      secuencial_ref = min(tr_secuencial_ref),
      fecha_Trn      = substring(convert(varchar,tr_fecha_mov, @i_formato_fecha),1,15),
      fecha_Ref      = substring(convert(varchar,tr_fecha_ref, @i_formato_fecha),1,15),
      oficina        = tr_ofi_oper,
      moneda         = tr_moneda , 
      concepto       = min(dtr_concepto) ,
      codvalor       = min(dtr_codvalor),
      dividendo      = min(dtr_dividendo),
      corresponsal_id= convert(int,null),
      forma_pago     = convert(varchar,null),
      estado         = tr_estado,
      usuario        = tr_usuario,
      tramite        =@w_tramite, 
      observacion    = convert(varchar,null),
      monto          = sum(dtr_monto) 
      into #transacciones_grup 
      from  #ca_transaccion  , #ca_det_trn 
      where( tr_operacion in (select operacion from #operaciones))
      and tr_operacion = dtr_operacion 
      and tr_secuencial= dtr_secuencial 
      and tr_secuencial  < 0 
      and tr_tran not in ('REJ','CMO','REC','PRV','HFM') 
      and  (dtr_concepto in ( select co_concepto from #conceptos ) or dtr_concepto in (select co_nombre from ca_corresponsal))
      group by tr_tran,tr_ofi_oper,tr_moneda,tr_estado,tr_usuario,tr_observacion,tr_fecha_mov,tr_fecha_ref
      
      --SUMARIZAMOS Y AGRUPAMOS TODAS LAS TRANSACCIONES NORMALES  
      insert into #transacciones_grup
      select
      oper           = max(tr_operacion),
      transaccion    = tr_tran,
      secuencial     = max(tr_secuencial),
      secuencial_ref = max(tr_secuencial_ref),
      fecha_Trn      = substring(convert(varchar,max(tr_fecha_mov), @i_formato_fecha),1,15),
      fecha_Ref      = substring(convert(varchar,max(tr_fecha_ref), @i_formato_fecha),1,15),
      oficina        = tr_ofi_oper,
      moneda         = tr_moneda ,
      concepto       = max(dtr_concepto) ,
      codvalor       = max(dtr_codvalor),
      dividendo      = max(dtr_dividendo),
      corresponsal_id= convert(int,null),
      forma_pago     = convert(varchar,null),
      estado         = tr_estado,
      usuario        = tr_usuario,
      tramite        = @w_tramite, 
      observacion    = convert(varchar,null),
      monto          = sum(dtr_monto) 
      from  #ca_transaccion  , #ca_det_trn
      where( tr_operacion in (select operacion from #operaciones))
      and tr_operacion = dtr_operacion 
      and tr_secuencial = dtr_secuencial 
      and tr_secuencial  > 0 
      and tr_tran not in ('REJ','CMO','REC','PRV','HFM') 
      and (dtr_concepto in ( select co_concepto from #conceptos ) or dtr_concepto in (select co_nombre from ca_corresponsal))
      group by tr_tran,tr_ofi_oper,tr_moneda,tr_estado,tr_usuario,tr_observacion,tr_fecha_mov,tr_fecha_ref
     
      
      select  @w_grupo = tg_grupo,@w_tramite = tg_tramite 
      from cob_credito..cr_tramite_grupal where tg_referencia_grupal =@i_banco 

      
      --TRANSACCIONES GAR GRUPALES  NORMALES 
      insert into #transacciones_grup  
      select
      oper           = min(tr_operacion),
      transaccion    = tr_tran,
      secuencial     = min(tr_secuencial),
      secuencial_ref = min(tr_secuencial_ref),
      fecha_Trn      = substring(convert(varchar,tr_fecha_mov, @i_formato_fecha),1,15),
      fecha_Ref      = substring(convert(varchar,tr_fecha_ref, @i_formato_fecha),1,15),
      oficina        = tr_ofi_oper,
      moneda         = tr_moneda , 
      concepto       = min(dtr_concepto) ,
      codvalor       = min(dtr_codvalor),
      dividendo      = min(dtr_dividendo),
      corresponsal_id= convert(int,null),
      forma_pago     = convert(varchar,null),
      estado         = tr_estado,
      usuario        = tr_usuario,
      tramite        =@w_tramite, 
      observacion    = tr_observacion,
      monto          = sum(dtr_monto)  
      from  #ca_transaccion  , #ca_det_trn 
      where(tr_banco in (select cliente from #clientes))
      and tr_operacion = dtr_operacion 
      and tr_secuencial = dtr_secuencial 
      and tr_tran = 'GAR'
      and tr_operacion = -3  
      and   tr_secuencial <0
      and tr_dias_calc  = @w_tramite 
      and   (dtr_concepto in ( select co_concepto from #conceptos ) or dtr_concepto in (select co_nombre from ca_corresponsal))
      group by tr_tran,tr_ofi_oper,tr_moneda,tr_estado,tr_usuario,
      tr_observacion,tr_fecha_mov,tr_fecha_ref  
      
      
      insert into #transacciones_grup
      select
      oper           = max(tr_operacion),
      transaccion    = tr_tran,
      secuencial     = max(tr_secuencial),
      secuencial_ref = max(tr_secuencial_ref),
      fecha_Trn      = substring(convert(varchar,tr_fecha_mov, @i_formato_fecha),1,15),
      fecha_Ref      = substring(convert(varchar,tr_fecha_ref, @i_formato_fecha),1,15),
      oficina        = tr_ofi_oper,
      moneda         = tr_moneda , 
      concepto       = max(dtr_concepto) ,
      codvalor       = max(dtr_codvalor),
      dividendo      = max(dtr_dividendo),
      corresponsal_id= convert(int,null),
      forma_pago     = convert(varchar,null),
      estado         = tr_estado,
      usuario        = tr_usuario,
      tramite        =@w_tramite, 
      observacion    = tr_observacion,
      monto          = sum(dtr_monto)      
      from  #ca_transaccion  , #ca_det_trn
      where(tr_banco in (select cliente from #clientes))
      and tr_operacion = dtr_operacion 
      and tr_secuencial = dtr_secuencial 
      and tr_tran = 'GAR'
      and tr_operacion = -3  
      and tr_secuencial >0
      and tr_dias_calc  = @w_tramite
      and (dtr_concepto in ( select co_concepto from #conceptos ) or dtr_concepto in (select co_nombre from ca_corresponsal))
      group by tr_tran,tr_ofi_oper,tr_moneda,tr_estado,tr_usuario,tr_observacion,tr_fecha_mov,tr_fecha_ref  
 

      --ACTUALIZANDO FORMA DE PAGO
      update #transacciones_grup   set 
      forma_pago = isnull(abd_concepto, '')  
      from ca_abono,ca_abono_det 
      where ab_operacion      = abd_operacion 
      and   ab_secuencial_ing = abd_secuencial_ing        
      and   oper              = abd_operacion
      and   (ab_secuencial_rpa = secuencial_ref  or ab_secuencial_pag =abs(secuencial))                 
      and   transaccion   in (  'PAG', 'GAR', 'GAR_DEB')    

      insert into #transacciones_grup
      select 
            tr_operacion,
            tr_tran,
            tr_secuencial,
            tr_secuencial_ref,
            substring(convert(varchar,tr_fecha_mov, @i_formato_fecha),1,15),
            substring(convert(varchar,tr_fecha_ref, @i_formato_fecha),1,15),
            tr_ofi_oper,
            tr_moneda,
            dtr_concepto,
            dtr_codvalor,
            dtr_dividendo,
            convert(int,null),
            convert(varchar,null),
            tr_estado,
            tr_usuario,
            null,
            tr_observacion,
            dtr_monto
      from ca_transaccion, ca_det_trn
      where tr_operacion = dtr_operacion
      and tr_secuencial = dtr_secuencial
      and dtr_concepto  = 'SANTANDER'
      and tr_operacion    = @w_operacionca  
    
      --INSERTAMOS Y DEJAMOS LISTO EL DETALLE DE LA TRANSACCION PARA QUE SEA LEIDO EN LA OPCION K
    
      delete ca_qry_det_trn     where qd_usuario = @s_user
      
    
      insert into ca_qry_det_trn
      select
      qd_secuencial_trn   = secuencial,
      qd_concepto         = concepto,
      qd_estado           = 1,
      qd_cuota            = dividendo,
      qd_secuencia        = 0,
      qd_codigo_valor     = codvalor,
      qd_monto            = monto,
      qd_usuario          = @s_user
      from #transacciones_grup
      where transaccion <>'DSC'
      order by dividendo
      
      insert into ca_qry_det_trn 
      select  
      qd_secuencial_trn   = dtr_secuencial,
      qd_concepto         = dtr_concepto,
      qd_estado           = dtr_estado,
      qd_cuota            = dtr_dividendo,
      qd_secuencia        = 0,
      qd_codigo_valor     = dtr_codvalor,
      qd_monto            = dtr_monto,
      qd_usuario          = @s_user
      from 
      ca_transaccion,ca_det_trn 
      where tr_operacion = dtr_operacion
      and tr_secuencial = dtr_secuencial
      and tr_operacion = @w_operacionca 
      and dtr_concepto <> 'SANTANDER'
      
      
      select @w_secuencia = 0
      
      update  ca_qry_det_trn set 
      qd_secuencia    =    @w_secuencia, 
      @w_secuencia    =    @w_secuencia +1
      where qd_usuario =   @s_user 
    

     
    if @i_secuencial_ing = 0  begin 
   
         delete ca_qry_transacciones where qt_usuario = @s_user
      
         insert into ca_qry_transacciones 
         select 
         qt_transaccion     =transaccion ,
         qt_secuencial      =secuencial,  
         qt_fecha_Trn       =fecha_Trn,       
         qt_fecha_Ref       =fecha_Ref ,  
         qt_oficina         =oficina,     
         qt_monto           =sum(monto),     
         qt_moneda          =moneda  , 
         qt_corresponsal_id ='',      
         qt_forma_pago      =(case when transaccion = 'GAR'then  observacion else forma_pago end)  ,  
         qt_estado          =estado ,     
         qt_usuario_trn     =usuario ,
         qt_tramite         =0    ,
         qt_usuario          =@s_user        
         from  #transacciones_grup
         group by transaccion ,secuencial,fecha_Trn, fecha_Ref ,oficina,moneda  , forma_pago ,estado , usuario ,observacion
         order by abs(secuencial), fecha_Ref asc
     
    end 
         
  
   
      set rowcount 20
      
      select 
       qt_id,
      'Tipo_tran'        = qt_transaccion ,
      'Id_tran'          = qt_secuencial,       
      'Fecha_Ingreso'    = qt_fecha_Trn,       
      'Fecha_Valor'      = qt_fecha_Ref ,  
      'Oficina'          = qt_oficina,     
      'Monto'            = qt_monto,     
      'Moneda'           = qt_moneda  ,    
      'Id_Corresponsal'  = qt_corresponsal_id,
      'Forma_Pago'       = qt_forma_pago , 
      'Estado'           = qt_estado ,     
      'Usuario'          = qt_usuario_trn     
      from ca_qry_transacciones
      where qt_id >@i_secuencial_ing 
      and qt_usuario = @s_user
      order by qt_id
      
      set rowcount 0 
      
      
   end 
end 


if @i_operacion = 'K' begin

   select 
   'CONCEPTO'    = qd_concepto,
   'ESTADO'      = substring((select es_descripcion from ca_estado  where es_codigo = a.qd_estado),1,10),
   'CUOTA'       = qd_cuota,
   'SECUENCIA'   = qd_secuencia,
   'CODIGO_VALOR'= qd_codigo_valor,
   'MONTO'       = qd_monto      
   from  ca_qry_det_trn a
   where qd_usuario = @s_user 
   and qd_secuencial_trn =@i_secuencial_ing
   order by qd_id 
 

end 
 



return 0

ERROR:

exec cobis..sp_cerror
   @t_debug = 'N',
   @t_from  = @w_sp_name,
   @i_num   = @w_error
return @w_error
                        
go
