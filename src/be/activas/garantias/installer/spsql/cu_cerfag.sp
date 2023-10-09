/************************************************************************/
/*	Archivo:        	cu_certfag.sp                           */
/*	Stored procedure:       sp_certifica_fag                 	*/
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               Credito               		        */ 
/*	Disenado por:           Elkin Latorre.                      	*/
/*	Fecha de escritura:     Mayo 16 del 2005              		*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa  permite almacenar los datos para el reporte      */
/*      de cada oficina sobre el número de certificado que ha sido      */
/*      asignado a cada obligación por el FAG.                          */
/************************************************************************/
/*				MODIFICACIONES	                        */
/*	FECHA		AUTOR		        RAZON			*/
/*  16/May/2005	     E. Latorre          Emision Inicial                */
/*  18/Oct/2016	     J. Salazar          Migracion Cobis Cloud          */
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_certifica_fag')
    drop proc sp_certifica_fag
go
create proc sp_certifica_fag
(
   @i_fecha_ini          datetime    = null, 
   @i_fecha_fin          datetime    = null
   )
as

declare
   @w_today               datetime,     /* fecha del dia */ 
   @w_return              int,          /* valor que retorna */
   @w_sp_name             varchar(32),  /* nombre stored proc*/
   @w_existe              tinyint,      /* existe el registro*/
   @w_matriz              int,
   @w_d_prorr             int ,
   @w_mensaje             varchar(255), 
   @w_error               int,
   @w_error_act           int,
   @w_tipo_esp            varchar(30),
   @w_codpag              varchar(30),
   @w_parnorma            varchar(30),
   @w_sesion              int,
   @w_operacion           int,
   @w_fecha_vto_1cap      datetime,
   @w_fecha_red           datetime,
   @w_periodo             int,
   @w_tdiv                catalogo,
   @w_oficina             smallint

   select @w_sp_name = 'sp_certifica_fag'


   if exists(select 1 from sysobjects o, syspartitions p where o.id = p.id and   o.name = 'cu_certfag')   
     -- alter table cu_certfag unpartition

   truncate table cu_certfag

   --alter table cu_certfag partition 200

   
   -- CREACION DE TABLA TEMPORAL DE INSPECTORES --
   create table #cu_tipos
   ( tipo           varchar(64) null
   )
   

------------------
-- Asignaciones --
------------------


-- garantia FAG --
select @w_tipo_esp = pa_char
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'FAG'
set transaction isolation level READ UNCOMMITTED


-- pagare de cartera --
select @w_codpag   = pa_char
from   cobis..cl_parametro
where  pa_producto = 'GAR'
and    pa_nemonico = 'CODPAG'

-- norma legal --    
select @w_parnorma   = pa_char
from   cobis..cl_parametro
where  pa_producto   = 'CRE'
and    pa_nemonico   = 'NLLF'


insert into #cu_tipos
select 	tc_tipo  
from 	cob_custodia..cu_tipo_custodia
where 	tc_tipo 		    = @w_tipo_esp
union
select 	tc_tipo 
from 	cob_custodia..cu_tipo_custodia
where 	tc_tipo_superior 	= @w_tipo_esp
union
select 	tc_tipo
from 	cob_custodia..cu_tipo_custodia
where 	tc_tipo_superior in (select 	tc_tipo 
			      from cob_custodia..cu_tipo_custodia
			      where tc_tipo_superior = @w_tipo_esp)



declare cur_regional cursor for
select  of_oficina  
from    cobis..cl_oficina
where of_oficina > 0

for     read only
    
open    cur_regional
fetch   cur_regional into @w_oficina

while @@fetch_status = 0
begin
   insert into cu_certfag
select op_operacion,
       null,
       op_oficina,  
       op_banco,  
       op_codigo_externo,
       op_fecha_liq,
       op_cliente,
       op_nombre,
       null,
       op_monto,
       cu_num_dcto,
       gp_porcentaje,
       null,
       op_destino,   
       null,
       op_plazo,
       null,
       op_tplazo,
       op_tdividendo, 
       cu_estado,
       op_tramite ,
	gp_tramite     
   from   cob_cartera..ca_operacion, cob_credito..cr_tramite, cob_credito..cr_gar_propuesta, cob_custodia..cu_custodia
   where op_fecha_liq between  @i_fecha_ini and @i_fecha_fin
   and op_oficina = @w_oficina
   and tr_op_redescuento = op_operacion
   and gp_tramite = tr_tramite
   and gp_garantia = cu_codigo_externo
   and cu_tipo in (select tipo from #cu_tipos)
   and cu_estado in ('V','P','F','X')   


   fetch   cur_regional into @w_oficina
end

close cur_regional

----------------------------------------------
-- 	Actualización de los campos adicionales --
----------------------------------------------

--	Numero del pagare, certificado y estado de la garantía
update cu_certfag
set    ce_pagare  = cu_codigo_externo
from   cob_credito..cr_gar_propuesta, cob_custodia..cu_custodia, cob_cartera..ca_operacion
where  cu_codigo_externo = gp_garantia
and    cu_estado in ('V','X','F','P')
and    cu_tipo      = @w_codpag
and    gp_tramite   = op_tramite
and    op_tramite   = ce_tram_act    
and    ce_operacion > 0
and    ce_tramite > 0







-- 	Norma legal
update cu_certfag
set    ce_norma = case charindex('-',dt_valor)
                  when 0 then dt_valor
                  else   rtrim(substring(rtrim(dt_valor), 1, charindex('-',dt_valor)-1))
                  end
from   cob_credito..cr_datos_tramites
where  dt_dato    = @w_parnorma
and    dt_tramite = ce_tramite
and    ce_operacion > 0
and    ce_tramite > 0


--	Plazo
update cu_certfag
set    ce_plazo = (ce_teplazo * td_factor)/30  
from   cob_cartera..ca_tdividendo
where  td_tdividendo  = ce_tplazo
and    ce_operacion > 0
and    ce_tramite > 0


-- Regional
update cu_certfag
set    ce_regional = of_regional
from   cobis..cl_oficina
where  of_oficina = ce_oficina
and    ce_operacion > 0
and    ce_tramite > 0


--	Periodo de gracia
 declare cur_periodo cursor for
         select  ce_operacion,
                 ce_fecha_red,
                 ce_tdiv
         from    cu_certfag
         FOR UPDATE
         

 open    cur_periodo
 fetch   cur_periodo into 
 @w_operacion,
 @w_fecha_red,
 @w_tdiv



 while @@fetch_status = 0
       begin
          if @@fetch_status = -1
          begin
             close cur_periodo
             deallocate cur_periodo
             select @w_error = 21000
             goto ERROR
          end

           SELECT @w_fecha_vto_1cap = min(di_fecha_ven)
           FROM   cob_cartera..ca_amortizacion, cob_cartera..ca_dividendo
           WHERE  am_operacion = @w_operacion
           and    am_concepto = 'CAP'
           and    am_cuota > 0
           and    am_operacion = di_operacion
           and    am_dividendo = di_dividendo


           select @w_periodo = datediff (mm, @w_fecha_red, @w_fecha_vto_1cap)
           from   cob_cartera..ca_tdividendo
           where  td_tdividendo  = @w_tdiv


           update cu_certfag
           set ce_periodo = @w_periodo
           Where current of cur_periodo
    
            

      fetch cur_periodo into   
       @w_operacion,
       @w_fecha_red,
       @w_tdiv



 end -- end while
close cur_periodo
deallocate cur_periodo

return 0

ERROR:
exec cobis..sp_cerror
     @t_debug  = 'N',
     @t_file   = null,
     @t_from   = @w_sp_name,
     @i_num    = @w_error
return @w_error

go



