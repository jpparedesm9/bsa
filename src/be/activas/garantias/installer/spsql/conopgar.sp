/************************************************************************/
/*	Archivo: 	        conopgar.sp                             */ 
/*	Stored procedure:       sp_con_opgar                            */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                  	*/
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
/*	Este programa procesa las transacciones de:			*/
/*	Consulta de operaciones que ampara una garantia                 */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995		     Emision Inicial			*/
/*      Nov 18/2002  Jennifer V       Especificaciones -                */
/*                   cambio de clase de garantia a admisibilidad        */     
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_con_opgar')
    drop proc sp_con_opgar
go
create proc sp_con_opgar      (

   @s_date               datetime = null,
   @t_trn                smallint = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_producto		 catalogo = null,
   @i_operac             descripcion = null,
   @i_tipo_cust          descripcion = null,
   @i_custodia           int = null,
   @i_filial             tinyint = null,
   @i_sucursal           smallint = null,
   @i_codigo_compuesto   varchar(64) = null,
   @i_banco 		 varchar(24) = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_abreviatura        descripcion,
   @w_codigo_custodia    descripcion,
   @w_clase_custodia     smallint,
   @w_cod_cca            smallint,
   @w_contador           tinyint

--select @w_today = convert(varchar(10),getdate(),101)
select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_con_opgar'

/***********************************************************/
/* Codigos de Transacciones                                */

--if (@t_trn <> 19204 and @i_operacion = 'S') 

    if @i_codigo_compuesto is not null 
    begin
       exec sp_compuesto
       @t_trn = 19245,
       @i_operacion = 'Q',
       @i_compuesto = @i_codigo_compuesto,
       @o_filial    = @i_filial out,
       @o_sucursal  = @i_sucursal out,
       @o_tipo      = @i_tipo_cust out,
       @o_custodia  = @i_custodia out
    end
   
if @i_operacion = 'S'
begin
   if @i_modo < 2  
   begin
      exec sp_consult3
      @t_trn = 19475,
      @i_operacion = 'Q',
      @i_filial    = @i_filial,
      @i_sucursal  = @i_sucursal,
      @i_tipo_cust = @i_tipo_cust,
      @i_custodia  = @i_custodia,
      @s_date      = @s_date,
      @i_banco     = @i_banco
   end
   else 
   begin
      select  @w_clase_custodia = codigo
      from cobis..cl_tabla
      --where tabla = 'cu_admisible'
      where tabla = 'cu_clase_custodia'
      set transaction isolation level read uncommitted

      select  @w_cod_cca =codigo
      from cobis..cl_tabla
      where tabla = 'cr_clase_cartera'
      set transaction isolation level read uncommitted
  

      if @i_modo = 2
      begin

         select  @w_cod_cca =codigo
         from cobis..cl_tabla
         where tabla = 'cr_clase_cartera'
	 set transaction isolation level read uncommitted

         select  @w_clase_custodia =codigo
         from cobis..cl_tabla
         --where tabla = 'cu_admisible'
         where tabla = 'cu_clase_custodia'
	 set transaction isolation level read uncommitted

	 set rowcount 20
	 select-- distinct
	 "MODULO"            = tr_producto, 
	 "CLASE CARTERA"     = substring(A.valor,1,10),
     --	 "CLASE CUSTODIA"    = substring(B.valor,1,10),  jvc nov 2002 i/o
	 "ADMISIBILIDAD "    = substring(B.valor,1,10),
	 "CLIENTE"           = substring(en_nomlar,1,20),
	 "OBLIGACION"        = tr_numero_op_banco
	 from cob_credito..cr_tramite,cob_credito..cr_gar_propuesta,      
         cob_custodia..cu_custodia,cob_custodia..cu_cliente_garantia,
         cobis..cl_catalogo A,cobis..cl_ente,cobis..cl_catalogo B
	 where A.tabla    =  @w_cod_cca
	 and A.codigo     =  tr_clase
	 and B.tabla      =  @w_clase_custodia
	 --and B.codigo     =  cu_adecuada_noadec emg feb-16-02
	 and B.codigo     =  cu_clase_custodia
	 and en_ente      =  cg_ente
         and cg_principal = 'D'
	 and gp_tramite   = tr_tramite
         and gp_garantia  =  @i_codigo_compuesto 
         and gp_garantia  = cu_codigo_externo
         and cg_codigo_externo = cu_codigo_externo
	 and tr_numero_op_banco is not null
	 and (tr_numero_op_banco > @i_operac or @i_operac is null)
	 order by tr_numero_op_banco
      end 
   end
end
go