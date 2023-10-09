/************************************************************************/
/*  Archivo:                sp_var_integrantes_externo.sp               */
/*  Stored procedure:       sp_var_integrantes_externo                  */
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
/* Determina la cantidad de integrantes que forman parte de un grupo    */
/* promo pero no vienen de una entidad externa                          */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                   RAZON                         */
/* 24/Abr/2018   P. Ortiz    Emision Inicial                            */
/* 17/Sep/2021   ACH         ERR#168924,se toma el parametro de ingreso */
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_integrantes_externo')
	drop proc sp_var_integrantes_externo
GO


CREATE PROC sp_var_integrantes_externo
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
        @w_cont             int,
        @w_promocion        char(1),
        @w_max_externos     int,
        @w_asig_act         int,
        @w_numero           int,
        @w_proceso			varchar(5),
        @w_usuario			varchar(30),
        @w_comentario		varchar(510),
        @w_nombre           varchar(64),
        @w_parte_1  		varchar(255),
        @w_parte_2  		varchar(255),
		@w_linea            int,
		@w_lineas           int
       
	       

select @w_sp_name='sp_var_integrantes_externo'

select @w_grupo    = convert(int,io_campo_1),
	   @w_tramite  = convert(int,io_campo_3),
	   @w_ttramite = io_campo_4,
	   @w_asig_act = convert(int, @i_id_asig_act) -- antes: io_campo_2
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

/* PARAMETROS */
select @w_max_externos = (select pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MAXLF' AND pa_producto = 'CRE') 
select @w_proceso = pa_int from cobis..cl_parametro where pa_nemonico = 'OAA'

select @w_tramite = isnull(@w_tramite,0)

if @w_tramite = 0 return 0

select @w_cont = 0 

/* Determinar si en grupo es promocion */
select @w_promocion = tr_promocion from cob_credito..cr_tramite where tr_tramite = @w_tramite
select @w_promocion = isnull(@w_promocion,'N')


select @w_parte_1 = 'El Grupo de la solicitud PROMO tiene la siguiente conformación: INTEGRANTES DEL GRUPO ORIGINAL:  '
select @w_parte_2 = '. INTEGRANTES EXTERNOS AL GRUPO ORIGINAL:  '
select @w_comentario = '' 

if (@w_promocion = 'S')
begin 
    if @w_ttramite = 'GRUPAL'
    begin
        print 'INICIA PROCESO sp_var_integrantes_externo'
        
    	select @w_cont = count(distinct(tg_cliente))
    	from cob_credito..cr_tramite_grupal
    	where tg_grupo = @w_grupo
    	and tg_tramite = @w_tramite
    	and tg_participa_ciclo = 'S'
    	and tg_cliente not in 
    	(select gpi_ente from cob_credito..cr_grupo_promo_inicio where gpi_grupo =  @w_grupo)
    	
      	print 'EVALUA INTEGRANTES GRUPO PROMO EXTERNOS @w_cont: '+ convert(varchar,@w_cont)
      	
      	if (@w_cont > 0) 
        begin
        	--CON UN WHILE LE PONE EN LA PARTE 1 O LA PARTE 2
        
            print 'INGRESA OBSERVACION EXTERNAS:' + @w_comentario
            
            select @w_ente = 0
    	    while 1 = 1 begin
    	    
               select top 1 @w_ente = cg_ente 
    	       from cobis..cl_cliente_grupo, cob_credito..cr_tramite_grupal 
    	       where cg_grupo = @w_grupo
    	       and tg_tramite = @w_tramite
    	       and cg_grupo = tg_grupo
    	       and tg_cliente = cg_ente
    	       and tg_participa_ciclo = 'S'
    	       and cg_estado = 'V'
    	       and cg_ente > @w_ente
    	       order by cg_ente asc
    	         
    	       IF @@ROWCOUNT = 0 BREAK
                
               if not exists(select 1 from cob_credito..cr_grupo_promo_inicio 
                            where gpi_grupo = @w_grupo and gpi_ente = @w_ente)
                    select @w_parte_2 = @w_parte_2 + convert(varchar,@w_ente) +', '
               else
               	 select @w_parte_1 = @w_parte_1 + convert(varchar,@w_ente) +', '
            
            end --end while
            
			
            delete cob_workflow..wf_observaciones 
            where ob_id_asig_act = @w_asig_act
            and ob_numero in (select ol_observacion from  cob_workflow..wf_ob_lineas 
            where ol_id_asig_act = @w_asig_act 
            and ol_texto like 'El Grupo de la solicitud PROMO tiene la siguiente%')
            
			
            delete cob_workflow..wf_ob_lineas 
            where ol_id_asig_act = @w_asig_act 
            and ol_texto like 'El Grupo de la solicitud PROMO tiene la siguiente%'
            
            select @w_comentario = substring(@w_parte_1,0,len(@w_parte_1)+1) + '. ' + substring(@w_parte_2,0,len(@w_parte_2)+1) + '.'
            
			
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
            
			select @w_linea = 0
            select @w_usuario = fu_nombre from cobis..cl_funcionario where fu_login = @s_user
            print @w_comentario
            if len(@w_comentario) > 255
            begin
			     
                 insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
                 values (@w_asig_act, @w_numero, getdate(), @w_proceso, 2, 'a', @w_usuario)                 
				 			    
				 insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
                 values (@w_asig_act, @w_numero, 1, substring(@w_comentario,@w_linea,254))
				 
                 insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
                 values (@w_asig_act, @w_numero, 2, substring(@w_comentario,255,255))				 
				 
                 
            end
            else
            begin
			     
	             insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
                 values (@w_asig_act, @w_numero, getdate(), @w_proceso, 1, 'a', @w_usuario)
                 
                 insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
                 values (@w_asig_act, @w_numero, 1, @w_comentario)
            end
            
        end
      	
      	select @w_valor_nuevo = @w_cont
      	
    end
end
else
begin
    select @w_valor_nuevo = 0
end

print 'EVALUA INTEGRANTES GRUPO PROMO EXTERNOS: '+ @w_valor_nuevo

-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc @i_id_asig_act @w_valor_ant' + convert(varchar, @i_id_inst_proc) +'-'+convert(varchar, @i_id_asig_act)  +'-'+  @w_valor_ant
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

--print '@i_id_inst_proc @i_id_asig_act @w_valor_ant' + convert(varchar, @i_id_inst_proc) +'-' + convert(varchar, @i_id_asig_act) +'-' +convert(varchar, @w_valor_ant)
if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc AND
                    mv_codigo_var  = @i_id_variable AND
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

