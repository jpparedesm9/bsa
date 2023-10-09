/************************************************************************/
/*  Archivo:                sp_consultar_buro_ln_nf.sp                  */
/*  Stored procedure:       sp_consultar_buro_ln_nf                     */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           SRO                                         */
/*  Fecha de Documentacion: 28/Ago/2017                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Procedure tipo Variable, retorna la periodicidad del prestamo        */
/*                                                                      */
/************************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_consultar_buro_ln_nf')
	drop proc sp_consultar_buro_ln_nf
go

create proc [dbo].[sp_consultar_buro_ln_nf](
   @s_ssn          int         = null,
   @s_ofi          smallint    = null,
   @s_user         login       = null,
   @s_date         datetime    = null,
   @s_srv          varchar(30) = null,
   @s_term	       descripcion = null,
   @s_rol          smallint    = null,
   @s_lsrv	       varchar(30) = null,
   @s_sesn	       int 	       = null,
   @s_org          char(1)     = null,
   @s_org_err      int 	       = null,
   @s_error        int 	       = null,
   @s_sev          tinyint     = null,
   @s_msg          descripcion = null,
   @t_rty          char(1)     = null,
   @t_trn          int         = null,
   @t_debug        char(1)     = 'N',
   @t_file         varchar(14) = null,
   @t_from         varchar(30) = null,
   --variables
   @i_id_inst_proc  int,    --codigo de instancia del proceso
   @i_id_inst_act   int,    
   @i_id_empresa    int, 
   @o_id_resultado  smallint  out
)as

declare 
@w_sp_name       	       varchar(32),
@w_ente                    int,
@w_valor_ant               varchar(255),
@w_valor_nuevo             varchar(255),
@w_error                   int,
@w_msg                     varchar(255),
@w_resultado_ln            int,
@w_resultado_nf            int    



select @w_ente        = io_campo_3
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

if @@rowcount = 0 and @w_ente is null begin
   select @w_error = 2108060
   goto ERROR 
end
select @o_id_resultado = 1


exec @w_error   = sp_li_negra_cliente
@i_ente         = @w_ente,
@o_resultado    = @w_resultado_ln output

if @w_error <> 0 begin
   goto ERROR
end   

exec @w_error   = sp_negative_file
@i_ente         = @w_ente,
@o_resultado    = @w_resultado_nf output   

if @w_error <> 0 begin
   goto ERROR
end

if @w_resultado_ln <> 1 or @w_resultado_nf <> 1 begin
   select @o_id_resultado  = 3
end


return 0


ERROR:
exec cobis..sp_cerror
@t_debug = 'N',
@t_from  = @w_sp_name,
@i_num   = @w_error,
@i_msg   = @w_msg

return @w_error

go

