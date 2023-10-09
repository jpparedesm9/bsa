

/**************************************************************************/
/*   ARCHIVO:         sp_pasa_cartera_onboard.sp                          */
/*   NOMBRE LOGICO:   sp_pasa_cartera_onboard                             */
/*   PRODUCTO:        COBIS-ONBOARD APP                                   */
/**************************************************************************/
/*                            IMPORTANTE                                  */
/*   Esta aplicacion es parte de los  paquetes bancarios propiedad de     */
/*   MACOSA S.A.                                                          */
/*   Su uso no autorizado queda  expresamente  prohibido asi como         */
/*   cualquier alteracion o agregado hecho  por alguno de sus usuarios    */
/*   sin el debido consentimiento por escrito de MACOSA.                  */
/*   Este programa esta protegido por la ley de derechos de autor y por   */
/*   las convenciones  internacionales de propiedad intelectual.          */
/*   Su uso  no  autorizado dara derecho a MACOSA para obtener ordenes    */
/*   de secuestro o  retencion  y  para  perseguir  penalmente a  los     */
/*   autores de cualquier infraccion.                                     */
/**************************************************************************/
/*                            PROPOSITO                                   */
/*   Desembolso de la  OPERACION individual con una forma de desembolso   */ 
/*   definida  OnBoard para el proyecto de flujo Onboarding               */
/**************************************************************************/
/*                          MODIFICACIONES                                */
/*   FECHA       AUTOR                    RAZON                           */
/*  01/00/0000    DESC    Version Inicial                                 */
/*  16/08/2022    ACH     #191441 Validar fecha de proceso vs fecha de cre*/
/*  10/11/2022    KVI     R.196073-Tanqueo tabla gen.archivos             */
/**************************************************************************/

use cob_cartera 
go
if exists (select 1 from sysobjects where name = 'sp_onboard_pasa_cartera')
   drop proc sp_onboard_pasa_cartera
go

create proc sp_onboard_pasa_cartera
        (@s_ssn           int          = null,
	     @s_ofi           smallint     = null,
	     @s_user          login        = null,
         @s_date          datetime     = null,
	     @s_srv		      varchar(30)  = null,
	     @s_term	      descripcion  = null,
	     @s_rol		      smallint     = null,
	     @s_lsrv	      varchar(30)  = null,
	     @s_sesn	      int 	       = null,
         @i_tramite       int          ,  
         --variables
		 @i_id_inst_proc int            = null,    --codigo de instancia del proceso
		 @i_id_inst_act  int            = null,    
	   	 @i_id_empresa   int            = null
)as
declare
@w_error             INT,
@w_sp_name           VARCHAR(30),
@w_tramite           INT,
@w_forma_des         CHAR(10),
@w_commit            char(1),
@w_msg               varchar(255),
@w_fecha_proceso     datetime,
@w_fecha_dispersion  datetime,
@w_banco_real        cuenta,
@w_operacionca       int,
@w_product_type		 varchar(50), -- Req.196073
@w_canal             int          -- Req.196073


SELECT @w_sp_name = 'sp_onboard_pasa_cartera'

set rowcount 0

SELECT @w_tramite = convert(int,io_campo_3),
       @w_product_type = io_campo_4 -- Req.196073
FROM cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_tramite = isnull( @w_tramite, @i_tramite) 

--INICIALIZACION DE VARIABLES
select  @s_ssn  = isnull(@s_ssn,convert(int,rand()*10000))

select 
@s_user             = isnull(@s_user ,'onboarding'),
@s_ofi              = isnull(@s_ofi   ,9001),
@s_srv              = isnull(@s_srv  ,'CTSSRV'),
@s_term             = isnull(@s_term ,'onboarding-desembolso'),
@s_date             = isnull(@s_date  ,fp_fecha) 
from cobis..ba_fecha_proceso 


SELECT @w_forma_des = pa_char
FROM cobis..cl_parametro
WHERE pa_nemonico = 'NCRAHO'
AND pa_producto = 'CCA'

if @@trancount = 0 begin
   select @w_commit = 'S'
   begin tran
end
    
-- Caso#191441
select @w_fecha_proceso = @s_date
select @w_fecha_dispersion = op_fecha_liq from cob_cartera..ca_operacion where op_tramite = @w_tramite

if @w_fecha_dispersion < @w_fecha_proceso  
begin
    select @w_banco_real = op_banco,
           @w_operacionca = op_operacion
    from cob_cartera..ca_operacion
    where op_tramite = @w_tramite   
    
    update cob_cartera..ca_operacion
    set op_fecha_ini = @w_fecha_proceso,
        op_fecha_liq = @w_fecha_proceso,
	    op_cuota = 0
    where op_tramite = @w_tramite

    exec @w_error     = cob_cartera..sp_borrar_tmp
    @i_banco           = @w_banco_real
    
    if @w_error <> 0  goto ERROR
   
    --Se agrega para no modificar el sp_desembolso y el sp_paso_cartera, porque estos tienen como variable  @i_tabla_nueva en 'D'
    exec @w_error     = cob_cartera..sp_pasotmp
         @s_user            = @s_user,
         @s_term            = @s_term,
         @i_banco           = @w_banco_real,
         @i_operacionca     = 'S',
         @i_dividendo       = 'S',
         @i_amortizacion    = 'N',
         @i_cuota_adicional = 'S',
         @i_rubro_op        = 'S',
         @i_relacion_ptmo   = 'S',
         @i_nomina          = 'S',
         @i_acciones        = 'S',
         @i_valores         = 'S'

    if @w_error <> 0
    begin
         GOTO ERROR
    end

    exec @w_error = cob_cartera..sp_modificar_operacion_int
         @s_user              = @s_user,
         @s_sesn              = @s_sesn,
         @s_date              = @s_date,
         @s_ofi               = @s_ofi,
         @s_term              = @s_term,
         @i_calcular_tabla    = 'S',
         @i_tabla_nueva       = 'S',
         @i_salida            = 'N',
         @i_operacionca       = @w_operacionca,
         @i_banco             = @w_banco_real

    if @w_error <> 0
    begin
         GOTO ERROR
    end

    exec @w_error = cob_cartera..sp_pasodef
         @i_banco        = @w_banco_real,
         @i_operacionca  = 'S',
         @i_dividendo    = 'S',
         @i_amortizacion = 'S',
         @i_cuota_adicional = 'S',
         @i_rubro_op     = 'S',
         @i_relacion_ptmo = 'S',
         @i_nomina       = 'S',
         @i_acciones     = 'S',
         @i_valores      = 'S'

    if @w_error <> 0
    begin
         GOTO ERROR
    end

    exec @w_error = cob_cartera..sp_borrar_tmp
         @s_user       = @s_user,
         @s_sesn       = @s_sesn,
         @s_term       = @s_term,
         @i_desde_cre  = 'N',
         @i_banco      = @w_banco_real

    if @w_error <> 0
    begin
         GOTO ERROR
    end    
end

-- Ejecuta el desembolso de la operacion de CCA
EXEC @w_error = cob_cartera..sp_pasa_cartera 
     @s_ofi   = 9001,
     @s_user  ='onboarding',
     @s_date  = @s_date,
     @s_term  = @s_term,
     @s_ssn   = @s_ssn,
     @i_tramite = @w_tramite,
     @i_forma_desembolso = @w_forma_des
     
    IF @w_error <> 0 
       BEGIN 
        select  @w_error 
        select @w_error = 79990 , @w_msg  = 'ERROR: NO SE PUDO DESEMBOLSAR LA OPERACION'
        GOTO ERROR
    END
    

if not exists (select 1 from cob_credito..cr_cli_reporte_on_boarding where co_tramite = @w_tramite)
begin
	insert into cob_credito..cr_cli_reporte_on_boarding ( co_ente, 
	       co_buc,           co_banco,         co_tramite,      co_email,        co_est_zip,      
		   co_fecha_zip,     co_est_envio,     co_fecha_envio,  co_ruta_zip,     co_estd_clv_co,
		   co_fecha_reg)
    select top 1 
	       op_cliente, 
	       en_banco,         op_banco,         op_tramite,      di_descripcion,  'P',
           null,             null,             null,            null,             null,
		   getdate()
    from cob_cartera..ca_operacion, cobis..cl_ente, cobis..cl_direccion
    where op_tramite = @w_tramite
    and op_cliente = en_ente
    and di_ente = en_ente
    and di_tipo = 'CE'
	order by di_direccion desc

    if ((@@rowcount = 0 or @@error <> 0) and @w_commit = 'S') begin
       select @w_error = 70129 ,  @w_msg  = 'ERROR: NO SE PUDO DESEMBOLSAR LA OPERACION SECCION REPORTES 1'
	   GOTO ERROR
    end
	
	select @w_canal = ca_canal from cobis..cl_canal where ca_nombre = 'b2c_digital' -- Req.196073
	
    insert into cob_credito..cr_cli_reporte_on_boarding_det ( cod_ente,
	       cod_buc,              cod_banco,             cod_tramite,            cod_cod_documento, 
	       cod_est_gen,          cod_fecha_gen,         
		   cod_enviar_correo,    cod_ruta_gen, 
	       cod_est_des_alfresco,                                                cod_canal,       -- Req.196073
		   cod_id_inst_proc,     cod_grupo,             cod_carpeta,   	        cod_nombre_doc,  -- Req.196073
		   cod_codigo_tipo_doc,  cod_fecha_reg)												     -- Req.196073			    
    select co_ente,                                     
           co_buc,                                              co_banco,              co_tramite,             ra_cod_documento,
           case when ra_est_gen = 'S' then 'P' else null end,   null,
           case when ra_est_envio = 'S' then 'S' else 'N' end,  null,                            
	       case when ra_est_des_alfresco = 'S' then 'P' else null end,          ra_canal,        -- Req.196073
		   @i_id_inst_proc,      null,                  null,                   null,            -- Req.196073
		   null,                 getdate()                                                       -- Req.196073
    from cob_credito..cr_cli_reporte_on_boarding, cob_credito..cr_reporte_on_boarding
	where co_tramite = @w_tramite
	and ra_toperacion = @w_product_type -- Req.196073
	and ra_canal = @w_canal	            -- Req.196073

    if ((@@rowcount = 0 or @@error <> 0) and @w_commit = 'S') begin
	    select @w_error = 70129 ,  @w_msg  = 'ERROR: NO SE PUDO DESEMBOLSAR LA OPERACION SECCION REPORTES 2' 
        GOTO ERROR
    end
end 

--- hasta aca
if @w_commit = 'S' begin
    select @w_commit = 'N'
    commit tran
end

return 0
ERROR:
    if @w_commit = 'S' begin
       select @w_commit = 'N'
       rollback tran
    end
    
    select @w_msg = isnull ( @w_msg , 'ERROR: NO SE PUDO DESEMBOLSAR LA OPERACION') 
	
    exec cobis..sp_cerror @t_from = @w_sp_name, @i_num = @w_error ,@i_msg = @w_msg
    return @w_error



GO

