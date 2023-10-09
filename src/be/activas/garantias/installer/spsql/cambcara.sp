/************************************************************************/
/*  Archivo:                   cambcara.sp                              */
/*  Stored procedure:          sp_cambio_caracter                       */
/*  Base de datos:             cob_custodia                             */
/*  Producto:                  Garantia                                 */
/*  Disenado por:              Milena Gonzalz                           */
/*  Fecha de escritura:        18/Marzo/2003                            */
/************************************************************************/
/*                       IMPORTANTE                                     */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                       PROPOSITO                                      */
/*  Este programa cambia  el caracter (abierto-cerrado) de garantias    */
/*  en estado vigente con obligacion y con estado vigente por cancelar  */
/************************************************************************/
/*                       MODIFICACIONES                                 */
/*  FECHA           AUTOR                 RAZON                         */
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_cambio_caracter')
   drop proc sp_cambio_caracter
go

create proc sp_cambio_caracter
 @s_user           login        = null,
 @s_term           varchar(64)  = null,
 @s_ofi            smallint     = null,
 @t_debug          char(1)  = 'N',
 @t_file           varchar(14) = null,
 @t_from           varchar(30) = null,
 @s_date           datetime     = null,
 @i_codigo_externo varchar (64),
 @i_fecha_tran     datetime     = null,
 @i_usuario        login        = null,
 @i_terminal       descripcion  = null,
 @i_oficina        smallint     = null,
 @i_caracter	   char(1) =null,
 @i_caracter_ant   char(1) =null,
 @i_operacion	   char(1) =null,
 @i_porcentaje	   float =null,
 @i_monto	   money =null,
 @i_tramite	   int =null



as

declare
   @w_error		 int,
   @w_sp_name             varchar(32),
   @w_return              int,
   @w_tramite             int, 
   @w_admisible           char(1),
   @w_admisible_ant       char(1),
   @w_secuencial          int,
   @w_secuenciald         int,
   @w_hora                varchar(8),
   @w_oficina_contabiliza smallint,
   @w_abierta_cerrada     char(1),
   @w_clase_custodia      char(1),
   @w_codvalor            int,
   @w_valor_actual        money,
   @w_estado              catalogo,
   @w_caracter_ant        char(1),
   @w_entra               char(1), --bandera para contabilizacion
   @w_valor_respaldo      money ,
   @w_clase_cartera       catalogo,
   @w_calificacion        char(1),
   @w_filial              smallint,
   @w_sucursal            smallint,
   @w_tipo                varchar(64),
   @w_custodia            int,
   @w_valor_resp          money,
   @w_valor_cobertura     money,
   @w_monto               money,
   @w_porcentaje          float


select 	@w_sp_name	= 'sp_cambio_caracter' 
select	@w_hora 	= convert(varchar(8),getdate(),108)

select   @w_oficina_contabiliza = cu_oficina_contabiliza,
         @w_clase_custodia      = cu_clase_custodia,
         @w_valor_actual        = isnull(cu_valor_inicial, isnull(cu_valor_refer_comis,0)),
         @w_estado              = cu_estado,
         @w_clase_custodia      = cu_clase_custodia
from 	cu_custodia
where 	cu_codigo_externo 	= @i_codigo_externo   


if @i_operacion = 'U' 
begin

   update cu_custodia
   set 	  cu_abierta_cerrada = @i_caracter
   where  cu_codigo_externo  = @i_codigo_externo

   if @i_caracter = 'A'
      update cob_credito..cr_gar_propuesta
      set    gp_porcentaje 		= null,
             gp_valor_resp_garantia	= null,
             gp_abierta 		= @i_caracter,
             gp_fecha_mod  		= getdate()
      where  gp_garantia 		= @i_codigo_externo

   if @i_caracter = 'C' 
   begin


      select	@i_monto = do_saldo_cap
      from	cob_credito..cr_dato_operacion,
      		cob_cartera..ca_operacion 
      where	do_tipo_reg 			= 'D'
      and	do_numero_operacion_banco 	= op_banco
      and	do_numero_operacion		= op_operacion
      and	op_tramite			= @i_tramite
      and	do_codigo_producto 		= 7

      if @i_monto is null
      begin
         select	@i_monto = case tr_moneda

		when 0 then tr_monto 

		else tr_montop

		end

         from	cob_credito..cr_tramite

         where	tr_tramite	= @i_tramite
      end

      update cob_credito..cr_gar_propuesta
      set    gp_porcentaje 		= @i_porcentaje,
             gp_valor_resp_garantia 	= (@i_monto * @i_porcentaje) /100,
     	     gp_abierta 		= @i_caracter,
             gp_fecha_mod  		= getdate()
      where  gp_garantia 		= @i_codigo_externo
      and    gp_tramite 		= @i_tramite

   end

end




if @i_operacion = 'S'
begin
   select	'TRAMITE' 	= tr_tramite,
		'GARANTIA' 	= gp_garantia,
		'PORCENTAJE' 	= gp_porcentaje,
		'RESPALDO' 	= gp_valor_resp_garantia,
	        'MONTO APR.'	= tr_monto,
		'SALDO CAP'	= (select do_saldo_cap
				   from   cob_credito..cr_dato_operacion,
					  cob_cartera..ca_operacion 
				   where  do_tipo_reg 			= 'D'
				   and    do_numero_operacion_banco 	= op_banco
                                   and    do_numero_operacion		= op_operacion
                                   and	  op_tramite			= cob_credito..cr_tramite.tr_tramite
				   and	  do_codigo_producto 		= 7)
   from		cob_credito..cr_tramite,
		cob_custodia..cu_custodia,
		cob_credito..cr_gar_propuesta
   where	tr_tipo		  in ('O','R','M') -- CCA 436 Agregado nuevo tipo de tramite Normalizacion
   and		tr_estado	  not in ('Z','X','R','S')
   and		cu_codigo_externo = @i_codigo_externo
   and		cu_codigo_externo = gp_garantia
   and		tr_tramite	  = gp_tramite
   order by    tr_tramite
end

if @i_operacion = 'Q'
begin
   select	VALOR_ACTUAL	  = cu_valor_actual
   from		cob_custodia..cu_custodia
   where	cu_codigo_externo = @i_codigo_externo

end


return 0
ERROR:
   if @w_error = 1 
	   begin   
      exec cobis..sp_cerror
      @t_from  	= @w_sp_name,
      @i_num   	= 1910001
   end
   else 
   begin
      exec cobis..sp_cerror
      @t_from  	= @w_sp_name,
      @i_num   	= @w_error
      return 1910001
   end   
                                                                                                                                                                   
go
