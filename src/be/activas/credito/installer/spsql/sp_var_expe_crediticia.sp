/************************************************************************/
/*  Archivo:                sp_var_expe_crediticia.sp                   */
/*  Stored procedure:       sp_var_expe_crediticia                      */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 24/Abr/2017                                 */
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
/*  Permite determinar si los integrantes de un grupo promo tienen      */
/*  experiencia crediticia o es un emprededor                           */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA          AUTOR                   RAZON                        */
/*  24/Abr/2018    P. Ortiz    Emision Inicial                          */
/*  30/Sep/2021    ACH         ERR#168924,s toma el parametro de ingreso*/
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_expe_crediticia')
	drop proc sp_var_expe_crediticia
GO


CREATE PROC sp_var_expe_crediticia
		(@s_ssn        int         = null,
	     @s_ofi        smallint    = null,
	     @s_user       login       = null,
         @s_date       datetime    = null,
	     @s_srv		   varchar(30) = null,
	     @s_term	   descripcion = null,
	     @s_rol		   smallint    = null,
	     @s_lsrv	   varchar(30) = null,
	     @s_sesn	   int 	       = null,
	     @s_org		   char(1)     = NULL,
		 @s_org_err    int 	       = null,
         @s_error      int 	       = null,
         @s_sev        tinyint     = null,
         @s_msg        descripcion = null,
         @t_rty        char(1)     = null,
         @t_trn        int         = null,
         @t_debug      char(1)     = 'N',
         @t_file       varchar(14) = null,
         @t_from       varchar(30)  = null,
         --variables
		 @i_id_inst_proc int,    --codigo de instancia del proceso
		 @i_id_inst_act  int,    
		 @i_id_asig_act  int,
		 @i_id_empresa   int, 
		 @i_id_variable  smallint 
		 )
AS
DECLARE @w_sp_name       	varchar(32),
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
        @w_promocion        char(1),
        @w_asig_act         int,
        @w_numero           int,
        @w_proceso			varchar(5),
        @w_usuario			varchar(64),
        @w_comentario		varchar(255),
        @w_nombre           varchar(64),
        @w_exp_credit       varchar(1),
        @w_emprendedor      varchar(1)      
       

select @w_sp_name='sp_var_expe_crediticia'

select @w_grupo    = convert(int,io_campo_1),
	   @w_tramite  = convert(int,io_campo_3),
	   @w_ttramite = io_campo_4,
       @w_asig_act = convert(int,@i_id_asig_act)--io_campo_2
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc


select @w_tramite = isnull(@w_tramite,0)

if @w_tramite = 0 return 0


/* Determinar si en grupo es promocion */
select @w_promocion = tr_promocion from cob_credito..cr_tramite where tr_tramite = @w_tramite
select @w_promocion = isnull(@w_promocion,'N')

select @w_comentario = 'ERROR EXPERIENCIA CREDITICIA: No se admiten en el Grupo Promo emprendedores o miembros sin experiencia crediticia.' 

select @w_proceso = pa_int from cobis..cl_parametro where pa_nemonico = 'OAA'

if (@w_promocion = 'S')
begin 
    if @w_ttramite = 'GRUPAL'
    begin
        
      	select @w_ente = 0
    	while 1 = 1
    	begin
    	    
            select top 1 @w_ente        = cg_ente,
                        @w_emprendedor  = isnull(nc_emprendedor, 'N')
            from cobis..cl_cliente_grupo, cob_credito..cr_tramite_grupal, cobis..cl_negocio_cliente
            where cg_grupo = @w_grupo
            and tg_tramite = @w_tramite
            and cg_grupo = tg_grupo
            and tg_cliente = cg_ente
            and nc_ente  = tg_cliente 
            and tg_participa_ciclo = 'S'
            and cg_estado = 'V'
            and cg_ente > @w_ente
            order by cg_ente asc
            
            IF @@ROWCOUNT = 0
              BREAK
            
            
            exec cob_credito..sp_var_experiencia_crediticia
            @i_id_cliente   =   @w_ente,
            @o_resultado    =   @w_exp_credit output
            
            if ((@w_exp_credit = 'N') or (@w_emprendedor = 'S'))
            begin
                
                delete cob_workflow..wf_observaciones 
                where ob_id_asig_act = @w_asig_act
                and ob_numero in (select ol_observacion from  cob_workflow..wf_ob_lineas 
                where ol_id_asig_act = @w_asig_act 
                and ol_texto like 'ERROR EXPERIENCIA CREDITICIA:%')
                
                delete cob_workflow..wf_ob_lineas 
                where ol_id_asig_act = @w_asig_act 
                and ol_texto like 'ERROR EXPERIENCIA CREDITICIA:%'
                
                
                select top 1 @w_numero = ob_numero from cob_workflow..wf_observaciones 
                where ob_id_asig_act = @w_asig_act
                order by ob_numero desc
                
                if (@w_numero is not null)
                begin
                	select @w_numero = @w_numero + 1 --aumento en uno el maximo
                end
                else
                begin
                	select @w_numero = 1
                end
                
                select @w_usuario = fu_nombre from cobis..cl_funcionario where fu_login = @s_user
                
                insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
                values (@w_asig_act, @w_numero, getdate(), @w_proceso, 1, 'a', @w_usuario)
                
                insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
                values (@w_asig_act, @w_numero, 1, @w_comentario)
                
				select @w_valor_nuevo = 'NO'
                    BREAK
            end
    	    else if((@w_exp_credit = 'S') or (@w_emprendedor = 'N'))
    	    begin
    	        select @w_valor_nuevo = 'SI'
    	    end
    	end
    end
end
else
begin
    select @w_valor_nuevo = 'SI'
end


-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @i_id_asig_act %2! @w_valor_ant %3!',@i_id_inst_proc, @i_id_asig_act, @w_valor_ant
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
--print '@i_id_inst_proc %1! @i_id_asig_act %2! @w_valor_ant %3!',@i_id_inst_proc, @i_id_asig_act, @w_valor_ant
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


