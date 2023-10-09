/************************************************************************/
/*	Archivo: 		valitem.sp				*/
/*	Stored procedure: 	sp_valitem				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     01-Febrero-1995				*/
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
/*	   Insercion y consulta de datos para conciliacion bancaria     */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	01/Feb/1995	G Jaramillo     Emision Inicial			*/
/*	05/May/1995	M Suarez        Control Calidad			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_valitem')
    drop proc sp_valitem
go
create proc sp_valitem (
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
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_empresa            tinyint  = null,
   @i_fecha_tran         datetime  = null,
   @i_comprobante        int  = null,
   @i_asiento            smallint  = null ,
   @i_item1		 tinyint = null,
   @i_subopcion          tinyint = 0
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_empresa            tinyint,
   @w_fecha_tran         datetime,
   @w_comprobante        int,
   @w_asiento            smallint,
   @w_valor              descripcion

select @w_today = getdate()
select @w_sp_name = 'sp_valitem'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6821 and @i_operacion = 'I') or
   (@t_trn <> 6825 and @i_operacion = 'S') or
   (@t_trn <> 6826 and @i_operacion = 'Q')
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 

    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1 
end


/* Insercion del registro */
/**************************/


if @i_operacion = 'I'
begin
    begin tran
	 delete cb_val_item
	 where vi_empresa = @i_empresa and
		vi_fecha_tran = @i_fecha_tran and
		vi_comprobante = @i_comprobante and
		vi_asiento = @i_asiento

         insert into cb_val_item(
              vi_empresa, vi_opcion, vi_debcred, vi_item, vi_fecha_tran,
              vi_comprobante, vi_asiento, vi_valor)
	 select ti_empresa, ti_opcion, ti_debcred, ti_item, ti_fecha_tran,
              ti_comprobante, ti_asiento, ti_valor
	 from cob_conta..cb_tval_item
	 where ti_empresa = @i_empresa and
		ti_fecha_tran = @i_fecha_tran and
		ti_comprobante = @i_comprobante and
		ti_asiento = @i_asiento
      
         delete cb_tval_item
         where  ti_empresa     = @i_empresa and
                ti_fecha_tran  = @i_fecha_tran and
                ti_comprobante = @i_comprobante and
                ti_asiento     = @i_asiento

         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 603059
             return 1 
         end

    commit tran 
    return 0
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
   if @i_subopcion = 0
   begin
	if @i_modo = 0
	begin
	    select vi_opcion,isnull(convert(char(4),vi_item),"NULL"),vi_valor
	    from cob_conta..cb_val_item
	    where vi_empresa = @i_empresa and
		  vi_fecha_tran = @i_fecha_tran and
		  vi_comprobante = @i_comprobante and
		  vi_asiento = @i_asiento
	    order by vi_item

   	    if @@rowcount = 0
   	    begin
   	       /*Registro no existe */
       	       exec cobis..sp_cerror
       	       @t_debug = @t_debug,
       	       @t_file  = @t_file, 
       	       @t_from  = @w_sp_name,
       	       @i_num   = 601153
       	       return 1 
   	    end
	end
	else begin
	    select vi_opcion,isnull(convert(char(4),vi_item),"NULL"),vi_valor
	    from cob_conta..cb_val_item
	    where vi_empresa = @i_empresa and
		  vi_fecha_tran = @i_fecha_tran and
		  vi_comprobante = @i_comprobante and
		  vi_asiento = @i_asiento and
		  vi_item > @i_item1
	    order by vi_item

   	    if @@rowcount = 0
   	    begin
   	       /*Registro no existe */
       	       exec cobis..sp_cerror
       	       @t_debug = @t_debug,
       	       @t_file  = @t_file, 
       	       @t_from  = @w_sp_name,
       	       @i_num   = 601150
       	       return 1 
   	    end
	end
    end
    if @i_subopcion = 1
    begin
	if @i_modo = 0
	begin
	    select vi_asiento,vi_opcion,vi_debcred,
                   isnull(convert(char(4),vi_item),"NULL"), vi_valor
	    from cb_val_item
	    where vi_empresa = @i_empresa and
		  vi_fecha_tran = @i_fecha_tran and
		  vi_comprobante = @i_comprobante 
	    order by vi_asiento, vi_item

   	    -- if @@rowcount = 0
   	    -- begin
   	    -- Registro no existe
       	       -- exec cobis..sp_cerror
       	       -- @t_debug = @t_debug,
       	       -- @t_file  = @t_file, 
       	       -- @t_from  = @w_sp_name,
       	       -- @i_num   = 601153
       	       -- return 1 
   	    -- end
	end
	else begin
	    select vi_asiento,vi_opcion,vi_debcred,
                   isnull(convert(char(4),vi_item),"NULL"), vi_valor
	    from cb_val_item
	    where vi_empresa    = @i_empresa 
              and vi_fecha_tran = @i_fecha_tran 
              and vi_comprobante = @i_comprobante
              and ((vi_asiento    = @i_asiento and vi_item > @i_item1)
               or  (vi_asiento    > @i_asiento))
	    order by vi_item

   	    -- if @@rowcount = 0
   	    -- begin
   	       -- Registro no existe
       	       -- exec cobis..sp_cerror
       	       -- @t_debug = @t_debug,
       	       -- @t_file  = @t_file, 
       	       -- @t_from  = @w_sp_name,
       	       -- @i_num   = 601150
       	       -- return 1 
   	    -- end
	end
    end

 return 0
end


/* Consulta opcion Search */
/*************************/

if @i_operacion = 'S'
begin
	if @i_modo = 0
	begin
	    select op_nombre,
		   it_nombre,
		   vi_valor,
		   vi_item
	    from cob_conta..cb_val_item,cob_conta..cb_opcion,
		 cob_conta..cb_item
	    where vi_empresa = @i_empresa and
		  vi_fecha_tran = @i_fecha_tran and
		  vi_comprobante = @i_comprobante and
		  vi_asiento = @i_asiento and
		  op_empresa = @i_empresa and
		  op_opcion = vi_opcion and
	          op_debcred = vi_debcred and
		  it_empresa = @i_empresa and
		  it_item = vi_item 	
	    order by vi_item

   	    if @@rowcount = 0
   	    begin
   	       /*Registro no existe */
       	       exec cobis..sp_cerror
       	       @t_debug = @t_debug,
       	       @t_file  = @t_file, 
       	       @t_from  = @w_sp_name,
       	       @i_num   = 601153
       	       return 1 
   	    end
	end
	else begin
	    select op_nombre,
		   it_nombre,
		   vi_valor,
		   vi_item
	    from cob_conta..cb_val_item,
		 cob_conta..cb_opcion, cob_conta..cb_item
	    where vi_empresa = @i_empresa and
		  vi_fecha_tran = @i_fecha_tran and
		  vi_comprobante = @i_comprobante and
		  vi_asiento = @i_asiento and
		  vi_item > @i_item1 and
		  op_empresa = @i_empresa and
		  op_opcion = vi_opcion and
	          op_debcred = vi_debcred and
		  it_empresa = @i_empresa and
		  it_item = vi_item 	
		  
	    order by vi_item

   	    if @@rowcount = 0
   	    begin
   	       /*Registro no existe */
       	       exec cobis..sp_cerror
       	       @t_debug = @t_debug,
       	       @t_file  = @t_file, 
       	       @t_from  = @w_sp_name,
       	       @i_num   = 601150
       	       return 1 
   	    end
	end
    return 0
end

go
