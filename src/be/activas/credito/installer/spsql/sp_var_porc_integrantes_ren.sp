/************************************************************************/
/*  Archivo:                sp_var_porc_integrantes_ren.sp              */
/*  Stored procedure:       sp_var_porc_integrantes_ren                 */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           Sonia Rojas                                 */
/*  Fecha de Documentacion: 13 Enero de 2021                            */
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
/* Procedure tipo Variable, Retorna SI si existe un cliente en el grupo */
/* cuyo puntaje en la verificación de datos sea menor a 9               */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR           RAZON                                   */
/*  13/Ene/2021 S.Rojas         Emision Inicial                         */
/* **********************************************************************/
USE cob_credito
GO

if exists(select 1 from sysobjects where name ='sp_var_porc_integrantes_ren')
	drop proc sp_var_porc_integrantes_ren
GO

CREATE PROC sp_var_porc_integrantes_ren(
   @s_ssn        int         = null,
   @s_ofi        smallint    = null,
   @s_user       login       = null,
   @s_date       datetime    = null,
   @s_srv		 varchar(30) = null,
   @s_term	     descripcion = null,
   @s_rol		 smallint    = null,
   @s_lsrv	     varchar(30) = null,
   @s_sesn	     int 	     = null,
   @s_org		 char(1)     = NULL,
   @s_org_err    int 	     = null,
   @s_error      int 	     = null,
   @s_sev        tinyint     = null,
   @s_msg        descripcion = null,
   @t_rty        char(1)     = null,
   @t_trn        int         = null,
   @t_debug      char(1)     = 'N',
   @t_file       varchar(14) = null,
   @t_from       varchar(30) = null,
   --variables
   @i_id_inst_proc int,    --codigo de instancia del proceso
   @i_id_inst_act  int,    
   @i_id_asig_act  int,
   @i_id_empresa   int, 
   @i_id_variable  smallint 
)
AS
declare 
@w_sp_name       	      varchar(32),
@w_tramite_ant     	      int,
@w_tramite       	      int,
@w_integrantes_act        int,
@w_integrantes_ant        int,
@w_integrantes_renov      int,
@w_valor_ant      	      varchar(255),
@w_valor_nuevo    	      varchar(255), 
@w_porc_integrantes_ren   float ,
@w_error                  int

select @w_sp_name='sp_var_porc_integrantes_ren'


declare @w_integrantes_ciclo_act table(
   cliente       int
)

declare @w_integrantes_ciclo_ant table(
   cliente       int
)


select 
@w_tramite_ant = convert(int,io_campo_5),
@w_tramite     = io_campo_3
FROM cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select 
@w_tramite_ant = isnull(@w_tramite_ant,0),
@w_tramite     = isnull(@w_tramite,0)

if @w_tramite_ant = 0 return 0
if @w_tramite     = 0 return 0

insert into @w_integrantes_ciclo_act
select 
tg_cliente       as cliente
from cr_tramite_grupal
where tg_tramite         = @w_tramite
and   tg_participa_ciclo = 'S'

select @w_integrantes_act = @@rowcount
if @w_integrantes_act = 0 return 0

insert into @w_integrantes_ciclo_ant
select 
tg_cliente       as cliente
from cr_tramite_grupal
where tg_tramite         = @w_tramite_ant
and   tg_participa_ciclo = 'S'

select @w_integrantes_ant = @@rowcount
if @w_integrantes_act = 0 return 0

select @w_integrantes_renov = count(1)
from @w_integrantes_ciclo_act
where cliente in (select cliente from @w_integrantes_ciclo_ant)

select @w_porc_integrantes_ren = (@w_integrantes_renov * 100 )/ @w_integrantes_ant
select @w_valor_nuevo = convert(varchar , @w_porc_integrantes_ren)
--insercion en estructuras de variables

if @i_id_asig_act is null select @i_id_asig_act = 0

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
              where mv_id_inst_proc = @i_id_inst_proc and
                    mv_codigo_var= @i_id_variable and
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
     select @w_error = 2101002
     goto ERROR	           
   end 

END

return 0

ERROR:

exec cobis..sp_cerror
@t_debug = @t_debug,
@t_file  = @t_file, 
@t_from  = @t_from,
@i_num   = @w_error

return 1
go


