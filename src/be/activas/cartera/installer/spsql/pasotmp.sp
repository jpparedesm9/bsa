/************************************************************************/
/*      Archivo:                pasotmp.sp                              */
/*      Stored procedure:       sp_pasotmp                              */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           R Garces                                */
/*      Fecha de escritura:     Jul. 1997                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA".	                                                */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                              PROPOSITO                               */
/*      Copia los datos de una operacion de sus tablas definitivas      */
/*      a sus tablas temporales                                         */
/************************************************************************/  

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_pasotmp')
	drop proc sp_pasotmp
go
create proc sp_pasotmp
@s_user                 login,
@s_term                 varchar(30) = null,
@i_banco		cuenta  = null,
@i_operacionca		char(1) = null,
@i_dividendo		char(1) = null,
@i_amortizacion		char(1) = null,
@i_cuota_adicional	char(1) = null,
@i_rubro_op		char(1) = null,
@i_relacion_ptmo        char(1) = null,
@i_nomina               char(1) = null,
@i_acciones             char(1) = 'N',  
@i_valores              char(1) = 'N'   

as
declare 
@w_operacionca		int ,
@w_error		int ,
@w_sp_name		descripcion,
@w_tipo                 char(1),
@w_moneda               int,
@w_toperacion           catalogo,
@w_rubros_def           int,
@w_rubros_tmp           int

if @i_dividendo = ''  select @i_dividendo	= null
  
if  @i_amortizacion = ''  select @i_amortizacion	= null

if @i_cuota_adicional	= '' select @i_cuota_adicional = null

if @i_rubro_op	= ''  select @i_rubro_op	= null

if @i_relacion_ptmo = '' select @i_relacion_ptmo = null

-- Se aniade rowcount porque no creaba todos
set rowcount 0

select 
@w_operacionca = op_operacion,
@w_moneda      = op_moneda,
@w_toperacion  = op_toperacion
from   ca_operacion
where  op_banco = @i_banco 

/* CONTROL PARA EVITAR QUE DOS USUARIOS EDITEN UNA MISMA OPERACION */
if exists(select 1 from ca_operacion_tmp
where opt_operacion = @w_operacionca)
begin
   return 710018
end


if @i_acciones = 'S'
begin
  delete ca_acciones_tmp
  where act_operacion = @w_operacionca

  if @@error !=0 begin
     select @w_error = 710003
     goto ERROR
  end

  insert into ca_acciones_tmp
  select * from ca_acciones
  where  ac_operacion = @w_operacionca

  if @@error != 0 begin
     select @w_error = 710001
     goto ERROR
  end
end

if @i_valores = 'S' begin
   delete ca_valores_tmp
   where vat_operacion = @w_operacionca

   if @@error != 0 begin
      select @w_error = 710003
      goto ERROR
   end

   insert into ca_valores_tmp
   select * from ca_valores  with (rowlock)
   where  va_operacion = @w_operacionca

   if @@error != 0 begin
      select @w_error = 710001
      goto ERROR
   end

end



select @w_tipo = dt_tipo from ca_default_toperacion
where dt_toperacion = @w_toperacion
and   dt_moneda     = @w_moneda


if @i_operacionca = 'S' begin
   insert into ca_operacion_tmp
   select * from ca_operacion
   where  op_operacion = @w_operacionca

   if @@error != 0 begin
      select @w_error = 710001
      goto ERROR
   end

end


if @i_dividendo = 'S' begin

   delete ca_dividendo_tmp
   where  dit_operacion = @w_operacionca

   if @@error != 0 begin
      select @w_error = 710003
      goto ERROR
   end        
                      
   insert into ca_dividendo_tmp
   select * from ca_dividendo
   where  di_operacion = @w_operacionca
   
   if @@error != 0
   begin
      select @w_error = 710001
      goto ERROR
   end

   /*DIVIDENDOS ORIGINALES PARA TABLAS DE AMORTIZACION MANUAL */
   delete ca_dividendo_original_tmp
   where  dot_operacion = @w_operacionca

   if @@error != 0 begin
      select @w_error = 710003
      goto ERROR
   end

   insert into ca_dividendo_original_tmp
   select * from ca_dividendo_original
   where  do_operacion = @w_operacionca

   if @@error != 0
   begin
      select @w_error = 710001
      goto ERROR
   end

end

if @i_amortizacion = 'S'
begin
   delete ca_amortizacion_tmp
   where  amt_operacion = @w_operacionca

   if @@error != 0
   begin
      select @w_error = 710003
      goto ERROR
   end        
                      
   insert into ca_amortizacion_tmp
   select * from ca_amortizacion
   where  am_operacion = @w_operacionca

   if @@error != 0
   begin
      select @w_error = 710001
      goto ERROR
   end
end


if @i_nomina = 'S'
begin
   delete ca_nomina_tmp
   where  not_operacion = @w_operacionca

   if @@error != 0
   begin
      select @w_error = 710101
      goto ERROR
   end        

   delete ca_definicion_nomina_tmp
   where  dnt_operacion = @w_operacionca

   if @@error != 0
   begin
      select @w_error = 710101
      goto ERROR
   end


   insert into ca_definicion_nomina_tmp
   select * from ca_definicion_nomina
   where  dn_operacion = @w_operacionca

   if @@error != 0
   begin
      select @w_error = 710101
      goto ERROR
   end

   insert into ca_nomina_tmp
   select * from ca_nomina
   where  no_operacion = @w_operacionca

   if @@error != 0
   begin
      select @w_error = 710101
      goto ERROR
   end            
end              

if @i_rubro_op = 'S'
begin
   delete ca_rubro_op_tmp
   where  rot_operacion = @w_operacionca

   if @@error != 0
   begin
      select @w_error = 710003
      goto ERROR
   end          
                    
   insert into ca_rubro_op_tmp
   select * from ca_rubro_op
   where  ro_operacion = @w_operacionca

   if @@error != 0
   begin
      select @w_error = 710001
      goto ERROR
   end

end

if @i_cuota_adicional = 'S'
begin
   delete ca_cuota_adicional_tmp
   where  cat_operacion = @w_operacionca

   if @@error != 0
   begin
      select @w_error = 710003
      goto ERROR
   end          
                    
   insert into ca_cuota_adicional_tmp
   select * from ca_cuota_adicional
   where  ca_operacion = @w_operacionca

   if @@error != 0
   begin
      select @w_error = 710001
      goto ERROR
   end
end

if @i_relacion_ptmo = 'S' begin
   if @w_tipo = 'R' begin
      delete ca_relacion_ptmo_tmp
      where  rpt_pasiva = @w_operacionca

      if @@error != 0 begin
         select @w_error = 710003
         goto ERROR
      end

      insert into ca_relacion_ptmo_tmp
      select * from ca_relacion_ptmo
      where  rp_pasiva  = @w_operacionca

      if @@error != 0 begin
         select @w_error = 710001
         goto ERROR
      end
   end 
   else begin
      delete ca_relacion_ptmo_tmp
      where  rpt_activa = @w_operacionca

      if @@error != 0 begin
         select @w_error = 710003
         goto ERROR
      end

      insert into ca_relacion_ptmo_tmp
      select * from ca_relacion_ptmo
      where  rp_activa  = @w_operacionca

      if @@error != 0 begin
         select @w_error = 710001
      goto ERROR
      end
   end
end    


---VALIDACION DE LOS RUBROS PASADOS A TEMPORALES

select @w_rubros_def = count(1)
from ca_rubro_op with (nolock)
where ro_operacion = @w_operacionca

select @w_rubros_tmp = count(1)
from ca_rubro_op_tmp with (nolock)
where rot_operacion = @w_operacionca

if @w_rubros_def <> @w_rubros_tmp
begin
  select @w_error = 710561
  goto ERROR
end 




/* LLENADO DE LA TABLA ca_en_temporales CON LOS DATOS DE LA */
/* OPERACION QUE PASO A TEMPORALES                          */

/*VALIDACION QUE LOS CAMPOS NO SEAN NULOS PARA ESTA TABLA*/

if (@s_user is null or @s_user = '') or (@s_term is null or @s_term = '') or @w_operacionca is null 
begin
  select @w_error = 710469
  goto ERROR
end 

insert into ca_en_temporales values (@s_user,@s_term,@w_operacionca)



return 0

ERROR:
return @w_error

go

