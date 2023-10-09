/*************************************************************************/
/*   Archivo:            sp_pasa_cartera_ren_wf.sp                       */
/*   Stored procedure:   sp_pasa_cartera_ren_wf                          */
/*   Base de datos:      cob_workflow                                    */
/*   Producto:           Originacion                                     */
/*   Disenado por:       AGO                                             */
/*   Fecha de escritura: 09/01/2020	                                     */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier acion o agregado hecho por alguno de sus                  */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este procedimiento almacenado, cambia el estado del tramite  a A    */
/*   en una actividad automatica                                         */
/*************************************************************************/
/*                        MODIFICACIONES                                 */
/*   FECHA         AUTOR                   RAZON                         */
/*   22/11/2022    ACH      #194284 Dia de Pago                          */
/*************************************************************************/
use cob_cartera 
go

if object_id ('sp_pasa_cartera_ren_wf') is not null
   drop procedure sp_pasa_cartera_ren_wf
go

create procedure sp_pasa_cartera_ren_wf
(
   @s_ssn            int           = null,
   @s_ofi            smallint,
   @s_user           login,
   @s_date           datetime,
   @s_srv            varchar(30)   = null,
   @s_term           descripcion   = null,
   @s_rol            smallint      = null,
   @s_lsrv           varchar(30)   = null,
   @s_sesn           int           = null,
   @s_org            char(1)       = null,
   @s_org_err        int           = null,
   @s_error          int           = null,
   @s_sev            tinyint       = null,
   @s_msg            descripcion   = null,
   @t_rty            char(1)       = null,
   @t_trn            int           = null,
   @t_debug          char(1)       = 'N',
   @t_file           varchar(14)   = null,
   @t_from           varchar(30)   = null,
   --variables
   @i_id_inst_proc   int,    --codigo de instancia del proceso
   @i_id_inst_act    int,
   @i_id_empresa     int,
   @i_etapa_flujo    varchar(10)  = 'FIN',-- LGU 2017-07-13: para ver en que momento se ccrea el DES y LIQ del prestamo
                                          -- (1) IMP: impresion: solo crear OP hijas
                                          -- (2) FIN: al final del flujo: crea DES y LIQ de OP hijas
   @i_fecha_ini      datetime     = null, -- para crear las operaciones hijas
   @o_id_resultado   smallint out
)
as
declare
@w_error                  int,
@w_return                 int,
@w_tramite                int,
@w_grupal                 varchar(1),
@w_codigo_proceso         int,
@w_version_proceso        int,
@w_cliente                int,
@w_codigo_tramite         char(50),
@w_sp_name                varchar(30),
@w_rule                   int,
@w_rule_version           int,
@w_retorno_val            varchar(255),
@w_retorno_id             int,
@w_variables              varchar(255),
@w_result_values          varchar(255),
@w_tasa_grupal            float,
@w_forma_desembolso       catalogo,
@w_forma_pago             catalogo,
@w_cod_oficial            int,
@w_ofi_def_app_movil      smallint,
@w_fecha_proceso          datetime,
@w_fecha_dispersion       datetime,
@w_reduccion_tasa_grupal  float,
@w_min_porc_tasa_grupal   float, 
@w_tasa_grupal_aux        float,
@w_banco                  varchar(24),
@w_tplazo                 varchar(10),
@w_periodo_int            smallint,
@w_dia_pago               datetime,
@w_fecha_ini_tmp          datetime,
@w_dia_inicio             int,
@w_fecha_dispersion_d     datetime

select @w_sp_name = 'sp_pasa_cartera_wf'
select @w_error = 0
-- PARAMETRO NOTA DE CREDITO CARTERA
select @w_forma_desembolso = pa_char
from cobis..cl_parametro
where pa_nemonico = 'NCRAHO' --NOTA DE CREDITO AHORRO
and   pa_producto = 'CCA'

if @@rowcount = 0 begin
   select @w_error = 101077
   goto ERROR
end

-- PARAMETRO NOTA DE DEBITO CARTERA
select @w_forma_pago = pa_char
from cobis..cl_parametro
where pa_nemonico = 'NCDAHO' --NOTA DE CREDITO AHORRO
and   pa_producto = 'CCA'

if @@rowcount = 0 begin
   select @w_error = 101077
   goto ERROR
end

-- SRO. PARAMETRO REDUCCION DE TASA GRUPAL
select @w_reduccion_tasa_grupal = pa_float
from cobis..cl_parametro
where pa_nemonico               = 'RDTGRP'
and   pa_producto               = 'CRE'

if @@rowcount = 0 begin
   select @w_error = 101077
   goto ERROR
end


-- SRO. PARAMETRO MINIMO TASA GRUPAL
select @w_min_porc_tasa_grupal = pa_float
from cobis..cl_parametro
where pa_nemonico               = 'MNPRTG'
and   pa_producto               = 'CRE'

if @@rowcount = 0 begin
   select @w_error = 101077
   goto ERROR
end

/*
select @w_tramite = convert(int, io_campo_3)
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc
*/
select @w_cod_oficial = oc_oficial,
       @w_grupal  = tr_grupal,
	   @w_tramite = convert(int, io_campo_3)
from cob_workflow..wf_inst_proceso
inner join cob_credito..cr_tramite on io_campo_3 = tr_tramite
inner join cobis..cc_oficial on oc_oficial = tr_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where io_id_inst_proc = @i_id_inst_proc

-- PRINT 'NUMERO DE OFICINA POR DEFECTO DEL APP MOVIL'
select @w_ofi_def_app_movil = pa_smallint 
from   cobis..cl_parametro 
where  pa_nemonico = 'OFIAPP' 
and    pa_producto = 'CRE'

if(@s_ofi = @w_ofi_def_app_movil)
begin
	select @s_ofi = fu_oficina	
	from   cobis..cl_funcionario, 
	       cobis..cc_oficial
	where  oc_oficial     = @w_cod_oficial
	and    oc_funcionario = fu_funcionario
end

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

/*
select @w_grupal  = tr_grupal
from cob_credito..cr_tramite
where tr_tramite = @w_tramite
*/

/*** Estado A para el tramite, estado Aprobado ***/

if @w_grupal is null begin
   exec @w_error = cob_cartera..sp_pasa_cartera
   @s_ssn     = @s_ssn,
   @s_ofi     = @s_ofi,
   @s_user    = @s_user,
   @s_date    = @s_date,
   @s_term    = @s_term,
   @i_tramite = @w_tramite,
   @i_forma_desembolso = @w_forma_desembolso


   if @w_error <> 0 begin
       select
       @o_id_resultado = 3, -- Error
       @w_error        = @w_error,
       @w_sp_name      = 'cob_cartera..sp_pasa_cartera'
       goto ERROR
   end
end

if @w_grupal = 'S' begin

   --SRO. 147999
   select @w_tasa_grupal_aux = or_tasa_ciclo_ant
   from cob_credito..cr_op_renovar
   where or_tramite          = @w_tramite	   
  
   select @w_tasa_grupal = @w_tasa_grupal_aux - @w_reduccion_tasa_grupal 
   if @w_tasa_grupal < @w_min_porc_tasa_grupal select @w_tasa_grupal = convert(float, @w_tasa_grupal_aux)

   -- print '@w_tasa_grupal: '+convert(varchar, @w_tasa_grupal)
   
   -- print 'SMO @i_fecha_ini>> '+convert(varchar,@i_fecha_ini)


   --SMO cuando el desembolso se hace en una fecha posterior a la fecha de dispersión configurada
   select @w_fecha_dispersion = tr_fecha_dispersion 
   from cob_credito..cr_tramite
   where tr_tramite = @w_tramite
	
	
   --   print 'SMO @w_fecha_dispersion>> '+convert(varchar,@w_fecha_dispersion)

   if @w_fecha_dispersion < @w_fecha_proceso  
   begin
   	  update cob_cartera..ca_operacion
      set op_fecha_ini = @w_fecha_proceso,
      op_fecha_liq     = @w_fecha_proceso
      where op_tramite = @w_tramite
      
      select @i_fecha_ini = null
   end

   ---->>>>---->>>>Caso#194284 Dia de Pago
   select @w_banco = op_banco, @w_tplazo = op_tplazo, @w_periodo_int = op_periodo_int 
   from cob_cartera..ca_operacion where op_tramite = @w_tramite
   
    select @w_dia_pago  = dp_fecha_dia_pag,
           @w_fecha_dispersion_d = dp_fecha_dispercion  -- validar con la fecha del tramite de más arriba
	from cob_cartera..ca_dia_pago where dp_banco = @w_banco
	
    exec sp_valida_diapago
         @i_banco            = @w_banco           ,
         @i_fecha_dispersion = @w_fecha_dispersion_d,
         @i_dia_pago         = @w_dia_pago        ,
         @i_periodo_int      = @w_periodo_int     ,
         @i_tplazo           = @w_tplazo          ,
         @o_fecha_inicio     = @w_fecha_ini_tmp out,
         @o_dia_inicio       = @w_dia_inicio    out,       
         @o_error            = @w_error         out
   
    if @w_error <> 0 begin
      print 'Error en sp_valida_diapago'+ convert(varchar, @w_error)
      select
      @o_id_resultado = 3, -- error
      @w_error        = @w_error,
      @w_sp_name      = 'sp_valida_diapago'
      goto ERROR
    end 
	 
   ---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>
   exec @w_error     = cob_cartera..sp_desembolso_ren_grupal
   @s_ofi            = @s_ofi,
   @s_user           = @s_user,
   @s_date           = @s_date,
   @s_term           = @s_term,
   @i_tramite_grupal = @w_tramite,
   @i_oficina        = @s_ofi,
   @i_grupal         = @w_grupal,
   @i_tasa           = @w_tasa_grupal,
   @i_forma_pago     = @w_forma_desembolso,
   @i_forma_desembolso = @w_forma_desembolso,
   @i_etapa_flujo      = @i_etapa_flujo,      -- LGU: envio etapa para separar la creacion de la liquidacion
   @i_fecha_ini        = @i_fecha_ini -- SMO para crear las hijas con la fecha ini del padre, si es null toma la fecha de proceso

   if @w_error <> 0 begin
       select
       @o_id_resultado = 3, -- error
       @w_error        = @w_error,
       @w_sp_name      = 'cob_cartera..sp_desembolso_ren_grupal'
       goto ERROR
   end
end

select @o_id_resultado = 1 --OK

return 0
ERROR:
    return @w_error
GO
