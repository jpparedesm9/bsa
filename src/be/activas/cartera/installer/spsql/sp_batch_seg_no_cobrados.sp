/************************************************************************/
/*   Archivo:              sp_batch_seg_no_cobrados.sp                   */
/*   Stored procedure:     sp_batch_seg_no_cobrados                      */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         SMO                                         */
/*   Fecha de escritura:   12/12/2017                                   */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/*   Genera un archivo plano para reportar los préstamos que de los que */
/*  no se ha podido cobrar el seguro                                    */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      12/12/2017     SMO             Emision Inicial                  */
/*      14/11/2019     PXSG            Cambios Req 124807               */
/*      20/04/2020     SRO             REQ 138247                       */
/*      07/05/2020     SRO             REQ 139251                       */
/************************************************************************/
USE cob_cartera

GO

IF OBJECT_ID ('sp_batch_seg_no_cobrados') IS NOT NULL
	DROP PROCEDURE sp_batch_seg_no_cobrados
GO

create proc sp_batch_seg_no_cobrados (
   @i_param1                      DATETIME      = null,
   @i_operacion                   char(1)       = null,
   @i_modo                        char(1)       = null,  -- modo en la que quiero que se llena la tabla temporal de clientes  
   @i_fecha_proceso               DATETIME      = null,
   @s_ssn                         int           = null,
   @s_user                        login         = null,
   @s_sesn                        int           = null,
   @s_term                        varchar(30)   = null,
   @s_date                        datetime      = null,
   @s_srv                         varchar(30)   = null,
   @s_lsrv                        varchar(30)   = null,
   @s_rol                         smallint      = null,
   @s_ofi                         smallint      = null,
   @s_org                         char(1)       = null,
   @t_debug                       char(1)       = 'N',
   @t_file                        varchar(14)   = null,
   @t_from                        varchar(32)   = null,
   @t_trn                         int           = null

)
as
DECLARE
@w_s_app                        varchar(40),
@w_cmd                          varchar(5000),
@w_destino_lineas               varchar(255),
@w_destino_cabecera             varchar(255),
@w_destino                      varchar(255),
@w_errores                      varchar(255),
@w_comando                      varchar(6000),
@w_columna                      varchar(50),
@w_col_id                       int,
@w_cabecera                     varchar(5000),
@w_error                        int, 
@w_path                         varchar(255),
@w_mensaje                      varchar(100),
@w_sp_name                      varchar(32), 
@w_operacion                    INT,
@w_ente                         INT,
@w_banco                        VARCHAR(36),
@w_monto_prima                  MONEY,
@w_id_oficina                   INT,
@w_sucursal                     VARCHAR(64),
@w_id_padre                     INT,
@w_region                       VARCHAR(64),
@w_id_ciudad                    INT,
@w_ciudad                       VARCHAR(64),
@w_id_grupo                     INT,
@w_nombre_grupo                 VARCHAR(64),
@w_nombre_cliente               VARCHAR(64),
@w_fecha_inicio                 DATETIME,
@w_fecha_inicio_str             VARCHAR(10),
@w_fecha_fin                    DATETIME,
@w_fecha_fin_str                VARCHAR(10),
@w_gen_arch_dom_seg             CHAR(1),
@w_fecha_proceso                datetime,
@w_fecha_inicial                DATETIME,
@w_fini_domi                    DATETIME, --'02/04/2019'
@w_est_vigente                  tinyint,
@w_est_novigente                tinyint,
@w_est_vencido                  tinyint,
@w_est_cancelado                tinyint,
@w_est_suspenso                 tinyint,
@w_est_castigado                tinyint,
@w_est_diferido                 tinyint,
@w_long_cobertura               int,
@w_dias_reporte_cons            int


-----------------------------------------
--Inicializacion de Variables
-----------------------------------------
select @w_sp_name  = 'sp_batch_seg_no_cobrados'

--select @w_fecha_proceso = '0/06/2019'
if @i_param1 is null
   select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
else 
   select @w_fecha_proceso = @i_param1
   
select 
@w_fecha_inicial    = dateadd(mm,-1,@w_fecha_proceso),
@w_long_cobertura   = 4

select @w_dias_reporte_cons   = isnull(pa_int,112)  from cobis..cl_parametro where pa_nemonico='DIRECO' and pa_producto='CCA'

select @w_fini_domi = pa_datetime
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'FDOMI'
and    pa_producto = 'CCA'

 /* ESTADOS DE CARTERA */
exec @w_error = cob_cartera..sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_novigente  = @w_est_novigente out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_suspenso   = @w_est_suspenso  out,
@o_est_diferido   = @w_est_diferido  OUT


SELECT @w_fini_domi = ISNULL (@w_fini_domi , '02/04/2019')
select @w_fini_domi = dateadd(dd,1,@w_fini_domi)

IF @w_fecha_inicial < @w_fini_domi
	SELECT @w_fecha_inicial =  @w_fini_domi


--PARAMETRO PARA INDICAR SI SE PAGA O NO EL SEGURO
select @w_gen_arch_dom_seg = pa_char
from   cobis..cl_parametro
 where pa_producto = 'CCA'
   and pa_nemonico = 'GADOSE'   
   
select @w_gen_arch_dom_seg = isnull(@w_gen_arch_dom_seg, 'N') 
 


select 
op_operacion                            as operacion,
se_cliente                              as cliente,
op_banco                                as banco,
se_monto                                as monto,
datediff(mm,op_fecha_ini, op_fecha_fin) as meses_expiracion
into #seguros_operaciones
from cob_cartera..ca_seguro_externo, cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion 
where se_cliente              = op_cliente
and   tg_operacion            = op_operacion
and   tg_tramite              = se_tramite
and  (  (se_monto=0 and se_monto_pagado=0)
     or (se_monto>0 and se_monto_pagado=0)
     )--(se_estado='N' and @w_gen_arch_dom_seg = 'S') -- Cambio por activación de seguros
and datediff(dd,op_fecha_liq, @w_fecha_proceso) = 0
and op_estado                                   = @w_est_vigente  



TRUNCATE TABLE cob_cartera..seguros_no_cobrados_tmp



SET @w_operacion=0


WHILE 1 = 1  -----> WHILE POR SEGURO
BEGIN
   --seguros no cobrados
   select TOP 1
   @w_operacion   = operacion,
   @w_ente        = cliente,
   @w_banco       = banco,
   @w_monto_prima = monto
   from #seguros_operaciones
   where operacion > @w_operacion
   order by operacion asc
            
   IF @@ROWCOUNT = 0 break   

   --oficina / regional / sucursal
   SELECT @w_id_oficina=op_oficina 
   FROM cob_cartera..ca_operacion 
   WHERE op_operacion = @w_operacion
   
   SELECT 
   @w_sucursal=of_nombre,
   @w_id_ciudad=of_ciudad,
   @w_id_padre=of_regional
   FROM cobis..cl_oficina 
   WHERE of_oficina = @w_id_oficina
   
   SELECT 
   @w_region=of_nombre
   FROM cobis..cl_oficina 
   WHERE of_oficina = @w_id_padre
   
   SELECT 
   @w_ciudad=ci_descripcion
   FROM cobis..cl_ciudad 
   WHERE ci_ciudad = @w_id_ciudad
   
   
   SELECT @w_id_grupo = cg_grupo
   FROM cobis..cl_cliente_grupo
   WHERE cg_ente=@w_ente
   
   SELECT @w_nombre_grupo = gr_nombre
   FROM cobis..cl_grupo
   WHERE gr_grupo=@w_id_grupo
   
   
   SELECT @w_nombre_cliente = isnull(en_nombre,'') +' '+isnull(p_s_nombre,'')+' '+isnull(p_p_apellido,'')+' '+isnull(p_s_apellido,'')
   FROM cobis..cl_ente
   WHERE en_ente=@w_ente
   
   
   SELECT @w_fecha_inicio = op_fecha_liq FROM cob_cartera..ca_operacion WHERE op_operacion=@w_operacion  
   SELECT @w_fecha_fin = dateadd(dd, @w_dias_reporte_cons ,@w_fecha_inicio)
   
   SET @w_fecha_inicio_str=REPLACE(CONVERT(VARCHAR(10), @w_fecha_inicio, 103),'/', '')
   SET @w_fecha_fin_str=REPLACE(CONVERT(VARCHAR(10), @w_fecha_fin, 103),'/', '')
   
   
   INSERT INTO seguros_no_cobrados_tmp(
   	w_ciudad,w_region,w_sucursal,w_id_grupo,w_nombre_grupo,w_id_prestamo,
   	w_nombre_cliente,w_fecha_inicio,w_fecha_fin,w_valor_seguro
   )
   VALUES(
      @w_ciudad,@w_region,@w_sucursal,@w_id_grupo,@w_nombre_grupo,@w_banco,
      @w_nombre_cliente,@w_fecha_inicio_str,@w_fecha_fin_str,@w_monto_prima
   )
           
END --end while por seguros
     
     
     
----------------------------------------
--	Generar Archivo Plano
----------------------------------------
select @w_s_app = pa_char
from cobis..cl_parametro	
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'


SELECT @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 7   
	
select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..seguros_no_cobrados_tmp out '

select 	@w_destino_lineas  = @w_path + 'SEGUROS_NO_COBRADOS_lineas' +  REPLACE(CONVERT(VARCHAR(10), getdate(), 103),'/', '')+ '.txt',
      	@w_destino_cabecera = @w_path + 'SEGUROS_NO_COBRADOS_cabecera'      + REPLACE(CONVERT(VARCHAR(10), getdate(), 103),'/', '')+ '.txt',
		@w_destino= @w_path + 'SEGUROS_NO_COBRADOS' +  REPLACE(CONVERT(VARCHAR(10), getdate(), 103),'/', '')+ '.txt',
        @w_errores  = @w_path + 'SEGUROS_NO_COBRADOS' +  REPLACE(CONVERT(VARCHAR(10), getdate(), 103),'/', '')+ '.err'

select @w_comando = @w_cmd + @w_destino_lineas+ ' -b5000 -c -T -e ' + @w_errores + ' -t"\t" ' + '-config ' + @w_s_app + 's_app.ini'


PRINT '@w_comando 1>> ' +@w_comando
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 724676,
   @w_mensaje = 'Error generando Archivo de lineas de Reporte de Seguros no Cobrados'
   goto ERROR
end

----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select @w_col_id   = 0,
       @w_columna  = '',
       @w_cabecera = ''
       
while 1 = 1 begin
   set rowcount 1
    select @w_columna = substring(c.name,3,20),
         @w_col_id  = c.colid
  	 from cob_cartera..sysobjects o, cob_cartera..syscolumns c
  	 where o.id    = c.id
  	 and   o.name  = 'seguros_no_cobrados_tmp'
  	 and   c.colid > @w_col_id
  	 order by c.colid
    
   if @@rowcount = 0 begin
      set rowcount 0
      break
   end

   select @w_cabecera = @w_cabecera + @w_columna + char(9)
end

--Escribir Cabecera
select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_destino_cabecera
PRINT '@w_comando2>> '+ convert(VARCHAR(300),@w_comando)

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 724677,
   @w_mensaje = 'Error generando Archivo de Cabeceras Seguros no Cobrados'
   goto ERROR
end

select @w_comando = 'copy ' + @w_destino_cabecera + ' + ' + @w_destino_lineas + ' ' + @w_destino
PRINT '@w_comando3>> '+ convert(VARCHAR(300),@w_comando)

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 724678,
   @w_mensaje = 'Error generando Archivo Completo de Seguros no Cobrados'
   goto ERROR
end
	     	      
return 0  
 
ERROR:
     exec cobis..sp_errorlog 
     @i_fecha        = @i_fecha_proceso,
     @i_error        = @w_error,
     @i_usuario      = @s_user ,
     @i_tran         = 26004,
     @i_descripcion  = @w_mensaje,
     @i_tran_name    =null,
     @i_rollback     ='S'
      return @w_error

go
           