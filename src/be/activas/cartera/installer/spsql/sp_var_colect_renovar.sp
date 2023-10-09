/************************************************************************/
/*  archivo:                sp_var_colect_renovar.sp                    */
/*  stored procedure:       sp_var_colect_renovar                       */
/*  base de datos:          cob_cartera                                 */
/*  producto:               credito                                     */
/*  disenado por:           Inca Alexander                              */
/*  fecha de documentacion: septiembre 2019                             */
/************************************************************************/
/*          importante                                                  */
/*  este programa es parte de los paquetes bancarios propiedad de       */
/*  "macosa",representantes exclusivos para el ecuador de la            */
/*  at&t                                                                */
/*  su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  presidencia ejecutiva de macosa o su representante                  */
/************************************************************************/

use cob_cartera 
go

if exists(select 1 from sysobjects where name ='sp_var_colect_renovar')
	drop proc sp_var_colect_renovar
go

create proc sp_var_colect_renovar (
         @s_ssn            int         = null,
	     @s_ofi            smallint    = null,
	     @s_user           login       = null,
         @s_date           datetime    = null,
	     @s_srv            varchar(30) = null,
	     @s_term	       descripcion = null,
	     @s_rol            smallint    = null,
	     @s_lsrv	       varchar(30) = null,
	     @s_sesn	       int 	     = null,
	     @s_org            char(1)     = null,
         @s_org_err        int 	     = null,
         @s_error          int 	     = null,
         @s_sev            tinyint     = null,
         @s_msg            descripcion = null,
         @t_rty            char(1)     = null,
         @t_trn            int         = null,
         @t_debug          char(1)     = 'N',
         @t_file           varchar(14) = null,
         @t_from           varchar(30) = null,
         --variables       
         @i_id_inst_proc   int,    --codigo de instancia del proceso
		 @i_id_inst_act    int,    
	   	 @i_id_empresa     int, 
		 @o_id_resultado   smallint  out
)

AS

DECLARE @w_sp_name       	    varchar(32),
        @w_tramite       	    int,
        @w_return        	    INT,
        ---var variables	
        @w_ente                 int,
        @w_error_1              int,
        @w_ttramite             varchar(255),
        @w_banco                cuenta
        
		
print 'Inicio de Sp'

select @w_sp_name='sp_var_colect_renovar'

select @w_ente       = convert(int,io_campo_1),
	   @w_tramite    = convert(int,io_campo_3),
	   @w_ttramite   = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

print '@w_ente: ' + convert(varchar(max),@w_ente)
print '@w_tramite: ' + convert(varchar(max),@w_tramite)
print '@w_ttramite: ' + @w_ttramite

if @w_ttramite = 'REVOLVENTE'
begin
   
   select @w_banco = op_banco from cob_cartera..ca_operacion
   where op_tramite  = @w_tramite
   
   print '@w_banco: ' + convert(varchar(max),@w_banco)
   
   
   exec @w_error_1 = cob_cartera..sp_lcr_renovar
        @i_cliente = @w_ente,
        @i_banco   = @w_banco
    
   print '@w_error_1' + convert(varchar(max),@w_error_1)
   
   if @w_error_1 = 0
   begin
      select @o_id_resultado = 1
   end
end
else
begin
   select @o_id_resultado = 3
end

return 0
go
