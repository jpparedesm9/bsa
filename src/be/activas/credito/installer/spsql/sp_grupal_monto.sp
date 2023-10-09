/************************************************************/
/*   ARCHIVO:         sp_grupal_monto.sp                    */
/*   NOMBRE LOGICO:   sp_grupal_monto                       */
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
/*    Guardar informacion de los prestamos grupales         */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR               RAZON                */
/* 02/MAR/2017     LGU        Emision Inicial               */
/* 09/NOV/2017     P. Ortiz   Validar montos en 0           */
/* 29/JUL/2019     PXSG       Req. 118728                   */
/*                            Renovaciones                  */
/* 10/DIC/2019     DCU        Cambios seguros               */
/* 07/ENE/2020     ALD        Cambios seguros               */
/* 14/SEP/2020     ACH        Por caso #145927              */
/* 15/SEP/2020     PMO        Req. 140073                   */
/* 05/ABR/2021     SRO        Req. 147999                   */
/* 26/Abr/2021     ACH        156045-quitar reconformación  */
/* 14/JUN/2021     ACH        ERR. 160480, op ants no pinta */
/* 17/Dic/2021     ACH        #169730 Correccion por pruebas*/
/************************************************************/
use cob_credito
go

if exists(select 1 from sysobjects where name = 'sp_grupal_monto')
    drop proc sp_grupal_monto
go

create proc sp_grupal_monto (
@i_operacion         char(1),
@i_grupo             int         = null,
@i_tramite           int         = null,
@i_ente              int         = null,
@i_monto             money       = 0,
@s_ssn               int         = null,
@s_sesn              int         = null,
@s_ofi               smallint    = null,
@s_rol               smallint    = null,
@s_user              login       = null,
@s_date              datetime    = null,
@s_term              descripcion = null,
@t_debug             char(1)     = 'N',
@t_file              varchar(10) = null,
@t_from              varchar(32) = null,
@s_srv               varchar(30) = null,
@s_lsrv              varchar(30) = null,
@i_cheque            int         = null,
@i_modo              int         = null,
@i_participa_ciclo   char(1)     = null, --LPO Santander
@i_tg_monto_aprobado money       = null, --LPO Santander
@i_ahorro            money       = null, --LPO Santander
@i_monto_max         money       = null, --LPO Santander
@i_bc_ln             char(10)    = null, --LPO Santander,
@i_mant_grp          char(1)     = 'N',
@i_insurance         varchar(20)     = null,
@i_tipo_seguro       catalogo    = null,
@o_msg1              varchar(1200) = null output,  -- LGU  para mostrar las alertas del porcentaje y monto maximo
@o_msg2              varchar(1200) = null OUTPUT,  -- LGU  para mostrar las alertas del porcentaje y monto maximo
@o_msg3              varchar(1200) = null output,   -- LGU  para mostrar las alertas del porcentaje y monto maximo
@o_msg4              varchar(1200) = null output,   -- LGU  para mostrar las alertas del porcentaje y monto maximo
@o_tasa_grp          varchar(255) =null output
)
as
declare
@w_operacionca            int,
@w_fecha_ini              datetime,
@w_fecha_fin              datetime,
@w_fecha_liq              datetime,
@w_monto                  money,
@w_moneda                 tinyint,
@w_oficina                smallint,
@w_banco                  cuenta,
@w_cliente                int,
@w_nombre                 descripcion,
@w_estado                 smallint,
@w_op_direccion           tinyint,
@w_lin_credito            cuenta,
@w_tipo_amortizacion      catalogo,
@w_cuota                  MONEY,
@w_periodo_cap            int,
@w_periodo_int            int,
@w_base_calculo           char(1),
@w_dias_anio              smallint,
@w_plazo                  tinyint,
@w_tplazo                 char(1),
@w_plazo_no_vigente       tinyint,
@w_min_fecha_vig          datetime,
@w_est_novigente          smallint,
@w_formato_fecha          int,
@w_return                 int,
@w_tipo                   char(1),
@w_nombre_grupo           varchar(64),
@w_sector                 varchar(30),
@w_toperacion             varchar(10),
@w_oficial                smallint,
@w_fecha_crea             datetime,
@w_destino                varchar(10),
@w_ciudad                 int,
@w_banca                  catalogo,
@w_val_ahorro_vol         float ,  -- LGU porc. ahorro_voluntario
@w_error                  int,
@w_sp_name                varchar(32),
@w_promocion              char(1),   --LPO Santander
@w_acepta_ren             char(1),   --LPO Santander
@w_no_acepta              char(1000),--LPO Santander
@w_emprendimiento         char(1),   --LPO Santander
@w_suma_montos            money,
@w_msg                    varchar(500), -- LGU mensaje de error en las reglas
@w_multiplo               money, -- LGU, control de multiplos de 500 o 100
@w_suma_montos_aprob      money,      --LPO Ajustes definicion de nuevos campos Santander
@w_actualiza_movil        varchar(1),		
@w_parm_ofi_movil         smallint,
@w_ciclo_grupo            int,
@w_cliente_f              int,
@w_num_ant                int,
@w_num_comunes_ant        int,
@w_num_act                int,
@w_num_comunes_act        int, 
@w_tramite_anterior       int,
@w_debe_validar           char(1),
@w_cambiar_valor          char(1),
@w_count                  int,
@w_ingreso                varchar(30),
@w_op_anterior	          varchar(64),
@w_saldo_actual	          money,
@w_desplazamiento         int ,
@w_banco_ant              varchar(30),
@w_max_ciclo_grupo        int,
@w_grupo                  int

select @w_est_novigente = 0,
       @w_formato_fecha = 101,
       @w_sp_name = 'sp_grupal_monto'
-- validaciones para Insercion y Modificacion

select @w_parm_ofi_movil = pa_smallint from cobis..cl_parametro where pa_nemonico = 'OFIAPP' and pa_producto = 'CRE'

if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if @i_tramite is null or @i_ente is null -- LGU: para llamado desde mantenimiento de Grupos
    begin
        select @w_error = 2101001 --CAMPOS NOT NULL CON VALORES NULOS
        goto ERROR
    end
	
	--Se validan montos
end

if @i_operacion = 'I' -- LGU: 22/AGO/2017 insertar un cliente desde MANTENIMIENTO DE GRUPOS
begin
    if exists(select 1 from cr_tramite_grupal where tg_tramite = @i_tramite and tg_cliente    = @i_ente)
    begin
        select @w_error = 2101002  -- REGISTRO YA EXISTE
        goto ERROR
    end

    select @w_val_ahorro_vol = tr_porc_garantia from cr_tramite
    where tr_tramite = @i_tramite

    select @w_val_ahorro_vol = isnull( @w_val_ahorro_vol , (select pa_int from cobis..cl_parametro where pa_nemonico = 'VAHVO' and pa_producto = 'CRE' ))

    insert into cr_tramite_grupal (
        tg_tramite           ,    tg_grupo             ,    tg_cliente           ,
        tg_monto             ,    tg_grupal            ,    tg_operacion         ,
        tg_prestamo          ,
        tg_referencia_grupal ,    tg_cuenta            ,    tg_cheque            ,
        tg_participa_ciclo   ,    tg_monto_aprobado    ,    tg_ahorro            ,
        tg_monto_max         ,    tg_bc_ln             ,    tg_incremento        ,
        tg_monto_ult_op      ,    tg_monto_max_calc    ,    tg_monto_min_calc)
    select top 1 -- <<------------ EL PRIMER REGISTRO SOLAMENTE
        tg_tramite           ,    tg_grupo             ,    @i_ente              ,
        0                    ,    'S'                  ,    (select op_operacion from cob_cartera..ca_operacion where op_tramite = @i_tramite),
        tg_referencia_grupal          ,
        tg_referencia_grupal ,    tg_cuenta            ,    tg_cheque            ,
        'N'                  ,    0                    ,    @w_val_ahorro_vol    ,
        null                 ,    null                 ,    null                 ,
        null                 ,    NULL                 ,    null
    from cr_tramite_grupal 
    where tg_tramite = @i_tramite

    if @@error <> 0
    begin
        select @w_error = 150000 -- ERROR EN INSERCION
        goto ERROR
    end


 -- LGU-ini 22/AGO/2017  RECALCULAR MONTO MAXIMO Y PORC. DE INCREMENTO
    exec @w_return = sp_grupal_monto
    @s_ssn     = @s_ssn ,
    @s_rol     = @s_rol ,
    @s_ofi     = @s_ofi ,
    @s_sesn    = @s_sesn ,
    @s_user    = @s_user ,
    @s_term    = @s_term ,
    @s_date    = @s_date ,
    @s_srv     = @s_srv ,
    @s_lsrv    = @s_lsrv ,
    @i_operacion = 'R',
    @i_tramite   = @i_tramite,
    @i_modo      = 1

    -- LGU-ini 22/AGO/2017  RECALCULAR MONTO MAXIMO Y PORC. DE INCREMENTO
    exec @w_return = sp_grupal_monto
    @s_ssn     = @s_ssn ,
    @s_rol     = @s_rol ,
    @s_ofi     = @s_ofi ,
    @s_sesn    = @s_sesn ,
    @s_user    = @s_user ,
    @s_term    = @s_term ,
    @s_date    = @s_date ,
    @s_srv     = @s_srv ,
    @s_lsrv    = @s_lsrv ,
    @i_operacion = 'Q',
    @i_tramite   = @i_tramite,
    @i_modo      = 1

    if @w_return <> 0
    begin
        select @w_error = 21008,
               @w_msg   = 'Error al determinar MONTO MAX Y PORCENTAJE DE INCREMENTO'
        goto ERROR
    end
    -- LGU-ini 22/AGO/2017  RECALCULAR MONTO MAXIMO Y PORC. DE INCREMENTO
    return 0
end

if @i_operacion = 'U'  -- Modificar el valor de la solicitud de un cliente del tramite del grupo
begin
	
	if @i_modo = 1 --Se crea este modo para actualizar solo el cheque
    begin
       update cr_tramite_grupal
       set    tg_cheque   = @i_cheque
       where  tg_tramite  = @i_tramite
       and    tg_cliente  = @i_ente
       and    tg_grupo    = @i_grupo
    end
    
    if @i_modo = 2 
    begin 
       if exists (select 1 from cobis..cl_ente_aux, cob_credito..cr_tramite_grupal where ea_nivel_riesgo_cg = 'F'
					and ea_ente = @i_ente and ea_ente = tg_cliente and tg_tramite = @i_tramite and @i_participa_ciclo = 'S')
	   begin
	      select @w_msg = (isnull(en_nombre,'') + ' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,''))
		   from cobis..cl_ente, cobis..cl_ente_aux
		  where ea_nivel_riesgo_cg = 'F'
		    and en_ente = ea_ente
		    and en_ente = @i_ente
			
          select 
          @w_error = 103167,
		  @w_msg   = 'Prospecto rechazado por deterioro crediticio: ' + @w_msg 
			goto ERROR
	   end
       
       --consulta el cédigo de trámite anterior  
	   select @w_tramite_anterior = max(tg_tramite)
       from cob_credito..cr_tramite_grupal
	   where tg_grupo = @i_grupo
       and tg_tramite < @i_tramite
       
       PRINT 'SMO tramite anterior'+  convert(varchar,@w_tramite_anterior)
       
	   select @w_ciclo_grupo = gr_num_ciclo from cobis..cl_grupo where gr_grupo = @i_grupo
             
       if(@w_ciclo_grupo >= 1)
       begin
          -- LGU-ini: 2017-06-22 control de montos multiplos de 100
          select @w_multiplo = pa_money from cobis..cl_parametro
          where pa_producto = 'CCA'
          and pa_nemonico = 'MUL100'
          
          select @w_multiplo = isnull(@w_multiplo, 100)
          -- LGU-fin: 2017-06-22 control de montos multiplos de 100
       end
       else
       begin
          -- LGU-ini: 2017-06-22 control de montos multiplos de 500
          select @w_multiplo = pa_money from cobis..cl_parametro
          where pa_producto = 'CCA'
          and pa_nemonico = 'MUL500'
          
          select @w_multiplo = isnull(@w_multiplo, 100)
          -- LGU-fin: 2017-06-22 control de montos multiplos de 500
	   end
       
       -- ACHP se cambia para que el monto aprobado sea el tg_monto y
       -- el monto solicitado sea el monto aprobado.
       if ((@i_tg_monto_aprobado <> 0) and (@i_monto = 0))
       begin
          select 
          @w_error = 21011,
          @w_msg   = 'Error el monto solicitado del cliente '+ (select en_nomlar from cobis..cl_ente where en_ente = @i_ente) + ' no puede ser 0 si se ingresa monto autorizado '
          goto ERROR
       end
       
	   --Se valida si es renovacion
	   select @w_op_anterior = op_anterior from cob_cartera..ca_operacion where op_tramite= @i_tramite
	   if( @w_op_anterior is not null)
	   begin 
				print 'ES RENOVACION'
			    select  @w_saldo_actual = sum(am_acumulado + am_gracia - am_pagado)
				from cr_tramite_grupal, cob_cartera..ca_amortizacion
				where tg_referencia_grupal =(select op_anterior from cob_cartera..ca_operacion where op_tramite=@i_tramite)
				and am_operacion =  tg_operacion
				and tg_cliente = @i_ente
				and tg_monto > 0
				and tg_participa_ciclo = 'S'
				group by tg_cliente, tg_prestamo, tg_operacion
				
				print 'SALDO ACTUAL: '+convert(varchar(10),@w_saldo_actual)
				
				if(( @i_monto - @w_saldo_actual) <=0)
				begin
					select 
					@w_error = 21011,
					@w_msg   = 'El monto resultado del cliente '+ (select en_nomlar from cobis..cl_ente where en_ente = @i_ente) + ' no puede ser menor o igual a 0 '
					goto ERROR
				end
	   end
	   
       
       -- LGU-ini: 2017-06-22 control de montos multiplos de 100
       if (@i_tg_monto_aprobado % @w_multiplo) = 0
       begin  
          --monto aprobado es multiplo
          update cr_tramite_grupal
          set    tg_monto           = @i_tg_monto_aprobado,  --ACHP - Se cambia por conceptos
                 tg_participa_ciclo = @i_participa_ciclo,    --LPO Santander
                 tg_monto_aprobado  = @i_monto,              --ACHP - Se cambia por conceptos - es el monto solicitado
                 tg_ahorro          = @i_ahorro,             --LPO Santander
                 tg_monto_max       = @i_monto_max,          --LPO Santander
                 tg_bc_ln           = @i_bc_ln,              --LPO Santander
                 tg_conf_grupal     = 'N'                    --Por cada cliente, se dispara el update de monto, pero se requiere que la validación de reconformación grupal se haga solo en el último de los updates	
	                                                         --para lo cual se utiliza el campo tg_conf_grupal, que se actualiza cada vez que se dispara el update del monto del cliente
          where  tg_tramite         = @i_tramite
          and    tg_cliente         = @i_ente
          and    tg_grupo           = @i_grupo
       
          
          --Consulta si existe algun registro con valor null, si no existe significa que fue el último update
          select tg_tramite
          from  cob_credito..cr_tramite_grupal
          where tg_tramite    = @i_tramite
          and   tg_conf_grupal is null
          
          if @@rowcount = 0 begin  -- si todos los registros son diferentes de null (si ya se actualizaron todos los montos uno a uno)
             select @w_debe_validar = 'S'
		     print 'SMO 1 todos los registros se han actualizado'
		     update cob_credito..cr_tramite_grupal -- se ponen todos null para que vuelva a validar porque es una nueva actualizacion de todos los montos 
             set tg_conf_grupal = null
             where tg_grupo    = @i_grupo
             and tg_tramite    = @i_tramite
          end
          else
	  	     print 'SMO 1 NO todos los registros se han actualizado '+convert(varchar(10),@i_ente)
       
       
          --MONTO GRUPAL
          if @w_debe_validar = 'S' --debe Validar en S
          begin
             print 'SMO 1 entra a validar '+convert(varchar(10),@i_ente)
             
			 --Se quita el estado X, por el caso #156045 (cancelado)
             --if @w_tramite_anterior is not null and  EXISTS (select 1 from cob_credito..cr_tramite where tr_tramite = @w_tramite_anterior and tr_estado in ('X','Z'))
			 if @w_tramite_anterior is not null and  EXISTS (SELECT 1 FROM cob_credito..cr_tramite WHERE tr_tramite = @w_tramite_anterior AND tr_estado in ('Z'))
             begin
                select @w_num_ant = count (tg_cliente) from  cr_tramite_grupal tg where tg_tramite = @w_tramite_anterior and tg_monto_aprobado > 0
                select @w_num_comunes_ant = count (tg_cliente)  from  cr_tramite_grupal tg where tg_tramite = @w_tramite_anterior and tg_monto_aprobado > 0 and tg_cliente IN 
                      (select tg_cliente from  cr_tramite_grupal tg where tg_tramite = @i_tramite)

                select @w_num_act = count (tg_cliente) from  cr_tramite_grupal tg where tg_tramite = @i_tramite and tg_monto_aprobado > 0
                select @w_num_comunes_act = count (tg_cliente) from  cr_tramite_grupal tg where tg_tramite = @i_tramite and tg_monto_aprobado > 0 and tg_cliente IN 
                      (select tg_cliente from  cr_tramite_grupal tg where tg_tramite = @w_tramite_anterior)
                
		        PRINT 'SMO VALIDA  @w_num_ant'+ convert(VARCHAR(10),@w_num_ant)
		        PRINT 'SMO VALIDA  @w_num_comunes_ant'+ convert(VARCHAR(10),@w_num_comunes_ant)
		        PRINT 'SMO VALIDA  @w_num_act'+ convert(VARCHAR(10),@w_num_act)
		        PRINT 'SMO VALIDA  @w_num_comunes_act'+ convert(VARCHAR(10),@w_num_comunes_act)
		
                if @w_num_ant = @w_num_comunes_ant and @w_num_act = @w_num_comunes_act and @w_num_ant = @w_num_act
                begin
                    PRINT 'SMO RESULTADO: NO CAMBIO EL GRUPO'
                    select 
                    @w_error =5300,
                    @w_msg   = 'No puede continuar la solicitud porque no hubo reconformación grupal'
                    goto ERROR
                end
                else
                    print 'SMO RESULTADO: SI cambio el grupo'
             end
                else
                     print 'SMO RESULTADO: VALIDA  no existe trámite anterior o el trámite anterior no fue rechazado'
          end -- End debe validar en S
          else
             print 'SMO RESULTADO: NO ENTRA A VALIDAR '+convert(varchar(10),@i_tramite)+' valida cliente '+convert(varchar(10),@i_ente)
       end  --End monto aprobado es multiplo
            -- EMITIR MENSAJES DE ALERTA POR SOBREPASAR EL MONTO MAXIMO Y EL PORC. DE INREMENTO
       else
       begin
          select @w_error = 99 --  Debe Ingresar los Montos
          select @w_msg = 'Para: ' + (select en_nombre + ' ' + p_p_apellido from cobis..cl_ente where en_ente = @i_ente) +
                             '. El valor ' + convert(varchar, @i_tg_monto_aprobado) + ' no es múltiplo de ' + convert(varchar,@w_multiplo)+'.'
          goto ERROR
       end
            
       --seguros
       if @i_insurance is not null and @i_tramite is not null and @i_tramite > 0
       begin
          exec @w_return = cob_cartera..sp_mantenimiento_seguros
               @t_file           = @t_file       ,
               @t_from           = @t_from       ,
               @i_tramite        = @i_tramite    ,
               @i_cliente        = @i_ente       ,
               @i_tipo_seguro    = @i_insurance,
               @i_grupo          = @i_grupo      ,
               @i_operacion      = 'I',
			   @s_user           = @s_user,
			   @s_term           = @s_term
                   
          if @w_return <> 0
          begin
             select @w_error = @w_return,
                    @w_msg   = 'Error al ejecutar mantenimiento seguros'
             goto ERROR
          end        
       end
   end
   else 
   if @i_modo = 3
   begin
      if(@i_mant_grp='N')
      begin
         print 'Ingresa por flujo y por mantenimiento de grupos '
         
         select tg_tramite, tg_cliente, tg_monto, tg_monto_aprobado, tg_participa_ciclo, cg_rol
         into #tramite_grupal
         from cob_credito..cr_tramite_grupal, cobis..cl_cliente_grupo
         where tg_tramite = @i_tramite
         and   cg_grupo   = tg_grupo
         and   cg_ente    = tg_cliente
         and   cg_estado  = 'V'
         
         --Aqui poner la validacion de P,S,T--
         if not exists (select 1 from #tramite_grupal where cg_rol = 'P')
         begin
            select @o_msg1 = 'EL GRUPO DEBE TENER UN PRESIDENTE'
            select @w_error = 208921 --'EL GRUPO DEBE TENER UN PRESIDENTE'
            goto ERROR
         end
             
         if not exists (select 1 from #tramite_grupal where cg_rol='S')
         begin
            select @o_msg1 = 'EL GRUPO DEBE TENER UN SECRETARIO'
            select @w_error = 208926 --'EL GRUPO DEBE TENER UN SECRETARIO'
            goto ERROR
         end
             
         if not exists (select 1 from #tramite_grupal where cg_rol='T')
         begin
            select @o_msg1 = 'EL GRUPO DEBE TENER UN TESORERO'
            select @w_error = 208922 --'EL GRUPO DEBE TENER UN SECRETARIO'
            goto ERROR
         end             
						
         /*Validacion de que la Directiva participe*/
         if((select count(1) from #tramite_grupal
             where cg_rol     in ('P','S','T')
             and tg_monto   > 0
             and tg_participa_ciclo = 'S') < 3)
         begin
            select @o_msg1 = 'LOS INTEGRANTES DEL COMITE DEBEN PARTICIPAR'
            select @w_error = 2108051 --LOS INTEGRANTES DEL COMITE DEBEN PARTICIPAR
            goto ERROR			
         end	
	  end 					
           
      exec @w_return = sp_grupal_monto
           @s_ssn     = @s_ssn ,
           @s_rol     = @s_rol ,
           @s_ofi     = @s_ofi ,
           @s_sesn    = @s_sesn ,
           @s_user    = @s_user ,
           @s_term    = @s_term ,
           @s_date    = @s_date ,
           @s_srv     = @s_srv ,
           @s_lsrv    = @s_lsrv ,
           @i_operacion = 'R',
           @i_tramite   = @i_tramite,
           @i_modo      = 2,
           @o_tasa_grp  = @o_tasa_grp output
             
      if @w_return <> 0
      begin
         select @w_error = 21008,
                @w_msg   = 'Error al determinar MONTO MAX Y PORCENTAJE DE INCREMENTO'
         goto ERROR
      end
             
      -- LGU-INI: control de porcentaje y montos maximos 2017-06-21
      exec @w_return = sp_grupal_reglas
           @i_tramite = @i_tramite,
           @i_id_rule = 'VAL_TRAMITE',
           @o_msg1    = @o_msg1  output,
           @o_msg2    = @o_msg2  OUTPUT,
           @o_msg3    = @o_msg3  output
	  
	  select @o_msg1 = @o_msg1 + '-' + @o_msg2 + '-' + @o_msg3+ '-' +@o_msg4
      -- LGU-FIN: control de porcentaje y montos maximos 2017-06-21
      
      select @w_suma_montos       = sum(tg_monto),
             @w_suma_montos_aprob = sum(tg_monto_aprobado) --ACHP - Solicitado
      from   #tramite_grupal

      -- Inicio Se copia de sp_pasa_cartera_interciclo porque los datos no quedaban consistentes
      select @w_operacionca       = op_operacion,
             @w_fecha_liq         = convert(varchar(10),op_fecha_liq,@w_formato_fecha),
             @w_moneda            = op_moneda,
             @w_fecha_ini         = convert(varchar(10),op_fecha_ini,@w_formato_fecha),
             @w_fecha_fin         = convert(varchar(10),op_fecha_fin,@w_formato_fecha),
             @w_oficina           = op_oficina,
             @w_banco             = op_banco,
             @w_cliente           = op_cliente,
             @w_nombre            = op_nombre,
             @w_estado            = op_estado,
             @w_op_direccion      = op_direccion,
             @w_lin_credito       = op_lin_credito,
             @w_tipo_amortizacion = op_tipo_amortizacion,
             @w_cuota             = op_cuota,
             @w_periodo_cap       = op_periodo_cap,
             @w_periodo_int       = op_periodo_int,
             @w_base_calculo      = op_base_calculo,
             @w_dias_anio         = op_dias_anio,
             @w_plazo             = op_plazo,
             @w_tplazo            = op_tplazo,
             @w_banca             = op_banca,
             @w_promocion         = op_promocion,     --LPO Santander
             @w_acepta_ren        = op_acepta_ren,    --LPO Santander
             @w_no_acepta         = op_no_acepta,     --LPO Santander
             @w_emprendimiento    = op_emprendimiento, --LPO Santander
             @w_desplazamiento    = op_desplazamiento  
      from  cob_cartera..ca_operacion
      where op_tramite = @i_tramite
      
      select @w_plazo_no_vigente = count(1) - 1,
      @w_min_fecha_vig    = convert(varchar(10),min(di_fecha_ini),@w_formato_fecha)
      from  cob_cartera..ca_dividendo
      where di_operacion = @w_operacionca --@w_tg_operacion
      and   di_estado    = @w_est_novigente
       
      --Se añade validacion por problemas en montos
     if(@w_suma_montos > 0)
     begin
        -- BORRAR TEMPORALES
        exec @w_return = cob_cartera..sp_borrar_tmp
             @i_banco  = @w_banco,
             @s_user   = @s_user,
             @s_term   = @s_term
                   
        if @w_return <> 0
             return @w_return
                     
        ---PASAR A TEMPRALES CON LOS ULTIMOS DATOS
        exec @w_return          = cob_cartera..sp_pasotmp
             @s_term            = @s_term,
             @s_user            = @s_user,
             @i_banco           = @w_banco,
             @i_operacionca     = 'S',
             @i_dividendo       = 'S',
             @i_amortizacion    = 'S',
             @i_cuota_adicional = 'S',
             @i_rubro_op        = 'S',
             @i_nomina          = 'S'
                   
        if @w_return <> 0
             return @w_return

        exec @w_return = cob_cartera..sp_modificar_oper_sol_wf
             @i_tipo              = @w_tipo,--'O',
             @i_tramite           = @i_tramite,--3862386,
             @i_cliente           = @w_cliente,
             @i_nombre            = @w_nombre_grupo,--'COOP MCUSTODE',
             --@i_codeudor          = 0,
             @i_sector            = @w_sector,--'1',
             @i_toperacion        = @w_toperacion,--'CREGRP',
             @i_oficina           = @w_oficina,--1,
             @i_moneda            = @w_moneda,--0,
             @i_comentario        = 'Operacion creada desde Workflow',
             @i_oficial           = @w_oficial,--2,
             @i_fecha_ini         = @w_fecha_crea,--'04/26/2017 00:00:00.000',
             @i_monto             = @w_suma_montos,    --ACHP - Se cambia por conceptos
             @i_monto_aprobado    = @w_suma_montos,    --ACHP - Se cambia por conceptos
             @i_destino           = @w_destino,--'02',
             @i_ciudad            = @w_ciudad,--212,
             @i_formato_fecha     = @w_formato_fecha,
             --@i_clase_cartera     = '1',
             --@i_numero_reest      = 0,
             @i_num_renovacion    = 0,
             @i_grupal            = 'S',
             @i_cuota             = 0,
             @i_banca             = @w_banca,
             @i_operacionca       = @w_operacionca,--2500,
             @i_promocion         = @w_promocion,     --LPO Santander
             @i_acepta_ren        = @w_acepta_ren,    --LPO Santander
             @i_no_acepta         = @w_no_acepta,     --LPO Santander
             @i_emprendimiento    = @w_emprendimiento,--LPO Santander
             @t_trn               = 77300,
             @o_operacion         = 0,
             @o_tramite           = 0,
             @s_srv               = 'CTSSRV',
             @s_user              = @s_user,--'admuser',
             @s_term              = @s_term,--'192.168.84.100',
             @s_ofi               = @s_ofi,--1,
             --@s_rol               = 3,
             @s_ssn               = @s_ssn,--988145,
             @s_lsrv              = 'CTSSRV',
             @s_date              = @s_date,--'04/26/2017',
             @s_sesn              = @s_sesn, --23985,
	         @i_desplazamiento    = @w_desplazamiento, --SRO #140073
             @i_plazo             = @w_plazo
        if @w_return <> 0
           return @w_return
             
        if @o_msg1 is not null
        begin
            print ' ALERTA 1: ' + @o_msg1 --'<<< Existen Prestamos que SUPERAN EL INCREMENTO PERMITIDO>>>'
        end
        
        if @o_msg2 is not null
        begin
            print ' ALERTA 2: ' + @o_msg2 --'<<<Existen Prestamos que SUPERAN EL MONTO MAXIMO>>>'
        end
        
        if @o_msg3 is not null
        begin
            print ' ALERTA 3: ' + @o_msg3 --'<<<Existen Prestamos que SUPERAN EL MONTO MAXIMO>>>'
        end
     end
     else
     begin
        select @w_error = 2103058 --  Debe Ingresar los Montos
        select @w_msg = 'Debe ingresar un monto.  '
        goto ERROR
     end
            
   end
   /*
   if @i_insurance is not null and @i_tramite is not null and @i_tramite > 0
   begin
      exec @w_return = cob_cartera..sp_mantenimiento_seguros
	       @t_file           = @t_file       ,
		   @t_from           = @t_from       ,
	       @i_tramite        = @i_tramite    ,
		   @i_cliente        = @i_ente       ,
		   @i_tipo_seguro    = @i_insurance	,
		   @i_grupo          = @i_grupo      ,
		   @i_operacion      = 'I' 
			   
      if @w_return <> 0
	  begin
	     select @w_error = @w_return,
			    @w_msg   = 'Error al ejecutar mantenimiento seguros'
				goto ERROR
	  end        
   end*/
   return 0
end

if @i_operacion = 'D' -- Eliminar un cliente del tramite del grupo
begin
   
    select @w_monto = tg_monto
    from cr_tramite_grupal
    where tg_tramite = @i_tramite
    and tg_cliente = @i_ente

    select @w_monto = isnull(@w_monto ,0)
    
    --begin tran
    delete cr_tramite_grupal
    where tg_tramite = @i_tramite
    and   tg_cliente = @i_ente

    if @@error <> 0
    begin
        select @w_error = 150004 -- ERROR EN ELIMINACION
        goto ERROR
    end

    -- LGU-ini 22/ago/2017 regenerar la operacion, si elimina un cliente que solicita prestamo
    if @w_monto > 0
    begin
       print'@i_mant_grp' +convert(varchar(50),@i_mant_grp)
       
       exec @w_return = sp_grupal_monto
        @s_ssn     = @s_ssn ,
        @s_rol     = @s_rol ,
        @s_ofi     = @s_ofi ,
        @s_sesn    = @s_sesn ,
        @s_user    = @s_user ,
        @s_term    = @s_term ,
        @s_date    = @s_date ,
        @s_srv     = @s_srv ,
        @s_lsrv    = @s_lsrv ,
        @i_operacion = 'U',
        @i_tramite   = @i_tramite,
        @i_ente      = @i_ente,
        @i_modo      = 3,
        @i_mant_grp  =@i_mant_grp,
        @o_msg1      = @o_msg1 out

        if @w_return <> 0
        begin
           select @w_error = 21008
           if @o_msg1 <>''
               select @w_msg = @o_msg1
           else
               select @w_msg   = 'Error al determinar MONTO MAX Y PORCENTAJE DE INCREMENTO'
            
            goto ERROR
        end
    end
    -- LGU-fin 22/ago/2017 regenerar la operacion, si elimina un cliente que solicita prestamo
    --commit

    return 0
end

if @i_operacion = 'R' -- Calcula reglas
begin 
   print 'Ingreso a Operacion R'
   -- LGU-INI: control de porcentaje y montos maximos 2017-06-21
   if exists(select 1 from cr_tramite_grupal tg where tg_tramite = @i_tramite) ----  LGU: para recalcular siempre - and ( tg_monto_max_calc is null or ------- tg_monto_ult_op is null ))
   begin
      exec @w_return  = sp_grupal_reglas
           @s_ssn     = @s_ssn ,
           @s_rol     = @s_rol ,
           @s_ofi     = @s_ofi ,
           @s_sesn    = @s_sesn ,
           @t_trn     = 1111    ,
           @s_user    = @s_user ,
           @s_term    = @s_term ,
           @s_date    = @s_date ,
           @s_srv     = @s_srv ,
           @s_lsrv    = @s_lsrv ,
           @i_tramite = @i_tramite,
           @i_valida_part = 'N', --para que valide las reglas para los que no participan
           @i_id_rule = 'INC_GRP'  -- encontral el % incremento y monto de ultima operacion cancelada
			
      if @w_return <> 0
      begin
         select @w_error = 21008,
                @w_msg   = 'Error al determinar PORCENTAJE DE INCREMENTO'
         goto ERROR
      end
      
      exec @w_return  = sp_grupal_reglas
           @s_ssn         = @s_ssn ,
           @s_rol         = @s_rol ,
           @s_ofi         = @s_ofi ,
           @s_sesn        = @s_sesn ,
           @t_trn         = 1111    ,
           @s_user        = @s_user ,
           @s_term        = @s_term ,
           @s_date        = @s_date ,
           @s_srv         = @s_srv ,
           @s_lsrv        = @s_lsrv ,
           @i_tramite     = @i_tramite,
           @i_valida_part = 'N', --para que valide las reglas para los que no participan
           @i_id_rule     = 'MONTO_GRP'  -- encontrar el monto maximo del cliente
                
      if @w_return <> 0
      begin
         select @w_error = 21009,
                 @w_msg   = 'Error al determinar MONTO MAXIMO'
         goto ERROR
      end
      
      exec @w_return = sp_grupal_reglas
           @s_ssn     = @s_ssn ,
           @s_rol     = @s_rol ,
           @s_ofi     = @s_ofi ,
           @s_sesn    = @s_sesn ,
           @t_trn     = 1111    ,
           @s_user    = @s_user ,
           @s_term    = @s_term ,
           @s_date    = @s_date ,
           @s_srv     = @s_srv ,
           @s_lsrv    = @s_lsrv ,
           @i_tramite = @i_tramite,
           @i_valida_part = 'N', --para que valide las reglas para los que no participan
           @i_id_rule = 'TASA_GRP',  -- encontral el % incremento y monto de ultima operacion cancelada
           @o_resultado   = @o_tasa_grp output
			
      if @w_return <> 0
      begin
         select @w_error = 21008,
                @w_msg   = 'Error al determinar TASA GRUPAL'
         goto ERROR
      end
            
      print 'RESULTADO TASA GRP ---->>>>' + @o_tasa_grp
            
      select @w_ingreso = pa_char 
      from cobis..cl_parametro 
      where pa_nemonico = 'ETINGR'
      
      select @i_grupo      = tr_cliente,
             @w_promocion  = tr_promocion
      from cob_credito..cr_tramite where tr_tramite = @i_tramite
            
      /* Este proceso sólo se ejecuta en la etapa de ingreso */
      if exists (select 1 from cob_workflow..wf_inst_proceso, cob_workflow..wf_inst_actividad, 
                 cob_workflow..wf_asig_actividad, cob_workflow..wf_actividad
                 where ia_codigo_act = ac_codigo_actividad and aa_id_inst_act = ia_id_inst_act
                 and ia_id_inst_proc = io_id_inst_proc and aa_estado = 'PEN' and io_estado = 'EJE'
                 and ia_nombre_act = @w_ingreso and io_campo_3 = @i_tramite and io_campo_1 = @i_grupo)
      begin
         if @i_modo <> 2 or @i_modo is null  /* Para que no recalcule el monto sugerido cuando se guarda */
         begin
            exec cob_credito..sp_monto_inicial
         	     @i_tramite        = @i_tramite,
                 @i_grupo          = @i_grupo,
             	 @i_promocion      = @w_promocion,
             	 @i_ejecuta_reg_ini= 'N'
         end
      end
            
      -- LGU: 22/ago/2017 para que retorne si es llamado desde mantenimiento de GRUPOS
      if @i_modo = 1 return 0
   end
        -- LGU-FIN: control de porcentaje y montos maximos 2017-06-21
end

if @i_operacion = 'Q' -- consulta: valores de la solicitud de los integrantes del grupo
begin
    if exists( select 1 from cr_tramite_grupal tg where tg_tramite = @i_tramite )
    begin

  declare @w_integrantes_montos table (
		   cliente                int,           
		   nombre                 varchar(254),           
		   monto                  money,             
		   cuenta                 varchar(45),        
		   cheque                 int,           
		   participa_ciclo        char(1),   
		   monto_aprobado         money,    
		   ahorro                 money,            
		   monto_max              money,
		   incremento             money,
		   listas_negras          varchar(10),     
		   role                   varchar(10),         
		   cycleNumber            int,
		   rfc                    varchar(30),
		   liquidGuarantee        float,
		   riskLevel              varchar(10),
		   safePackage            char(20),
		   checkRenapo            char(1)
        )		   
		   
		   
        insert into @w_integrantes_montos
        select
        'cliente'             = tg_cliente,
        'nombre'              = (select en_nomlar from cobis..cl_ente where en_ente = tg.tg_cliente),
        'monto'               =  tg_monto,
        'cuenta'              = '',--(select ea_cta_banco from cobis..cl_ente_aux where ea_ente=tg.tg_cliente ),
        'cheque'              = tg_cheque,
        'participa_ciclo'     = tg_participa_ciclo,          --LPO Santander
        'monto_aprobado'      = isnull(tg_monto_aprobado,0), --LPO Santander
        'ahorro'              = isnull(tg_ahorro,0),         --LPO Santander
        'monto_max'           = isnull(tg_monto_max_calc,0),      --LPO Santander
        'incremento'          = case when (en_nro_ciclo is null or en_nro_ciclo = 0 or tg_monto_ult_op = 999999999)  then tg_monto_max_calc else (tg_monto_ult_op*(1+tg_incremento/100)) end,
        'listas_negras'       = tg_bc_ln,                     --LPO Santander
        'role'                = cg_rol,
        'cycleNumber'         = 0,
        'rfc'                 = en_nit,
        'liquidGuarantee'     = ((ISNULL(tr_porc_garantia,0))*tg_monto/100),
        'riskLevel'           = (ISNULL(en_calificacion,'')),
        'safePackage'         = ISNULL((select se_tipo_seguro from  cob_cartera..ca_seguro_externo where se_tramite = tg_tramite and se_cliente = tg_cliente),''),
        'checkRenapo'         = ''
        from  cr_tramite_grupal tg,cobis..cl_cliente_grupo cg, cobis..cl_ente,  cob_credito..cr_tramite, cobis..cl_grupo
        where tg_tramite = @i_tramite
        and   tg_cliente = cg_ente 
        and   tg_cliente = en_ente
        and   tg_tramite = tr_tramite
        and   gr_grupo   = tg_grupo
        and   cg_estado  = 'V'
		
        update @w_integrantes_montos set
        cuenta      = ea_cta_banco,
        checkRenapo = ea_consulto_renapo
        from cobis..cl_ente_aux
        where cliente = ea_ente		
		
	    update @w_integrantes_montos set
        cycleNumber = (select isnull(max(dc_ciclo_grupo), 0) + 1 from cob_cartera..ca_det_ciclo where dc_cliente = cliente)        
        
        select 
        cliente,         
        nombre,          
        monto ,          
        cuenta,          
        cheque,       
        participa_ciclo, 
        monto_aprobado,  
        ahorro,          
        monto_max,       
        incremento,      
        listas_negras,   
        role,            
        cycleNumber,     
        rfc,             
        liquidGuarantee, 
        riskLevel,
		checkRenapo,
        safePackage    
        from @w_integrantes_montos
		
        return 0
    end
    else
    begin
        select @i_operacion = 'G'
    end
end


if @i_operacion = 'G' -- consulta de los miembros del grupo que van a solicitar el prestamo
begin

    select
        'cliente' = cg_ente,
        'nombre' = (select en_nomlar from cobis..cl_ente where en_ente = cg.cg_ente),
        'monto'  = 0
    from cobis..cl_grupo, cobis..cl_cliente_grupo cg
    where gr_grupo = @i_grupo
    and gr_grupo = cg_grupo
    and  cg_estado='V'

    insert into cr_tramite_grupal (tg_tramite, tg_cliente, tg_monto, tg_grupal, tg_grupo )
    select
        @i_tramite,
        cg_ente,
        0,
        'S',
        @i_grupo
    from cobis..cl_grupo, cobis..cl_cliente_grupo cg
    where gr_grupo = @i_grupo
    and gr_grupo = cg_grupo
    and  cg_estado='V'

    if @@error <> 0
    begin
        select @w_error = 150000 -- ERROR EN INSERCION
        goto ERROR
    end

    return 0
end

if @i_operacion = 'C' -- consulta: para servicio de recuperar data de la solicitud - para enviar a la movil - sp_grupal_xml
begin
    if exists( select 1 from cr_tramite_grupal tg where tg_tramite = @i_tramite )
    begin
	    declare @i_inst_proc int
	    select @i_inst_proc = io_id_inst_proc,
		       @i_grupo     = io_campo_1
		from cob_workflow..wf_inst_proceso where io_campo_3 = @i_tramite		
		        
        exec cob_pac..sp_grupo_busin
        @i_operacion       = 'M',
        @i_grupo           = @i_grupo,
		@t_trn             = 800,
        @o_actualiza_movil = @w_actualiza_movil OUTPUT
        
	    select
        'applicationDate'= (select format(op_fecha_liq,'yyyy-MM-ddTHH:mm:ss.fffZ')),
        'applicationType'= op_toperacion,
		'groupAgreeRenew'= TR.tr_acepta_ren,
        'groupAmount'    = op_monto,
        'groupCycle'     = isnull(G.gr_num_ciclo,0),
        'groupName'      = G.gr_nombre,
        'groupNumber'    = G.gr_grupo,
        'office'         = (select of_nombre from cobis..cl_oficina where of_filial = 1 and of_oficina = TR.tr_oficina),
        'officer'        = (select fu_nombre from cobis..cl_funcionario, cobis..cc_oficial
                                   where oc_funcionario = fu_funcionario and oc_oficial = TR.tr_oficial),
        'processInstance'= @i_inst_proc,
		'promotion'      = TR.tr_promocion,
        'rate'           = convert (VARCHAR(30),(select ro_porcentaje from cob_cartera..ca_rubro_op
                                      where  ro_operacion = OP.op_operacion
                                      and OP.op_tramite = TR.tr_tramite
                                      and ro_concepto  = 'INT')),
        'reasonNotAccepting' = tr_no_acepta,
        'term'               = tr_plazo, 
	'flagModifyApplication' = @w_actualiza_movil,
        'displacement'          = (select op_desplazamiento from cob_cartera..ca_operacion where op_tramite = @i_tramite)
        from cob_cartera..ca_operacion OP,cobis..cl_grupo G, cob_credito..cr_tramite TR
        where OP.op_tramite=TR.tr_tramite
        and   OP.op_cliente=G.gr_grupo
        and   TR.tr_tramite =@i_tramite
    end
    return 0
end

if(@i_operacion = 'X')
begin
   select @w_grupo = io_campo_1 from cob_workflow..wf_inst_proceso where io_campo_3 = @i_tramite
   select @w_max_ciclo_grupo = max(dc_ciclo_grupo) from cob_cartera..ca_det_ciclo where dc_grupo = @w_grupo 

   select operacion_hij_ant = dc_operacion, 
          banco_hij_ant = convert(varchar(255),''), 
          cliente_ant = dc_cliente, 
		  referencia_grupal_ant = dc_referencia_grupal,
		  ciclo_ant = dc_ciclo_grupo
   into #operaciones_anteriores
   from cob_cartera..ca_det_ciclo,  cob_credito..cr_tramite_grupal -- Por caso #169730
   where dc_grupo = @w_grupo and dc_ciclo_grupo = @w_max_ciclo_grupo
   and dc_grupo = tg_grupo
   and dc_referencia_grupal = tg_referencia_grupal
   and tg_prestamo <> tg_referencia_grupal
   and dc_operacion = tg_operacion
   and dc_cliente = tg_cliente
   and tg_monto > 0
   and tg_participa_ciclo = 'S'
   
   update #operaciones_anteriores
   set banco_hij_ant = op_banco
   from cob_cartera..ca_operacion
   where op_operacion = operacion_hij_ant

   select
   'cliente'    = tg_cliente, 
   ----Antes
   'prestamo'   = convert(varchar(255),''), --tg_prestamo, 
   'operacion'  = convert(int,0), --tg_operacion
   'saldo'      = convert(money,0.0),
   ----Actual
   'monto'      = tg_monto,
   'monto_max'  = isnull(tg_monto_max_calc,0),      --LPO Santander
   'incremento' = case when (en_nro_ciclo is null or en_nro_ciclo = 0 or tg_monto_ult_op = 999999999)  then tg_monto_max_calc else (tg_monto_ult_op*(1+tg_incremento/100)) END,
   'ciclo'      = 0
   into #w_monto_grupal
   from cr_tramite_grupal, cobis..cl_ente
   where tg_tramite = @i_tramite   
   and   tg_cliente = en_ente

   update #w_monto_grupal set 
   prestamo = banco_hij_ant,
   operacion = operacion_hij_ant,
   ciclo = ciclo_ant + 1
   from #operaciones_anteriores
   where cliente = cliente_ant

   select saldo_antes = isnull (sum(AM.am_acumulado + AM.am_gracia - AM.am_pagado), 0),
          operacion_hij_ant
   into #saldo_antes		  
   from cob_cartera..ca_amortizacion AM, #operaciones_anteriores
   where AM.am_operacion = operacion_hij_ant
   group by operacion_hij_ant
   
   update #w_monto_grupal set 
   saldo = saldo_antes
   FROM #saldo_antes
   where operacion = operacion_hij_ant

   select * from #w_monto_grupal      	
 	
end

return 0

ERROR:
begin --Devolver mensaje de Error
        while @@trancount > 0 rollback

        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = @w_error,
             @i_msg   = @w_msg
        return @w_error
end
go
