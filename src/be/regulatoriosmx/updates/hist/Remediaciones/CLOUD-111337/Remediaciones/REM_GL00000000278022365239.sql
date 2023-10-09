use cob_cartera
go

declare
@w_error                   int,
@w_fecha_inicial           datetime,
@w_fecha_dia               datetime,
@w_banco                   cuenta,
@w_operacionca             int,
@w_fecha_ult_proceso       datetime,
@w_fecha_respuesta         datetime,
@w_cuenta                  cuenta,
@w_sp_name                 varchar(30),
@w_dividendo               INT,
@w_commit                  char(1),
@w_est_vigente             int,
@w_est_vencido             int,
@w_fecha_pago              datetime,
@w_tipo_pago               catalogo,
@w_secuencial              INT,
@w_tipo                    char(2),           
@w_codigo_interno          varchar(10), 
@w_porcentaje              FLOAT,      
@w_fecha_valor             datetime,          
@w_referencia              varchar(64),       
@w_moneda                  tinyint,           
@w_monto                   money ,            
@w_co_status_srv           varchar(24),    
@w_co_estado               char(1),        
@w_co_error_id             int,            
@w_co_error_msg            varchar(254),   
@w_num_dec                 int,
@w_descripcion             varchar(60),
@w_msg                     varchar(255),
@w_est                     char(2),
@w_forma_pago              catalogo,
@w_total_exigible          MONEY,
@w_total_pago              MONEY,
@w_diferencia              FLOAT,
@w_operacion_int           INT,
@w_banco_int               cuenta,
@w_monto_pago              MONEY,
@w_tramite                 int, 
@w_valor_inicial           money, 
@w_monto_aprobado          MONEY,
@w_tramite_grupal          INT,
@w_digito_verfi            CHAR(1),
@w_cadena                  VARCHAR(64),
@w_cadena_proce            VARCHAR(64),
@w_concil_est              CHAR(1),
@w_concil_motivo           CHAR(2),
@w_archivo_monto           MONEY,
@w_secuencial_ing          int,
@w_secuencial_pag          INT,
@w_sec_ing                 INT,
@w_concil_user             login, 
@w_concil_fecha            datetime,
@w_concil_obs       VARCHAR(255),
@w_estado_pag              CHAR(2),
@w_error_sp                char(1),
@w_monto_garantia          MONEY,
@w_gl_tramite              int,
@w_gl_grupo                int,
@w_gl_cliente              int,
@w_gl_monto_garantia       MONEY,
@w_gl_pag_valor            MONEY,
@w_gl_diferencia           MONEY,
@w_operacion_gar           CHAR(2),
@w_fecha_pro               DATETIME,
@w_total_exigible_fecha    money,
@w_valor_pagado_gar        money,
@w_monto_gar               money,
@w_oficina                 smallint,
@w_cliente                 int,
@w_usuario                 varchar(10),
@w_param_refopenpay        int,
@w_param_refsantander      int,
@w_long_ref                int,
@w_archivo_pag             varchar(64),
@w_param_refsantander_gar  int ,
@w_bandera                 int ,
@w_est_cancelado           int,
@w_ope                     int,
@w_ente                    int,
@w_ciudad_nacional         INT,
@w_formula                 int,
@w_saldo_exigible          money,
@w_saldo_precancelar       money,
@w_sensibilidad            float,
@w_tipo_formula_1          int,
@w_trn_id_corresp          varchar(8),
@w_accion                  char(1),
@w_estado                  char(1),
@w_secuencial_trn_rv       int,
@w_secuencial_trn          int,
@w_sp_val_corresponsal     varchar(50),
@w_id_corresponsal         varchar(10),
@w_estado_trn              char(1),
@w_token_validacion        varchar(255),
@w_limite_max              money,
@w_limite_min              money,
--@w_tipo_tran               char(2),
@w_monto_individual        money,
@w_tanquear                char(1),
@w_fecha_hoy               varchar(10), 
@w_fecha_ult_disper        datetime,
@w_hora_ult_dis            varchar(10),
@w_en_tanqueo              char(1),
@w_monto_tanqueo           money,
@w_min_dividendo           int,
@w_est_trn_reverso	       CHAR(1),
@w_est_corresponsal        char(1),
@s_date                    datetime,
@s_user                    login,
@s_term                    varchar(10)
IF OBJECT_ID('tempdb..#garantia_liquidas_tmp') IS NOT NULL DROP TABLE #garantia_liquidas_tmp

CREATE TABLE #garantia_liquidas_tmp(
gl_tramite int,
gl_grupo   int,
gl_cliente int,
gl_monto_garantia MONEY,
gl_pag_valor  MONEY,
gl_diferencia MONEY
)    

select
@s_date        = getdate(),
@w_referencia  = 'GL00000000278022365239',
@s_user        = 'admuser',
@s_term        = '0',
@w_operacionca = substring(@w_referencia,3,12),
@w_monto       = 3400,
@w_error       = 0,
@w_forma_pago  = 'SANTANDER'

select @w_tramite_grupal = max(gl_tramite) 
from ca_garantia_liquida
where gl_pag_estado  ='PC'
and   gl_grupo = @w_operacionca
	        
if @w_tramite_grupal = 0 
begin
   select 
   @w_error = 2101019,
   @w_est = 'E',
   @w_msg = 'NO EXISTE VALORES POR COBRAR DE GAR LIQUIDA ' +  convert(varchar,@w_operacionca)
   --rollback tran
end
    
select @w_ente = @w_operacionca --nro grupo que va a la tabla de ca_santander_log_pagos en el campo cliente
PRINT 'Trámite Grupal: '+ convert(varchar,@w_tramite_grupal)
select
@w_oficina = tr_oficina,
@w_usuario = tr_usuario,
@w_ope     = tr_numero_op --MTA
from cob_credito..cr_tramite 
where tr_tramite = @w_tramite_grupal
  
if @@rowcount = 0 begin
    select 
    @w_error = 70194,
    @w_msg = 'NO EXISTE REGISTRO DEL TRAMITE GRUPAL.'
    --rollback tran
end
       
PRINT 'Oficina: ' + convert(varchar,@w_oficina )
if @w_oficina = null begin
    select 
    @w_error = 70195,
    @w_msg = 'NO EXISTE OFICINA DEL TRAMITE INGRESADO PARA EL GRUPO: ' +  convert(varchar,@w_codigo_interno)
    --rollback tran
end
  
if @w_usuario = null begin
    select 
     @w_error = 70196,
     @w_msg = 'NO EXISTE OFICIAL DEL TRAMITE INGRESADO PARA EL GRUPO: ' +  convert(varchar,@w_codigo_interno)
end 
       

insert into #garantia_liquidas_tmp
select
gl_tramite,         gl_grupo,                 gl_cliente,
gl_monto_garantia,  isnull(gl_pag_valor,0),   (gl_monto_garantia - ISNULL(gl_pag_valor,0))
from cob_cartera..ca_garantia_liquida
where gl_tramite        = @w_tramite_grupal
and   gl_monto_garantia > ISNULL(gl_pag_valor,0)
      
if @@error <> 0 begin
   select 
   @w_error = 2101011,
   @w_est = 'E',
   @w_msg = 'NO EXISTE PRESTAMOS ASOCIADOS A LA GAR LIQ OPERACION GRUPAL:  ' + convert(varchar,@w_tramite_grupal)
   --rollback tran
end 
      
--valor pendiente de pago de Garantia
select @w_diferencia = sum(gl_diferencia)
from   #garantia_liquidas_tmp
where  gl_diferencia >0

if @w_diferencia <> @w_monto begin
   if @w_tanquear = 'N' begin
      select 
      @w_error = 210101,
      @w_msg = 'EL VALOR DE LA GARANTIA NO CORRESPONDE AL VALOR PAGADO, GAR: '   + convert(varchar, @w_diferencia)+' PAG: '+convert(varchar, @w_monto)+' TRAM: '+convert(varchar, @w_tramite_grupal),
      @w_est = 'E' 
	  --rollback tran
   end
   else begin
      select @w_est = 'I' --deja en estado I para procesar devolucion 
      print 'NO PROCESA PAGO DE GARANTIA , DEJA PENDIENTE PARA DEVOLUCION O REPROCESO' 
  end 
  --rollback tran
  
end   
        

begin tran

SELECT @w_gl_cliente = 0

WHILE 1= 1 begin
           
   SELECT TOP 1
   @w_gl_tramite = gl_tramite,
   @w_gl_grupo   = gl_grupo,
   @w_gl_cliente = gl_cliente,
   @w_gl_monto_garantia = gl_monto_garantia,
   @w_gl_pag_valor = gl_pag_valor,
   @w_gl_diferencia = gl_diferencia
   FROM #garantia_liquidas_tmp
   where gl_diferencia > 0
   AND gl_cliente > @w_gl_cliente
   ORDER BY gl_cliente asc

   IF @@ROWCOUNT = 0 BREAK
   
   EXEC @w_error  = cob_custodia..sp_contabiliza_garantia
   @s_date           = @s_date ,
   @s_ofi            = @w_oficina,
   @s_user           = @s_user ,
   @s_term           = @s_term,     
   @i_operacion      = 'C',
   @i_monto          = @w_gl_diferencia,
   @i_en_linea       = 'N' ,   
   @i_ente           = @w_gl_cliente,
   @i_tramite        = @w_gl_tramite,
   @i_forma_pago     = @w_forma_pago,
   @o_secuencial     = @w_secuencial_ing out
          
   if @w_error != 0 begin
     
      select             
      @w_est = 'E',
      @w_msg = 'ERROR AL EJECUTAR PROCESO DE CONTABILIZACION DE LA GARANTIA: ' + convert(varchar,@w_operacionca)
                           
      --rollback tran
   end 
   
   INSERT INTO ca_corresponsal_det(
   cd_operacion,   cd_banco,                           cd_sec_ing,         cd_referencia, cd_secuencial)
   VALUES (
   @w_gl_cliente,  convert(varchar,@w_gl_tramite),     @w_secuencial_ing  ,@w_referencia, @w_secuencial  )
    
   
   if @@error != 0 begin
      select
      @w_error          = 710001,      
      @w_est            = 'E',
      @w_msg            = 'ERROR AL CREAR DETALLE PAGO : ' + convert(varchar,@w_banco_int) + 'Secuencial ' + convert(varchar,@w_secuencial_ing)

      rollback tran
   end 
   
   

end -- end while         

select 
@w_error ,
@w_est,
@w_msg 

if @w_error = 0 and @w_msg is null begin
   update ca_corresponsal_trn set 
   co_estado = 'P',
   co_error_msg = ''
   where co_referencia = @w_referencia  
end 
else  begin
   update ca_corresponsal_trn set 
   co_estado = 'E',
   co_error_msg = @w_msg
   where co_referencia = @w_referencia  

end