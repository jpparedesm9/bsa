/************************************************************************/
/*  Archivo:                sp_var_porcentaje_nuevos.sp                 */
/*  Stored procedure:       sp_var_porcentaje_nuevos                    */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 23/Abr/2018                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Determina el porcentaje de clientes nuevos con respecto a la         */
/* solicitud anterior                                                   */
/************************************************************************/
/*                    MODIFICACIONES                                    */
/*  FECHA         AUTOR                   RAZON                         */
/* 31/Ene/2019    S. Mosquera    Emision Inicial                        */
/* 29/Oct/2020    S. Rojas       Mejoras                                */
/* 30/Sep/2021    ACH            ERR#168924,se toma el parametro de ingr*/
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_porcentaje_nuevos')
	drop proc sp_var_porcentaje_nuevos
GO


CREATE PROC sp_var_porcentaje_nuevos
(@s_ssn          int         = null,
 @s_ofi          smallint    = null,
 @s_user         login       = null,
 @s_date         datetime    = null,
 @s_srv		     varchar(30) = null,
 @s_term	     descripcion = null,
 @s_rol		     smallint    = null,
 @s_lsrv	     varchar(30) = null,
 @s_sesn	     int 	       = null,
 @s_org		     char(1)     = NULL,
 @s_org_err      int 	       = null,
 @s_error        int 	       = null,
 @s_sev          tinyint     = null,
 @s_msg          descripcion = null,
 @t_rty          char(1)     = null,
 @t_trn          int         = null,
 @t_debug        char(1)     = 'N',
 @t_file         varchar(14) = null,
 @t_from         varchar(30)  = null,
 @i_id_inst_proc int,    --codigo de instancia del proceso
 @i_id_inst_act  int,    
 @i_id_asig_act  int,
 @i_id_empresa   int, 
 @i_id_variable  smallint 
 )
AS
DECLARE 
@w_sp_name       	varchar(32),
@w_tramite       	int,
@w_return        	INT,	
@w_valor_ant      	varchar(255),
@w_valor_nuevo    	varchar(255),
@w_actividad      	catalogo,
@w_grupo			int,
@w_ente             int,
@w_fecha			datetime,
@w_fecha_dif		DATETIME,
@w_ttramite         varchar(255),
@w_cont             int,
@w_promocion        char(1),
@w_max_externos     int,
@w_asig_act         int,
@w_numero           int,
@w_proceso			varchar(5),
@w_usuario			varchar(64),
@w_comentario		varchar(510),
@w_nombre           varchar(64),
@w_parte_1  		varchar(255),
@w_parte_2  		varchar(255),
@w_ciclo_grupal     int,
@w_num_tramite_ant  int,--numero de tramite anterior
@w_inte_nuevos       int,--numero de integrantes que se agregaron en este ciclo
@w_inte_tram_ant     int, --numero de integrantes del tramite anterior (definir anterior en funcion del ciclo)    
@w_porc_nuevos       int

select @w_sp_name='sp_var_porcentaje_nuevos'


select @w_grupo    = convert(int,io_campo_1),
	   @w_tramite  = convert(int,io_campo_3),
	   @w_ttramite = io_campo_4,
       @w_asig_act = convert(int,@i_id_asig_act)--io_campo_2
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_ciclo_grupal = isnull(gr_num_ciclo,0)+1
from cobis..cl_grupo
where gr_grupo = @w_grupo

select @w_tramite = isnull(@w_tramite,0)

if @w_tramite = 0 return 0

select @w_cont = 0 

/* Determinar si en grupo es promocion */
select @w_promocion = tr_promocion from cob_credito..cr_tramite where tr_tramite = @w_tramite
select @w_promocion = isnull(@w_promocion,'N')
select @w_valor_nuevo = 0
        print 'SMO INICIA PROCESO sp_var_porcentaje_nuevos @w_ttramite '+@w_ttramite+' @w_promocion '+@w_promocion+' @w_ciclo_grupal '+convert(varchar,@w_ciclo_grupal)

--select @w_parte_1 = 'ERROR EXCEDE EXPERIENCIA CREDITICIA: Grupo Promo excede integrantes con experiencia crediticia, los integrantes del grupo original son: '
--select @w_parte_2 = 'Los integrantes con solo experiencia crediticia son: '
--select @w_comentario = '' 

if @w_ttramite = 'GRUPAL' and @w_promocion = 'S' and @w_ciclo_grupal >= 2
begin 

        
     	select top 1 @w_num_tramite_ant = tg_tramite
     	from cob_credito..cr_tramite_grupal 
     	where tg_grupo = @w_grupo
        and tg_tramite <> @w_tramite
		order by tg_tramite desc
        
        print ' sp_var_porcentaje_nuevos @w_num_tramite_ant '+convert(varchar,@w_num_tramite_ant)
        
        select @w_inte_nuevos = count(1)
        from cob_credito..cr_tramite_grupal 
        where tg_tramite = @w_tramite
        and tg_participa_ciclo = 'S'
     and tg_cliente not in (select tg_cliente from cob_credito..cr_tramite_grupal where tg_tramite = @w_num_tramite_ant and tg_participa_ciclo = 'S')
        
        print ' sp_var_porcentaje_nuevos @w_inte_nuevos '+convert(varchar,@w_inte_nuevos)
        
        select @w_inte_tram_ant = count(1)
        from cob_credito..cr_tramite_grupal 
        where tg_tramite = @w_num_tramite_ant
        and tg_participa_ciclo = 'S'
        	
         print ' sp_var_porcentaje_nuevos @w_inte_tram_ant '+convert(varchar,@w_inte_tram_ant)
        
  
        select @w_porc_nuevos = convert(int,@w_inte_nuevos*100/@w_inte_tram_ant)
        
        
         print ' sp_var_porcentaje_nuevos @w_porc_nuevos '+convert(varchar,@w_porc_nuevos)
        
      	select @w_valor_nuevo = convert(varchar,@w_porc_nuevos)
end
else
begin
    select @w_valor_nuevo = 0 --solo para pruebas
end


-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
  update cob_workflow..wf_variable_actual
     set va_valor_actual = @w_valor_nuevo 
   where va_id_inst_proc = @i_id_inst_proc
     and va_codigo_var   = @i_id_variable    
end
else
begin
  insert into cob_workflow..wf_variable_actual
         (va_id_inst_proc, va_codigo_var, va_valor_actual)
  values (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo )

end
--print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc AND
                    mv_codigo_var= @i_id_variable AND
                    mv_id_asig_act = @i_id_asig_act)
BEGIN
    insert into cob_workflow..wf_mod_variable
           (mv_id_inst_proc, mv_codigo_var, mv_id_asig_act,
            mv_valor_anterior, mv_valor_nuevo, mv_fecha_mod)
    values (@i_id_inst_proc, @i_id_variable, @i_id_asig_act,
            @w_valor_ant, @w_valor_nuevo , getdate())
			
	if @@error > 0
	begin
            --registro ya existe
			
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file = @t_file, 
          @t_from = @t_from,
          @i_num = 2101002
    return 1
	end 

END

return 0
go

