/************************************************************************/
/*   Stored procedure:     sp_conse_seguro_medico                       */
/*   Base de datos:        cob_cartera                                  */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/*  informacion para el reporte 1 Consentimiento de seguros TUIIO Seguro*/
/*	medico																*/
/************************************************************************/
/*                            CAMBIOS                                   */
/************************************************************************/
/*   5/DEC/2019  		 JCH		  EMISION INICIAL 		            */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_conse_seguro_medico')
   drop proc sp_conse_seguro_medico
go

create proc sp_conse_seguro_medico
(  @s_ssn              int          = null,
   @s_sesn             int          = null,
   @s_srv              varchar (30) = null,
   @s_lsrv             varchar (30) = null,
   @s_user             login        = null,
   @s_date             datetime     = null,
   @s_ofi              int          = null,
   @s_rol              tinyint      = null,
   @s_org              char(1)      = null,
   @s_term             varchar (30) = null,  
   @i_cliente   	   int          = null,
   @i_operacion        char(1)      = 'I',
   @i_tramite          varchar(10)  = null
)
as
declare 
@w_sp_name                  varchar(30),
@w_fecha_proceso            datetime,
@w_rowcount					int

select @w_sp_name = 'sp_conse_seguro_medico'
select @w_fecha_proceso = fp_fecha 
from cobis..ba_fecha_proceso

if(@i_cliente=null  and @i_cliente ='')
begin 
	exec cobis..sp_cerror
		 @t_debug  = 'N',
		 @t_from   = @w_sp_name,
		 @i_num    = 708150 --  CAMPO REQUERIDO ESTA CON VALOR NULO         
	return 708150    
end


-----------------------------------
--informacion  titular asegurado---
-----------------------------------
if(@i_operacion='I')
begin
	select convert(varchar(15), tg_prestamo)+ ' - ' +en_nomlar  as 'nombre_cliente',
		   p_fecha_nac = CONVERT(varchar, isnull(p_fecha_nac,''), 103)
	from cobis..cl_ente, cob_credito..cr_tramite_grupal
	where en_ente    = tg_cliente
	and   en_ente    = @i_cliente
	and   tg_tramite = convert(int, @i_tramite)
end

-----------------------------------
------declaracion beneficios ------
-----------------------------------
if(@i_operacion='B')
begin
	select 
	   nombre_cliente   = ' ',
	   fecha_nacimiento = ' ',
	   parentesco   	= ' ',
	   porcentage	  	= ' '						 
	from cobis..cl_ente
	where en_ente in  (5,6)-- @i_cliente
	
	if @w_rowcount = 0
	begin
		exec cobis..sp_cerror
			@t_debug  = 'N',
			@t_from   = @w_sp_name,
			@i_num    = 151172 --   No existen registros     
		return 151172  	
	end
end

-----------------------------------
------beneficios del seguro ad-----
-----------------------------------
--crear tabla y llenarla y regresarla
if(@i_operacion='S')
begin
	IF OBJECT_ID('tempdb..##tmp_beneficios_seguros_medico') IS NOT NULL DROP TABLE ##tmp_beneficios_seguros_medico
	create table ##tmp_beneficios_seguros_medico(	bs_cobertura  varchar(100),		bs_titular    varchar(300),	bs_pareja     varchar(90),	bs_hijos      varchar(90))
	insert into ##tmp_beneficios_seguros_medico(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('SEGURO DE VIDA1','$20,000.00','','')
	insert into ##tmp_beneficios_seguros_medico(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('SEGURO ANTICIPO POR ENFERMEDAD TERMINAL1','30% de anticipo por diagnóstico de enfermedad terminal','','')
	insert into ##tmp_beneficios_seguros_medico(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('SEGURO POR PRIMER DIAGNÓSTICO DE CÁNCER2','$5,000.00','','')
	insert into ##tmp_beneficios_seguros_medico(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('SEGURO POR PRIMER DIAGNÓSTICO DE INFARTO CARDÍACO2','$5,000.00','','')
	insert into ##tmp_beneficios_seguros_medico(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('SEGURO POR PRIMER DIAGNÓSTICO DE DERRAME CEREBRAL2','$5,000.00','','')
	insert into ##tmp_beneficios_seguros_medico(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('SALDO DEUDOR POR FALLECIMIENTO','$5,000.00','','')
	insert into ##tmp_beneficios_seguros_medico(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('ASISTENCIA FUNERARIA COMPLETA3','Ataúd básico + Sala de velación + Arreglo y embalsamado del cuerpo + Traslado local del cuerpo + Carroza fúnebre + Asesoría telefónica para trámites legales + Cremación','','')
	insert into ##tmp_beneficios_seguros_medico(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('MÉDICOS ESPECIALISTAS4','Pediatría + Gastroenterología + Urología + Ginecología + Otorrinolaringología + Limpieza dental + Descuentos en farmacias de red','','')
	insert into ##tmp_beneficios_seguros_medico(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('CHECK-UPS4','Química Sanguínea 12 Elementos + Biometría Hemática + EGO + Mastografía + Colposcopía + Antígeno Prostático +Perfil Hormonal Femenino/Masculino','','')							  
	select top 1
	bs_cobertura,
	bs_titular = case 
					when bs_cobertura='MÉDICOS ESPECIALISTAS4'  then SUBSTRING ( bs_titular , 1, 40) 
					else case when  bs_cobertura='CHECK-UPS4'   then SUBSTRING  ( bs_titular , 1, 32) else bs_titular end  
					
				end ,
	bs_pareja  = case 
					when bs_cobertura='MÉDICOS ESPECIALISTAS4'  then SUBSTRING ( bs_titular , 41, 56) 
					else case when  bs_cobertura='CHECK-UPS4'   then  SUBSTRING  ( bs_titular , 33, 56) else '' end  
				end ,
	bs_hijos   = case 
					when bs_cobertura='MÉDICOS ESPECIALISTAS4'  then SUBSTRING ( bs_titular , 97, 147) 
					else case when  bs_cobertura='CHECK-UPS4'   then  SUBSTRING  ( bs_titular , 88, 143) else '' end  
				end  
	from ##tmp_beneficios_seguros_medico
 


	
	if @w_rowcount = 0
	begin
		exec cobis..sp_cerror
			@t_debug  = 'N',
			@t_from   = @w_sp_name,
			@i_num    = 151172 --   No existen registros       
		return 151172  	
	end
end
return 0

go