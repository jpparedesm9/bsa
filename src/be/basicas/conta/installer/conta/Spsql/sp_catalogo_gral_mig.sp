/************************************************************************/
/*	Archivo: 		sp_catalogo_gral_mig.sp			*/
/*	Stored procedure: 	sp_catalogo_gral_mig			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Johanna Botero     	        	*/
/*	Fecha de escritura:    	Febrero 2002				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*									*/
/*				PROPOSITO				*/
/*	Ejecuta todos los sp's para la creacion del archivo		*/
/*	cbcatalogo.h							*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/************************************************************************/

use cob_conta
go

if exists(select 1 from sysobjects where name = "sp_catalogo_gral_mig")
   drop proc sp_catalogo_gral_mig
go

create proc sp_catalogo_gral_mig
as
declare 

@w_return 	tinyint,
@w_sp_name      varchar(32)


     exec @w_return= sp_empresa_mig
     if @w_return != 0
        return 1
     exec @w_return = sp_fecha_corte_mig
     if @w_return != 0
        return 2
     exec @w_return = sp_em_oficina_mig
     if @w_return != 0
        return 3
     exec @w_return = sp_em_area_mig
     if @w_return != 0
        return 4
     exec @w_return = sp_moneda_mig
     if @w_return != 0
        return 5
     exec @w_return = sp_cu_mov_mig
     if @w_return != 0
        return 6
     exec @w_return = sp_cu_proceso_mig
     if @w_return != 0
        return 7
     exec @w_return = sp_cu_especial_mig
     if @w_return != 0
        return 8
     exec @w_return = sp_cu_asociada_mig
     if @w_return != 0
        return 9
     exec @w_return = sp_banco_mig
     if @w_return != 0
        return 10
     exec @w_return = sp_tipo_terc_mig
     if @w_return != 0
        return 11
     exec @w_return = sp_concepto_ret_mig
     if @w_return != 0
        return 12
     exec @w_return = sp_operacion_ent_mig
     if @w_return != 0
        return 13
go    
