USE cob_credito
GO
/************************************************************/
/*   ARCHIVO:         sp_monto_inicial.sp                   */
/*   NOMBRE LOGICO:   sp_monto_inicial                      */
/*   PRODUCTO:        COBIS CREDITO                         */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  internacionales de    */
/*   propiedad intelectual.  Su uso  no  autorizado dara    */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*  Evaluacion de reglas para encontrar el calculo de porc. */
/*  incremento y monto maximo por cliente                   */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR               RAZON                */
/* 02/MAR/2017     LGU                 Emision Inicial      */
/* 07/JUN/2019    P. Ortiz             Montos Promo 116387  */
/* 22/Oct/2019     ACHP                Para caso #127801    */
/* 09/Nov/2020     DCU                 Mejoras              */
/************************************************************/

if object_id ('sp_monto_inicial') is not null
	drop procedure sp_monto_inicial
GO

create proc sp_monto_inicial
    @s_ssn              int         = null,    
    @s_rol              smallint    = null,    
    @s_ofi              smallint    = null,    
    @s_sesn             int         = null,
    @t_trn              int         = null,     
    @t_debug            char(1)     = 'N', 
    @t_file             varchar(14) = null,    
    @s_user             login       = null,
    @s_term             varchar(30) = null,
    @s_date             datetime    = null,
    @s_srv              varchar(30) = null,
    @s_lsrv             varchar(30) = null,
    @i_tramite          int,
    @i_grupo            int,
    @i_promocion        char(1),
    @i_ejecuta_reg_ini  char(1)     = 'S'
 
AS

declare @w_sp_name           varchar(32),  ---NOMBRE STORED PROC
        @w_rule               int,
        @w_ciclo_grupal       int,
        @w_credito_extra      money,
        @w_cliente_tmp        int,
        @w_monto_max          money,
        @w_monto_min          money,
        @w_incremento         numeric(8,4),
        @w_monto_ult_op       money,
        @w_valor_inc          money,
        @w_monto_inicial      money,
        @w_max_tramite_grupal int,
        @w_monto_ant          money,  
        @w_monto_cta_ref      money,    
        @w_return             int          ---VALOR QUE RETORNA

select @w_sp_name = 'sp_monto_inicial'

select @w_ciclo_grupal = isnull(gr_num_ciclo,0) +1
from   cobis..cl_grupo
where  gr_grupo = @i_grupo


--EJECUTA LA REGLAS MONTO GRUPAL E INCREMENTO GRUPAL
if @i_ejecuta_reg_ini = 'S' 
begin
   exec @w_return = sp_grupal_reglas
        @s_ssn     = @s_ssn ,
        -- @s_rol     = @s_rol ,
        @s_ofi     = @s_ofi ,
        @s_sesn    = @s_sesn ,
        @t_trn     = 1111    ,
        @s_user    = @s_user ,
        @s_term    = @s_term ,
        @s_date    = @s_date ,
        @s_srv     = @s_srv ,
        @s_lsrv    = @s_lsrv ,
        @i_tramite = @i_tramite,
        @i_valida_part = 'N',
        @i_id_rule = 'INC_GRP'  -- encontral el % incremento y monto de ultima operacion cancelada
            
   if @w_return <> 0 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 21008,
      @i_msg   = 'Error al determinar PORCENTAJE DE INCREMENTO'
   end
   
   exec @w_return = sp_grupal_reglas
        @s_ssn     = @s_ssn ,
        --@s_rol     = @s_rol ,
        @s_ofi     = @s_ofi ,
        @s_sesn    = @s_sesn ,
        @t_trn     = 1111    ,
        @s_user    = @s_user ,
        @s_term    = @s_term ,
        @s_date    = @s_date ,
        @s_srv     = @s_srv ,
        @s_lsrv    = @s_lsrv ,
        @i_tramite = @i_tramite,
        @i_grupo   = @i_grupo,
        @i_valida_part = 'N',
        @i_id_rule = 'MONTO_GRP'  -- encontrar el monto maximo del cliente
       
   if @w_return <> 0 begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 21009,
      @i_msg   =  'Error al determinar MONTO MAXIMO'
   end
end

select @w_credito_extra = pa_money  
from cobis..cl_parametro 
where pa_nemonico = 'CREXTR' and pa_producto = 'CRE'

--Obtiene el ultimo tramite del grupo
select @w_max_tramite_grupal = max(tg_tramite)
from cob_credito..cr_tramite_grupal
where tg_grupo = @i_grupo
and tg_tramite <> @i_tramite
--and tg_referencia_grupal <> tg_prestamo --ACHP

/* Actualizo montos */
if @w_ciclo_grupal > 1
begin
   --ACHP -- se anade para que se actualice el campo tg_monto_cuenta_ref, cada vez que cambia de promo de S a N
   exec cob_credito..sp_var_integrantes_original
             @i_id_inst_proc=-1,
             @i_id_inst_act=1,
             @i_id_asig_act =1,
             @i_id_empresa =1,
             @i_id_variable =1,
             @i_tramite = @i_tramite,
             @i_grupo   = @i_grupo,
             @i_ttramite  = 'GRUPAL'
		   	
    if(@i_promocion = 'S') --ACHP -- se anade solo para promo = S debido a que si era no promo tambien se llenaban el campo tg_monto_cuenta_ref
	begin
	   print '****ACHP-sp_monto_inicial promo = S'
       update cob_credito..cr_tramite_grupal
       set tg_monto_cuenta_ref = gpi_cred_max_comp + @w_credito_extra
       from cob_credito..cr_grupo_promo_inicio
       where tg_tramite = @i_tramite
       and   tg_grupo   = @i_grupo 
       and tg_grupo     = gpi_grupo
       and tg_cliente   = gpi_ente
        --and tg_tramite = gpi_tramite
        --and tg_participa_ciclo = 'S'
	end	
    print 'Se actualiza Cuenta de referencia'
end

-- si el tramite anterior fue rechazado
if exists(select 1 from cob_credito..cr_tramite where tr_tramite = @w_max_tramite_grupal and tr_estado in ('X','Z'))
begin
    print 'MONTO INICIAL actualiza tramite anterior fue rechazado'
    select @w_cliente_tmp = 0
    
    while 1=1
    begin
        select top 1 @w_cliente_tmp = tg_cliente 
        from cob_credito..cr_tramite_grupal 
        where tg_tramite=@i_tramite 
        and tg_cliente > @w_cliente_tmp ORDER BY tg_cliente 
          
        if @@rowcount = 0  break
        print '@w_cliente_tmp '+convert(varchar,@w_cliente_tmp)
        
        select  @w_monto_ant = tg_monto 
        from cob_credito..cr_tramite_grupal 
        where tg_tramite = @w_max_tramite_grupal 
        and tg_cliente = @w_cliente_tmp 
        
        if @w_monto_ant is null
         select @w_monto_ant=0
        
        update cob_credito..cr_tramite_grupal 
        set tg_monto          = @w_monto_ant, 
        tg_monto_aprobado = @w_monto_ant,
        tg_participa_ciclo = 'S'  
        where tg_tramite = @i_tramite 
        and tg_cliente = @w_cliente_tmp 
    end
end    
else
begin
    print 'MONTO INICIAL actualiza tramite anterior NO fue rechazado'
    --cuando el tramite anterior no fue cancelado
    
    select @w_cliente_tmp = 0
    
    while 1=1
    begin    
        select top 1 @w_cliente_tmp = tg_cliente
        from cob_credito..cr_tramite_grupal 
        where tg_tramite=@i_tramite 
        and tg_cliente > @w_cliente_tmp 
        order by tg_cliente 
        
        if @@rowcount = 0 break
        
        print '@w_cliente_tmp '+convert(varchar,@w_cliente_tmp)
        select  
        @w_monto_max    = tg_monto_max_calc,
        @w_monto_min    = tg_monto_min_calc,
        @w_incremento   = tg_incremento,
        @w_monto_ult_op = tg_monto_ult_op,
        @w_monto_cta_ref = tg_monto_cuenta_ref
        from cob_credito..cr_tramite_grupal 
        where tg_tramite=@i_tramite 
        and tg_cliente = @w_cliente_tmp
        
        if @w_ciclo_grupal > 1
           select @w_valor_inc = @w_monto_ult_op + @w_monto_ult_op * @w_incremento/100.0
        
        if @w_ciclo_grupal = 1
           select @w_monto_inicial = @w_monto_max
        
        if @w_ciclo_grupal > 1
        begin
            if @w_monto_cta_ref is null
            begin
                if @w_valor_inc <= @w_monto_max
                   select @w_monto_inicial = @w_valor_inc
                else
                   select @w_monto_inicial = @w_monto_max
            end
            else
            begin
                if @w_valor_inc <= @w_monto_cta_ref
                   select @w_monto_inicial = @w_monto_cta_ref
                else
                   select @w_monto_inicial = @w_valor_inc
            end
        end
        
        update cob_credito..cr_tramite_grupal
        set tg_monto = @w_monto_inicial ,
        tg_monto_aprobado = @w_monto_inicial ,
        tg_participa_ciclo = 'S' 
        from cob_credito..cr_tramite_grupal
        where tg_tramite = @i_tramite
        and   tg_cliente = @w_cliente_tmp
    end
end 

if @w_ciclo_grupal = 1 and @i_promocion = 'S'
begin
   print 'MONTO INICIAL actualiza montos PROMO @i_tramite'+convert(varchar,@i_tramite)
   exec cob_credito..sp_var_integrantes_original
            @i_id_inst_proc=-1,
            @i_id_inst_act=1,
            @i_id_asig_act =1,
            @i_id_empresa =1,
            @i_id_variable =1,
            @i_tramite = @i_tramite,
            @i_grupo   = @i_grupo,
            @i_ttramite  = 'GRUPAL'
   
   update cob_credito..cr_tramite_grupal
   set tg_monto        = gpi_cred_max_comp + @w_credito_extra,
   tg_monto_aprobado   = gpi_cred_max_comp + @w_credito_extra,
   tg_monto_cuenta_ref = gpi_cred_max_comp + @w_credito_extra,
   tg_participa_ciclo  = 'S' 
   from cob_credito..cr_tramite_grupal,cob_credito..cr_grupo_promo_inicio
   where tg_tramite = @i_tramite
   and   tg_grupo = gpi_grupo
   and   tg_cliente = gpi_ente
end

RETURN 0

GO
