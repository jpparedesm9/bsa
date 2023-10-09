/************************************************************************/
/*  Archivo:                sp_var_porcmin_reingreso_ren.sp            */
/*  Stored procedure:       sp_var_porcmin_reingreso_ren               */
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
/*  17/Ene/2022 KVI             Error #175979 - Modificacion retorno    */
/* **********************************************************************/
USE cob_credito
GO

if exists(select 1 from sysobjects where name ='sp_var_porcmin_reingreso_ren')
	drop proc sp_var_porcmin_reingreso_ren
GO

CREATE PROC sp_var_porcmin_reingreso_ren(
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
@w_grupo                  int,
@w_return        	      int,
@w_grupal                 char(1),
@w_parametro_resultado    tinyint,
@w_asig_actividad 	      int,
@w_valor_ant      	      varchar(255),
@w_valor_nuevo    	      varchar(255),
@w_actividad      	      catalogo, 
@w_integrantes            int,
@w_integrantes_reingreso  int,
@w_porc_reingreso         float,
@w_integrantes_cumplen    int,
@w_cliente                int,
@w_actual                 int,
@w_anterior               int,
@w_ttrans_porc_ren        int,
@w_ttranscurrido          int,
@w_error                  int,
@w_fecha_reg              datetime,
@w_param_porc_reingreso   float,
@w_integrantes_antes_reingreso  int,
@w_integrantes_no_cumplen       int,
@w_integrantes_permitidos       int
       

select @w_sp_name='sp_var_porcentaje_reingreso_ren'

create table #integrantes_his (
   secuencial    int identity(1,1),
   operacion     int,
   cliente       int,
   fecha_reg     datetime
)

create table #integrantes_antiguos (
   cliente                int,
   tiempo_transcurrido    int
)

create table #integrantes (
   cliente       int,
   operacion     int,
   fecha_reg     datetime null
)

create table #integrantes_nuevos (
   cliente       int,
   operacion     int,
   fecha_reg     datetime null
)

-- SRO. TIEMPO TRANSCURRIDO PORCENTAJE RENOVACION
select @w_ttrans_porc_ren = isnull(pa_int, 12) --tiempo en meses
from cobis..cl_parametro
where pa_nemonico         = 'TTPREN'
and   pa_producto         = 'CRE'

if @@rowcount = 0 begin
   select @w_error = 101077
   goto ERROR
end

--PORCENTAJE REINGRESO RENOVACION
select @w_param_porc_reingreso = pa_float
from cobis..cl_parametro
where pa_nemonico         = 'PORREN'
and   pa_producto         = 'CRE'

if @@rowcount = 0 begin
   select @w_error = 101077
   goto ERROR
end


select 
@w_tramite_ant = convert(int,io_campo_5),
@w_tramite     = io_campo_3,
@w_grupo     = io_campo_1
FROM cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select 
@w_tramite_ant = isnull(@w_tramite_ant,0),
@w_tramite     = isnull(@w_tramite,0)

if @w_tramite_ant = 0 return 0
if @w_tramite     = 0 return 0

--integrantes actuales
insert into #integrantes
select 
tg_cliente       as cliente,
tg_operacion     as operacion,
null             as fecha_reg
from cr_tramite_grupal
where tg_tramite         = @w_tramite
and   tg_participa_ciclo = 'S'
and   tg_monto           > 0

update #integrantes set 
fecha_reg          = op_fecha_ini
from cob_cartera..ca_operacion
where op_operacion = operacion

select @w_integrantes = @@rowcount

if @w_integrantes = 0 return 0

--integrantes actuales que no estaban en el tramite anterior 
insert into #integrantes_nuevos
select 
cliente     as cliente, 
operacion   as operacion,
null        as fecha_reg
from #integrantes
where  cliente not in (select tg_cliente from cr_tramite_grupal where tg_tramite = @w_tramite_ant) 

select @w_integrantes_reingreso = @@rowcount

update #integrantes_nuevos set 
fecha_reg          = op_fecha_ini
from cob_cartera..ca_operacion
where op_operacion = operacion

--integrantes actuales que no estaban en el tramite anterior(nuevos) pero si estuvieron en otros tramites
insert into #integrantes_his 
select tg_operacion as operacion, tg_cliente as cliente, null as fecha_reg
from cr_tramite_grupal 
where tg_cliente         in (select cliente from #integrantes_nuevos)
and   tg_participa_ciclo = 'S'
and   tg_tramite         <> @w_tramite 
and   tg_monto           > 0
order by tg_operacion, tg_cliente asc

update #integrantes_his set 
fecha_reg          = op_fecha_ini
from cob_cartera..ca_operacion
where op_operacion = operacion

select  @w_cliente = 0

while 1 = 1 begin

   select top 1 
   @w_cliente        = cliente,
   @w_fecha_reg      = fecha_reg
   from #integrantes_nuevos
   where cliente     > @w_cliente
   order by cliente asc
   
   if @@rowcount = 0 break
   
   if not exists ( select 1 from #integrantes_his  where cliente = @w_cliente ) begin
      insert into #integrantes_antiguos values ( @w_cliente , 0 )
   end else begin
      select @w_ttranscurrido = datediff( mm, max(fecha_reg), @w_fecha_reg )
      from #integrantes_his
      where cliente    = @w_cliente  
      	  
      insert into #integrantes_antiguos values ( @w_cliente , @w_ttranscurrido )  
   
   end
end 

select @w_integrantes_antes_reingreso = @w_integrantes - @w_integrantes_reingreso 
select @w_integrantes_permitidos = round ((@w_integrantes_antes_reingreso * (@w_param_porc_reingreso/100)),0)

if @w_integrantes is null or @w_integrantes = 0 begin
   select @w_porc_reingreso = 0
end else begin
   select @w_integrantes_cumplen = count(1) from #integrantes_antiguos where tiempo_transcurrido <= @w_ttrans_porc_ren
   select @w_integrantes_cumplen = isnull( @w_integrantes_cumplen, 0)
   select @w_integrantes_no_cumplen = count(1) from #integrantes_antiguos where tiempo_transcurrido > @w_ttrans_porc_ren
   select @w_integrantes_no_cumplen = isnull( @w_integrantes_no_cumplen, 0)
   
   if @w_integrantes_no_cumplen <> 0 select @w_integrantes_cumplen =  @w_integrantes_permitidos + 1
   /*if @w_integrantes_cumplen = @w_integrantes select @w_porc_reingreso = 0
   else if @w_integrantes_cumplen = 0 select @w_porc_reingreso = 0
   else select @w_porc_reingreso = floor ((@w_integrantes_cumplen * 100.0) / @w_integrantes)*/
end

--print '@w_porc_reingreso: ' + convert (varchar, @w_porc_reingreso)
print '@w_integrantes_cumplen: ' + convert (varchar, @w_integrantes_cumplen)
print '@w_integrantes_no_cumplen: ' + convert (varchar, @w_integrantes_no_cumplen)

if (@w_integrantes_cumplen <= @w_integrantes_permitidos)   
   select @w_valor_nuevo = 'SI'
else 
   select @w_valor_nuevo = 'NO'

--insercion en estructuras de variables

if @i_id_asig_act is null
  select @i_id_asig_act = 0

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
GO
