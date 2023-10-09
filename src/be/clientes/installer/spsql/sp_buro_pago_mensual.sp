/*************************************************************************/
/*   Archivo:            sp_buro_pago_mensual.sp                         */
/*   Stored procedure:   sp_buro_pago_mensual                            */
/*   Base de datos:      cobis                                           */
/*   Producto:           Clientes                                        */
/*   Disenado por:       Patricio Samueza                                */
/*   Fecha de escritura: 03/03/2022                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'MACOSA', representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBISCORP o su representante.              */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este programa ejecuta la regla de riesgo individual externo         */
/*************************************************************************/
/*                               OPERACIONES                             */
/*   OPER. OPCION                     DESCRIPCION                        */
/*     I                    Ejecuta pago mensual                         */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA        AUTOR                       RAZON                      */
/* 03/03/2022   Patricio Samueza              Version Inicial            */
/*************************************************************************/
use cobis
go

if object_id ('sp_buro_pago_mensual') is not null
   drop procedure sp_buro_pago_mensual
go

create proc sp_buro_pago_mensual (
       @s_ssn             int         = null,
       @s_user            login       = null,
       @s_term            varchar(32) = null,
       @s_date            datetime    = null,
       @s_sesn            int         = null,
       @s_culture         varchar(10) = null,
       @s_srv             varchar(30) = null,
       @s_lsrv            varchar(30) = null,
       @s_ofi             smallint    = null,
       @s_rol             smallint    = null,
       @s_org_err         char(1)     = null,
       @s_error           int         = null,
       @s_sev             tinyint     = null,
       @s_msg             descripcion = null,
       @s_org             char(1)     = null,
       @t_debug           char(1)     = 'N',
       @t_file            varchar(10) = null,
       @t_from            varchar(32) = null,
       @t_show_version    bit         = 0,
       @i_operacion       char(1)     = 'I',
       @i_ente            int         = null,
       @o_max_mop         int         = null  out,
       @o_pag_ctas_abi    MONEY       = null  out,    
       @o_porc_ctas_tot   float      = null  out
)
as

declare   
@w_sp_name            varchar(32),
@w_ts_name            varchar(32),
@w_num_error          int,
@w_nivel              char(1),
@w_semaforo           varchar(32),
@w_fecha_act          datetime,
@w_secuencial         INT,
@w_cuentas_fin1       INT,
@w_cuentas_fin2       INT,
@w_cuentas_fin        INT,
@w_cuentas_totales    INT,
@w_por_mensual        FLOAT,
@w_porcentaje          FLOAT

   
select @w_sp_name = 'sp_buro_pago_mensual'

SELECT @w_por_mensual = convert( FLOAT ,pa_int )
FROM cobis..cl_parametro
WHERE  pa_nemonico = 'PPAMCA'
AND    pa_producto = 'CLI'

--Si es null pongo 75
IF(@w_por_mensual IS null)
BEGIN
 SELECT @w_por_mensual= convert( FLOAT ,75)
END

SELECT @w_porcentaje = convert(float,(@w_por_mensual/100))

select TOP 10 
@w_fecha_act 	= ib_fecha,
@w_secuencial   = ib_secuencial
from cob_credito..cr_interface_buro 
where ib_cliente = @i_ente--459917 
and ib_estado    = 'V'


--cuentas abiertas
SELECT 
'cta_abierta'  = 1, 
'saldo_actual' = bc_saldo_actual,
'forma_pag_ori'= bc_forma_pago_actual,
'forma_pago'   = (CASE WHEN  ltrim(rtrim(bc_forma_pago_actual)) = 'UR' THEN 0
                            WHEN  ltrim(rtrim(bc_forma_pago_actual)) = '' THEN 0
                            ELSE  convert(INT,bc_forma_pago_actual)
                            END),
'monto_pagar'  = bc_monto_pagar,
'pago_mensual' = (CASE WHEN convert(MONEY,isnull(REPLACE(bc_saldo_actual,'+',''),0)) = convert(MONEY,isnull(bc_monto_pagar,0)) 
                       OR (convert(MONEY,isnull(bc_monto_pagar,0)) / ( CASE WHEN convert(MONEY,isnull(REPLACE(bc_saldo_actual,'+',''),0)) = 0 
                                                                            THEN 1 
                                                                            ELSE convert(MONEY,isnull(REPLACE(bc_saldo_actual,'+',''),0))
                                                                        end )) >= @w_porcentaje
                        THEN convert(MONEY,isnull(bc_monto_pagar,0))
                      when bc_frecuencia_pagos = 'B' THEN  convert(MONEY,isnull(bc_monto_pagar,0) / 2)
                      WHEN bc_frecuencia_pagos = 'D' THEN convert(MONEY,isnull(bc_monto_pagar,0) * 30)
                      WHEN bc_frecuencia_pagos = 'H' THEN convert(MONEY,isnull(bc_monto_pagar,0) / 6)
                      WHEN bc_frecuencia_pagos = 'K' THEN convert(MONEY,(isnull(bc_monto_pagar,0)) * (30/14))
                      WHEN bc_frecuencia_pagos IN ('M','P','V','Z') THEN convert(MONEY,isnull(bc_monto_pagar,0))
                      WHEN bc_frecuencia_pagos IN ('Q') THEN convert(MONEY,isnull(bc_monto_pagar,0) / 3) 
                      WHEN bc_frecuencia_pagos IN ('S') THEN convert(MONEY,isnull(bc_monto_pagar,0) * 3)
                      WHEN bc_frecuencia_pagos IN ('W') THEN convert(MONEY,isnull(bc_monto_pagar,0) * 4)
                      WHEN bc_frecuencia_pagos IN ('Y') THEN convert(MONEY,isnull(bc_monto_pagar,0) / 12)
                      ELSE bc_monto_pagar
                      end),
                
'frecuancia_pago'     = bc_frecuencia_pagos,
'bc_nombre_otorgante' = bc_nombre_otorgante
into #cr_buro_pago_mensual
FROM cob_credito..cr_buro_cuenta
WHERE bc_ib_secuencial= @w_secuencial--728460
AND bc_fecha_cierre_cuenta IS NULL


SELECT @o_max_mop      = isnull(max(forma_pago),0),
       @o_pag_ctas_abi = isnull(sum (pago_mensual),0)       
FROM #cr_buro_pago_mensual

--cunetas totales
SELECT @w_cuentas_totales = count(1)      
FROM #cr_buro_pago_mensual

--cuentas finacieras
SELECT @w_cuentas_fin1 = count(1)      
FROM #cr_buro_pago_mensual
WHERE  bc_nombre_otorgante IN ('CABLEVISION DF','COMERCIAL','COMUNICACIONES',
                               'SERVICIOS','SERVS. GRALES.','SKY TV','TELCELMETRO')
                                                         
                                 
SELECT @w_cuentas_fin2 = count(1)      
FROM #cr_buro_pago_mensual
WHERE  bc_nombre_otorgante like ('%TIENDA%')   
          

SELECT @w_cuentas_fin = isnull(@w_cuentas_totales,0) - ( isnull(@w_cuentas_fin1,0) + isnull(@w_cuentas_fin2,0))


IF(@w_cuentas_totales = 0)
BEGIN
 SELECT @w_cuentas_totales = 1
end
--encuentro el porcentaje 
SELECT @o_porc_ctas_tot =round((convert(FLOAT,@w_cuentas_fin)/convert(FLOAT,@w_cuentas_totales)),3)  
 

RETURN 0                             

errores:
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_num_error
   return @w_num_error
   

RETURN 0

go