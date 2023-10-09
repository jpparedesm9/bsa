/************************************************************************/
/*  Archivo:                sp_qr_ns_estado_cuenta.sp                   */
/*  Stored procedure:       sp_qr_ns_estado_cuenta                      */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 15/Feb/2018                                 */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*                          PROPOSITO                                   */
/* Permite insertar la informacion requerida para el envio de correo    */
/* y se puede saber si un correo fue generado o no para su envio        */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*   FECHA        AUTOR                   RAZON                         */
/* 29/01/2018    P. Ortiz    Emision Inicial                            */
/* 06/06/2019    PXSG        Estado de Cuenta LCR Req 115931            */
/* 05/08/2022    PXSG        #174670 Estado de cuenta Crédito simple    */
/* 09/08/2022    ACH         R#174670 Se agrega el tipo de operacion    */
/* **********************************************************************/

use cob_conta_super
go

if exists(select 1 from sysobjects where name ='sp_qr_ns_estado_cuenta')
	drop proc sp_qr_ns_estado_cuenta
go

create proc sp_qr_ns_estado_cuenta (
	@i_operacion	   char(1),
	@i_codigo 		   int 	= null,
	@i_estado		   char(1) = null, --archivosPDF: P Pendiente, D Generado(GRUPAL-INDIVIDUAL)-->>X Pendiente, G Generado(REVOLVENTE)
	@i_in_nombre_pdf   varchar(200) = null,
	@i_toperacion      varchar(10) = null  --GRUPAL - INDIVIDUAL - REVOLVENTE
)
AS

declare 
@w_cont_P  int,
@w_num_eje int


--Ejecucion del parametro de nuemro de ejecucones
select @w_num_eje  = pa_int 
from   cobis..cl_parametro 
where  pa_nemonico = 'NEJECU' 
and    pa_producto = 'REC'

--if es null el parametro asigno a 50

select @w_num_eje = isnull(@w_num_eje, 50)

--Devuelve una lista segun el parametro para iniciar con la generacion de archivos pdf
if @i_operacion = 'Q'
begin

   select @i_estado = isnull(@i_estado, 'P')

   select top (@w_num_eje)
   nec_codigo,
   nec_banco,
   convert(varchar(10), in_fecha_fin_mes,101),
   nec_correo,
   in_cliente_buc,
   convert(varchar(10), in_fecha_fin_mes,101)
   from sb_ns_estado_cuenta
   where nec_estado   = @i_estado
   and   in_met_fact  = 'PUE'
   and(( in_estd_timb = 'N' and @i_toperacion = 'INDIVIDUAL')
	 or (in_estd_timb  = 'S' and @i_toperacion = 'GRUPAL' ))
   and   in_toperacion = @i_toperacion
   order by nec_codigo
   
end

--Devuelve una lista segun el parametro para iniciar con la generacion de archivos pdf
--opcion que se usa en revolvente, por el caso 174670 para las revolventes se envia desde el java a la opcion Q y ya no la V
if @i_operacion = 'V'
begin
	
   select @i_estado = isnull(@i_estado, 'X')	
	
   select top (@w_num_eje)
   nec_codigo,
   nec_banco,
   convert(varchar(10), in_fecha_fin_mes,101),
   nec_correo,
   in_cliente_buc,
   convert(varchar(10), in_fecha_fin_mes,101)
   from sb_ns_estado_cuenta
   where nec_estado   = @i_estado
   and   in_met_fact  = 'PUE'
   and   in_estd_timb = 'S'
   and   in_toperacion = @i_toperacion
   order by nec_codigo
   
   if @@rowcount = 0 begin 
      return 1
   end
   
end

--Actualiza estado
if @i_operacion = 'U'
begin
	update sb_ns_estado_cuenta set
     in_nombre_pdf      = @i_in_nombre_pdf ,
	  nec_estado 	    = @i_estado
	 where nec_codigo 	= @i_codigo
 
end

if @i_operacion = 'A'
begin
	update sb_ns_estado_cuenta set
	 in_estado_pdf 	   = @i_estado
	 where nec_codigo  = @i_codigo
 
end

if @i_operacion = 'C'
begin
	update sb_ns_estado_cuenta set
	 in_estado_correo 	= @i_estado
	 where nec_codigo 	= @i_codigo
 
end

--GRUPALES - INDIVIDUALES / CORREO/PDF
if (@i_operacion = 'W' or @i_operacion = 'Y' )begin

	select top (@w_num_eje)
	nec_codigo,
	nec_banco,
	replace(convert(varchar, nec_fecha, 102), '.', ''),
	nec_correo,
	in_cliente_buc,
	rtrim(in_nombre_pdf),
	convert(varchar(10), in_fecha_fin_mes,101),
	in_grupo,
	in_nombre_cli
	from sb_ns_estado_cuenta
	where nec_estado = 'D'
	and in_toperacion = @i_toperacion
	and(( in_estado_correo = 'P' and   @i_operacion = 'W' )
	or (in_estado_pdf    = 'P' and   @i_operacion = 'Y' ))
	order by nec_codigo
	
   if @@rowcount = 0 begin 
      return 1
   end

end 

--REVOLVENTES  CORREO/PDF
if (@i_operacion = 'X' or @i_operacion = 'T' )begin

	select top (@w_num_eje)
	nec_codigo,
	nec_banco,
	replace(convert(varchar, nec_fecha, 102), '.', ''),
	nec_correo,
	in_cliente_buc,
	rtrim(in_nombre_pdf),
	convert(varchar(10), in_fecha_fin_mes,101),
	in_grupo,
	in_nombre_cli
	from sb_ns_estado_cuenta
	where nec_estado = 'G' 
	and(( in_estado_correo ='P' and   @i_operacion = 'X' )
	or (in_estado_pdf    ='P' and   @i_operacion = 'T' ))
	order by nec_codigo
	
   if @@rowcount = 0 begin 
      return 1
   end


end

return 0

go
