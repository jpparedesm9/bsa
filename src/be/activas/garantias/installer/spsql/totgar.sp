/************************************************************************/
/*	Archivo: 	        totgar.sp                               */ 
/*	Stored procedure:       sp_total_gar                            */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces			      	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Junio-1995  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Dado el cliente entrega los totales de garantias por tipo       */
/*	de garantia  en moneda nacional                                 */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		    RAZON			*/
/*	Oct/1995        L.Castellanos    Emision Inicial		*/
/*	Nov/1996   Ma.del Pilar Vizuete  Modificaciones                 */
/*      Dic/200    Jvelandia   modificacion de etiqueta valor actual    */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_total_gar')
    drop proc sp_total_gar
go
create proc sp_total_gar (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               varchar(64) = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_toperacion         varchar(4)  = null,
   @i_producto           catalogo  = null,
   @i_modo               smallint = null,
   @i_cliente            int = null, 
   @i_tipo_cust          varchar(64) = null,
   @i_codigo_externo     varchar(64) = null
)
as
declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_retorno            int,
   @w_ayer               datetime 


select @w_today 	= @s_date
select @w_sp_name 	= 'sp_total_gar',
       @w_ayer 		= convert(char(10),dateadd(dd,-1,@s_date),101)

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19704 and @i_operacion = 'S') or
   (@t_trn <> 19705 and @i_operacion = 'Z') 
     
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

if not exists (	select 	1 
		from 	cu_cotizacion_moneda
		where   fecha = @s_date)
begin
   insert into cu_cotizacion_moneda
   (
   moneda, 	cotizacion, 	fecha)               
   select
   cv_moneda, 	cv_valor, 	@s_date
   from cob_conta..cb_vcotizacion a 
   where cv_fecha =(	select 	max(cv_fecha)
                 	from 	cob_conta..cb_vcotizacion b 
                 	where 	a.cv_moneda = b.cv_moneda)
   and   cv_fecha <= @s_date
end

if @i_operacion = 'S'
begin
  set rowcount 20

  if @i_modo = 1  -- TOTALES POR TIPO DE GARANTIA
  begin
    if @i_tipo_cust is not null 
    begin
     select 	'TIPO' 			= substring(cu_tipo,1,25),
            	'DESCRIPCION' 		= (select substring(tc_descripcion,1,35) from cu_tipo_custodia where tc_tipo = cu_custodia.cu_tipo),
            	'TOTAL VALOR GARANTIA' 	= convert(money,sum(isnull(cu_valor_inicial, isnull(cu_valor_refer_comis,0))  
                                       	  * isnull(cotizacion,1)))
    from  cu_custodia,
	  cu_cliente_garantia,
          cu_cotizacion_moneda
    where cg_ente            = @i_cliente
      and cu_filial          = cg_filial
      and cu_sucursal        = cg_sucursal 
      and cu_tipo            = cg_tipo_cust
      and cu_custodia        = cg_custodia 
      and cu_codigo_externo  = cg_codigo_externo
      and cu_estado          in ("P","F","V","X")
      and cg_tipo_garante    in ("J","C")
      and moneda             = cu_moneda
      and fecha              = @s_date
      and cu_tipo            > @i_tipo_cust
    group by cu_tipo
    order by cu_tipo
    end
    else
    begin
     select 	'TIPO' 			= substring(cu_tipo,1,25),
            	'DESCRIPCION' 		= (select substring(tc_descripcion,1,35) from cu_tipo_custodia where tc_tipo = cu_custodia.cu_tipo),
            	'TOTAL VALOR GARANTIA' 	= convert(money,sum(isnull(cu_valor_inicial, isnull(cu_valor_refer_comis,0))  
                                       	  * isnull(cotizacion,1)))
    from  cu_custodia,
	  cu_cliente_garantia,
          cu_cotizacion_moneda
    where cg_ente            = @i_cliente
      and cu_filial          = cg_filial
      and cu_sucursal        = cg_sucursal 
      and cu_tipo            = cg_tipo_cust
      and cu_custodia        = cg_custodia 
      and cu_codigo_externo  = cg_codigo_externo
      and cu_estado          in ("P","F","V","X")
      and cg_tipo_garante    in ("J","C")
      and moneda             = cu_moneda
      and fecha              = @s_date
    group by cu_tipo
    order by cu_tipo
    end
   end
   else            -- CODIGO,DESCRIPCION Y MONTO DE UN TIPO DADO
    if @i_codigo_externo is not null 
    begin
       select 'CODIGO'       	= cu_codigo_externo,
              'DESCRIPCION'  	= substring(cu_descripcion,1,40),
              'ESTADO'       	= cu_estado,
              'VALOR GARANTIA' 	= convert(money,(isnull(cu_valor_inicial,isnull(cu_valor_refer_comis,0))
                                  * isnull(cotizacion,1))), --XTA 21/JUL/1999
	      'COMPARTIDA'   	= cu_compartida --NVR-BE
       from  cu_custodia,
	     cu_cliente_garantia,
             cu_cotizacion_moneda
       where cg_ente      = @i_cliente
         and cg_tipo_cust = @i_tipo_cust
         and cu_filial    = cg_filial
         and cu_sucursal  = cg_sucursal
         and cu_tipo      = cg_tipo_cust
         and cu_custodia  = cg_custodia
         and cu_codigo_externo  = cg_codigo_externo
         and cu_estado    in ("P","F","V","X")
         and moneda       = cu_moneda
         and cg_tipo_garante    in ("J","C")
         and fecha 	  = @s_date
         and cu_codigo_externo > @i_codigo_externo 
       order by cu_codigo_externo
    end
    else
    begin
       select 'CODIGO'       	= cu_codigo_externo,
              'DESCRIPCION'  	= substring(cu_descripcion,1,40),
              'ESTADO'       	= cu_estado,
              'VALOR GARANTIA' 	= convert(money,(isnull(cu_valor_inicial,isnull(cu_valor_refer_comis,0))
                                  * isnull(cotizacion,1))), --XTA 21/JUL/1999
	      'COMPARTIDA'   	= cu_compartida --NVR-BE
       from  cu_custodia,
	     cu_cliente_garantia,
             cu_cotizacion_moneda
       where cg_ente      = @i_cliente
         and cg_tipo_cust = @i_tipo_cust
         and cu_filial    = cg_filial
         and cu_sucursal  = cg_sucursal
         and cu_tipo      = cg_tipo_cust
         and cu_codigo_externo  = cg_codigo_externo
         and cu_custodia  = cg_custodia
         and cu_estado    in ("P","F","V","X")
         and moneda       = cu_moneda
         and cg_tipo_garante    in ("J","C")
         and fecha 	  = @s_date
       order by cu_codigo_externo
    end
end

if @i_operacion = 'Z'
begin
   if @i_modo = 0
         exec 	@w_retorno 	= cob_credito..sp_con_riesgo
         	@t_trn 		=  21839, 
         	@i_cliente   	= @i_cliente,
         	@i_modo 	= 0 
   else
         exec @w_retorno = cob_credito..sp_con_riesgo
         @t_trn 	 =  21839, 
         @i_cliente   	 = @i_cliente,
         @i_producto 	 = @i_producto,
         @i_toperacion 	 = @i_toperacion,
         @i_modo 	 = 1 

         if @w_retorno <> 0
         begin
         /*  Error en consulta de registro */
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 1909002
              return 1 
         end
end
go
