/************************************************************************/
/*      Archivo:                cr_migrag.sp                            */
/*      Stored procedure:       sp_migra_garantia                       */
/*      Base de datos:          cob_credito                             */
/*      Producto:               Credito                                 */
/*      Disenado por:           JLatorre                                */
/*      Fecha de escritura:     Abril 2002                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA"							*/
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Generar el cargue automatico de cdts como garantia idonea       */
/************************************************************************/

use cob_credito
go
if exists (select * from sysobjects where name = 'sp_migra_garantia')
   drop proc sp_migra_garantia
go

create proc sp_migra_garantia (
  @s_date       datetime,
  @i_tramite    int,
  @i_banco      char(24),
  @i_garantia   char(24),
  @i_cliente    int,
  @o_tiene_gar  int out
)

as


declare
   @w_garantia          varchar(64),
   @w_abierta           char(1),
   @w_est_garantia      char(1)


select @w_garantia = @i_garantia
/**************************************/
/* Verificar que no haya campos nulos */
/**************************************/

if @i_tramite is null or @i_banco is null or @i_cliente 
is null or @i_garantia is null
begin
   print "Error en datos de parametro, Campos con valores NULL"
   print "Tramite: %1!   Banco: %2!  Cliente: %3!"+ cast (@i_tramite as varchar) + cast(@i_banco as varchar) + cast (@i_cliente as varchar)
   return 1
end


/***************************************************//* Utilizar cursor para sacar datos de cliente_tmp */
/***************************************************/

   /*******************************************/
   /* Obtiene el tipo y estado de la garantia */
   /*******************************************/

   select
      @w_abierta = cu_abierta_cerrada,
      @w_est_garantia = cu_estado
   from
      cob_custodia..cu_custodia
   where
      cu_codigo_externo=@i_garantia

   if  (@w_abierta is null) or (@w_est_garantia is null)
    begin
      select @o_tiene_gar = 0
      return 1
    end
   else
    begin
     INSERT INTO cr_gar_propuesta
     (gp_tramite,
      gp_garantia,
      gp_clasificacion,
      gp_exceso,
      gp_monto_exceso,
      gp_abierta,
      gp_deudor,
      gp_est_garantia,     
      gp_fecha_mod)        /*emg pendiente definir contenido de los campos gp_porcentaje,gp_valor_resp_garantia,gp_proceso*/
     VALUES (
      @i_tramite,
      @w_garantia,
      'a',
      null,
      0,
      @w_abierta,
      @i_cliente,
      @w_est_garantia,
      @s_date
     )
  end


return 0



