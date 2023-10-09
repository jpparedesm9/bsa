/**************************************************************************/
/* Base de datos:             cob_cartera                                 */
/* Producto:                  Cartera                                     */
/* Disenado por:              ACH                                         */
/* Fecha de escritura:        04/02/2021                                  */
/**************************************************************************/
/*                              IMPORTANTE                                */
/* Este programa es parte de los paquetes bancarios propiedad de 'MACOSA'.*/
/* Su uso no autorizado queda expresamente prohibido asi como             */
/* cualquier alteracion o agregado hecho por alguno de sus                */
/* usuarios sin el debido consentimiento por escrito de la                */
/* Presidencia Ejecutiva de MACOSA o su representante.                    */
/**************************************************************************/
/*                            PROPOSITO                                   */
/* Tiene como proposito procesar los pagos de garantia liquida            */
/**************************************************************************/
/*                          MOFICIACIONES                                 */
/* 04/02/2021    ACH    Version Inicial. Se toma solo el codigo del sp    */
/*                      sp_pagos_corresponsal para pagos de garantia      */
/*                      liquida, por el caso #153406,                     */
/* 04/05/2021    ACH    Cs#158401, se agrega variables para controlar el  */
/*                      pase de etapa gl y ant                            */
/* 18/02/2022    ACH    Cs#177825, validacion rol bio grupal              */
/* 09/06/2022    ACH    Req #185234-se agrega para individuales aunque    */
/*                      solo se cobre seguro                              */
/**************************************************************************/

use cob_cartera
go

IF OBJECT_ID ('dbo.sp_pagos_corresponsal_gar_liquida') IS NOT NULL
	DROP PROCEDURE dbo.sp_pagos_corresponsal_gar_liquida
GO

create proc sp_pagos_corresponsal_gar_liquida
(
@s_ssn             int         = 1,
@s_sesn            int         = 1,
@s_date            datetime    = null,
@s_user            login       = 'usrbatch',
@s_term            varchar(30) = 'consola',
@s_ofi             smallint    = null,
@s_srv             varchar(30) = 'CTSSRV',
@s_lsrv            varchar(30) = 'CTSSRV',
@s_rol             smallint    = null,
@s_org             varchar(15) = null,
@s_culture         varchar(15) = null,
@i_operacion       CHAR(1),            -- (B)atch, (S)ervicio, (C)onciliacion manual
@i_referencia      VARCHAR(64) = NULL, -- no obligatorio para batch
@i_corresponsal    VARCHAR(64) = NULL, -- no obligatorio para batch
@i_moneda          int         = 0, -- obligatoria para el servicio
@i_fecha_valor     DATETIME    = NULL, -- obligatoria para el servicio
@i_status_srv      VARCHAR(64) = '', -- obligatoria para el servicio
@i_observacion     VARCHAR(255)= '', -- obligatoria para la conciliacion
@i_fecha_pago      varchar(8)  = NULL,
@i_monto_pago      varchar(14) = NULL,
@i_archivo_pago    varchar(255)= NULL,
@i_trn_id_corresp  varchar(25) = NULL,
@i_accion          char(1)     = NULL,
@i_en_linea        char(1)     = 'N',
@i_externo         char(1)     = 'N', -- S cuando la invocacion viene desde un agente externo N(cuando la invocacion es desde Cobis)
@i_co_linea        int         = null,--para guardar el numero de linea caundo viene por pagos masivo de la web
@i_pagos_masivos   CHAR(1)      = 'N',  -- Para ejecucion desde pantalla de pagos masivos
@o_msg             varchar(255) = null OUT, --No cambiar el orden, por el SG
@i_token           varchar(255) = null, -- para validar token 
@i_ejecutar_fvalor char(1)      = 'S',               --parametro para no ejecutar fecha valor en el sp_pago_cartera_srv en proceso masivo por remediacion
@o_codigo_err      varchar(50)  = null           out, --codigo del error esperado por el corresponsal
@o_mensaje_err     varchar(100) = null          out, --mensaje de error   
@o_monto_recibido  varchar(14)  = null out,  --monto recibido
@o_mensaje_ticket  varchar(125) = null out,  --mensaje para imprimir en el ticket del coresponsal
@o_cuenta          varchar(30)  = null out,   -- referencia para registrar el pago
@o_codigo_pago     varchar(30)  = null out,    -- codigo unico de cobis para identificar el pago 
@o_codigo_reversa  varchar(30)  = null out
)
as 
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
--@w_tramite_grupal          INT,--porCaso185234
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
@w_concil_obs              VARCHAR(255),
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
@w_trn_id_corresp          varchar(25),
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
@w_rowcount                int,
@w_valor_vigente           money,
@w_saldo_cuota             money,
@w_saldo_mas_vencido       money,
@w_trancount               int,
@w_error_tmp               int,
@w_monto_seg               money,
@w_pagado_seg              char(1),
@w_fecha_liq               datetime,
@w_precancela_dias         int,
@w_diferencia_seguro 	   float,
@w_cad_tramite             varchar(100),
@w_sc_tramite              int,
@w_sc_grupo                int,
@w_sc_cliente              int,
@w_sc_monto_seguro		   money,
@w_sc_monto_pagado		   money,
@w_sc_diferencia           money,
@w_promo                   char(1),
@w_monto_seguro_basico     money,
@w_monto_gar_liquida       money,
@w_saldo_exigible_gl       money,
@w_error_id                int,
@w_dividendo_aux           int,
@w_total                   money,
@w_saldo                   money,
--Por caso#177825
@w_id_destinatario        int,
@w_ij_id_item_jerarquia   int,
@w_continua_gl            char(1) = 'S',
@w_id_inst_proc           int,
@w_param_AVUSEB           varchar(30),
@w_codigo_cat_rol         varchar(30), 
@w_error_etapa            int, 
@w_error_etapa_mns        varchar(256), 
@w_toperacion             varchar(256)
		
select @w_cuenta = ''

select @w_fecha_pro = fp_fecha 
from cobis..ba_fecha_proceso

--Por caso#177825
select @w_param_AVUSEB = pa_char from cobis..cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'AVUSEB'
print  'Inicia: sp_pagos_corresponsal_gar_liquida--->>>Activa_validacion_etapa: ' + convert (varchar(256), @w_param_AVUSEB)

--SRO. #Req. 99183
select @w_precancela_dias = pa_int
from  cobis..cl_parametro
where pa_nemonico = 'DIPRE'
and   pa_producto = 'CCA'


select 
@w_sp_name         ='sp_pagos_corresponsal_gar_liquida',
@s_date            = isnull(@s_date,@w_fecha_pro),
@w_forma_pago      = @i_corresponsal, --OPEN_PAY,BANCO SANTANDER
@w_commit          = 'N',
@w_error_sp        = '0',
@w_bandera         = 0,
@w_moneda          = isnull(@i_moneda, 0),
@w_precancela_dias = isnull(@w_precancela_dias , 10)


-- PARAMETRO CODIGO CIUDAD FERIADOS NACIONALES
select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

if @@rowcount = 0 begin
   select @w_error = 101024
   goto ERROR_FIN
end


-- PARAMETRO SENSIBILIDAD PARA LIMITES EN DISTRIBUCION DE PAGOS 
select @w_sensibilidad = pa_float
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'SENSI'
and    pa_producto = 'CCA'

if @@rowcount = 0  select @w_sensibilidad = 0


exec @w_error   = sp_estados_cca
@o_est_vigente  = @w_est_vigente   OUT,
@o_est_vencido  = @w_est_vencido   OUT,
@o_est_cancelado= @w_est_cancelado  OUT

if @w_error <> 0
begin 
   SELECT
   @w_error = 701103,
   @w_msg = 'Error !:No exite estado vencido'
   goto ERROR_FIN
end

--- NUMERO DE DECIMALES 
exec @w_error = sp_decimales
@i_moneda      = @w_moneda ,
@o_decimales   = @w_num_dec out

if @w_error <> 0
begin 
   SELECT 
   @w_error = 701103,
   @w_descripcion = 'Error !:No existe parametro para numero de decimales'
   goto ERROR_FIN
end


--se borra operacion I


  
CREATE TABLE #prestamos_grupo(
operacion          int,
banco              cuenta,
oficina            SMALLINT, 
fecha_ult_proceso  datetime,
cliente            int
)

CREATE TABLE #op_mas_vencidos(
prestamo           int,
oficina            SMALLINT, 
banco              cuenta,
cliente            INT,
div                INT
)

CREATE TABLE #pagos_grupales(
banco          cuenta,
operacion      int,
oficina        smallint,
cliente        int, 
monto_exigible MONEY,
monto_pago     MONEY  
)


CREATE TABLE #garantia_liquidas(
gl_tramite int,
gl_grupo   int,
gl_cliente int,
gl_monto_garantia MONEY,
gl_pag_valor  MONEY,
gl_diferencia MONEY
)    

CREATE TABLE #ca_corresponsal_trn(
co_secuencial            INT ,
co_corresponsal          VARCHAR(16) NULL,
co_tipo                  CHAR(2) NULL,
co_codigo_interno        INT NULL,
co_fecha_valor           DATETIME NULL,
co_moneda                INT NULL,
co_monto                 MONEY NULL,
co_concil_est            CHAR(1) NULL,
co_concil_motivo         CHAR(2) NULL,
co_referencia            VARCHAR(64) NULL,
co_archivo_pag           varchar(64) null,
co_accion                char(1),
co_trn_id_corresp        varchar(10),
co_fecha_real            datetime
)

CREATE TABLE #ca_corresponsal_pr(
co_id                    int identity,
co_secuencial            INT ,
co_corresponsal          VARCHAR(16) NULL,
co_tipo                  CHAR(2) NULL,
co_codigo_interno        INT NULL,
co_fecha_valor           DATETIME NULL,
co_moneda                INT NULL,
co_monto                 MONEY NULL,
co_concil_est            CHAR(1) NULL,
co_concil_motivo         CHAR(2) NULL,
co_referencia            VARCHAR(64) NULL,
co_archivo_pag           varchar(64) null,
co_accion                char(1),
co_trn_id_corresp        varchar(10),
co_fecha_real            datetime
)

CREATE TABLE #seguro_cobro(
sc_tramite 			int,
sc_grupo   			int,
sc_cliente 			int,
sc_monto_seguro 	money,
sc_monto_pagado 	money,
sc_diferencia 		money
)  


create table #numero_div(
dividendo    int)

create table #saldo_dividendo(
di_dividendo int, 
saldo        money)
----------
--BATCH
---------- 
if @i_operacion = 'B' begin
   
    --Inserta en la tabla temporal todos los registros que deben procesarse (Estado I)
    INSERT INTO #ca_corresponsal_trn
    SELECT co_secuencial , co_corresponsal , co_tipo,  
    co_codigo_interno    , co_fecha_valor,   co_moneda,         --co_codigo_interno es la operacion
    co_monto             , co_concil_est,    co_concil_motivo,
    co_referencia        , co_archivo_ref,   co_accion,
    co_trn_id_corresp    , co_fecha_real
    FROM ca_corresponsal_trn
    where  co_estado  = 'I'
    and co_tipo in ('GL', 'GI')
    ORDER BY co_secuencial
    
    if @@error <> 0 begin
       select
       @w_msg   = 'ERROR AL INSERTAR REGISTROS EN #ca_corresponsal_trn',
       @w_error = 710001     
       goto ERROR_FIN 
    end
    
    --EVITAR PROCESAR LAS TRANSACCIONES MUY CERCANAS AL TIEMPO REAL
    --PORQUE PUDIERON SER OBJETOS DE UNA REVERSA.
    
    delete #ca_corresponsal_trn
    from #ca_corresponsal_trn a ,ca_corresponsal b
    where a.co_corresponsal = b.co_nombre
    and isnull(a.co_fecha_real,@w_fecha_pro) >  dateadd(mi, (isnull(b.co_tiempo_aplicacion_pag_rev,5) * -1),getdate()) 
   
end



if @i_operacion = 'C' begin -- para conciliacion manual
 

    INSERT INTO #ca_corresponsal_trn
    SELECT co_secuencial , co_corresponsal , co_tipo,  
    co_codigo_interno    , co_fecha_valor,   co_moneda,         --co_codigo_interno es la operacion
    co_monto             , co_concil_est,    co_concil_motivo,
    co_referencia        , co_archivo_ref,   co_accion,
    co_trn_id_corresp    , co_fecha_real
    FROM ca_corresponsal_trn
    where co_referencia = @i_referencia 
    and co_estado = 'I'
    and co_tipo in ('GL', 'GI')
    
    
    if @@error <> 0  begin
      select
      @w_msg   = 'ERROR AL INSERTAR REGISTROS EN #ca_corresponsal_trn',
      @w_error = 710001       
        
      goto ERROR_FIN
    end

  
end


--Insert desc reversos
insert into #ca_corresponsal_pr(
co_secuencial      , co_corresponsal, co_tipo         ,
co_codigo_interno  , co_fecha_valor , co_moneda       ,
co_monto , co_concil_est  , co_concil_motivo,
co_referencia      , co_archivo_pag , co_accion       ,
co_trn_id_corresp  ) 
select
co_secuencial     , co_corresponsal , co_tipo,  
co_codigo_interno , co_fecha_valor  , co_moneda, 
co_monto          , co_concil_est   , co_concil_motivo,
co_referencia     , co_archivo_pag  , co_accion,
co_trn_id_corresp
from #ca_corresponsal_trn
where co_accion = 'R' 
order by co_fecha_valor desc, co_secuencial desc, co_trn_id_corresp desc --DCU. Reverso de Pagos

--Insert asc pagos
insert into #ca_corresponsal_pr(
co_secuencial      , co_corresponsal, co_tipo         ,
co_codigo_interno  , co_fecha_valor , co_moneda       ,
co_monto           , co_concil_est  , co_concil_motivo,
co_referencia      , co_archivo_pag , co_accion       ,
co_trn_id_corresp  ) 
select 
co_secuencial     , co_corresponsal , co_tipo,  
co_codigo_interno , co_fecha_valor  , co_moneda, 
co_monto          , co_concil_est   , co_concil_motivo,
co_referencia     , co_archivo_pag  , co_accion,
co_trn_id_corresp
from #ca_corresponsal_trn
where co_accion <> 'R' 
order by co_fecha_valor asc


--EJECUTA LOS PAGOS REGISTRADOS EN LA TABLA #ca_corresponsal_trn
declare cursor_transacciones cursor for SELECT
co_secuencial     , co_corresponsal , co_tipo,  
co_codigo_interno , co_fecha_valor  , co_moneda, 
co_monto          , co_concil_est   , co_concil_motivo,
co_referencia     , co_archivo_pag  , co_accion,
co_trn_id_corresp
FROM #ca_corresponsal_pr
order by co_id
for read only

OPEN cursor_transacciones

fetch cursor_transacciones into 
@w_secuencial   , @w_forma_pago , @w_tipo,
@w_operacionca  , @w_fecha_valor, @w_moneda, 
@w_monto        , @w_concil_est,  @w_concil_motivo,
@w_referencia   , @w_archivo_pag, @w_accion,
@w_trn_id_corresp

while @@fetch_status = 0  begin

   select
   @w_msg = '',
   @w_est = 'P' 
      
   if @i_operacion = 'C' and @w_bandera = 0 begin  
       
      if (@w_concil_motivo = 'NR' and @w_tipo in ('PG','P')) select @w_tipo = 'RP'   --Reverso de Pago grupal 
      if (@w_concil_motivo = 'NR' and @w_tipo in ('PI','I')) select @w_tipo = 'RI'   --Reverso de Pago individual 
      if (@w_concil_motivo = 'NR' and @w_tipo in ('GL','G')) select @w_tipo = 'RG'   --Reverso de Pago de garantia  
      if (@w_concil_motivo = 'NR' and @w_tipo in ('GI','G')) select @w_tipo = 'RD'   --Reverso de Pago de garantia  individual--porCaso#185234
         
   end
   --reverso es siempre y cuando no este aplicado el pago
   if @w_accion = 'R' begin
      if @w_tipo = 'PG' select @w_tipo = 'RP'   --Reverso de Pago grupal 
      if @w_tipo = 'PI' select @w_tipo = 'RI'   --Reverso de Pago individual 
      if @w_tipo = 'GL' select @w_tipo = 'RG'   --Reverso de Pago de garantia  
      if @w_tipo = 'GI' select @w_tipo = 'RD'   --Reverso de Pago de garantia individual--porCaso#185234
		
      select 
      @w_secuencial_trn_rv = co_secuencial,
      @w_estado     = co_estado 
      from ca_corresponsal_trn 
      where co_trn_id_corresp = @w_trn_id_corresp 
      and co_estado = 'P' 
      and co_monto            = @w_monto
      
      if @@rowcount = 0 begin
         select
         @w_error = 701221, --710002, --> poner codigo error de existencia (no existe registro)
         @w_msg   = 'ERROR: NO EXISTE TRANSACCION A REVERSAR ID ' + @w_trn_id_corresp,
         @w_est   = 'E'
         
         GOTO ERROR_CURSOR
      end
      
   end
   --para determinar si tiene o no tanqueo
   select @w_id_corresponsal = co_id
   from cob_cartera..ca_corresponsal
   where co_nombre = @w_forma_pago
   print 'PAGOS @w_id_corresponsal '+convert(varchar(10),@w_id_corresponsal)
        
   /***************PAGO DE GARANTIAS*********/
   if (@w_tipo in ('GL' , 'GI'))--porCaso185234
   begin
      truncate table #garantia_liquidas 
	  truncate table #seguro_cobro
     
      select @w_tanquear = 'N'

      select 1 from ca_corresponsal_limites 
      where cl_corresponsal_id = @w_id_corresponsal
      and cl_tipo_tran         = @w_tipo
	  
      --SI EXISTE LAS ENTRADAS PARA EL CORRESPONSAL EN LA TABLA
      if @@rowcount <> 0 select @w_tanquear = 'S'

      select @w_tramite = 0, @w_id_inst_proc = 0, @w_continua_gl = 'S'

        if (@w_tipo = 'GL') begin
            select @w_tramite = io_campo_3,
                   @w_id_inst_proc = io_id_inst_proc,
		           @w_toperacion = io_campo_4
            from cob_workflow..wf_inst_proceso
            where io_campo_1 = @w_operacionca--Nro del grupo
            and   io_campo_7 = 'S'
            and   io_campo_4 in ('GRUPAL')
            and   io_estado = 'EJE'
	    end else begin
		--porCaso185234
            select @w_tramite = io_campo_3,
                   @w_id_inst_proc = io_id_inst_proc,
                   @w_toperacion = io_campo_4
            from cob_workflow..wf_inst_proceso
            where io_campo_1 = @w_operacionca
            and   io_campo_7 = 'P'
            and   io_campo_4 in ('INDIVIDUAL')
            and   io_estado = 'EJE'
		end
	  	  
		--Inicio Caso#177825
	    print 'Inicia_Tramite: ' + convert(varchar(25), @w_tramite) + '--->>>w_id_inst_proc: ' + convert (varchar(256), @w_id_inst_proc) + '--->>>@w_continua_gl: ' + convert(varchar(25), @w_continua_gl)
            		
		if (@w_param_AVUSEB is null)
		    select @w_param_AVUSEB = 'N'

        if (@w_param_AVUSEB = 'S') begin
		    select @w_codigo_cat_rol = null
			
			--porCaso185234
            select @w_codigo_cat_rol = C.valor from cobis..cl_tabla T, cobis..cl_catalogo C where T.tabla = 'cr_activ_desp_gar_liq' and T.codigo = C.tabla and C.codigo = @w_toperacion
		    
		    print 'Tramite: ' + convert(varchar(25), @w_tramite) + '--->>>w_id_inst_proc: ' + convert (varchar(256), @w_id_inst_proc) + '--->>>w_codigo_cat_rol: ' + convert (varchar(256), @w_codigo_cat_rol)
		    
       	    if ( @w_codigo_cat_rol is null )
       	    select @w_codigo_cat_rol = ro_id_rol from cob_workflow..wf_rol where ro_nombre_rol = 'VALIDACION BIOMETRICA'
		    
		    begin try
		        exec cob_workflow..SP_DISTRIBUIDOR_AGENCIA
                     @i_id_inst_proc     = @w_id_inst_proc,
                     @i_id_inst_act      = 0,
                     @i_id_empresa       = 1,
                     @i_id_proceso       = 0,
                     @i_version_proc     = 0,
                     @i_id_actividad     = 0,
                     @i_oficina_asig     = 0,
                     @i_id_rol_dest      = @w_codigo_cat_rol,
                     --@i_id_destinatario  int = null, -- su uso esta comentando en el sp
                  	 @o_ij_id_item_jerarquia = @w_ij_id_item_jerarquia out,
                     @o_id_destinatario  = @w_id_destinatario out
            end try
            begin catch
		        select @w_continua_gl = 'N'
            end catch 
		end
		
		print 'Tramite: ' + convert(varchar(25), @w_tramite) + '--->>>w_id_inst_proc: ' + convert (varchar(256), @w_id_inst_proc) + '--->>>@w_secuencial: ' + convert(varchar(256), @w_secuencial) + '--->>>@w_continua_gl?: ' + convert(varchar(256), @w_continua_gl)		
        if (@w_continua_gl = 'N')
        begin        
           select @w_error_etapa_mns = null, @w_error_etapa = null
		   select @w_error_etapa_mns = mensaje, @w_error_etapa = numero from cobis..cl_errores where numero = 2101033
		
           update ca_corresponsal_trn 
           SET co_estado       = 'I',
           co_error_msg        = @w_error_etapa_mns,
           co_error_id         = @w_error_etapa
           where co_secuencial = @w_secuencial
           
		   GOTO SIGUIENTE_TRN
        end
        --Fin Caso#177825
		
      select @w_promo =tr_promocion
      from cob_credito..cr_tramite
      where tr_tramite=@w_tramite
      
              --Cobro de Seguros 
        select @w_monto_seguro_basico = sum(case when isnull(se_monto,0) <> 0 and isnull(se_monto,0) > isnull(se_monto_pagado,0)then
                                    isnull(se_monto,0)- isnull(se_monto_pagado,0)
                                    else 0 end)
        from cob_cartera..ca_seguro_externo
        where se_tramite = @w_tramite
        
        SELECT @w_monto_seguro_basico=isnull(@w_monto_seguro_basico,0)
        
        --Garantia Liquida
        select @w_monto_gar_liquida  = isnull(sum(isnull(gl_monto_garantia,0) - isnull(gl_pag_valor,0)),0) 
        from cob_cartera..ca_garantia_liquida
        where gl_tramite    = @w_tramite
        and   gl_pag_estado = 'PC'
       -- and   isnull(gl_monto_garantia,0) > isnull(gl_pag_valor,0)  
       
       SELECT @w_monto_gar_liquida=isnull(@w_monto_gar_liquida,0)  
               
       select @w_saldo_exigible_gl=isnull(@w_monto_seguro_basico,0)
      
       select @w_saldo_exigible_gl=isnull(@w_saldo_exigible_gl,0)+isnull(@w_monto_gar_liquida,0)
	        
	  
      	if @w_saldo_exigible_gl = 0 
      begin
         select 
         @w_error = 2101019,
         @w_est = 'I',
         @w_msg = 'NO EXISTE VALORES POR COBRAR DE GAR LIQUIDA ' +  convert(varchar,@w_operacionca)
         goto ERROR_CURSOR
      end
    
      
      select @w_ente = @w_operacionca --nro grupo que va a la tabla de ca_santander_log_pagos en el campo cliente
	  select
      @w_oficina = tr_oficina,
      @w_usuario = tr_usuario,
      @w_ope     = tr_numero_op --MTA
      from cob_credito..cr_tramite 
      where tr_tramite = @w_tramite
      
      if @@rowcount = 0 begin
          select 
          @w_error = 70194,
          @w_est = 'E',
          @w_msg = 'NO EXISTE REGISTRO DEL TRAMITE GRUPAL.'
          
          goto ERROR_CURSOR
      end
      
      if @w_oficina = null begin
          select 
          @w_error = 70195,
          @w_msg = 'NO EXISTE OFICINA DEL TRAMITE INGRESADO PARA EL GRUPO: ' +  convert(varchar,@w_codigo_interno),
          @w_est = 'E'
          
          goto ERROR_CURSOR
      end
        
      if @w_usuario = null begin
        select 
          @w_error = 70196,
          @w_msg = 'NO EXISTE OFICIAL DEL TRAMITE INGRESADO PARA EL GRUPO: ' +  convert(varchar,@w_codigo_interno),
          @w_est = 'E'
          
          goto ERROR_CURSOR
      end
       
      insert into #garantia_liquidas
      select
      gl_tramite,         gl_grupo,       gl_cliente,
      gl_monto_garantia,  gl_pag_valor,   (gl_monto_garantia - ISNULL(gl_pag_valor,0))
      from cob_cartera..ca_garantia_liquida
      where gl_tramite        = @w_tramite
      and   gl_monto_garantia > ISNULL(gl_pag_valor,0)
      
      if @@error <> 0 begin
         select 
         @w_error = 2101011,
         @w_est = 'E',
         @w_msg = 'NO EXISTE PRESTAMOS ASOCIADOS A LA GAR LIQ OPERACION:  ' + convert(varchar,@w_tramite)
                      

         goto ERROR_CURSOR
      end 
	  
	  /***************COBRO DE SEGUROS*********/
	  print 'Entro seguros ' + convert(varchar, @w_tramite)
	  insert into #seguro_cobro
	  select 
	  se_tramite,	se_grupo,			se_cliente,
	  se_monto, 	se_monto_pagado,	(se_monto - isnull(se_monto_pagado,0))
	  from cob_cartera..ca_seguro_externo
	  where se_tramite = @w_tramite
	  and se_monto > isnull(se_monto_pagado,0)
		
	  if @@error <> 0 begin
         select 
         @w_error = 2101011,
         @w_est = 'E',
         @w_msg = 'NO EXISTE SEGURO, OPERACION:  ' + convert(varchar,@w_tramite)

         goto ERROR_CURSOR
      end 
	        
      --valor pendiente de pago de Garantia
      select @w_diferencia = isnull(sum(gl_diferencia),0)
      from   #garantia_liquidas
      where  gl_diferencia >0
	  
	  --valor pendiente de pago de Seguro
      select @w_diferencia_seguro = isnull(sum(sc_diferencia),0)
      from   #seguro_cobro
      where  sc_diferencia >0
	  
	  -- valor total pendiende de pago garantia + seguro
	  select @w_diferencia = isnull(@w_diferencia,0) + isnull(@w_diferencia_seguro,0)
      
      if @w_diferencia <> @w_monto begin
         if @w_tanquear = 'N' 
            select 
            @w_error = 210101,
            @w_msg = 'EL VALOR DE LA GARANTIA NO CORRESPONDE AL VALOR PAGADO, GAR: '   + convert(varchar, @w_diferencia)+' PAG: '+convert(varchar, @w_monto)+' TRAM: '+convert(varchar, @w_tramite),
            @w_est = 'E' 
         else begin
            select @w_est = 'I' --deja en estado I para procesar devolucion 
            print 'NO PROCESA PAGO DE GARANTIA , DEJA PENDIENTE PARA DEVOLUCION O REPROCESO' 
        end 
        goto ERROR_CURSOR
        
      end   
        
      if @@trancount = 0 begin  
         select @w_commit = 'S'
         begin tran
      end
           
      declare cursor_contabiliza_gar cursor for SELECT 
      gl_tramite,         gl_grupo,      gl_cliente,
      gl_monto_garantia , gl_pag_valor,  gl_diferencia
      FROM #garantia_liquidas
      where gl_diferencia > 0
      
      for read only
      
      OPEN cursor_contabiliza_gar
      
      fetch cursor_contabiliza_gar into @w_gl_tramite, @w_gl_grupo, @w_gl_cliente,@w_gl_monto_garantia,@w_gl_pag_valor , @w_gl_diferencia
      
      while @@fetch_status = 0  begin
       
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
           
         
            close cursor_contabiliza_gar
            deallocate cursor_contabiliza_gar
            
            goto ERROR_CURSOR                         
         
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
        
            
            close cursor_contabiliza_gar
            deallocate cursor_contabiliza_gar
            goto ERROR_CURSOR
         end 
         
         fetch cursor_contabiliza_gar INTO @w_gl_tramite, @w_gl_grupo, @w_gl_cliente,@w_gl_monto_garantia,@w_gl_pag_valor , @w_gl_diferencia
      
      end -- end while         
            
      close cursor_contabiliza_gar
      deallocate cursor_contabiliza_gar
	  
	   -- INICIO SEGURO
	  declare cursor_contabiliza_seguro cursor for select 
      sc_tramite,        sc_grupo,      	sc_cliente,
      sc_monto_seguro,	 sc_monto_pagado,  	sc_diferencia
      from #seguro_cobro
      where sc_diferencia > 0
      
      for read only
      
      open cursor_contabiliza_seguro
      
      fetch cursor_contabiliza_seguro into @w_sc_tramite, @w_sc_grupo, @w_sc_cliente, @w_sc_monto_seguro, @w_sc_monto_pagado, @w_sc_diferencia
      
      while @@fetch_status = 0  begin
         select @w_cad_tramite = convert(varchar(100), @w_sc_tramite)
		 print 'tramite: ' + convert(varchar(256), @w_cad_tramite) + '--Integrante: ' + convert(varchar(256), @w_sc_cliente)--caso#177825

         EXEC @w_error  = cob_cartera..sp_contabiliza_seguro
         @s_date           = @s_date ,
         @s_ofi            = @w_oficina,
         @s_user           = @s_user ,
         @s_term           = @s_term,     
         @i_operacion      = 'C',
         @i_monto          = @w_sc_diferencia,
         @i_en_linea       = 'N' ,   
         @i_ente           = @w_sc_cliente,
         @i_tramite        = @w_cad_tramite,
		 @i_forma_pago     = @w_forma_pago,
         @o_secuencial     = @w_secuencial_ing out
                
         if @w_error != 0 begin
           
            select             
            @w_est = 'E',
            @w_msg = 'ERROR AL EJECUTAR PROCESO DE CONTABILIZACION DEL SEGURO: ' + convert(varchar,@w_operacionca)
           
            close cursor_contabiliza_seguro
            deallocate cursor_contabiliza_seguro
            
            goto ERROR_CURSOR                         
         
         end 
         
         INSERT INTO ca_corresponsal_det(
         cd_operacion,	cd_banco,                       cd_sec_ing,        cd_referencia, cd_secuencial )
         VALUES (
         @w_sc_cliente, convert(varchar,@w_sc_tramite), @w_secuencial_ing, @w_referencia, @w_secuencial )
          
         
         if @@error != 0 begin
            select
            @w_error = 710001,      
            @w_est   = 'E',
            @w_msg   = 'ERROR AL CREAR DETALLE PAGO : ' + convert(varchar,@w_banco_int) + 'Secuencial ' + convert(varchar,@w_secuencial_ing)
        
            close cursor_contabiliza_seguro
            deallocate cursor_contabiliza_seguro
            goto ERROR_CURSOR
         end 
         
         fetch cursor_contabiliza_seguro into @w_sc_tramite, @w_sc_grupo, @w_sc_cliente, @w_sc_monto_seguro, @w_sc_monto_pagado, @w_sc_diferencia
      
      end -- end while         
            
      close cursor_contabiliza_seguro
      deallocate cursor_contabiliza_seguro
	  
	  -- FIN SEGURO
            
      --SACA EL TRAMITE DE LA ESTACION DE ESPERA      


        if exists (select 1 from cob_workflow..wf_inst_actividad,cob_workflow..wf_inst_proceso
             where ia_nombre_act like '%ESPERA AUTOMATICA GAR LIQUIDA'
             and ia_estado       = 'ACT'
             and ia_id_inst_proc = io_id_inst_proc
             and io_estado       = 'EJE'
             and io_campo_1      = @w_operacionca)
	    begin
            begin try--Caso#177825
                exec @w_error = sp_ruteo_actividad_wf  
                @s_ssn              =   @s_ssn, 
                @s_user            =    @w_usuario,
                @s_sesn            =    null,
                @s_term            =    @s_term,
                @s_date            =    @s_date,
                @s_srv             =    @s_srv,
                @s_lsrv            =    @s_lsrv,
                @s_ofi             =    @w_oficina,     
                @i_tramite         =    @w_tramite, 
                @i_param_etapa     =    'EAGARL',
                @i_actualiza_var   =    'S' -- Caso#158401
                   
                if @w_error != 0 begin
                   select           
                   @w_est = 'E',
                   @w_msg = 'ERROR AL EJECUTAR PROCESO RUTEO DE ACTIVIDAD AUTOMATICA: ' + convert(varchar,@w_operacionca)
                   goto ERROR_CURSOR 
                end
            end try--Caso#177825
	    	begin catch
	    		print 'ERROR AL EJECUTAR PROCESO RUTEO DE ACTIVIDAD AUTOMATICA - Tramite: ' + convert(varchar, @w_tramite)		
	    	end catch
	    	
         end else begin 
	        select 
	    	@w_est = 'P',
	    	@w_msg = 'ALERTA NO EXISTE TRAMITE A PROCESAR EN EL WORKFLOW ' + convert(varchar,@w_operacionca)
            
         end 
          
          if @w_commit = 'S' begin  
              select @w_commit = 'N'
              commit tran
          end
          
          goto MARCAR 
                      
   end -- FIN PAGOS GARANTIA LIQUIDA

   if (@w_tipo in ('RG', 'RD')) begin  --Reverso de Garantias Reverso de Garantias individuales

      if @@trancount = 0 begin  
         select @w_commit = 'S'
         begin tran
      end
     
      truncate TABLE #garantia_liquidas 
     
	  if (@w_tipo = 'RG') begin
          select @w_tramite    = max(tg_tramite)
          from  cob_credito..cr_tramite_grupal
          where tg_grupo   = @w_operacionca
		  
          if @@rowcount = 0 begin
             select 
		     @w_ente = @w_operacionca, --se envia el codigo del grupo
             @w_error = 2101011,
             @w_est = 'E',
             @w_msg = 'NO EXISTE TRAMITE INGRESADO PARA EL GRUPO: ' +  convert(varchar,@w_operacionca)
                          
             goto ERROR_CURSOR
          end      
      end else begin
      --porCaso185234
          select @w_tramite    = max(tr_tramite)
          from  cob_credito..cr_tramite
          where tr_cliente = @w_operacionca
		  and tr_toperacion = 'INDIVIDUAL'
		  
          if @@rowcount = 0 begin
             select 
		     @w_ente = @w_operacionca, --se envia el codigo del cliente
             @w_error = 2101011,
             @w_est = 'E',
             @w_msg = 'NO EXISTE TRAMITE INGRESADO PARA EL CLIENTE: ' +  convert(varchar,@w_operacionca)
                          
             goto ERROR_CURSOR
          end 	  
	  end
	  
       select
       @w_oficina = tr_oficina
       from cob_credito..cr_tramite 
       where tr_tramite = @w_tramite
        
      declare cursor_contabiliza_gar cursor for SELECT 
      cd_operacion,     convert(int,cd_banco),     cd_sec_ing
      FROM ca_corresponsal_det
      where cd_secuencial = @w_secuencial_trn_rv --@w_secuencial
      for read only

      OPEN cursor_contabiliza_gar
      
      fetch cursor_contabiliza_gar into @w_gl_cliente, @w_gl_tramite, @w_secuencial_ing
  
      while @@fetch_status = 0  begin
         
         SELECT @w_gl_diferencia = sum(dtr_monto)
         from ca_det_trn
         where dtr_operacion = -3  --codigo de las garantias
         and  dtr_secuencial = @w_secuencial_ing
            
         EXEC @w_error  = cob_custodia..sp_contabiliza_garantia
         @s_date           = @s_date,
         @s_ofi            = @w_oficina,
         @s_user           = @s_user,
         @s_term           = @s_term,     
         @i_operacion      = 'RC',
         @i_monto          = @w_diferencia,
         @i_en_linea       = 'N' ,   
         @i_ente           = @w_gl_cliente,
         @i_tramite        = @w_gl_tramite,
         @i_forma_pago     = @w_forma_pago
                
         if @w_error != 0 begin
           
            select             
            @w_est = 'E',
            @w_msg = 'ERROR AL EJECUTAR PROCESO DE CONTABILIZACION DE LA GARANTIA: ' + convert(varchar,@w_operacionca)
           
         
            close cursor_contabiliza_gar
            deallocate cursor_contabiliza_gar
            
            goto ERROR_CURSOR                         
         
         end 
         
        fetch cursor_contabiliza_gar INTO @w_gl_tramite, @w_gl_grupo, @w_gl_cliente,@w_gl_monto_garantia,@w_gl_pag_valor , @w_gl_diferencia
      
      end --while 
      
      close cursor_contabiliza_gar
      deallocate cursor_contabiliza_gar
      
      --Actualiza la transaccion reversada al estado a R 
      update ca_corresponsal_trn 
      set co_estado = 'R'
      where co_secuencial = @w_secuencial_trn_rv
      
      if @@error != 0 begin
         select 
         @w_error = 705032,
         @w_est   = 'E',
         @w_msg   = 'ERROR AL ACTUALIZAR LA TRANSACCION A REVERSAR : ' + convert(varchar,@w_secuencial_trn_rv)
         
         goto ERROR_CURSOR
      end
      
      if @w_commit = 'S' begin  
          select @w_commit = 'N'
          commit tran
      end  -- end cursor cursor_contabiliza_gar

      goto MARCAR 
   end
      
   MARCAR:
   
   if @i_operacion = 'C' and @w_bandera = 0 begin 
       
       SELECT 
       @w_concil_est   = 'S',
       @w_concil_user  = @s_user, 
       @w_concil_fecha = @s_date,
       @w_concil_obs   = @i_observacion
   
   end
   
   if @i_operacion = 'B' or @w_bandera = 1  begin 
       SELECT
       @w_concil_est   = NULL,
       @w_concil_user  = NULL,
       @w_concil_fecha = null,
       @w_concil_obs   = null
   end
   

   UPDATE ca_corresponsal_trn SET 
   co_estado           = @w_est,
   co_error_msg        = @w_msg ,
   co_error_id         = @w_error,
   co_concil_est       = isnull(@w_concil_est, co_concil_est),
   co_concil_user      = isnull(@w_concil_user, co_concil_user),
   co_concil_fecha     = isnull(@w_concil_fecha, co_concil_fecha),
   co_concil_obs       = isnull(@w_concil_obs, co_concil_obs)
   WHERE co_secuencial = @w_secuencial            
     
   if @@error != 0 begin
       select
       @w_error = 710002,
       @w_msg   = 'ERROR AL MARCAR COMO PROCESADO EL REGISTRO: ' + convert(varchar, @w_referencia)
       close cursor_transacciones
       deallocate cursor_transacciones
       
       GOTO ERROR_FIN
   end
   
   update ca_corresponsal_tanqueo 
   set   ct_estado         = @w_est
   where ct_secuencial_trn = @w_secuencial
   and   ct_estado         = 'I'

   if @@error != 0 begin
       select
       @w_error = 710002,
       @w_msg   = 'ERROR AL MARCAR COMO PROCESADO EL REGISTRO: ' + convert(varchar, @w_referencia)
       close cursor_transacciones
       deallocate cursor_transacciones
       
       GOTO ERROR_FIN
   end
   
   GOTO SIGUIENTE_TRN
   ERROR_CURSOR:
    
   
   if @w_commit = 'S' begin
      select @w_commit = 'N'  
	  
	  select @w_trancount = @@trancount
      print 'TRANCOUNT ERROR_CURSOR'+ convert(varchar,@w_trancount)
      if @w_trancount > 0 begin  
      rollback tran
   end
   end
   
   UPDATE ca_corresponsal_trn SET 
   co_estado           = @w_est,
   co_error_msg        = @w_msg ,
   co_error_id         = @w_error
   WHERE co_secuencial = @w_secuencial
   
   if @@error <> 0 begin
       select
       @w_error = 710002,
       @w_msg   = 'ERROR AL MARCAR COMO PROCESADO EL REGISTRO: ' + convert(varchar, @w_referencia)
       close cursor_transacciones
       deallocate cursor_transacciones
       
       GOTO ERROR_FIN
   end
   
   if @i_operacion = 'B' or @w_bandera = 1 
   begin 
      exec @w_secuencial = sp_gen_sec
      @i_operacion  = -5
      
      --Registro para Log pagos referenciados
      insert into ca_santander_log_pagos
      (sl_secuencial, sl_fecha_gen_orden, sl_banco, sl_cuenta,
       sl_monto_pag,  sl_referencia,      sl_archivo, 
       sl_tipo_error, sl_estado,          sl_mensaje_err, sl_ente)
      select 
      @w_secuencial  ,@w_fecha_pro   ,@w_ope,     @w_cuenta, 
      @w_monto       ,@w_referencia,  @w_archivo_pag, 
      'PR'           ,convert(varchar,@w_error) , @w_msg,@w_ente
      --Errores Cobis
    end 
    
    if @i_operacion = 'C' and @w_bandera = 0  begin
      
      close cursor_transacciones
      deallocate cursor_transacciones
      goto ERROR_FIN
    end 
   
      
   SIGUIENTE_TRN:
   fetch  cursor_transacciones into 
   @w_secuencial   , @w_forma_pago , @w_tipo  ,
   @w_operacionca  , @w_fecha_valor, @w_moneda, 
   @w_monto        , @w_concil_est,  @w_concil_motivo,
   @w_referencia   , @w_archivo_pag, @w_accion,
   @w_trn_id_corresp
   
end   
   
close cursor_transacciones
deallocate cursor_transacciones
   
if @i_externo = 'S' begin
   if @w_error in (0,1) begin
      select 
      @o_codigo_err   =  '00',
      @o_mensaje_err  =  'TRANSACCION EXITOSA'
	end
	else goto ERROR_FIN
end   
   
return 0   
      
      
ERROR_FIN: 

if @w_commit = 'S' begin
  select @w_commit = 'N'  
  select @w_trancount = @@trancount
  if @w_trancount > 0 begin  
  rollback tran
end      
end      

select @o_msg = @w_msg

if @w_error is null or @w_error = 0 select @w_error = 1

   --Se limpia parametros de salida
   select 
   @o_monto_recibido = '',
   @o_cuenta         = '',
   @o_codigo_pago    = '',
   @o_codigo_reversa = ''
   
if @i_en_linea = 'N' and (@i_operacion = 'B' or @w_bandera = 0 or @i_externo = 'S') begin 
      exec cob_cartera..sp_errorlog 
      @i_fecha       = @w_fecha_pro,
      @i_error       = @w_error,
      @i_usuario     = 'usrbatch',
      @i_tran        = 7999,
      @i_tran_name   = @w_sp_name,
      @i_cuenta      = '',
      @i_descripcion = @w_msg,
      @i_rollback    = 'N'
 
end else begin 
      exec cobis..sp_cerror 
      @t_from = @w_sp_name, 
      @i_num = @w_error, 
      @i_msg = @w_msg
end

if @i_externo = 'S' begin

   select   
   @o_codigo_err  = ce_error_codigo, --codigo del error esperado por el corresponsal
   @o_mensaje_err = ce_error_descripcion +' (ERROR:'+ convert(varchar,@w_error) + ')'
   from ca_corresponsal_err
   where ce_corresponsal_id = @w_id_corresponsal
   and ce_error_cobis = @w_error

   if @@rowcount = 0 begin
   
      --ERRORES GENERICOS DE PAGO/REVERSA
	  select @w_error_tmp = @w_error
      SELECT @w_error = CASE @i_accion when 'I' then 70000 when 'R' THEN 80000 end 
      
      select   
      @o_codigo_err  = ce_error_codigo, --codigo del error esperado por el corresponsal
      @o_mensaje_err = ce_error_descripcion + ' (ERROR:'+ convert(varchar,@w_error_tmp) + ')'
      from ca_corresponsal_err
      where ce_corresponsal_id = @w_id_corresponsal
      and ce_error_cobis       = @w_error
      
      if @@rowcount = 0 begin
      select 
      @o_codigo_err = @w_error,
         @o_mensaje_err  = @w_msg +' (ERROR:'+ convert(varchar,@w_error_tmp) + ')'
		 return @w_error
   end 

   end 
   
   return 0

end


return @w_error

GO