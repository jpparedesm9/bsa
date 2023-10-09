/************************************************************************/
/*	Archivo: 	        congarop.sp                             */ 
/*	Stored procedure:       sp_con_garop                            */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Luis Castellanos/Rodrigo Garces     	*/
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
/*	Consulta de garantias  que amparan a una operacion              */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995		     Emision Inicial			*/
/*      Nov 15/2002     Jennifer Velandia  cambio por especificaciones  */
/*                      clase de garantia por admisibilidad             */
/************************************************************************/
use cob_custodia
go

set ansi_nulls off
go

if exists (select 1 from sysobjects where name = 'sp_con_garop')
    drop proc sp_con_garop
go
create proc sp_con_garop      (
   @s_date               datetime = null,
   @t_trn                smallint = null,
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @t_debug              char(1)  = 'N',
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_producto		     tinyint = null,
   @i_operac             descripcion = null,
   @i_tipo_cust          descripcion = null,
   @i_custodia           int = null,
   @i_param1             descripcion = null,
   @i_cond1              descripcion = null,
   @i_cond2              descripcion = null,
   @i_param2             descripcion = null,
   @i_filial             tinyint     = null,
   @i_sucursal           smallint    = null,
   @i_oficina            smallint    = null,
   @i_numero_op_banco    varchar(20) = null,
   @i_numero_op          varchar(20) = null,
   @i_tipo_op1           varchar(10) = null,
   @i_tipo_op            varchar(10) = null,
   @i_cliente		     int = null,
   @w_num_negocio        varchar(64) = null,
   @i_documento 	     varchar(16) = null,
   @i_tramite		     int = null,
   @i_grupo		         int = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_abreviatura        char(3),
   @w_tramite            int,
   @w_grupo              int,
   @w_tipo_linea         varchar(10)
  
select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_con_garop'

/***********************************************************/
/* Codigos de Transacciones                                */

/*if (@t_trn <> 19193 and @i_operacion = 'V') or
   (@t_trn <> 19194 and @i_operacion = 'S') or
   (@t_trn <> 19196 and @i_operacion = 'A') or
   (@t_trn <> 19197 and @i_operacion = 'O')*/
     

if @i_operacion = 'V'
begin
   select to_descripcion
   from cob_credito..cr_toperacion
   where to_toperacion = @i_tipo_op
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901005
      return 1 
   end
end

if @i_operacion = 'A'
begin 
   set rowcount 20
   select
   'MODULO'	  =to_producto,
   'TIPO PRODUCTO'=to_toperacion,
   'DESCRIPCION'  =substring(to_descripcion,1,30) 
   from		  cob_credito..cr_toperacion
   where	  ((to_producto > @i_param1 or (to_producto = @i_param1 and
		  to_toperacion > @i_param2)) or @i_param1 is null)
   order by	  to_producto,to_toperacion
end


if @i_operacion = 'O'
begin
   select   @w_abreviatura  = @i_tipo_op

   set rowcount 20
   
   if @i_numero_op is not null
   begin
	   select
	   'TIPO PRODUCTO'=tr_producto,
	   'OBLIGACION'   = op_banco
	   from		cob_credito..cr_tramite,
			cob_cartera..ca_operacion
	   where	tr_tramite	= op_tramite
	   and		op_banco	> @i_numero_op 
	   order by	op_banco, tr_producto

	   if @@rowcount = 0
	      return 1
   end
   else
   begin
	   select
	   'TIPO PRODUCTO'=tr_producto,
	   'OBLIGACION'   = op_banco
	   from		cob_credito..cr_tramite,
			cob_cartera..ca_operacion
	   where	tr_tramite	= op_tramite
	   and  	tr_tramite	>= 0
	   and  	op_tramite	>= 0
	   order by	op_banco, tr_producto

	   if @@rowcount = 0
	      return 1
   end
end
 
if @i_operacion = 'S'
begin
   if @i_sucursal is null   
      select @i_sucursal = of_oficina
      from cobis..cl_oficina
      where of_oficina = @i_oficina
      set transaction isolation level read uncommitted

   select   @w_abreviatura  = @i_tipo_op
   set rowcount 20

     select distinct
       cu_custodia as GARANTIA,
       substring(cu_tipo,1,15) + ' ' +
                          substring(tc_descripcion,1,20) as TIPO,
       cg_ente as CLIENTE,
       substring(cg_nombre,1,25) as NOMBRE,
       cu_valor_actual as VALOR_ACEPTADO,
       cu_valor_inicial as VALOR_GARANTIA,
       cu_moneda as MON,
       convert(varchar(10),cu_fecha_ingreso,101) as INGRESO,
   cu_valor_actual as VALOR_DE_COBERTURA,
   cu_clase_custodia as ADMISIBILIDAD,
   cu_compartida as COMPARTIDA,
   tr_clase as CLASE_CARTERA
   from cu_custodia, cu_cliente_garantia, 
        cu_tipo_custodia,
   cob_credito..cr_gar_propuesta,
   cob_credito..cr_tramite
   where cu_codigo_externo = gp_garantia  --XTA 
   and gp_tramite = tr_tramite --XTA
   and tr_numero_op_banco =  @i_numero_op --XTA
   and tr_producto = @w_abreviatura --XTA
   and cu_filial              = @i_filial
   and cu_codigo_externo      = cg_codigo_externo
   and cu_tipo                = tc_tipo
   and cg_principal           = 'D'
   and cu_estado <> 'A'
   order by GARANTIA,
   TIPO  ,
   CLIENTE ,
   NOMBRE,
   VALOR_ACEPTADO  ,
   VALOR_GARANTIA  ,
   MON  ,
   INGRESO  ,
   VALOR_DE_COBERTURA,
   ADMISIBILIDAD,
   COMPARTIDA		 ,
   CLASE_CARTERA 

   if @@rowcount = 0
      return 1
end 

 
if @i_operacion = 'F'
begin
   select @i_numero_op = isnull(@i_numero_op,'')

   set rowcount 20
   select 
	'CLIENTE' = op_cliente,
	'OPERACION' = op_banco,
	'TRAMITE' = op_tramite_ficticio,
	'GRUPO' = op_grupo_fact, op_tipo, op_estado
   from 
	cob_cartera..ca_operacion
   where 
	op_cliente = @i_cliente
	and op_tipo = 'D'
	and op_estado in (1,2,3,5,6,8,9)
	and (op_banco > @i_numero_op)
end

if  @i_operacion = 'H'
begin
     select @w_tramite = op_tramite,
            @w_tipo_linea = op_tipo_linea
     from   cob_cartera..ca_operacion 
     where  op_banco = @i_numero_op

     if @w_tipo_linea = '61'
     begin   
        set rowcount 20
        select
       'NUM NEGOCIO' = do_num_negocio,
       'NUM DOCUMENTO' = do_num_doc,
       'TIPO DOCUMENTO' = do_tipo_doc,
       'VALOR NEGOCIO' = do_valor_neg,
       'COD PROVEEDOR' = do_proveedor,
       'INI NEGOCIO' = convert(varchar(10),do_fecha_inineg,103),
       'VTO NEGOCIO' = convert(varchar(10),do_fecha_vtoneg,103)
       from cu_documentos,cu_grupos_doctos,cob_credito..cr_facturas
       where do_cliente = @i_cliente
       and   do_cliente = gd_cliente
       and   do_num_negocio = fa_num_negocio
       and   do_num_negocio = gd_num_negocio
       and   gd_num_negocio = fa_num_negocio
       and   do_estado = 'X'
       and   do_grupo = gd_grupo
       and   do_grupo = fa_grupo
       and   gd_grupo = fa_grupo
       and   fa_tramite = @w_tramite
       and   gd_tramite = fa_tramite
       and   fa_proveedor = do_proveedor     
       and   fa_referencia = do_num_doc
       order by	do_num_doc
    end
    else
    begin
        set rowcount 20

        select
       'NUM NEGOCIO' = do_num_negocio,
       'NUM DOCUMENTO' = do_num_doc,
       'TIPO DOCUMENTO' = do_tipo_doc,
       'VALOR NEGOCIO' = do_valor_neg,
       'COD PROVEEDOR' = do_proveedor,
       'INI NEGOCIO' = convert(varchar(10),do_fecha_inineg,103),
       'VTO NEGOCIO' = convert(varchar(10),do_fecha_vtoneg,103)
       from cu_documentos,cu_grupos_doctos,cob_credito..cr_facturas
       where do_proveedor = gd_cliente
       and   do_num_negocio = fa_num_negocio
       and   do_num_negocio = gd_num_negocio
       and   gd_num_negocio = fa_num_negocio
       and   do_estado = 'X'
       and   do_grupo = gd_grupo
       and   do_grupo = fa_grupo
       and   gd_grupo = fa_grupo
       and   fa_tramite   = @w_tramite
       and   fa_proveedor = do_proveedor
       and   fa_referencia = do_num_doc
       and   fa_tramite = gd_tramite		--SBU 19/dic/2001
    end


end
                                                
go

