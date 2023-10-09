

/************************************************************************/
/*  Archivo:                sp_var_monto_30.sp                          */
/*  Stored procedure:       sp_var_monto_30                             */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           VBR                                         */
/*  Fecha de Documentacion: 04/Jul/2017                                 */
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
/* Procedure tipo Variable, Retorna SI si en el grupo algún integrante  */
/* tiene un monto > al 30% del monto grupal de la solicitud             */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR           RAZON                                   */
/*  07/JUL/2017 VBR             Emision Inicial                         */
/* **********************************************************************/
USE cob_credito
GO

if exists(select 1 from sysobjects where name ='sp_var_monto_30')
	drop proc sp_var_monto_30
GO


CREATE PROC sp_var_monto_30
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
        @w_return                    int,
        @w_porc_monto_gr           float,
        @w_monto_30                money,  
        @w_asig_actividad 	int,
        @w_valor_ant      	varchar(255),
        @w_valor_nuevo       varchar(255),
        @w_max_ciclo                  int,
        @w_grupo                      int,
        @w_max_ciclo_ind              int,
        @w_ciclo_no_valida_nuevos     int,
        @w_ciclo_grupo                INT,
        @w_monto_sup30              MONEY,
        @w_monto_inf30              MONEY,
        @w_monto                    MONEY,
        @w_monto_prom				MONEY,
        @w_clientes_tr              INT,
        @w_es_promocion             char(1)
       
       

SELECT @w_sp_name='sp_var_monto_30'


SELECT @w_tramite = isnull(convert(int,io_campo_3),0),
       @w_grupo   = convert(int,io_campo_1)
FROM cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

if @w_tramite = 0 return 0


select @w_es_promocion = tr_promocion
from cob_credito..cr_tramite
where tr_tramite = @w_tramite

print 'SMO sp_var_monto_30 es PROMOCION @w_es_promocion '+@w_es_promocion
if @w_es_promocion = 'S' begin
    print 'SMO sp_var_monto_30 no valida para grupo promo '
   select @w_valor_nuevo  = 'NO' -- 0 (cumple la politica)
   goto CONTINUAR    
end
--return 0 --No valida el principio de equidad para solicitudes Promo


--parametro de porcentaje de monto grupal
SELECT @w_porc_monto_gr = pa_float
FROM cobis..cl_parametro 
WHERE pa_nemonico = 'PMMGR'

--Maximo ciclo individual en el que se debe validar la politica
SELECT @w_max_ciclo_ind = pa_int  --ciclo 1
FROM cobis..cl_parametro 
WHERE pa_nemonico = 'NMCI'
and pa_producto = 'CLI'

--Ciclo del grupo a partir del cual no se debe validar los miembros nuevos
SELECT @w_ciclo_no_valida_nuevos = pa_int  --ciclo 3
FROM cobis..cl_parametro 
WHERE pa_nemonico = 'CLICI'
and pa_producto = 'CLI'

--Calculo del valor del 30% del total del tramite
SELECT @w_monto = tr_monto
      FROM cob_credito..cr_tramite
      WHERE tr_tramite = @w_tramite
      
create table #clientes_validar(
    codigo_cliente   int,
    num_ciclo        int,
    debe_validar     char(1)
)

insert into #clientes_validar
select tg_cliente, isnull(en_nro_ciclo,0) +1, 'N'
from cobis..cl_ente, cob_credito..cr_tramite_grupal
where en_ente = tg_cliente
and tg_tramite = @w_tramite
AND tg_participa_ciclo = 'S'

--SI NO TIENE PARTICIPANTES NO VALIDA
IF @@ROWCOUNT = 0 RETURN 0

SELECT @w_clientes_tr = count(codigo_cliente) FROM #clientes_validar

SELECT @w_monto_prom = round(@w_monto/@w_clientes_tr,2)
SELECT @w_monto_30 = @w_monto_prom*@w_porc_monto_gr/100


--SI EL CICLO DEL CLIENTE ES MENOR O IGUAL QUE EL PARAMETRO CONFIGURADO, DEBE APLICAR EL PRINCIPIO DE EQUIDAD
update #clientes_validar 
set debe_validar = 'S'
where num_ciclo <= @w_max_ciclo_ind

--ciclo actual del grupo
select @w_ciclo_grupo = gr_num_ciclo + 1
from cobis..cl_grupo
where gr_grupo = @w_grupo

--SI EL GRUPO ESTA EN UN CICLO MAYOR O IGUAL AL PARAMETRO CONFIGURADO, NO DEBE VALIDAR LOS CLIENTES NUEVOS (CICLO 1)
if @w_ciclo_grupo >= @w_ciclo_no_valida_nuevos
   update #clientes_validar 
   set debe_validar = 'N'
   where num_ciclo = 1 --NUEVO MIEMBRO (PRIMER CREDITO)
   
      SELECT @w_monto_sup30 = @w_monto_prom + @w_monto_30
      SELECT @w_monto_inf30 = @w_monto_prom - @w_monto_30



if exists(select 1 from cob_credito..cr_tramite_grupal where tg_tramite = @w_tramite 
and (tg_monto > @w_monto_sup30 or tg_monto < @w_monto_inf30) 
          and tg_cliente in (select codigo_cliente from #clientes_validar where debe_validar = 'S'))  
   select @w_valor_nuevo  = 'SI' -- (no cumple la politica)
else
   select @w_valor_nuevo  = 'NO' -- 0 (cumple la politica)

goto CONTINUAR           

CONTINUAR:

--insercion en estrucuturas de variables
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


