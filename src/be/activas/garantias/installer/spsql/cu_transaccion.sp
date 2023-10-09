/************************************************************************/
/*	Archivo:            cu_transaccion.sp                               */
/*	Stored procedure:   sp_transaccion                                  */
/*	Base de datos:      cob_custodia                                    */
/*	Producto:           Garantias                                       */
/*	Disenado por:       RRB                                             */
/*	Fecha de escritura:	Jun 2011                                        */
/************************************************************************/
/*                             IMPORTANTE                               */
/*  Este programa es parte de los paquetes bancarios propied            */
/*  " MACOSA ", representantes exclusivos para el Ecuador               */
/*  " NCR CORPORATION ".                                                */
/*  Su uso no autorizado queda expresamente prohibido asi               */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/  
/*                              PROPOSITO                               */
/*  Genera las trasnacciones de cambios de estado de las garantias      */
/************************************************************************/  
/*                             MODIFICACIONES                           */
/*  Enero-2012    Luis Carlos Moreno   RQ293-incluir el estado cancelado*/
/*                                     de la obligacion en la consulta  */
/*                                     para la consulta de la garantia  */
/************************************************************************/  

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_transaccion')
   drop proc sp_transaccion
go

create proc sp_transaccion
@s_date                datetime    = null,
@s_user                login       = null,
@s_term                descripcion = null,
@i_codigo_externo      cuenta      = null,
@i_estado_fin          char(1)     = null,
@i_estado_gar          char(1)     = null,
@i_tipo_tran           varchar(3)  = null, -- 'EST' -> (Cambio de Estado) --  'CRE' -> Paso de (P - F) -- 'ACT' - (Vigente) 
@i_banderabe           char(1)     = null,
@i_valor               money       = null,
@i_valor_ant           money       = null

as declare

@w_valor               money,
@w_clase_custodia      char(1),
@w_agotada             char(1),
@w_codvalor            smallint,
@w_secuencial          int,
@w_clase_cartera       catalogo,
@w_calificacion        char(1),
@w_oficina_contabiliza int,
@w_hora                varchar(8),
@w_descripcion         varchar(64),
@w_sp_name             varchar(32),
@w_error               int,
@w_cod_colateral       catalogo,
@w_colateral           char(1),
@w_valor_cont          money

select 
@w_sp_name = 'sp_transaccion', @w_oficina_contabiliza = 0

/*PARAMETRO DE LA GARANTIA DE FNGD*/
select @w_cod_colateral = pa_char
from cobis..cl_parametro 
where pa_nemonico = 'COFIAD'
and   pa_producto = 'GAR'

-- Validacion Cambios Estados
if @i_estado_gar = 'P' and @i_estado_fin = 'A' begin -- Si cambio de estado de Propuesta a Anulada no Contabiliza
   return 0
end

if exists (select 1 from cu_tipo_custodia, cu_custodia
           where tc_tipo_superior in (select tc_tipo from cu_tipo_custodia where tc_tipo_superior = @w_cod_colateral)
           and   tc_tipo = cu_tipo
           and   cu_codigo_externo = @i_codigo_externo)
           
   select @w_colateral = 'S'
else
   select @w_colateral = 'N'
   

-- Obtención de características para generar la Transacción

if isnull(@i_valor,0) = 0 
   select @w_valor          = case @w_colateral when 'N' then cu_valor_inicial when 'S' then cu_valor_actual end,
          @w_clase_custodia = cu_clase_custodia,
          @w_agotada        = cu_agotada
   from   cu_custodia
   where  cu_codigo_externo = @i_codigo_externo 
else
   select @w_valor = @i_valor,
          @w_clase_custodia = cu_clase_custodia,
          @w_agotada        = cu_agotada
   from   cu_custodia
   where  cu_codigo_externo = @i_codigo_externo 
   
-- Definición del Código Valor

if @i_estado_fin = 'F' begin
   if @w_clase_custodia = 'I'
      select @w_codvalor = 21
   if @w_clase_custodia = 'O'
      select @w_codvalor = 41
end 
  
if @i_estado_fin = 'V' and @w_agotada = 'N' begin
   if @w_clase_custodia = 'I'
      select @w_codvalor = 22  
   if @w_clase_custodia = 'O'
      select @w_codvalor = 42  
end

if @i_estado_fin = 'V' and @w_agotada = 'S' begin 
   if @w_clase_custodia = 'I'
      select @w_codvalor = 23  
   if @w_clase_custodia = 'O'
      select @w_codvalor = 43  
end

if @i_estado_fin = 'X' and @w_agotada = 'N' begin
   if @w_clase_custodia = 'I'
      select @w_codvalor = 24  
   if @w_clase_custodia = 'O'
      select @w_codvalor = 44  
end

if @i_estado_fin = 'X' and @w_agotada = 'S' begin 
   if @w_clase_custodia = 'I'
      select @w_codvalor = 25  
   if @w_clase_custodia = 'O'
      select @w_codvalor = 45  
end

if @i_estado_fin = 'C' and @w_agotada = 'N' begin 
   if @w_clase_custodia = 'I'
      select @w_codvalor = 26  
   if @w_clase_custodia = 'O'
      select @w_codvalor = 46  
   select @i_tipo_tran = 'CAN'
end

if @i_estado_fin = 'C' and @w_agotada = 'S' begin 
   if @w_clase_custodia = 'I'
      select @w_codvalor = 27  
   if @w_clase_custodia = 'O'
      select @w_codvalor = 47  
   select @i_tipo_tran = 'CAN'
end

if @i_estado_fin is null and @i_tipo_tran = 'VAL' begin

   select @i_estado_fin = @i_estado_gar
   
   if @w_agotada = 'S' begin
      if @w_clase_custodia = 'I'
         select @w_codvalor = 28  
      if @w_clase_custodia = 'O'
         select @w_codvalor = 48  
   end
   if @w_agotada = 'N' begin
      if @w_clase_custodia = 'I'
         select @w_codvalor = 29  
      if @w_clase_custodia = 'O'
         select @w_codvalor = 49 
   end    
end

exec @w_secuencial = sp_gen_sec
@i_garantia = @i_codigo_externo

select @w_clase_cartera       = op_clase,
       @w_calificacion        = isnull(op_calificacion, 'A'),
       @w_oficina_contabiliza = op_oficina
from cob_credito..cr_gar_propuesta with (nolock), 
     cob_credito..cr_tramite with (nolock),
     cob_cartera..ca_operacion with (nolock)
where gp_garantia    = @i_codigo_externo
and   gp_tramite     = op_tramite
and   gp_tramite     = tr_tramite
and   tr_tramite     = op_tramite
and   tr_estado     <> 'Z'
and   op_estado not in (6) --LCM

if @@rowcount = 0 begin --LCM
   if @i_banderabe = 'S'
      return 1901040
   else begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901040
      return 1901040
   end
end

select @w_hora                = convert(varchar(8),getdate(),108),
       @w_descripcion         = case @i_tipo_tran 
                                   when 'VAL' then 'Cambio V_Ant: ' + cast(@i_valor_ant as varchar) + ' a ' +  'V_Nue: ' + cast(@w_valor as varchar)
                                   else 'Cambio : ' + @i_estado_gar + ' a estado ' +  @i_estado_fin 
                                end
insert into cu_transaccion
(
tr_secuencial,          tr_codigo_externo,     tr_fecha_tran,
tr_hora,                tr_descripcion,        tr_usuario,
tr_terminal,            tr_tran,               tr_oficina_orig,
tr_oficina_dest,        tr_estado,             tr_estado_gar
)
values
(
@w_secuencial,          @i_codigo_externo,     @s_date,
@w_hora,                @w_descripcion,        @s_user,
@s_term,                @i_tipo_tran,          @w_oficina_contabiliza,
@w_oficina_contabiliza, 'I',                   @i_estado_fin)         

if @@error <> 0 begin
   if @i_banderabe = 'S'
      return 1901013
   else begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901013
      return 1901013
   end
end

if @i_tipo_tran = 'VAL' 
   select @w_valor_cont = @i_valor_ant * -1
else
   select @w_valor_cont = @i_valor_ant

insert into cu_det_trn(
dtr_secuencial,         dtr_codigo_externo,    dtr_codvalor, 
dtr_valor,              dtr_clase_cartera,     dtr_calificacion)
values (
@w_secuencial,          @i_codigo_externo,     @w_codvalor,
@w_valor,          @w_clase_cartera,      @w_calificacion)

if @@error <> 0 begin
   if @i_banderabe = 'S'
      return 1901012
   else begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901012
      return 1901012
   end
end

if @i_tipo_tran = 'VAL' begin -- Cambio de Valor egenra dos registros contables

  insert into cu_det_trn(
  dtr_secuencial,         dtr_codigo_externo,    dtr_codvalor, 
  dtr_valor,              dtr_clase_cartera,     dtr_calificacion)
  values (
  @w_secuencial,          @i_codigo_externo,     @w_codvalor,
  @w_valor_cont,           @w_clase_cartera,      @w_calificacion)
  
  if @@error <> 0 begin
     if @i_banderabe = 'S'
        return 1901012
     else begin
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1901012
        return 1901012
     end
  end
  
end

go