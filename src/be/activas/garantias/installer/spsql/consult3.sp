/************************************************************************/
/*	Archivo: 	        consult3.sp                                     */ 
/*	Stored procedure:       sp_consult3                                 */ 
/*	Base de datos:  	cob_custodia				                    */
/*	Producto:               garantias               		            */
/*	Disenado por:           Rodrigo Garces                  	        */
/*			        Luis Alfredo Castellanos              	            */
/*	Fecha de escritura:     Junio-1995  				                */
/************************************************************************/
/*				IMPORTANTE				                                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	        */
/*	"NCR CORPORATION".						                            */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/*				PROPOSITO				                                */
/*	Este programa procesa las transacciones de:			                */
/*	Consulta los valores mas importantes de una garantia y su           */
/*      operacion.                                                      */
/*	                                                                    */
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		RAZON				                        */
/*	Nov/1995		     Emision Inicial			                    */
/*      DIC/2002        Jvelandia    titulos de valor actual            */       
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_consult3')
    drop proc sp_consult3
go
create proc sp_consult3  (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)     = null,
   @i_modo               smallint    = null,
   @i_filial             tinyint     = null,
   @i_sucursal           smallint    = null,
   @i_tipo_cust          varchar(64) = null,
   @i_custodia           int         = null,
   @i_tramite            int         = null,
   @i_codigo_externo  	 varchar(64) = null,
   @i_cliente            int         = null,
   @i_producto           varchar(20) = null,
   @i_operac             varchar(15) = null,
   @i_detalle            char(1)     = null,
   @i_banco		         varchar(15) = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_codigo_externo     varchar(64),
   @w_abierta_cerrada    char(1),
   @w_cliente            int       

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_consult3'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19475 and @i_operacion = 'Q') 
     
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

if @i_operacion = 'Q'
begin
    if @i_codigo_externo is not null
    begin
       exec sp_compuesto
       @t_trn = 19245,
       @i_operacion = 'Q',
       @i_compuesto = @i_codigo_externo,
       @o_filial    = @i_filial out,
       @o_sucursal  = @i_sucursal out,
       @o_tipo      = @i_tipo_cust out,
       @o_custodia  = @i_custodia out
       
       select   @w_codigo_externo = @i_codigo_externo
    end
    else
    -- CODIGO EXTERNO
       exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,@w_codigo_externo out

     set rowcount  20
     select distinct 
      "LINEA DE CREDITO"  = tr_producto,
      "OBLIGACION"       = tr_numero_op_banco, 
      "MONEDA"          = cu_moneda,
      "VALOR GARANTIA"   = convert(money,cu_valor_inicial),
      "VALOR ACEPTADO"    = convert(money,cu_valor_actual),
      "CLIENTE"          = cg_ente, 
      "NOMBRE CLIENTE"   = cg_nombre,
      "CLASE CARTERA    "  = (select valor from cobis..cl_tabla t, cobis..cl_catalogo c
                              where t.tabla = 'cr_clase_cartera'
                              and t.codigo = c.tabla
                              and c.codigo = tr_clase)
   from cu_custodia, cu_cliente_garantia, 
   cob_credito..cr_gar_propuesta,
   cob_credito..cr_tramite
   where gp_garantia          = @w_codigo_externo
   and tr_tramite = gp_tramite
   and cu_codigo_externo      = gp_garantia
   and cu_filial              = @i_filial
   and cu_sucursal            = @i_sucursal
   and cu_tipo                = @i_tipo_cust
   and cu_custodia            = @i_custodia
   and cg_principal           = 'D'
   and gp_garantia            = cg_codigo_externo
   and (tr_numero_op_banco > @i_banco or @i_banco is null)
   and tr_numero_op_banco is not null
   order by tr_numero_op_banco
set rowcount 0
return 0
end
go