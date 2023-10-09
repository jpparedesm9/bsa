/************************************************************************/
/*	Archivo: 	        sp_prenhi.sp                            */
/*	Stored procedure:       sp_prenhi                               */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           jennifer Velandia            	      	*/
/*			                                         	*/
/*	Fecha de escritura:     Diciembre-2002  			*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa genera tabla  de maestro de garantias		*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_prenhi')
    drop proc sp_prenhi
go
create procedure sp_prenhi(
@s_ssn                int      = null,
@s_date               datetime = null,
@s_user               login    = null,
@s_term               varchar(64) = null,
@s_corr               char(1)  = null,
@s_ssn_corr           int      = null,
@s_ofi                smallint  = null,
@t_rty                char(1)  = null,
@t_trn                smallint = null,
@t_file               varchar(14) = null,
@i_fecha              datetime    = null
)
    
as
declare  
@w_today             datetime,     
@w_return            int,          
@w_sp_name           varchar(32)



select @w_today   = @s_date
select @w_sp_name = 'sp_prenhi'


truncate table cu_tmp_prenhi

insert into cu_tmp_prenhi
select 
cu_oficina,
cg_ente,		
convert(varchar(30), cg_nombre),
convert(varchar(10), cu_tipo),
convert(varchar(20), tc_descripcion),
cu_custodia,	
cu_codigo_externo ,
cu_valor_inicial,
convert(varchar(10),cu_fecha_ingreso,101),
convert(varchar(10),cu_fecha_vencimiento,101),
valor
from cu_custodia, cu_cliente_garantia,   cu_tipo_custodia,
cobis..cl_catalogo A, cobis..cl_tabla B
where 
cu_tipo = tc_tipo
and (tc_tipo_superior = '1100' or tc_tipo_superior = '5400' )
and cu_codigo_externo <> ''
and (cu_estado <> 'A' and cu_estado <> 'C')
and cu_oficina > 0
and cu_tipo <> ''
and cg_principal = 'D'
and cg_codigo_externo = cu_codigo_externo 
and cg_codigo_externo > ''
and B.codigo = A.tabla
and B.tabla = 'cu_est_custodia'
and cu_estado = A.codigo
if @@error <> 0 
   begin
    /* Error en insercion de registro */
     exec cobis..sp_cerror
     @t_from  = @w_sp_name,
     @i_num   = 1903001
     return 1 
   end	   

          
  


return 0
     


go