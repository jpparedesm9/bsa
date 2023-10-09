/*****************************************************************************/
/*  ARCHIVO:         embargo_int.sp                                          */
/*  NOMBRE LOGICO:   sp_embargo_int                                          */
/*  PRODUCTO:        Depositos a Plazo Fijo                                  */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*                               PROPOSITO                                   */
/* Aplicar, en el momento del pago de intereses, el/los embargo ingresado.   */
/*****************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where type = 'P' and name = 'sp_embargo_int')
   drop proc sp_embargo_int
go

create proc sp_embargo_int
@s_date             datetime,
@i_operacion        int,
@i_ente             int,
@i_nomlar           varchar(64),
@i_oficina          int,
@i_moneda           int   = 0,
@i_monto_int        money = 0,
@i_fpago			varchar(20)
with encryption
as
declare
@w_error            int,
@w_sec              int,
@w_val_int          money,
@w_val_apl          money,
@w_val_xemb         money,
@w_val_emb          money,
@w_monto_disp       money,
@w_secuencial       int,
@w_autoridad        varchar(64),
@w_oficina          int,
@w_cod_aut          int,
@w_porcentaje       float,
@w_pg_cli           catalogo,
@w_pg_juz           catalogo,
@w_tipo		    varchar(20)

--CAPTURA DE PARAMETRO DE FORMA DE PAGO DE INTERESES A JUZGADOS 
select @w_pg_juz = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'FPITE'

if @@rowcount = 0
begin
   select @w_error =  141244
   goto ERROR
end

--CAPTURA DE PARAMETRO DE FORMA DE PAGO DEL RESTO DE INTERESES AL CLIENTE
select @w_pg_cli = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'MPICLE'

if @@rowcount = 0
begin
   select @w_error =  141244
   goto ERROR
end

delete pf_det_pago
where  dp_operacion = @i_operacion

if @@error <> 0 begin
   select @w_error = 147038
   goto ERROR
end

select @w_monto_disp = @i_monto_int

declare cur_bloqueo cursor for
select
bl_secuencial,
isnull(bl_valor_int_embgdo_banco,    0),
isnull(bl_valor_int_embgdo_aplicado, 0),
isnull(bl_valor_int_embgdo_banco, 0) - isnull(bl_valor_int_embgdo_aplicado,0),
bl_autoridad,
bl_oficina
from  pf_bloqueo_legal
where bl_operacion = @i_operacion
and   bl_estado = 'I'
order by bl_secuencial

open cur_bloqueo

fetch cur_bloqueo into
@w_secuencial,
@w_val_int,
@w_val_apl,
@w_val_xemb,
@w_autoridad,
@w_oficina

while @@fetch_status = 0
begin
   if @w_val_xemb <= 0 goto SIGUIENTE --PARA EVITAR HALLOWEEN

   /* SI EL VALOR POR EMBARGAR ES MENOR O IGUAL AL DISPONIBLE HAGO EL EMBARGO POR EL VALOR POR
   EMBRARGAR, DE LO CONTRARIO LO HAGO POR EL VALOR DISPONIBLE */
   if @w_monto_disp >= @w_val_xemb begin
      select @w_val_emb = @w_val_xemb
   end else begin
      select @w_val_emb = @w_monto_disp
   end

   /* PIDO UN CODIGO DE CLIENTE EXTERNO PARA EL JUZGADO */
   exec @w_error = cobis..sp_cseqnos
   @i_tabla = 'pf_cliente_externo',
   @o_siguiente = @w_cod_aut out

   if @w_error <>  0 goto ERROR_CUR
   
   select @w_cod_aut = isnull(@w_cod_aut, 1)

   insert into pf_cliente_externo(
   ce_secuencial, ce_nombre,     ce_cedula,
   ce_direccion      )
   values(
   @w_cod_aut,    @w_autoridad,  ' ',
   '*JUZ*'   )

   if @@error <> 0 begin
      select @w_error = 143055
      goto ERROR_CUR
   end

   update pf_bloqueo_legal set
   bl_valor_int_embgdo_aplicado = isnull(bl_valor_int_embgdo_aplicado, 0) + @w_val_emb
   where bl_operacion  = @i_operacion
   and   bl_secuencial = @w_secuencial

   if @@error <> 0 begin
      select @w_error = 145046
      goto ERROR_CUR
   end

   
   select  @w_porcentaje = (@w_val_emb/@i_monto_int) * 100
   
   /* INSERCION DETALLE DE PAGO INTERESES */
   select @w_sec = isnull(max(dp_secuencia), 0) + 1
   from   pf_det_pago
   where  dp_operacion = @i_operacion

   if @i_fpago = 'PER'
   	select @w_tipo = 'INT'
   else
   	select @w_tipo = 'INTV'
      
   insert into pf_det_pago(
   dp_operacion,       dp_secuencia,       dp_ente,           
   dp_forma_pago,      dp_tipo,            dp_moneda_pago,     
   dp_monto,           dp_porcentaje,      dp_estado_xren,    
   dp_estado,          dp_fecha_crea,      dp_fecha_mod,      
   dp_descripcion,     dp_oficina,         dp_tipo_cliente,    
   dp_benef_chq      )
   values(
   @i_operacion,       @w_sec,             @w_cod_aut,--@i_ente,
   @w_pg_juz,          @w_tipo,              @i_moneda,
   @w_val_emb,         @w_porcentaje,      'N',
   'I',                @s_date,            @s_date,
   @w_autoridad,       @w_oficina,         'E',
   convert(varchar, @w_cod_aut)+';')
   
   if @@error <> 0 begin
      select @w_error = 143038
      goto ERROR_CUR
   end


   select @w_monto_disp = @w_monto_disp - @w_val_emb

   if @w_monto_disp <= 0 
   begin
		close cur_bloqueo
		deallocate cur_bloqueo
		goto SIGUIENTE1 
   end
   		
   goto SIGUIENTE
   
   ERROR_CUR:
   close cur_bloqueo
   deallocate cur_bloqueo
   goto ERROR

   SIGUIENTE:
   fetch cur_bloqueo into
   @w_secuencial,
   @w_val_int,
   @w_val_apl,
   @w_val_xemb,
   @w_autoridad,
   @w_oficina
end --CURSOR cur_bloqueo

close cur_bloqueo
deallocate cur_bloqueo

SIGUIENTE1:


/* SI SOBRA ALGO GENERO UN VXP PARA EL CLIENTE */
if @w_monto_disp > 0 begin
   select  @w_porcentaje = (@w_monto_disp/@i_monto_int) * 100
   
   /* INSERCION DETALLE DE PAGO INTERESES */
   select @w_sec = isnull(max(dp_secuencia), 0) + 1
   from   pf_det_pago
   where  dp_operacion = @i_operacion

   insert into pf_det_pago(
   dp_operacion,       dp_secuencia,       dp_ente,           
   dp_forma_pago,      dp_tipo,            dp_moneda_pago,     
   dp_monto,           dp_porcentaje,      dp_estado_xren,    
   dp_estado,          dp_fecha_crea,      dp_fecha_mod,      
   dp_descripcion,     dp_oficina,         dp_tipo_cliente,    
   dp_benef_chq      )
   values(
   @i_operacion,       @w_sec,             @i_ente,
   @w_pg_cli,          'INT',              @i_moneda,
   @w_monto_disp,      @w_porcentaje,      'N',
   'I',                @s_date,            @s_date,
   @i_nomlar,          @i_oficina,         'M',
   convert(varchar, @i_ente)+';')
   
   if @@error <> 0 begin
      select @w_error = 143038
      goto ERROR
   end
end

ERROR:
return @w_error
go


