/************************************************************************/
/*      Archivo:                cu_macust.sp                            */
/*      Stored procedure:       sp_maestro_custodia                     */
/*      Base de datos:          cob_custodia                            */
/*      Producto:               Garantias                               */
/*      Disenado por:           Iván Jiménez.                           */
/*      Fecha de escritura:     06/Oct/2006                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes  exclusivos  para el  Ecuador  de la   */
/*      "NCR CORPORATION".                                              */
/*      Su  uso no autorizado  queda expresamente  prohibido asi como   */
/*      cualquier   alteracion  o  agregado  hecho por  alguno de sus   */
/*      usuarios   sin el debido  consentimiento  por  escrito  de la   */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa permite generar el archivo maestro de garantías   */
/*      en custodia                                                     */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*         FECHA              AUTOR                  RAZON              */
/*      06/Oct/2006       Iván Jiménez.          Emision Inicial        */
/*		19/Oct/2016		  Nolbderto Vite		 Migracion Cobis Cloud	*/
/************************************************************************/
use cob_custodia 
go

if exists (select 1 from sysobjects where name = 'sp_maestro_custodia')
   drop proc sp_maestro_custodia
go


create proc sp_maestro_custodia(
   @i_fecha_proceso   datetime,
   @i_tipo            catalogo
)
as
declare
   
   @w_mc_regional         int,
   @w_mc_oficina          smallint,
   @w_mc_desc_oficina     varchar(64),
   @w_mc_id_cliente       varchar(30),
   @w_mc_cliente          int,
   @w_mc_nom_cliente      varchar(40),
   @w_mc_operacion        varchar(24),
   @w_mc_valor_des        money,
   @w_mc_f_desemb         varchar(10),
   @w_mc_tipo             catalogo,
   @w_mc_codigo_externo   varchar(64),
   @w_mc_depend_destino   catalogo,
   @w_mc_f_envio          varchar(10),
   @w_mc_f_recep          varchar(10),
   @w_mc_estado           char(3),
   @w_mc_f_estado         datetime,
   @w_mc_dias             int,
   @w_mc_usuario          login,
   @w_sp_name			  varchar (32),
   @w_error         	  int,
   @w_msg				  varchar(132)

select	@w_sp_name = 'sp_maestro_custodia'   
   
-- Borra la tabla de maestro de garantias
delete from cu_maestro_custodia


declare cur_garantias cursor for
select gc_oficina, gc_cliente,        gc_operacion, 
       gc_tipo,    gc_codigo_externo, gc_depend_destino, 
       gc_estado,  gc_usuario,        gc_fecha_modif
from   cu_garantias_custodia, cu_custodia
where  gc_codigo_externo = cu_codigo_externo
and    gc_depend_origen  = @i_tipo
and    cu_estado         = 'V'
for read only

open cur_garantias
fetch cur_garantias into
   @w_mc_oficina,    @w_mc_cliente,          @w_mc_operacion,
   @w_mc_tipo,       @w_mc_codigo_externo,   @w_mc_depend_destino,
   @w_mc_estado,     @w_mc_usuario,          @w_mc_f_estado

while @@fetch_status = 0
begin
   if @@fetch_status = -1
   begin
      select @w_error = 21000 --Error en cursor
	  select @w_msg = 'Error en cursor'
      close cur_regional
      deallocate cur_regional
      goto ERROR
   end   

   -- Nombre de Oficina
   select @w_mc_desc_oficina = of_nombre
   from  cobis..cl_oficina
   where of_oficina = (@w_mc_oficina)

   -- Codigo de Regional
   select @w_mc_regional = convert(smallint,codigo_sib)
   from  cob_credito..cr_corresp_sib
   where tabla  = 'T21'
   and   codigo = (select convert(varchar,of_regional)
                   from   cobis..cl_oficina
                   where  of_oficina = @w_mc_oficina )
 
   -- Nombre e Identificación del Cliente
   select @w_mc_id_cliente  = en_ced_ruc,
          @w_mc_nom_cliente = en_nombre
   from  cobis..cl_ente
   where en_ente = @w_mc_cliente

   -- Valor Desembolsado, Fecha de desembolso
   select @w_mc_valor_des = op_monto, 
          @w_mc_f_desemb  = convert(varchar(10),op_fecha_liq,103)
   from  cob_cartera..ca_operacion
   where op_banco = @w_mc_operacion

	select @w_mc_valor_des = isnull(@w_mc_valor_des,0),
			 @w_mc_f_desemb  = isnull(@w_mc_f_desemb,'')

   -- Fecha de Envio a Custodia
   select @w_mc_f_envio = convert(varchar(10),min(hc_fecha),103)
   from  cu_historial_custodia
   where hc_dep_destino    = 'C'
   and   hc_estado         = 'GEN'
   and   hc_codigo_externo = @w_mc_codigo_externo

   -- Fecha de recepción en custodia
   select @w_mc_f_recep = convert(varchar(10),max(hc_fecha),103)
   from  cu_historial_custodia
   where hc_dep_origen     = 'C'
   and   hc_estado         = 'GRE'
   and   hc_codigo_externo = @w_mc_codigo_externo

   -- Dias entre la fecha de proceso y la del estado
   select @w_mc_dias = datediff(dd, @w_mc_f_estado ,@i_fecha_proceso)

   -- Insercion en Tabla Maestro de Garantias en Custodia
   insert into cu_maestro_custodia
      (mc_regional,        mc_oficina,          mc_desc_oficina,  mc_id_cliente, mc_cliente,
       mc_nom_cliente,     mc_operacion,        mc_valor_des,     mc_f_desemb,   mc_tipo,
       mc_codigo_externo,  mc_depend_destino,   mc_f_envio,       mc_f_recep,    mc_estado,
       mc_f_estado,        mc_dias,             mc_usuario)
   values
      (@w_mc_regional,       @w_mc_oficina,        @w_mc_desc_oficina,  @w_mc_id_cliente, @w_mc_cliente,
       @w_mc_nom_cliente,    @w_mc_operacion,      @w_mc_valor_des,     @w_mc_f_desemb,   @w_mc_tipo,
       @w_mc_codigo_externo, @w_mc_depend_destino, @w_mc_f_envio,       @w_mc_f_recep,    @w_mc_estado,
       convert(varchar(10),@w_mc_f_estado,103),    @w_mc_dias,          @w_mc_usuario)


   fetch cur_garantias into
      @w_mc_oficina,    @w_mc_cliente,          @w_mc_operacion,
      @w_mc_tipo,       @w_mc_codigo_externo,   @w_mc_depend_destino,
      @w_mc_estado,     @w_mc_usuario,          @w_mc_f_estado 

end --@@fetch_status = 0
close cur_garantias
deallocate cur_garantias

return 0

ERROR:
   exec cobis..sp_cerror
        @t_debug  = 'N',
        @t_file   = null,
        @t_from   = @w_sp_name,
        @i_num    = @w_error,
	    @i_msg 	  = @w_msg
   return @w_error 

go