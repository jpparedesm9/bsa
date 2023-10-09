/************************************************************************/
/*  Archivo:            validgar.sp             			*/
/*  Stored procedure:   sp_valid_estado_gar                             */
/*  Base de datos:      cob_custodia                  			*/	
/*  Producto:           Garantias                			*/
/*  Disenado por:  	Lilian Alvarez                                  */ 
/*  Fecha de escritura: 04/Ene/2007                 			*/
/************************************************************************/
/*              IMPORTANTE              				*/
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de 		*/
/*  AT&T GIS  .                      					*/
/*  Su uso no autorizado queda expresamente prohibido asi como  	*/
/*  cualquier alteracion o agregado hecho por alguno de sus     	*/
/*  usuarios sin el debido consentimiento por escrito de la     	*/
/*  Presidencia Ejecutiva de MACOSA o su representante.     		*/
/************************************************************************/
/*              PROPOSITO               				*/
/*  Este programa realiza  lo siguiente:                                */
/*      Permite validar si existe parametrizadas garantias en estado    */
/*      Futuros creditos                     			        */
/************************************************************************/
/*              	MODIFICACIONES              			*/
/*  FECHA       	AUTOR       		RAZON               	*/
/*  02-Ene-2007 	L.Alvarez        	Emision Inicial		*/
/************************************************************************/
use cob_custodia
go

if exists(select 1 from sysobjects where name = 'sp_valid_estado_gar')
   drop proc sp_valid_estado_gar
go
create proc sp_valid_estado_gar
   @i_filial   int
as
declare      
   @w_return             int,          
   @w_sp_name            varchar(32)

   select @w_sp_name = 'sp_valid_estado_gar'

   truncate table cu_error_futuros

   insert into cu_error_futuros
         (tc_oficina,				tc_tipo_bien,    	tc_op_clase,       	tc_moneda,
          tc_calificacion, 			tc_clase_custodia, 	tc_tipo,		tc_codvalor,     
	  tc_valor,				tc_codigo_externo)
   select cu_oficina_contabiliza,		tc_tipo_bien,    	'-',               	isnull(cu_moneda,0),
          '-',             			'-',               	cu_tipo,		cv_codval,
	  (isnull(cu_valor_inicial,0)),		cu_codigo_externo 
   from   cu_custodia,
          cu_tipo_custodia,
	  cu_codigo_valor,
	  cob_credito..cr_corresp_sib
   where  cu_tipo 	  	= tc_tipo
   and    tc_contabilizar 	= 'S'
   and    tc_tipo 	  	> ''
   and    cu_oficina	  	>= 0
   and    cu_codigo_externo	> ''
   and	  cu_moneda             >= 0
   and    cu_valor_inicial 	> 0
   and	  cv_tipo               = cu_tipo
   and	  cu_tipo               = codigo
   and    tabla 		= "T40"
   and	  cv_tipo               = tc_tipo
   and    cv_estado             = cu_estado 	
   and	  cu_estado		in ('F')
   and    tc_clase              = "I"



   insert into cu_error_futuros
         (tc_oficina,				tc_tipo_bien,    	tc_op_clase,       	tc_moneda,
          tc_calificacion, 			tc_clase_custodia, 	tc_tipo,		tc_codvalor,     
	  tc_valor,				tc_codigo_externo)
   select cu_oficina_contabiliza,		tc_tipo_bien,    	'-',               	isnull(cu_moneda,0),
          '-',             			'-',               	cu_tipo,		cv_codval,
	  (isnull(cu_valor_inicial,0)),		cu_codigo_externo 
   from   cu_custodia,
          cu_tipo_custodia,
	  cu_codigo_valor,
	  cob_credito..cr_corresp_sib
   where  cu_tipo 	  	= tc_tipo
   and    tc_contabilizar 	= 'S'
   and    tc_tipo 	  	> ''
   and    cu_oficina	  	>= 0
   and    cu_codigo_externo	> ''
   and	  cu_moneda             >= 0
   and    cu_valor_inicial 	> 0
   and	  cv_tipo               = cu_tipo
   and	  cv_tipo               = tc_tipo
   and    cv_estado             = cu_estado 	
   and	  cu_estado		in ('F')
   and	  cu_tipo               = codigo
   and    tabla 		= "T40"
   and    tc_clase              = "O"

return 0
go

