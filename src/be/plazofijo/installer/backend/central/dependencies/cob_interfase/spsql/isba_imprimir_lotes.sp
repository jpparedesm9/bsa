/************************************************************************/
/*  Archivo:              isba_imprimir_lotes.sp                        */
/*  Stored procedure:     sp_isba_imprimir_lotes                        */
/*  Base de datos:        cob_interfase                                 */
/*  Producto:             PFIJO                                         */
/*  Disenado por:         Byron Ron                                     */
/*  Fecha de escritura:   15-Jul-2009                                   */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                 PROPOSITO                                            */
/*  Sp interfase.                                                       */
/************************************************************************/ 
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR           RAZON                               */
/*  15-JUL-2009     B. RON          Emision Inicial                     */
/************************************************************************/
use cob_interfase
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_isba_imprimir_lotes') is not null
   drop procedure sp_isba_imprimir_lotes
go

create proc sp_isba_imprimir_lotes(   
@s_ssn               int             = NULL,
@s_user              varchar(30)     = NULL,      
@s_term              descripcion     = NULL,      
@s_date              datetime        = NULL,
@s_srv               varchar(30)     = NULL,            
@s_lsrv              varchar(30)     = NULL,   
@s_ofi               smallint        = NULL,
@s_sesn              int             = NULL,
@t_debug             char(1)         = NULL,
@t_trn               smallint        = NULL,
@i_oficina_origen    smallint        = NULL,
@i_ofi_destino       smallint        = NULL, 
@i_func_solicitante  smallint        = NULL,      
@i_producto          tinyint         = NULL,
@i_valor             money           = NULL,
@i_beneficiario      varchar(255)    = NULL,
@i_referencia        cuenta          = NULL,
@i_campo1            varchar(20)     = NULL,
@i_campo2            varchar(20)     = NULL,      
@i_campo3            varchar(20)     = NULL,
@i_campo4            varchar(20)     = NULL,     
@i_campo5            varchar(20)     = NULL,      
@i_campo6            varchar(20)     = NULL,       
@i_campo7            varchar(20)     = NULL,      
@i_campo8            varchar(20)     = NULL,   
@i_campo21           varchar(20)     = NULL,
@i_campo22           varchar(20)     = NULL,
@i_campo40           varchar(20)     = NULL,   
@i_observaciones     varchar(255)    = NULL,
@i_area_origen       smallint        = NULL,
@i_llamada_ext       estado          = NULL,
@i_concepto          tinyint         = NULL,
@i_fpago             varchar(20)     = NULL,
@i_moneda            tinyint         = NULL,
@i_origen_ing        char(1)         = NULL,
@i_idlote            int             = NULL,
@i_subtipo           int             = NULL,
@i_instrumento       smallint        = NULL,
@i_cod_ben           varchar(255)    = NULL,
@i_orig_ben          varchar(20)     = NULL,
@i_tipo_benef        char(1)         = NULL,
@i_fecha_solicitud   datetime        = NULL,
@i_estado            char(1)         = NULL,
@o_idlote            int             = NULL  out,
@o_secuencial        int             = NULL  out)
with encryption
as
declare 
@w_error             int

/** Esta validacion es para evitar que viajen datos con espacios en blanco    *****/
select @i_tipo_benef = isnull(nullif(ltrim(rtrim(@i_tipo_benef)), ''), 'PA') 

exec @w_error       = cob_sbancarios..sp_imprimir_lotes
@t_trn              = 29334,
@s_ssn              = @s_ssn,
@s_date             = @s_date,
@s_user             = @s_user,
@s_term             = @s_term,
@s_ofi              = @s_ofi,
@s_lsrv             = @s_lsrv,
@s_srv              = @s_srv,
@i_estado           = @i_estado,
@i_oficina_origen   = @i_oficina_origen,  
@i_ofi_destino      = @i_ofi_destino,     
@i_area_origen      = @i_area_origen,     
@i_fecha_solicitud  = @i_fecha_solicitud, 
@i_producto         = @i_producto,        
@i_instrumento      = @i_instrumento,     
@i_subtipo          = @i_subtipo,         
@i_valor            = @i_valor,           
@i_beneficiario     = @i_beneficiario,    
@i_referencia       = @i_referencia,      
@i_tipo_benef       = @i_tipo_benef,      
@i_campo1           = @i_campo1,          
@i_campo2           = @i_campo2,          
@i_campo3           = @i_campo3,          
@i_campo4           = @i_campo4,          
@i_campo5           = @i_campo5,          
@i_campo6           = @i_campo6,          
@i_campo7           = @i_campo7,          
@i_campo21          = @i_campo21,
@i_campo22          = @i_campo22,
@i_campo40          = @i_campo40,
@o_idlote           = @o_idlote     out,
@o_secuencial       = @o_secuencial out
      
if @w_error <> 0 
   return @w_error 

return 0

go
