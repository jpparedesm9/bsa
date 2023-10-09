/************************************************************************/
/*   Archivo:              camestma.sp                                  */
/*   Stored procedure:     sp_cambio_estado_manual                      */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Credito y Cartera                            */
/*   Disenado por:         Fabian de la Torre                           */
/*   Fecha de escritura:   31/08/1999                                   */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA".                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                               PROPOSITO                              */
/*   Maneja los cambios de estado manuales definidos en las operaciones */
/************************************************************************/
/*                              CAMBIOS                                 */
/*      FECHA          AUTOR            CAMBIO                          */
/*      DIC-07-2016    Raul Altamirano  Emision Inicial - Version MX    */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_cambio_estado_manual')
   drop proc sp_cambio_estado_manual
go

create proc sp_cambio_estado_manual
(  @s_user           login,
   @s_term           varchar(30),
   @s_date           datetime,
   @s_ofi            smallint,
   @i_toperacion     catalogo,
   @i_oficina        smallint,
   @i_banco          cuenta,
   @i_operacionca    int,
   @i_moneda         tinyint,
   @i_fecha_proceso  datetime,
   @i_en_linea       char(1),
   @i_gerente        smallint,
   @i_estado_ini     tinyint,
   @i_estado_fin     tinyint,
   @i_moneda_nac     smallint
) 

as 
declare
   @w_return            int,
   @w_secuencial        int,
   @w_error             int,
   @w_estado_fin        tinyint,
   @w_est_castigo       tinyint,
   @w_trn               catalogo,
   @w_gar_admisible     char(1), 
   @w_reestructuracion  char(1), 
   @w_calificacion      char(1), 
   @w_tr_observacion    descripcion,
   @w_op_moneda         tinyint,
   @w_est_anulado       smallint


-- CARGAR VARIABLES DE TRABAJO
select @w_trn           = 'ETM', --ETM (CAMBIO DE ESTADO MANUAL) --CAS (CASTIGOS) 
       @w_secuencial    = 0,
       @w_tr_observacion = 'CAMBIO DE ESTADO MANUAL'


--CARGAR ESTADOS POSIBLES ESTADOS MANUALES: SOLO CASTIGADO Y ANULADO
exec @w_error = sp_estados_cca
@o_est_castigado  = @w_est_castigo   out,
@o_est_anulado    = @w_est_anulado   out
       

-- DATOS DE LA OPERACION
select @w_gar_admisible     = op_gar_admisible,    
       @w_reestructuracion  = op_reestructuracion, 
       @w_calificacion      = op_calificacion,     
       @w_op_moneda         = op_moneda
from   ca_operacion
where  op_operacion = @i_operacionca

-- CONDICION DE SALIDA
if @i_estado_fin is null 
   return 0

if @i_estado_ini = @i_estado_fin
   return 0


select @w_estado_fin = @i_estado_fin   


if @w_estado_fin = @w_est_castigo
begin
   exec @w_error   = sp_cambio_estado_castigo
   @s_user         = @s_user,
   @s_term         = @s_term,
   @i_operacionca  = @i_operacionca

   if @w_error <> 0 
   begin
      PRINT 'Error ejecutando sp  sp_cambio_estado_castigo  @i_operacionca  ' + cast (@i_operacionca as varchar)
      return 708201
   end
end
else 
begin
    update ca_operacion
    set    op_estado    = @w_estado_fin
    where  op_operacion = @i_operacionca

    if @@error <> 0 return 710003
       
    if @w_estado_fin != @w_est_anulado
    begin   
        insert into ca_transaccion
                 (tr_secuencial,       tr_fecha_mov,    tr_toperacion,
                  tr_moneda,           tr_operacion,    tr_tran,
                  tr_en_linea,         tr_banco,        tr_dias_calc,
                  tr_ofi_oper,         tr_ofi_usu,      tr_usuario,
                  tr_terminal,         tr_fecha_ref,    tr_secuencial_ref,
                  tr_estado,           tr_gerente,      tr_gar_admisible,   
                  tr_reestructuracion, tr_calificacion, tr_observacion,    
                  tr_fecha_cont,       tr_comprobante)
         values(@w_secuencial,         @s_date,         @i_toperacion,
                  @i_moneda,           @i_operacionca,  @w_trn,
                  @i_en_linea,         @i_banco,        0,
                  @i_oficina,          @s_ofi,          @s_user,
                  @s_term,             @i_fecha_proceso,   0,
                  'NCO',               @i_gerente,      isnull(@w_gar_admisible,''),
                  isnull(@w_reestructuracion,''),       isnull(@w_calificacion,''),   @w_tr_observacion,  
                  @s_date,             0)      
        
        if @@error <> 0 return 710003
    end   
end


return 0

go

