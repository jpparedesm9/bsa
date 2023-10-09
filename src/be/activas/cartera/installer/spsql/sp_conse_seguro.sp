/************************************************************************/
/*   Stored procedure:     sp_conse_seguro                              */
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
/************************************************************************/
/*                            CAMBIOS                                   */
/************************************************************************/
/*   5/DEC/2019    		 JCH		  EMISION INICIAL 		            */
/*  23/SEP/2020          DCU          Inc. #146406                      */
/*  16/JUN/2022          KVI          Req.185234-Op.C-Sol.Individual    */
/*  23/MAY/2023          LOG          Req.207662 Mod para leer campos   */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_conse_seguro')
   drop proc sp_conse_seguro
go

create proc sp_conse_seguro
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
@w_rowcount					int,
@w_plazo                    INT,
@w_producto                 VARCHAR(10),
@w_fecha_inicial            DATETIME

select @w_sp_name = 'sp_corresponsal_consulta'
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
	SELECT @w_plazo= (CASE WHEN op_tplazo = 'D' THEN ROUND(CONVERT(float,op_plazo)/30,0)
                  WHEN op_tplazo = 'W' THEN ROUND(CONVERT(float,op_plazo)/ 4,0)
                  WHEN op_tplazo = 'BW' THEN ROUND(CONVERT(float,op_plazo)/ 2,0)
                  WHEN op_tplazo = 'Q' THEN ROUND(CONVERT(float,op_plazo)/ 2,0)
                  WHEN op_tplazo = 'M' THEN ROUND(CONVERT(float,op_plazo),0)
                  WHEN op_tplazo = 'B' THEN ROUND(CONVERT(float,op_plazo) * 2,0)
                  WHEN op_tplazo = 'T' THEN ROUND(CONVERT(float,op_plazo) * 3,0)
                  WHEN op_tplazo = 'S' THEN ROUND(CONVERT(float,op_plazo) * 6,0)
             ELSE 1 END) , 
			 @w_producto = (CASE WHEN op_anterior IS NOT NULL THEN 'RENOVACION' ELSE op_toperacion END),
			 @w_fecha_inicial = op_fecha_ini
		FROM cob_cartera..ca_operacion 
			WHERE op_tramite = CONVERT(int, @i_tramite)

	    SELECT convert(varchar(15), tg_prestamo)+ ' - ' + 
           upper(isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') 
           + ' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,''))
           as 'nombre_cliente',
           p_fecha_nac = CONVERT(varchar, isnull(p_fecha_nac,''), 103),
        CONVERT(varchar, isnull(@w_fecha_inicial,''), 103) AS fecha_ini,
            CONVERT(varchar, isnull(
                DATEADD(MONTH, ISNULL(pm_plazo, 0), @w_fecha_inicial)
                ,''), 103) fecha_fin,
            pm_cobertura cobertura,
            pm_serv_medicos AS serv_medicos,
            pm_serv_checkup AS serv_checkup,
            pm_serv_dental AS serv_dental,
            pm_linea_embarazo AS linea_embarazo,
            pm_linea_diabetes AS linea_diabetes,
            pm_linea_violencia AS linea_violencia
    FROM cobis..cl_ente JOIN 
        cob_credito..cr_tramite_grupal 
            ON en_ente    = tg_cliente LEFT JOIN
        cob_cartera..ca_seguro_externo 
            ON en_ente = se_cliente AND tg_tramite = se_tramite
        LEFT JOIN cob_cartera..ca_plazo_asis_med 
            ON pm_plazo = @w_plazo AND pm_producto = @w_producto
    WHERE   
		en_ente    = @i_cliente
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
	where en_ente in  (2,4)-- @i_cliente
	
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
	IF OBJECT_ID('tempdb..##tmp_beneficios_seguros') IS NOT NULL DROP TABLE ##tmp_beneficios_seguros
	create table ##tmp_beneficios_seguros(	bs_cobertura  varchar(100),		bs_titular    varchar(300),	bs_pareja     varchar(90),	bs_hijos      varchar(90))
	insert into ##tmp_beneficios_seguros(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('SEGURO DE VIDA1','$20,000.00','','')
	insert into ##tmp_beneficios_seguros(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('SEGURO ANTICIPO POR ENFERMEDAD TERMINAL1','30% de anticipo por diagnóstico de enfermedad terminal','','')
	insert into ##tmp_beneficios_seguros(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('SEGURO POR PRIMER DIAGNÓSTICO DE CÁNCER2','$5,000.00','','')
	insert into ##tmp_beneficios_seguros(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('SEGURO POR PRIMER DIAGNÓSTICO DE INFARTO CARDÍACO2','$5,000.00','','')
	insert into ##tmp_beneficios_seguros(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('SEGURO POR PRIMER DIAGNÓSTICO DE DERRAME CEREBRAL2','$5,000.00','','')
	insert into ##tmp_beneficios_seguros(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('SALDO DEUDOR POR FALLECIMIENTO','$5,000.00','','')
	insert into ##tmp_beneficios_seguros(bs_cobertura,bs_titular,bs_pareja,bs_hijos) 
							  values('ASISTENCIA FUNERARIA COMPLETA3','Ataúd básico + Sala de velación + Arreglo y embalsamado del cuerpo + Traslado local del cuerpo + Carroza fúnebre + Asesoría telefónica para trámites legales + Cremación','','')		
	select top 1
	bs_cobertura as 'cobertura',
	bs_titular   as 'titulo',
	bs_pareja  	 as 'pareja',
	bs_hijos   	 as 'hijos'
	from ##tmp_beneficios_seguros
	
	if @w_rowcount = 0
	begin
		exec cobis..sp_cerror
			@t_debug  = 'N',
			@t_from   = @w_sp_name,
			@i_num    = 151172 --   No existen registros       
		return 151172  	
	end
end

----------------------------------------------
--informacion titular asegurado individual---
----------------------------------------------
IF(@i_operacion='C') -- Req.185234
    BEGIN
    -- Req.207662 Se cambian los JOIN para dar cardinalidad y se agregan los nuevos campos que se agregaron a la tabla
        SELECT 
            CONVERT(VARCHAR(15), op_banco)+ ' - ' + 
            UPPER(
                ISNULL(en_nombre,'') + ' ' +
                ISNULL(p_s_nombre,'') + ' ' +
                ISNULL(p_p_apellido,'') + ' ' + 
                ISNULL(p_s_apellido,'')) AS 'nombre_cliente',
            p_fecha_nac = CONVERT(VARCHAR, ISNULL(p_fecha_nac,''), 103),
            CONVERT(varchar, isnull(op_fecha_ini,''), 103) AS fecha_ini,
            CONVERT(varchar, isnull(
				DATEADD(MONTH, ISNULL(pm_plazo, 0),op_fecha_ini)
				,''), 103) fecha_fin,
            pm_cobertura cobertura,
            pm_serv_medicos AS serv_medicos,
            pm_serv_checkup AS serv_checkup,
            pm_serv_dental AS serv_dental,
            pm_linea_embarazo AS linea_embarazo,
            pm_linea_diabetes AS linea_diabetes,
            pm_linea_violencia AS linea_violencia
        FROM 
            cobis..cl_ente JOIN cob_credito..cr_tramite 
                ON en_ente    = tr_cliente 
            JOIN cob_cartera..ca_operacion 
                ON op_tramite = tr_tramite 
            LEFT JOIN cob_cartera..ca_seguro_externo 
                ON en_ente = se_cliente AND tr_tramite = se_tramite 
            LEFT JOIN cob_cartera..ca_plazo_asis_med 
                ON pm_plazo = se_plazo_asis_med AND tr_toperacion = pm_producto 
        WHERE 
            en_ente    = @i_cliente AND
            tr_tramite = CONVERT(INT, @i_tramite)

    END

RETURN 0

go