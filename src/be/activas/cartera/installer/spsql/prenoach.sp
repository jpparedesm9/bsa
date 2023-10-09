/************************************************************************/
/*      Archivo:                prenoach.sp                             */
/*      Stored procedure:       sp_prenotificar_ach                     */
/*      Base de datos:          cob_compensacion                        */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Elcira Pelaez Burbano		        */
/*      Fecha de escritura:     Feb. 2001                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                              PROPOSITO                               */
/*      Insertar y borrar de ach_prenotificados                         */
/*      Evaluar la existencia de cliente y cuenta en ach_prenotificados */
/*      Operaciones:							*/
/*                    'E' esta operacion evalua la existencia en        */
/*                        ach_prenotificados y retorna '0' si no existe */
/*                        '1'  si existe                                */
/*                    'I' esta operacion inserta registros en           */
/*                        ach_prenotificados                            */
/*                    'D' esta operacion Elimina registros en           */
/*                        ach_prenotificados                            */
/************************************************************************/  
/*                              MODIFICACIONES                          */
/*                                                                      */
/************************************************************************/  
use cob_compensacion
go

if exists (select 1 from sysobjects where name = 'sp_prenotificar_ach')
	drop proc sp_prenotificar_ach
go
create proc sp_prenotificar_ach
   @s_user		varchar(14) = null,
   @s_ofi 		smallint    = null,
   @s_date              datetime    = null,
   @i_operacion         char(1)     = null,
   @i_cliente   	int         = null,
   @i_cuenta    	varchar(64) = null,
   @i_tipo_cuenta       char(2)     = null,
   @i_cod_banco         int         = null,
   @i_fecha_proceso     datetime    = null,
   @o_respuesta         char(1)     = null out


as
declare 
   @w_sp_name           	varchar(64),
   @w_return            	int,
   @w_error             	int,
   @w_nit                       varchar(64)

   
/* CARGAR VALORES INICIALES */
select @w_sp_name = 'sp_prenotificar_ach'

/** PARCHADO HASTA CUANDO SE DECIDA UTILIZAR -- JCQ -- 10/10/2002 **/
/**

if @i_operacion  = 'E'
begin

if not exists (select 1 from ach_prenotificados
   where pr_cliente = @i_cliente
     and pr_cuenta  = @i_cuenta) 
   begin
    select @o_respuesta = '0'
   end 
   else
   select @o_respuesta = '1'

end



if @i_operacion = 'I'
begin

select @w_nit = en_ced_ruc
   from cobis..cl_ente
where en_ente = @i_cliente
set transaction isolation level read uncommitted

if not exists (select 1 from ach_prenotificados
   where pr_cliente = @i_cliente
     and pr_cuenta  = @i_cuenta) 
   begin
    insert into ach_prenotificados values (@i_cliente,
                                           @w_nit,
                                           @i_cuenta,
                                           @i_tipo_cuenta,
                                           @i_fecha_proceso,
					   @i_cod_banco)
      if @@error <> 0 return 250001

   end 

end



if @i_operacion = 'D'
begin

  delete ach_prenotificados
  where pr_cliente = @i_cliente
    and pr_cuenta  = @i_cuenta
    and pr_codigo_banco = @i_cod_banco
    if @@error <> 0 return 250012


end

**/

return 0


go

