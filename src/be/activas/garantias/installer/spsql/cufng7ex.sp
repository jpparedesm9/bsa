/******************************************************************/
/*  Archivo:            cufng7ex.sp                               */
/*  Stored procedure:   sp_fng_7_ex                               */
/*  Base de datos:      cob_custodia                              */
/*  Producto:           Custodia                                  */
/*  Disenado por:       Gabriel Alvis                             */
/*  Fecha de escritura: 22/Abr/2009                               */
/******************************************************************/
/*                          IMPORTANTE                            */
/*  Este programa es parte de los paquetes bancarios propiedad de */
/*  'MACOSA'                                                      */
/*  Su uso no autorizado queda expresamente prohibido asi como    */
/*  cualquier alteracion o agregado hecho por alguno de sus       */
/*  usuarios sin el debido consentimiento por escrito de la       */
/*  Presidencia Ejecutiva de MACOSA o su representante.           */
/******************************************************************/
/*                          PROPOSITO                             */
/*  Reemplazar al fng_7.sqr en funciones sirviendo de             */
/*  procedimiento cáscara en invocacion del SP                    */
/*  cob_credito..sp_asob                                          */
/******************************************************************/
/*                          MODIFICACIONES                        */
/*  FECHA       AUTOR       RAZON                                 */
/*  22/Abr/09   G. Alvis    Emision Inicial                       */
/******************************************************************/

use cob_custodia
go

if object_id('sp_fng_7_ex') is not null
   drop proc sp_fng_7_ex
go

create proc sp_fng_7_ex
   @i_param1   varchar(255) = null,
   @i_param2   varchar(255) = null
as

declare 
   @w_return      int,
   @i_fecha       datetime,
   @i_report      varchar(64)
   
select 
   @i_fecha      = convert(datetime,     @i_param1),  
   @i_report     = convert(varchar(64),  @i_param2)

if @i_report = '0'
   select @i_report = null
   
if object_id('cob_credito..cr_fng2_tmp') is not null
   drop table cob_credito..cr_fng2_tmp
   
create table cob_credito..cr_fng2_tmp(
   ref_archi            char(10),
   nit_inter            varchar(20),
   num_garantia         varchar(20),
   en_ced_ruc           varchar(16),
   ref_credito          varchar(18),
   cod_moneda           varchar(3),
   clif_robli           char(2),
   cam_reser            char(1),
   sal_fec_corte_infor  numeric(12, 0),
   sal_total_obli       numeric(12, 0),
   fecha_corte          char(8),
   num_cuotas_mora      int,
   fec_inicio_mora      char(8),
   fec_cancelacion      char(8)
)
      
exec @w_return = cob_credito..sp_asob
   @i_fecha      = @i_fecha,     
   @i_report     = @i_report
   
return @w_return
   
go
