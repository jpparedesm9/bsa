/************************************************************************/
/*	Archivo:		retencio.sp				                            */
/*	Stored procedure:	sp_retencion    			                    */
/*	Base de datos:		cob_cartera				                        */
/*	Producto: 		Credito y Cartera			                        */
/*	Disenado por:  		J.J.Lam  F.Espinosa			                    */
/*	Fecha de escritura:	03/07/1995				                        */
/************************************************************************/
/*				IMPORTANTE				                                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	'MACOSA'.							                                */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/************************************************************************/  
/*				PROPOSITO				                                */
/*	Este programa maneja los productos con retencion		            */
/*	U: Actualizacion de producto con retencion			                */
/*	S: Query de productos con retencion				                    */
/*	Q: Search de productos con retencion				                */	
/************************************************************************/

use cob_cartera
go

set ansi_nulls off
go


if exists (select 1 from sysobjects where name = 'sp_retencion')
   drop proc sp_retencion
go

create proc sp_retencion (
@s_user                 login = null,
@s_term                 varchar(30)    =   null,
@s_date                 datetime       =   null,
@s_sesn                 int            =   null,
@s_ofi                  smallint       =   null,
@i_operacion	        char(1),           
@i_concepto	            catalogo       =   null,
@i_categoria	        catalogo       =   null,
@i_descripcion          varchar(255)   =   null,
@i_retencion	        tinyint        =   null,
@i_desembolso           char(1)        =   null,
@i_pago                 char(1)        =   null,
@i_cod_valor            smallint       =   null,
@i_pago_aut             char(1)        =   null,
@i_moneda               tinyint        =   null,				
@i_atx                  char(1)        =   null,
@i_pcobis               tinyint        =   null,
@i_producto_reversa     catalogo       =   null,
@i_afectacion           char (1)       =   null,
@i_producto 	        varchar(20)    =   null,
@i_estado               char(1)        =   null,
@i_act_pas              char(1)        =   null,
@i_Sbancarios           int            =   null,
@i_canal                catalogo       =   null

)
as
declare 
@w_sp_name	    descripcion,
@w_error        int,
@w_cod_valor    int,
@w_rowcount     int



/*  Inicializar nombre del stored procedure  */
select	@w_sp_name = 'sp_retencion'

if @i_operacion in ('U','D') begin
   insert into ca_producto_ts
   select @s_date, getdate(), @s_user, @s_ofi, @s_term,@i_operacion, *
   from   ca_producto
   where cp_producto = @i_concepto
   
   if @@error <> 0 begin
      select @w_error = 703116
      goto ERROR
   end
  
end



/* ** Update ** */
if @i_operacion = 'U' begin

   update ca_producto set 
   cp_categoria	       = @i_categoria,
   cp_retencion        = @i_retencion,
   cp_desembolso       = @i_desembolso,
   cp_pago             = @i_pago,
   cp_pago_aut         = @i_pago_aut,
   cp_moneda           = @i_moneda,
   cp_atx              = @i_atx,
   cp_pcobis	       = @i_pcobis,
   cp_producto_reversa = @i_producto_reversa,
   cp_afectacion       = @i_afectacion,
   cp_descripcion      = @i_descripcion,
   cp_estado           = @i_estado,
   cp_act_pas          = @i_act_pas,
   cp_instrum_SB       = @i_Sbancarios,
   cp_canal            = @i_canal
   where cp_producto = @i_concepto
		
   if @@error <> 0 begin
      select @w_error = 705042
      goto ERROR
   end

   return 0

end



if @i_operacion = 'S' begin

   if @i_producto is null 
      select  @i_producto = ' '  


   set rowcount 20
   
   select 
   'PRODUCTO'        = cp_producto,
   'DESCRIPCION'     = convert(varchar(255),ca_producto.cp_descripcion),
   'CATEGORIA'       = cp_categoria,
   'DESEMBOLSO'      = cp_desembolso,
   'PAGO'            = cp_pago,       
   'DIAS RETENCION'  = convert(int,cp_retencion),
   'CODIGO VALOR'    = cp_codvalor,
   'PAGO AUT.'       = cp_pago_aut,
   'MONEDA'          = cp_moneda,
   'PAGO ATX '       = cp_atx, 
   'DESC. MONEDA'    = substring(mo_descripcion,1,20),
   'PCOBIS'          = cp_pcobis,
   'DESC. PCOBIS'    = substring(pd_descripcion,1,20),
   'PROD.REVERSA'    = cp_producto_reversa,
   'AFECTACION'      = cp_afectacion,
   'ACTIVA/PASIVA'   = cp_act_pas,
   'ESTADO'          = cp_estado,
   --'INSTRUM.SBanc'   = cp_instrum_SB,
   --'DESCRIP.SBanc'   = (select in_nombre from cob_sbancarios..sb_instrumentos where in_cod_instrumento = cp_instrum_SB ),
   'INSTRUM.SBanc'   = null,
   'DESCRIP.SBanc'   = null,   
   'CANAL'           = cp_canal,
   'DESCRIP.CANAL'   = (select valor from cobis..cl_catalogo where tabla in (select codigo from cobis..cl_tabla 
                                                                             where  tabla  = 'cl_canal') and codigo = cp_canal) 
   from  cobis..cl_producto right outer join ca_producto on pd_producto = cp_pcobis,
         cobis..cl_moneda
   where cp_moneda =  mo_moneda
   and cp_producto > @i_producto
   order by cp_producto 
   
   select @w_rowcount = @@rowcount
   
   if @w_rowcount = 0 begin
     print 'FINAL DE LA CONSULTA' 
   end
   
   set rowcount 0
   
   return 0

end



if @i_operacion = 'Q' begin

   select  cp_producto,
   cp_descripcion,
   cp_desembolso,
   cp_pago,
   cp_retencion,
   cp_codvalor,
   cp_pago_aut,
   cp_moneda,
   cp_atx,
   mo_descripcion,
   cp_afectacion,
   cp_estado,
   cp_act_pas,
   cp_instrum_SB     
   from ca_producto,cobis..cl_moneda
   where  cp_producto =  @i_concepto
   and    cp_moneda   =  mo_moneda

   return 0

end

if @i_operacion = 'I' begin
   /* Verifico que no exista concepto */
   if exists (select 1 from cob_cartera..ca_producto
   where cp_producto = @i_concepto) begin
      select @w_error = 701146
      goto ERROR
   end

   select @w_cod_valor = max(cp_codvalor) + 1
   from ca_producto
   
   select @w_cod_valor = isnull(@w_cod_valor, 0)

   if @w_cod_valor < 100  select @w_cod_valor = 100

   begin tran

   if @i_producto_reversa is null
      select @i_producto_reversa  = @i_producto
   
   insert into ca_producto (
   cp_producto,     cp_descripcion,       cp_categoria, 	cp_retencion, 
   cp_desembolso,   cp_pago,              cp_codvalor,
   cp_pago_aut,     cp_moneda,            cp_atx,
   cp_pcobis,       cp_producto_reversa,  cp_afectacion,    cp_estado,
   cp_act_pas,      cp_instrum_SB,        cp_canal)        
   values (                               
   @i_concepto,     @i_descripcion,       @i_categoria,	    @i_retencion,
   @i_desembolso,   @i_pago,              @w_cod_valor,
   @i_pago_aut,     @i_moneda,            @i_atx,
   @i_pcobis,       @i_producto_reversa,  @i_afectacion,    @i_estado,
   @i_act_pas,      @i_Sbancarios,        @i_canal)
   
   if @@error <> 0 begin
      select @w_error = 710001
      goto ERROR
   end
   
   insert into cob_conta..cb_codigo_valor (
   cv_empresa, cv_producto, cv_codval,    cv_descripcion)
   values (
   1,          7,           @w_cod_valor, @i_concepto)   

   if @@error <> 0 begin
      select @w_error = 710116
      goto ERROR
   end

   commit tran

   return 0

end


/** Eliminacion **/
if @i_operacion = 'D' begin

   select @w_cod_valor = cp_codvalor
   from ca_producto
   where cp_producto = @i_concepto

   begin tran

   delete cob_cartera..ca_producto
   where  cp_producto = @i_concepto

   if @@error <> 0 begin
      select @w_error = 710003
      goto ERROR
   end

   delete cob_conta..cb_codigo_valor
   where cv_empresa = 1
   and   cv_producto = 7
   and   cv_codval   = @w_cod_valor

   if @@error <> 0 begin
      select @w_error = 710003
      goto ERROR
   end

   commit tran

   return 0

end

return 0

ERROR:
exec cobis..sp_cerror
@t_debug= 'N', @t_file = null,
@t_from = @w_sp_name, @i_num  = @w_error
return @w_error

go
