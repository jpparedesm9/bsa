

/****************************************************************************/
/*  Archivo:                sp_onboard_crear_operacion.sp					*/
/*  Stored procedure:       sp_onboard_crear_operacion						*/ 
/*  Base de datos:          cob_cartera                                     */
/*  Diseñado :               AGO                                            */
/*  Producto:               Cartera			                                */
/****************************************************************************/
/*              IMPORTANTE                                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de COBISCorp.                                                           */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como        */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus        */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de   derechos de autor          */
/*  y por las    convenciones  internacionales   de  propiedad inte-        */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para     */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir            */
/*  penalmente a los autores de cualquier   infraccion.                     */
/****************************************************************************/
/*                              PROPOSITO                                   */
/*  creacion  On-Board de prestamos de cartera                              */
/****************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_onboard_crear_operacion')
   drop proc sp_onboard_crear_operacion
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO
create proc sp_onboard_crear_operacion (
    @s_srv              varchar(30)    = null,
    @s_lsrv             varchar(30)    = null,             
    @s_ssn              int            = null,
    @s_rol              int            = null,
    @s_org              char(1)        = null,
    @s_user             login          = null,
    @s_term             varchar(30)    = null,
    @s_date             datetime       = null,
    @s_sesn             int            = null,
    @s_ofi              smallint       = 9001,
    ---------------------------------------
    @t_trn              int            = null,
    @t_debug            char(1)        = null,
    @t_file             varchar(30)    = null,
    @i_tipo             varchar(1)     = 'O',
    @i_anterior         cuenta         = null,
    @i_migrada          cuenta         = null,
    @i_tramite          int            = null,
    @i_cliente          int            = 0,
    @i_tasa             int            = 0 ,  
    @i_nombre           descripcion    = null,
    @i_codeudor         int            = 0,
    @i_sector           catalogo       = null,
    @i_toperacion       catalogo       = null,
    @i_oficina          smallint       = null,
    @i_moneda           tinyint        = null,
    @i_comentario       varchar(255)   = null,
    @i_oficial          smallint       = 56,
    @i_fecha_ini        datetime       = null,
    @i_monto            money          = null,
    @i_monto_aprobado   money          = null,
    @i_destino          catalogo       = '01',
    @i_lin_credito      cuenta         = null,
    @i_ciudad           int            = 1,
    @i_forma_pago       catalogo       = null,
    @i_cuenta           cuenta         = null,
    @i_formato_fecha    int            = 101,
    @i_no_banco         varchar(1)     = 'S',
    @i_clase_cartera    catalogo       = null,
    @i_origen_fondos    catalogo       = null,
    @i_fondos_propios   varchar(1)     = 'S',
    @i_ref_exterior     cuenta         = null,
    @i_sujeta_nego      varchar(1)     = 'N' ,
    @i_convierte_tasa   varchar(1)     = null,
    @i_tasa_equivalente varchar(1)     = null,
    @i_fec_embarque     datetime       = null,
    @i_reestructuracion varchar(1)     = null,
    @i_numero_reest     int            = null,
    @i_num_renovacion   int            = 0,
    @i_tipo_cambio      varchar(1)     = null,
    @i_grupal           char(1)        = null,
    @i_en_linea         varchar(1)     = 'S',
    @i_externo          varchar(1)     = 'N',
    @i_desde_web        varchar(1)     = 'N',
    @i_banca            catalogo       = null,
    @i_salida           varchar(1)     = 'N',
    @i_promocion        char(1)        = 'N', 
    @i_acepta_ren       char(1)        = null,
    @i_no_acepta        char(1000)     = null,
    @i_emprendimiento   char(1)        = null,
    @i_participa_ciclo  char(1)        = null,
    @i_garantia         float          = null,
    @i_ahorro           money          = null,
    @i_monto_max        money          = null,
    @i_bc_ln            char(10)       = null,
    @i_plazo            int            = null,
    @i_tplazo           catalogo       = null,
    @i_tdividendo       catalogo       = null,
    @i_periodo_cap      int            = null,
    @i_periodo_int      int            = null,
    @i_alianza          int            = null, 
    @i_ciudad_destino   int            = null, 
    @i_experiencia_cli  char(1)        = null, 
    @i_monto_max_tr     money          = null, 
    @i_automatica       char(1)        = 'N',  
    @i_naturaleza       varchar(10)    = NULL,
    ---------------------------------------
    @o_banco            cuenta         = null out,
    @o_operacion        int            = null out,
    @o_tramite          int            = null out,
    @o_oficina          int            = null out,
    @o_msg              varchar(100)   = null out,
    @o_ciclo            int            = 0    out,
    @o_fecha_creacion   varchar(10)    = null out,
    @o_fecha_ini        varchar(10)    = null out,
    @o_fecha_fin        varchar(10)    = null out
)
as

declare 
@w_fecha_proceso datetime ,
@w_cliente       int ,
@w_banco         cuenta,
@w_error         int,
@w_tramite       int,
@w_msg           varchar(255),
@w_sp_name       varchar(24) ,
@w_oficial_onboarding  int  

select @w_sp_name = 'sp_onboard_crear_operacion'
select @w_fecha_proceso  = fp_fecha from cobis..ba_fecha_proceso 




select @w_oficial_onboarding = oc_oficial
from cobis..cc_oficial, cobis..cl_funcionario where  oc_funcionario = fu_funcionario and fu_login ='onboarding'

if @@rowcount  = 0 begin
   select 
   @w_msg  = 'ERROR: NO ESTA CREADO EL OFICIAL ONBOARD' ,
   @w_error= 713220
   goto ERROR_PROCESO
end




--INICIALIZACION DE VARIABLES
select  @s_ssn  = isnull(@s_ssn,convert(int,rand()*10000))

select 
@s_user             = isnull(@s_user ,'onboarding'),
@s_ofi              = isnull(@s_ofi   ,9001),
@s_srv              = isnull(@s_srv  ,'CTSSRV'),
@s_lsrv             = isnull(@s_lsrv  ,'CTSSRV'),
@s_term             = isnull(@s_term ,'onboarding-desembolso'),
@s_date             = isnull(@s_date  ,fp_fecha) 
from cobis..ba_fecha_proceso 


select @w_fecha_proceso = isnull ( 	@i_fecha_ini ,@w_fecha_proceso)

exec   @w_error = cob_cartera..sp_crear_individual
@s_srv              = @s_srv,
@s_lsrv             = @s_lsrv,             
@s_ssn              = @s_ssn,
@s_user             = 'onboarding',
@s_term             = @s_term,
@s_date             = @w_fecha_proceso,
@s_sesn             = @s_ssn,
@s_ofi              = 9103,
@i_tipo             = 'O',
@i_cliente          = @i_cliente ,
@i_toperacion       = 'INDIVIDUAL',
@i_oficina          = 9103,
@i_moneda           = 0,
@i_oficial          = @w_oficial_onboarding,
@i_destino          = '01',
@i_ciudad           = @i_ciudad,
@i_fecha_ini        = @w_fecha_proceso,
@i_monto            = @i_monto ,
@i_plazo            = @i_plazo ,
@i_tplazo           = @i_tplazo ,
--@i_tasa             = @i_tasa,
@i_monto_aprobado   = @i_monto_aprobado ,
@i_onboarding        = 'S',
@i_en_linea         = 'N',
@i_externo          = 'S',
@i_desde_web        = 'S',
---------------------------------------
@o_banco            = @w_banco   out,
@o_tramite          = @w_tramite out



select 
@o_banco      = @w_banco,
@o_tramite    = @w_tramite

select
@o_fecha_ini = convert(varchar,op_fecha_ini,103),
@o_fecha_fin = convert(varchar,op_fecha_fin,103) 
from cob_cartera..ca_operacion
where op_tramite = @w_tramite


select @w_error
if @w_error   <> 0 begin
   select 
   @w_msg  = 'ERROR: ERROR EN CREACION DEL PRESTAMO' ,
   @w_error= 713220
   goto ERROR_PROCESO
end



return 0


ERROR_PROCESO:


if @i_en_linea = 'S' begin 
   exec cobis..sp_cerror
   @t_debug = 'N',
   @t_from  = @w_sp_name,
   @i_num   = @w_error,
   @i_msg   = @w_msg

end else begin 

   exec sp_errorlog 
   @i_fecha       = @s_date,
   @i_error       = @w_error,
   @i_usuario     = @s_user,
   @i_tran        = 7999,
   @i_tran_name   = @w_sp_name,
   @i_cuenta      = @w_banco,
   @i_rollback    = 'N',
   @i_descripcion = @w_msg
end   


return @w_error


GO
