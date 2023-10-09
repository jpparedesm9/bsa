/************************************************************************/
/*   Archivo:             ingabono.sp                                   */
/*   Stored procedure:    sp_ing_abono                                  */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Cartera                                       */
/*   Disenado por:        R. Garces                                     */
/*   Fecha de escritura:  Feb. 1995                                     */
/************************************************************************/
/*            IMPORTANTE                                                */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/*            PROPOSITO                                                 */
/*   Ingreso de abonos                                                  */ 
/*   S: Seleccion de negociacion de abonos automaticos                  */
/*   Q: Consulta de negociacion de abonos automaticos                   */
/*   I: Insercion de abonos                                             */
/*   U: Actualizacion de negociacion de abonos automaticos              */
/*   D: Eliminacion de negociacion de abonos automaticos                */
/************************************************************************/
/*            MODIFICACIONES                                            */
/************************************************************************/

use cob_cartera
go



if exists (select 1 from sysobjects where name = 'sp_ing_abono')
   drop proc sp_ing_abono
go

create proc sp_ing_abono
   @s_user               login = null,
   @s_term               varchar(30)  = null,
   @s_srv                varchar(30)  = null,  --LALG 21/09/2001
   @s_date               datetime     = null,
   @s_sesn               int          = null,
   @s_ssn                int          = null,
   @s_ofi                smallint     = null,
   @s_rol		 smallint     = null,  --Req 00212 25/05/2011	
   @i_accion             char(1),
   @i_banco              cuenta,
   @i_secuencial         int          = NULL,
   @i_tipo               char(3)      = NULL,
   @i_fecha_vig          datetime     = NULL,
   @i_ejecutar           char(1)      = 'N',
   @i_retencion          smallint     = NULL,
   @i_cuota_completa     char(1)      = NULL,   
   @i_anticipado         char(1)      = NULL,   
   @i_tipo_reduccion     char(1)      = NULL, 
   @i_proyectado         char(1)      = NULL,
   @i_tipo_aplicacion    char(1)      = NULL,
   @i_prioridades        varchar(255) = NULL,
   @i_en_linea           char(1)      = 'S',
   @i_tasa_prepago       float        =  0.0,
   @i_verifica_tasas     char(1)      = null,
   @i_dividendo          smallint     = 0,
   @i_calcula_devolucion char(1)      = NULL,
   @i_no_cheque          int          = NULL,     
   @i_cuenta             cuenta       = NULL,  
   @i_mon                smallint     = NULL,
   @i_cod_banco          catalogo     = NULL,
   @i_beneficiario       varchar(50)  = NULL,
   @i_inscripcion        int          = null, 
   @i_carga              int          = null, 
   @i_cancela            char(1)      = NULL,
   @i_renovacion         char(1)      = NULL,
   @i_solo_capital       char(1)      = 'N',
   @i_valor_multa        money        = 0,
   @o_secuencial_ing     int          = NULL out
as
declare 
   @w_sp_name      descripcion,
   @w_return      int,
   @w_error       int,
   @w_tipo        char(1),
   @w_operacionca int


select @w_sp_name = 'sp_ing_abono'


begin tran

--- LLAMADA AL SP INTERNO DE ABONO
exec @w_return = sp_ing_abono_int
@s_user                 = @s_user,
@s_term                 = @s_term,
@s_date                 = @s_date,
@s_sesn                 = @s_sesn,
@s_ssn                  = @s_ssn,
@s_srv                  = @s_srv,   
@s_ofi                  = @s_ofi,
@s_rol		        = @s_rol,
@i_accion               = @i_accion,
@i_banco                = @i_banco,
@i_secuencial           = @i_secuencial,
@i_tipo                 = @i_tipo,
@i_fecha_vig            = @i_fecha_vig,
@i_ejecutar             = @i_ejecutar,
@i_retencion            = @i_retencion,
@i_cuota_completa       = @i_cuota_completa,   
@i_anticipado           = @i_anticipado,   
@i_tipo_reduccion       = @i_tipo_reduccion, 
@i_proyectado           = @i_proyectado,
@i_tipo_aplicacion      = @i_tipo_aplicacion,
@i_prioridades          = @i_prioridades,
@i_en_linea             = @i_en_linea,
@i_tasa_prepago         = @i_tasa_prepago,
@i_verifica_tasas       = @i_verifica_tasas,
@i_dividendo            = @i_dividendo,
@i_calcula_devolucion   = @i_calcula_devolucion,
@i_no_cheque            = @i_no_cheque,   
@i_cuenta               = @i_cuenta,      
@i_mon                  = @i_mon,       
@i_beneficiario         = @i_beneficiario,
@i_cod_banco            = @i_cod_banco,
@i_cancela              = @i_cancela,
@i_renovacion           = @i_renovacion,
@i_solo_capital         = @i_solo_capital,
@i_valor_multa          = @i_valor_multa ,
@o_secuencial_ing       = @o_secuencial_ing out

if @w_return !=0 
begin
   --PRINT 'ingabono.sp Error saliendo de ingaboin.sp'
   select @w_error = @w_return
   goto ERROR
end 

select @w_tipo = op_tipo,
       @w_operacionca = op_operacion
from ca_operacion
where op_banco = @i_banco



commit tran


return 0

ERROR:
   exec cobis..sp_cerror
   @t_debug = 'N',    
   @t_file  = null,
   @t_from  = @w_sp_name,   
   @i_num   = @w_error

   return @w_error
go
