/************************************************************************/
/*	Archivo: 	        garclien.sp                             */ 
/*	Stored procedure:       sp_crgarcli                             */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                   	*/
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
/*				PROPOSITO				*/
/*	Dado el cliente entrega los totales de garantias por tipo       */
/*	de garantia  en moneda nacional                                 */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995		     Emision Inicial			*/
/************************************************************************/
use cob_custodia
go

set ansi_nulls off
go

if exists (select 1 from sysobjects where name = 'sp_crgarcli')
    drop proc sp_crgarcli
go
create proc sp_crgarcli  (
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
   @i_modo               smallint = null,
   @i_cliente            int = null, 
   @i_tipo               tinyint = null,
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
   @w_estado             char(1),
   @w_fecha	             datetime ,
   @w_pid_buscus	     int


select @w_today = @s_date
select @w_sp_name = 'sp_crgarcli'
select @w_pid_buscus = @@spid * 100 

delete from cu_tmp_cotizacion_monedagar
where  sesion =@w_pid_buscus

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19334 and @i_operacion = 'S') 
     

begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

if @i_operacion = 'S'
begin

/*  PGA 4Mar2001
/* INICIO CAMBIO XTA: 23/OCT/99  */
/* CREACION TABLA TEMPORAL DE COTIZACION */

/*create table #cotizacion_moneda
       (moneda tinyint,
        cotizacion float null)*/

select @w_fecha = dateadd(dd,-1,@s_date)

exec @w_return = cob_cartera..sp_conversion_moneda_factor
     @s_date    = @w_fecha,
     @i_opcion  = 'C'

if @w_return <> 0
  begin
      /* NO HAY COTIZACION */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 2101091
      return 1
   end

  PGA 4Mar2001 */

   if @i_tipo = 1 or @i_tipo = 2 -- VIGENTES O PROPUESTAS
   begin
      if @i_tipo = 1 -- VIGENTES 
         select @w_estado = 'V'
      else
         select @w_estado = 'P'

      select 'TIPO'       = cu_tipo,
             'NUMERO'     = cu_custodia,
             'DESCRIPCION'= cu_descripcion, 
             'VALOR MN'   = cu_valor_actual* isnull(a.cv_valor,1), 
             'OTRAS OPER' = sum(isnull(gp_monto_exceso,0) + (tr_monto * isnull(b.cv_valor,1)) * isnull(gp_monto_exceso-gp_monto_exceso,1)),
             'MONEDA'     = cu_moneda,
             'VALOR ME'   = cu_valor_actual*(1-isnull(a.cv_valor-a.cv_valor,1))
      from cu_cliente_garantia,
           cob_credito..cr_deudores,
           cob_credito..cr_gar_propuesta c
        left join cu_custodia d  
        on  c.gp_garantia     = d.cu_codigo_externo 
           inner join cob_conta..cb_vcotizacion a
           on a.cv_moneda       = d.cu_moneda
             left join cob_credito..cr_tramite
             on c.gp_tramite         = tr_tramite
               inner join cob_conta..cb_vcotizacion b
               on b.cv_moneda        = tr_moneda 
      where cg_ente            = @i_cliente
        and cu_garante         is null   --  Excluye garantes personales
        and de_rol             = 'C'    --  Codeudor 
        and cu_filial          = cg_filial
        and cu_sucursal        = cg_sucursal 
        and cu_tipo            = cg_tipo_cust
        and cu_custodia        = cg_custodia 
        and de_tramite         = tr_tramite
        and (cu_codigo_externo > @i_codigo_externo or @i_codigo_externo is null)
        and a.cv_fecha = (select max(c.cv_fecha)
                             from  cob_conta..cb_vcotizacion c
                            where a.cv_moneda = c.cv_moneda
                              and c.cv_fecha <= @s_date)
     group by d.cu_tipo,d.cu_moneda,a.cv_valor, 
	          d.cu_custodia,
	          d.cu_descripcion,
              d.cu_valor_actual,
	          cg_ente,
	          d.cu_estado,
		      de_rol, d.cu_filial,
		      d.cu_sucursal, de_tramite,
		      gp_tramite,b.cv_moneda,
		      a.cv_fecha
     order by d.cu_tipo,d.cu_moneda,a.cv_valor

     if @@rowcount = 0 
        select @w_error = 19010003
     else
        select @w_error = 19010004
    end

     if @i_tipo = 3 --(E)xcepcionadas
     begin
         select @w_estado = 'E'

         select 'TIPO'= cu_tipo,'NUMERO' = cu_custodia,
             'DESCRIPCION'= cu_descripcion, 
             'VALOR MN' =  cu_valor_actual * isnull(a.cv_valor,1),
             'OTRAS OPER' = sum(isnull(gp_monto_exceso,0) + (tr_monto * isnull(b.cv_valor,1)) * isnull(gp_monto_exceso-gp_monto_exceso,1)),
             'MONEDA' = cu_moneda,
             'VALOR ME' = cu_valor_actual*(1-isnull(a.cv_valor-a.cv_valor,1))
       
           
      from cu_cliente_garantia,cob_credito..cr_excepciones,
           cob_credito..cr_deudores, cob_credito..cr_gar_propuesta c
        left join cu_custodia d  
        on  c.gp_garantia     = d.cu_codigo_externo 
           inner join cob_conta..cb_vcotizacion a
           on a.cv_moneda       = d.cu_moneda
             left join cob_credito..cr_tramite
             on c.gp_tramite         = tr_tramite
               inner join cob_conta..cb_vcotizacion b
               on b.cv_moneda        = tr_moneda      
      where cg_ente            = @i_cliente
        and d.cu_garante        is null   --  Excluye garantes personales
        and d.cu_estado          = @w_estado
        and de_rol             = 'C'    --  Codeudor 
        and d.cu_filial          = cg_filial
        and d.cu_sucursal        = cg_sucursal 
        and d.cu_tipo            = cg_tipo_cust
        and d.cu_custodia        = cg_custodia 
        and de_tramite         = tr_tramite
        and ex_garantia        = d.cu_codigo_externo
        and (cu_codigo_externo > @i_codigo_externo or @i_codigo_externo is null)
        and a.cv_fecha = (select max(c.cv_fecha)
                          from   cob_conta..cb_vcotizacion c 
                          where c.cv_moneda = a.cv_moneda
                          and   c.cv_fecha <= @s_date)

      group by d.cu_tipo,
		    cg_tipo_cust,
		    cg_ente,
		    d.cu_garante,        
        	d.cu_estado,          
         	de_rol,             
         	a.cv_moneda,        
         	d.cu_filial,          
         	d.cu_sucursal,                
         	d.cu_custodia,        
         	de_tramite,         
         	c.gp_tramite,        
         	c.gp_garantia,        
         	b.cv_moneda,        
         	ex_garantia,        
         	a.cv_fecha,
	    	d.cu_descripcion,
	    	d.cu_valor_actual,
        	d.cu_moneda,
		    b.cv_valor,
		    a.cv_valor 
      order by cu_tipo,cg_tipo_cust

     if @@rowcount = 0 
        select @w_error = 1901003
     else
        select @w_error = 1901004
    end
end
return 0

ERROR:
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = @w_error
           return 1 
go