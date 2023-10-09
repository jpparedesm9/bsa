use cob_conta
go

if exists(select 1 from sysobjects where name = 'sp_impuestos')
   drop proc sp_impuestos
go
   
create proc sp_impuestos (
   @i_empresa        tinyint,
   @i_concepto       char(4)  = NULL,
   @i_debcred        char(1),
   @i_monto          money    = 0,
   @i_impuesto       char(1),
   @i_ciudad         int      = NULL,
   @i_oforig_admin   smallint,
   @i_ofdest_admin   smallint,
   @i_ente           int,
   @i_producto       tinyint,
   @i_plazo          int      = NULL,
   @o_porcentaje     smallint =  0  out,
   @o_exento         char(1)  = 'N' out
)
as   
declare  @w_mensaje  descripcion,
         @w_return   int,
         @w_sp_name  varchar(20),
         @w_tiempo   tinyint

select @w_sp_name = 'sp_impuesto'
     
select @o_porcentaje = 0

if @i_impuesto = 'I'
   select @i_impuesto = 'C'

if (@i_producto = 14) and (@i_impuesto = 'R')
begin
   select @w_tiempo = pa_int
   from cobis..cl_parametro
   where pa_nemonico = 'TPCR'
   and   pa_producto = 'CON'
   
   select @i_concepto = pa_char
   from cobis..cl_parametro
   where pa_nemonico = 'CRCDT'
   and   pa_producto = 'CON'
end

exec @w_return = cob_conta..sp_exenciu    
@t_trn          = 6251,
@i_operacion    = 'F',
@i_empresa      = @i_empresa,
@i_impuesto     = @i_impuesto,
@i_concepto     = @i_concepto,
@i_debcred      = @i_debcred,
@i_oforig_admin = @i_oforig_admin,
@i_ofdest_admin = @i_ofdest_admin,
@i_ente         = @i_ente,
@i_producto     = @i_producto,
@i_pit          = 'N',
@o_exento       = @o_exento out

if @w_return <> 0
	return @w_return

select @w_mensaje = 'NO EXISTE CONCEPTO CONTABLE '
select @w_mensaje = @w_mensaje + @i_concepto + ' IMPUESTO ' + @i_impuesto

if @i_impuesto = 'V'	/*** 	IVA	****/
begin
   select 
   @o_porcentaje   = iva_des_porcen
   from cob_conta..cb_iva
   where iva_empresa = @i_empresa
   and   iva_codigo  = @i_concepto
   and   iva_debcred = @i_debcred
   and   iva_base   <= @i_monto
   
   if @@rowcount <> 1
   begin
      /*** Error: NO EXISTE CONCEPTO CONTABLE EN CONTABILIDAD	***/
      select @o_porcentaje = 0
   end
end

if @i_impuesto = 'R'	/**** RETENCION ***/
begin
   if (@i_producto = 14) and (@i_plazo > @w_tiempo)
   begin
      select @o_porcentaje = pa_tinyint
      from cobis..cl_parametro
      where pa_nemonico = 'PPTM'
      and   pa_producto = 'CON'
   end
   else
   begin
      select 
      @o_porcentaje = cr_porcentaje  
      from cob_conta..cb_conc_retencion
      where cr_empresa = @i_empresa
      and cr_codigo    = @i_concepto
      and cr_tipo      = 'R'   
      and cr_debcred   = @i_debcred 
      and   cr_base      <= @i_monto
   end
   
   if @@rowcount <> 1
   begin
      select @o_porcentaje = 0
   end
end

if @i_impuesto = 'T'	/****	TIMBRE	***/
begin
   select 
   @o_porcentaje = cr_porcentaje  
   from cob_conta..cb_conc_retencion
   where cr_empresa = @i_empresa
   and   cr_codigo    = @i_concepto
   and   cr_tipo      = 'T'
   and   cr_debcred   = @i_debcred
   and   cr_base      <= @i_monto

   if @@rowcount <> 1
   begin
      select @o_porcentaje = 0
   end
end   

if @i_impuesto = 'C'	/*** 	ICA	****/
begin
   select 
   @o_porcentaje   = ic_porcentaje/10   -- se divide en 10 al ser valor de 1000 no de 100
   from cob_conta..cb_ica
   where ic_empresa  =  @i_empresa
   and   ic_codigo   =  @i_concepto
   and   ic_ciudad   =  @i_ciudad
   and   ic_debcred  =  @i_debcred
   and   ic_base     <= @i_monto
   
   if @@rowcount <> 1
   begin
      select @o_porcentaje = 0
   end
end

if @i_impuesto = 'P'	/*** 	IVA PAGADO	****/
begin
   select 
   @o_porcentaje   = ip_porcentaje
   from cob_conta..cb_iva_pagado
   where ip_empresa =  @i_empresa
   and   ip_codigo  =  @i_concepto
   and   ip_debcred =  @i_debcred
   and   ip_base    <= @i_monto
   
   if @@rowcount <> 1
   begin
      select @o_porcentaje = 0
   end
end   

return 0

go