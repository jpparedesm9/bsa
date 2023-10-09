/************************************************************************/
/*      Archivo:                estados.sp                              */
/*      Stored procedure:       sp_estados                              */
/*      Base de datos:          cob_custodia                            */
/*      Producto:               Garantias                               */
/*      Disenado por:           Laura Alvarado                          */
/*      Fecha de escritura:     05-May-1998                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                              PROPOSITO                               */
/*      Este programa obtiene los estados de las garantias definidos en */
/*      el sistema                                                      */
/************************************************************************/  
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      10-May_1998     L. Alvarado     Emision inicial                 */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_estados')
        drop proc sp_estados
go
create proc sp_estados (
                
                @i_operacion            char(1) = 'C',
                @i_cond1                catalogo = null,
                @i_cond2                catalogo = null,
                @t_trn                  smallint  = null
                        
)
as

declare
   @w_sp_name           varchar (32),
   @w_descestini        varchar (64),
   @w_descestfin        varchar (64),
   @w_estfin            char (1),
   @w_error             int

select  @w_sp_name = 'sp_estados'
   
if @i_operacion = 'M'  --Estados manuales
begin
   select
   B.eg_estado, B.eg_descripcion
   from cob_custodia..cu_cambios_estado, cob_custodia..cu_estados_garantia A, cob_custodia..cu_estados_garantia B
   where A.eg_estado = @i_cond1
    --and (B.eg_estado = 'A' or null <> '1'  )
    --and (B.eg_estado <> 'X' or null <> '2'  )
    --and (B.eg_estado = 'X' or null <> '3'  )
    and A.eg_estado = ce_estado_ini
    and ce_estado_fin = B.eg_estado
    and ce_tipo       = 'M'   -- JAR REQ 226
    order by B.eg_estado
    
   if @@rowcount = 0 begin
      select @w_error = 1
      goto ERROR
   end
end

if @i_operacion = 'V'
begin
   select @w_descestini = eg_descripcion
   from cu_estados_garantia
   where eg_estado = @i_cond1

   select @w_descestfin = eg_descripcion  
   from cu_estados_garantia
   where eg_estado = 'F'

   select @w_estfin = 'F'

   select
   @i_cond1,
   @w_estfin,
   @w_descestini,
   @w_descestfin
end

if @i_operacion = 'A'
begin
   select @w_descestini = eg_descripcion
   from cu_estados_garantia
   where eg_estado = @i_cond1

   select
   @i_cond1,
   @w_descestini
end   
 
return 0
ERROR:
if @w_error = 1 print 'No existen cambios de estado'
go
