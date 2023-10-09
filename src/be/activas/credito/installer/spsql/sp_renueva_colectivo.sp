/************************************************************************/
/*  Archivo:                sp_renueva_colectivo.sp                     */
/*  Stored procedure:       sp_renueva_colectivo                        */
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
/* Procedure tipo Variable, retorna si la LCR para el colectivo es      */
/* renovación o no                                                      */
/*                                                                      */
/************************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_renueva_colectivo')
	drop proc sp_renueva_colectivo
go

create proc [dbo].[sp_renueva_colectivo](
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
)
as
declare 
@w_sp_name       	       varchar(32),
@w_ente                    int        

select @o_id_resultado = rs_codigo_resultado
from cob_workflow..wf_resultado
where rs_nombre_resultado = 'SI'

select @w_ente         = io_campo_1
from cob_workflow..wf_inst_proceso
where io_id_inst_proc  = @i_id_inst_proc

if @@rowcount = 0 and @w_ente is null begin
   return 2108070 
end

if not exists (select 1
               from cob_cartera..ca_operacion, cobis..cl_ente_aux
               where op_cliente    = ea_ente
               and   op_cliente    = @w_ente
               and   op_toperacion = 'REVOLVENTE'
               and   ea_colectivo  is not null) begin
   select @o_id_resultado = rs_codigo_resultado
   from cob_workflow..wf_resultado
   where rs_nombre_resultado = 'NO'    
end  


return 0
go