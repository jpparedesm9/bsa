/************************************************************************/
/*	Archivo: 		gmf_batch.sp                            */
/*	Stored procedure: 	sp_gmf_batch                            */
/*	Base de datos:  	cob_conta                               */
/*	Producto:               CONTABILIDAD                            */
/*	Disenado por:           Wladimir Ruiz G.                        */
/*	Fecha de escritura:     14/Abril/2004                           */
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de   */
/*	"MACOSA", representantes exclusivos para el Ecuador de          */
/*	"MACOSA".                                                       */
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/* Permite obtener Gravamen movimiento financiero                       */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	14-Abr-04	W. Ruiz 	Cetificado Gravamen     	*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_gmf_batch')
	drop proc sp_gmf_batch
go

create proc sp_gmf_batch (	
        @s_ssn                  int             = NULL,
        @s_user                 login           = NULL,
        @s_term                 varchar(30)     = NULL,
        @s_date                 datetime        = NULL,
        @s_sesn                 int             = NULL,
        @s_ssn_branch           int             = null, 
        @s_srv                  varchar(30)     = NULL,
        @s_lsrv                 varchar(30)     = NULL,
        @s_ofi                  smallint        = NULL,
        @s_rol                  smallint        = NULL,
        @t_debug                char(1)         = 'N',
        @t_file                 varchar(10)     = NULL,
        @t_from                 varchar(32)     = NULL,
        @t_trn                  smallint        = NULL,
        @i_fecha_ini            datetime        = NULL,
        @i_fecha_fin            datetime        = NULL       	        
)
as

/*DECLARACION DE VARIABLES TEMPORALES*/
declare @w_cuenta            cuenta_contable,
        @w_sp_name           varchar(32),                       
        @w_oficina           smallint,             
        @w_empresa           tinyint,
        @w_batch             int,
        @w_producto          tinyint     
        
/*ASIGNACION DE VARIABLES*/
select @w_sp_name         = 'sp_gmf_batch'      


if exists (select * from cb_gravamen_mf 
           where (gm_fecha_ini = @i_fecha_ini
           and    gm_fecha_fin = @i_fecha_fin ))
   begin        
   	exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
        	              @t_from=@w_sp_name, @i_num = 601185
   	return  1
   end

-------------------------------------------------------------
--CURSOR QUE PERMITE TRAER CUENTAS PARA BUSQUEDA DE GRAVAMEN
-------------------------------------------------------------
select @w_batch = ba_batch
from cobis..ba_batch
where ba_nombre = 'GRAVAMEN MOVIMIENTO FINANCIERO'
if @@rowcount = 0
begin
    exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
                          @t_from=@w_sp_name, @i_num = 601159
    return  1
end


declare cursor_producto cursor
for select pd_producto from cobis..cl_producto
    order by pd_producto

open  cursor_producto
fetch cursor_producto into @w_producto

WHILE @@fetch_status =0
begin
	
	if @@fetch_status = -1
	begin
		close cursor_producto
		deallocate cursor_producto
		raiserror (N'200001 - Fallo lectura del cursor', 16, 1)
		return 0
	end          	                 	
	
	                insert into cb_gravamen_mf                	                
	                select                               
			'EMPRESA'          = sa_empresa,                                                                
			'OFICINA'          = sa_oficina_dest,                                                                                                                                               
			'PRODUCTO'         = sa_producto,                                                                                                                                                                                                           
			'FECHA INICIAL'    = @i_fecha_ini,
			'FECHA FINAL'      = @i_fecha_fin,
			'CUENTA'           = sa_cuenta,
			'TOTAL CREDITO'    = sum (sa_credito),                 
			'TOTAL DEBITO'     = sum (sa_debito)                           
			from cob_conta_tercero..ct_sasiento, 
			cob_conta_tercero..ct_scomprobante
 
			where sc_fecha_tran between @i_fecha_ini  and @i_fecha_fin
			and   sc_producto = @w_producto
			and   sc_comprobante >= 1
			and   sc_empresa = 1
			and   sc_estado  = "P"
 
			and   sa_empresa = sc_empresa
			and   sa_producto = sc_producto 
			and   sa_fecha_tran = sc_fecha_tran
			and   sa_comprobante = sc_comprobante
			and   sa_asiento >= 1
			and   sa_cuenta   in (   select cp_cuenta from cb_cuenta_proceso 
					   where cp_empresa =   1
					   and cp_proceso   =   @w_batch
					   and cp_oficina   >=  0
					   and cp_area      >=  0
					   and cp_cuenta    >=  ''
				     )
			group by sa_empresa, sa_cuenta, sa_oficina_dest, sa_producto
			order by sa_cuenta		                     

                                               
fetch cursor_producto into @w_producto
end 

close cursor_producto
deallocate cursor_producto
	

return 0
go


