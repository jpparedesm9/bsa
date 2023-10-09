/************************************************************************/
/*      Archivo:                pf_bloqueo.sp                           */
/*      Stored procedure:       sp_bloqueo_pfijo                        */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Acelis                                  */
/*      Fecha de documentacion: 17/Jun/2015                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de INSERT, DELETE,      */
/*      SEARCH y QUERY de la tabla de retenciones 'pf_retencion'.       */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */
/*      17-Jun-2015  ACelis       Req 520 Emision Inicial               */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_bloqueo_pfijo')
   drop proc sp_bloqueo_pfijo
go

create proc sp_bloqueo_pfijo(
@i_param1              datetime)
with encryption
as
declare
@w_sp_name             varchar(32),
@w_operacionpf         int,
@w_secuencial          int,
@w_valor               money,
@w_fecha_crea          datetime,
@w_fecha_mod           datetime,
@w_suspendida          char(1),
@w_monto_disponible    money,
@w_monto_blq           money,
@w_monto               money,
@w_moneda              smallint,
@w_estado              catalogo,
@w_motivo              catalogo,
@w_historia            smallint,
@w_funcionario         login,
@w_cupon               tinyint,  
@w_return              int,      
@w_cuenta_referencia   cuenta,  
@w_prod_cobis	       catalogo,
@w_usuario             login,   
@o_codigo              varchar(30),
@w_dias_mora           tinyint,
@w_fecha_proceso	   datetime,
@w_msg                 varchar(255),
@w_error               int,
@w_servidor            varchar(30),
@w_numdeci             tinyint,
@w_usadeci             char(1),
@w_encabeza            varchar(2000),
@w_anio                varchar(4),
@w_mes                 varchar(2),
@w_dia                 varchar(2),
@w_path_destino        varchar(255),
@w_s_app               varchar(255),
@w_cmd                 varchar(1500),
@w_comando             varchar(1500),
@w_nombre_archivo      varchar(255),
@w_fecha_corte         varchar(10),
@w_hora                varchar(25),
@w_cont                int

select @w_sp_name = 'sp_bloqueo_pfijo'

select @w_fecha_proceso = @i_param1


select @w_anio = convert(varchar(4),datepart(yyyy,@w_fecha_proceso)),
       @w_mes = right('00' + convert(varchar(2),datepart(mm,@w_fecha_proceso)),2), 
       @w_dia = right('00' + convert(varchar(2),datepart(dd,@w_fecha_proceso)),2) 
       
select @w_fecha_corte = (@w_anio + right('00' + @w_mes,2) + right('00'+ @w_dia,2))

select @w_hora = CONVERT(varchar, GETDATE(), 108)

select @w_hora = REPLACE(@w_hora, ':', '_')



--CONSULTA RUTA  REPORTE  PARA PFIJO
select @w_path_destino = pp_path_destino
from   cobis..ba_path_pro
where  pp_producto = 14

if @@rowcount = 0 Begin
   select @w_msg = 'NO EXISTE RUTA DE LISTADOS PARA PFIJO'
   GOTO ERROR
End 

--CONSULTA RUTA PARA EJECUCION BCP
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'
if @@rowcount = 0 Begin
   select @w_msg = 'NO EXISTE RUTA S_APP',
          @w_error = 700008
   GOTO ERROR
End 


/* Encuentra parametro de decimales */
select @w_usadeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @w_moneda

if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
     from cobis..cl_parametro
    where pa_nemonico = 'DCI'
      and pa_producto = 'PFI'
end
else
   select @w_numdeci = 0   



if @@rowcount =0
begin
   select @w_msg = 'Error - Consulta Numero de Decimales',
          @w_error = 700002
   Goto ERROR   
end


select @w_dias_mora = pa_int
from   cobis..cl_parametro
where  pa_nemonico = 'MORCDT'
and    pa_producto = 'PFI'
if @@rowcount = 0
begin
   select @w_msg = 'Error - Consultando Parametro MORCDT',
          @w_error = 101077
   Goto ERROR 
end




--REQ 520
select 
op_operacion = C.op_operacion,
op_num_banco = C.op_num_banco,
op_cliente   = C.op_ente,
op_monto     = C.op_monto,
op_historia  = C.op_historia
into  #operaciones_pfijo
from  pf_operacion C
where C.op_estado in ('ACT','VEN','REN')
and not exists (select 1 from cob_pfijo..pf_retencion
                where  rt_operacion = C.op_operacion)
order by op_ente



select distinct
ocm_banco  = do_banco, 
ocm_cliente= do_codigo_cliente, 
ocm_mora   = do_dias_mora_365
into  #operaciones_cca_mora
from  cob_conta_super..sb_dato_operacion,#operaciones_pfijo
where do_codigo_cliente = op_cliente 
and   do_fecha  = @w_fecha_proceso
and   (do_estado_cartera = 4   
or    do_dias_mora_365 >= @w_dias_mora)
order by do_codigo_cliente


select 
oc_cliente = ocm_cliente, 
oc_mora    = max(ocm_mora),
oc_cuenta  = '            '
into  #operaciones_cca
from  #operaciones_cca_mora
group by ocm_cliente


update #operaciones_cca
set oc_cuenta  = (select top 1 ocm_banco from  #operaciones_cca_mora where oc_cliente = ocm_cliente and oc_mora = ocm_mora)

/*** INSERTA OPERACIONES CON BLOQUEO LEGAL ***/
select
bl_operacion, 
en_ced_ruc,
op_num_banco,
bl_ente
into   #bloqueo_legal
from   cob_pfijo..pf_bloqueo_legal with(nolock),
       #operaciones_pfijo,
       cobis..cl_ente with(nolock)
where  op_operacion = bl_operacion
and    bl_ente      = en_ente       


select distinct 
bp_cdt     = op_operacion, 
bp_num_banco = op_num_banco,
bp_banco   = oc_cuenta,
bp_mora    = oc_mora,
bp_monto   = op_monto,
bp_historia= op_historia,
bp_cliente = oc_cliente
into #bloqueos_pfijo
from #operaciones_cca, #operaciones_pfijo
where oc_cliente = op_cliente
and   op_operacion not in (select bl_operacion from #bloqueo_legal) -- EXCLUYE OPERACIONES CON BLOQUEO LEGAL

if @@rowcount >0
begin

insert into pf_retencion 
select 
      rt_operacion = bp_cdt,
      rt_secuencial = 1,
      rt_valor = bp_monto,
      rt_int_retencion = 0,
      rt_suspendida = 'N', 
      rt_motivo = 'INOP',
      rt_fecha_crea= @w_fecha_proceso,
      rt_fecha_mod = @w_fecha_proceso,
      rt_cupon = null,
      rt_cuenta = bp_banco,
	  rt_producto = 'CCA', 
	  rt_observacion = 'CUMPLIMIENTO DE OBLIGACIONES CON PASIVOS',
	  rt_funcionario= 'op_batch'
from #bloqueos_pfijo

                      

   
if @@error <> 0
begin
    select @w_msg = 'Error - Bloqueo CDTs tabla pf_retencion',
    @w_error = 143008
    Goto ERROR   
end
     
     

select @w_servidor =  @@servername
         
/**  INSERCION DE TRANSACCION DE SERVICIO  **/
exec @w_secuencial = ADMIN...rp_ssn

insert into ts_retencion 
select 
      secuencial      = @w_secuencial,    
      tipo_transaccion=14108, 
      clase           ='N',
      fecha           = @w_fecha_proceso,
      usuario         ='op_batch' ,
      terminal        ='consola',
      srv             = @w_servidor,
      lsrv            = null,
      operacion       =bp_cdt,
      rt_secuencial =1, 
      valor =bp_monto,            
      int_retencion =0,
      suspendida ='N', 
      motivo='INOP', 
      fecha_crea =@w_fecha_proceso,
      fecha_mod  =@w_fecha_proceso,
	  cupon = null,
	  cuenta=bp_banco, 
	  producto='CCA',
      observacion= 'CUMPLIMIENTO DE OBLIGACIONES CON PASIVOS', 
      funcionario = 'op_batch'
      from #bloqueos_pfijo

/**  VERIFICAR SI SE INSERTO CORRECTAMENTE  **/
if @@error <> 0
begin
    select @w_msg = 'Error - Bloqueo CDTs tabla pf_retencion',
    @w_error = 143008
    Goto ERROR   
end


           
/**  ACTUALIZAR LA TABLA DE OPERACIONES  **/
update pf_operacion
set    op_monto_blq = isnull ( op_monto_blq, 0 ) + round(bp_monto, @w_numdeci),
       op_retenido = 'S'
from   #bloqueos_pfijo
where  bp_cdt = op_operacion   

if @@error <> 0
begin
    select @w_msg = 'Error - Bloqueo CDTs tabla pf_operacion',
    @w_error = 145001
    Goto ERROR   
end


/**  INSERCION DEL REGISTRO EN HISTORIA  **/
         
insert pf_historia 
select 
      hi_operacion =bp_cdt,
      hi_secuencial=bp_historia,
      hi_fecha     =@w_fecha_proceso,
      hi_trn_code  =14108,
      hi_valor     =bp_monto,
      hi_funcionario= 'op_batch',
      hi_oficina   =4069,
      hi_observacion= 'CUMPLIMIENTO DE OBLIGACIONES CON PASIVOS', 
      hi_fecha_crea = @w_fecha_proceso,
      hi_fecha_mod  = @w_fecha_proceso,
      hi_tasa  = null,
      hi_cupon= null,
      hi_fecha_back    = null,
      hi_fecha_anterior= null,
      hi_saldo_capital= null,
      hi_secuencia= null

from #bloqueos_pfijo
/**  VERIFICAR SI SE INSERTO CORRECTAMENTE  **/
if @@error <> 0
begin
    select @w_msg = 'Error - Bloqueo CDTs tabla pf_operacion',
    @w_error = 143006
    Goto ERROR   
end


update pf_operacion
set    op_historia = op_historia + 1
from   #bloqueos_pfijo
where  bp_cdt = op_operacion
      
if @@error <> 0
begin
    select @w_msg = 'Error - Bloqueo CDTs tabla pf_operacion',
    @w_error = 145001
    Goto ERROR   
end

end 

if exists(select 1 from sysobjects where name = 'tmp_bloqueocdt')
   drop table tmp_bloqueocdt
   
create table tmp_bloqueocdt (cadena varchar(2000) not null)  
truncate table tmp_bloqueocdt --encabezado para sustitutivas

select @w_nombre_archivo = @w_path_destino + 'BLOQUEOCDT' + @w_fecha_corte + '_' + @w_hora + '.lis' 

select @w_encabeza = 'IDENTIFICACION DEL CLIENTE|NUMERO DE CDT|OBSERVACION'
insert into tmp_bloqueocdt (cadena)  values (@w_encabeza)

select @w_cont = COUNT(1)  from #bloqueos_pfijo

if isnull(@w_cont,0) = 0 
   insert into tmp_bloqueocdt (cadena) values  ('NO EXISTEN CDTS CON CONDICIONES PARA BLOQUEAR' )
else
begin
   insert into tmp_bloqueocdt (cadena) select  en_ced_ruc + '|' + bp_num_banco + '|OPERACION BLOQUEADA CORRECTAMENTE' from #bloqueos_pfijo, cobis..cl_ente where en_ente = bp_cliente
   
   if exists (select 1 from #bloqueo_legal)
      insert into tmp_bloqueocdt (cadena) select  en_ced_ruc + '|' + op_num_banco + '|OPERACION YA TIENE UN BLOQUEO LEGAL' from #bloqueo_legal
end


select @w_cmd     =  'bcp ''select cadena from cob_pfijo..tmp_bloqueocdt  '' queryout ' 
select @w_comando   = @w_cmd + @w_nombre_archivo + ' -b5000 -c -t"|" -T -S'+ @@servername + ' -ePLANOBloqueos.err' 


exec @w_error = xp_cmdshell @w_comando

If @w_error <> 0 Begin
   select @w_msg = 'Error Generando BCP Reporte bloqueos CDT ' + @w_comando
   Goto ERROR 
End                            

return 0

ERROR:
   
   select @w_msg = 'sp_bloqueo_pfijo' + @w_msg
   print cast(@w_msg as varchar) 
   exec @w_error = sp_errorlog
        @i_fecha      = @w_fecha_proceso,
        @i_error      = @w_error,
        @i_usuario    = 'op_batch',
        @i_tran       = 14108,
        @i_descripcion   = @w_msg
        
   return @w_error
go