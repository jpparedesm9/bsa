/************************************************************************/
/*    Archivo:                sp_ope_valid_cli.sp                       */
/*    Stored procedure:       sp_ope_valid_cli                          */
/*    Base de datos:          cobis                                     */
/*    Producto:               Clientes                                  */
/*    Disenado por:           KVI                                       */
/*    Fecha de escritura:     Octubre/2022                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'COBISCORP'.                                                      */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de COBISCORP o su representante.            */
/************************************************************************/
/*                              PROPOSITO                               */
/*    Operaciones de Validacion Cliente                                 */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    03/10/2022            KVI           Emision Inicial               */
/************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_ope_valid_cli')
    drop proc sp_ope_valid_cli
go

create proc sp_ope_valid_cli(
  @s_ssn              int         = null,
  @s_sesn             int         = null,
  @s_date             datetime    = null,
  @s_user             varchar(14) = null,
  @s_term             varchar(30) = null,
  @s_ofi              smallint    = null,
  @s_srv              varchar(30) = null,
  @s_lsrv             varchar(30) = null,
  @s_rol              smallint    = null,
  @s_org              varchar(15) = null,
  @s_culture          varchar(15) = null,
  @t_rty              char(1)     = null,
  @t_debug            char(1)     = 'N',
  @t_file             varchar(14) = null,
  @t_trn              int         = null,
  @i_operacion        varchar(10) = 'C',
  @i_ente             int         = null,
  @o_monto            money       = null out
)
as
declare
  @w_sp_name                     varchar(25),
  @w_error                       int,
  @w_msg                         varchar(200),
  @w_variables                   varchar(255),
  @w_result_values               varchar(255),
  @w_parent                      int,
  @w_resul_ciclo                 varchar(30),
  @w_tr_promocion_grupo          char(2),
  @w_tr_promocion                char(1),
  @w_var_en_nro_ciclo            smallint,
  @w_var_dias_atraso_grupal      int,
  @w_var_experiencia_crediticia  varchar(2),
  @w_ciclo_grupal                int,
  @w_monto_inicial               money,
  @w_monto_max_calc              money,
  @w_monto_min_calc              money


select @w_sp_name = 'sp_ope_valid_cli'

if @i_operacion = 'C' -- Calculo de Monto
begin
  print 'Calcula Monto Grupal del Cliente: ' + convert(varchar, @i_ente)
  
  -- Datos Cliente Nuevo
  select @w_tr_promocion_grupo = 'NO',
         @w_tr_promocion = 'N',
         @w_var_en_nro_ciclo = 1,
         @w_var_dias_atraso_grupal = 0,
		 @w_ciclo_grupal = 1
  
  
  -- Ejecucion de Experiencia Crediticia
  exec @w_error      = cob_credito..sp_var_experiencia_crediticia
       @i_id_cliente = @i_ente,
       @o_resultado  = @w_var_experiencia_crediticia output 
      
  if @w_error <> 0
  begin
    select @w_msg   = 'Error al determinar EXPERIENCIA CREDITICIA DEL CLIENTE'
    goto ERROR
  end
       
  print 'ID cliente en Regla: '+ convert (varchar(50), @i_ente)
  print 'Var Experiencia Crediticia: '+ convert (varchar(50), @w_var_experiencia_crediticia)
	  
  
  select @w_resul_ciclo = isnull(@w_tr_promocion_grupo,'NO')+'|' + 
        				  isnull (@w_tr_promocion,'N')+ '|' + 
                          isnull(convert(varchar,@w_var_en_nro_ciclo),'1') + '|' + 
	  				      isnull(convert(varchar,@w_var_dias_atraso_grupal),'0') + '|' + 
	  				      isnull(@w_var_experiencia_crediticia,' ')


  -- Ejecucion de Regla Monto Máximo Grupal (Monto Minimo y Monto Maximo)
  exec @w_error                 = cob_pac..sp_rules_param_run
	   @s_rol                   = @s_rol,
	   @i_rule_mnemonic         = 'MONTO_GRP',
	   @i_var_values            = @w_resul_ciclo, 
	   @i_var_separator         = '|',
	   @o_return_variable       = @w_variables     out,
	   @o_return_results        = @w_result_values out,
	   @o_last_condition_parent = @w_parent        out
         
  if @w_error != 0
  begin
    print 'Print: fallo MONTO_GRP para cliente ' + convert(varchar, @i_ente)
	print 'Error_fallo_monto_grp_regla:' + convert(varchar, @w_error)
	
	select @w_error = 21009,
	       @w_msg   = 'Error al determinar MONTO MAXIMO GRUPAL'
    goto ERROR
  end
  
  if @w_result_values is null
  begin
  	select @w_result_values = '0|0'
  end
	
  print '@w_variables MONTO_GRP: '     + convert(varchar(50),@w_variables)
  print '@w_result_values MONTO_GRP: ' + convert(varchar(50),@w_result_values)
  print '@w_parent MONTO_GRP: '        + convert(varchar(50),@w_parent)
  
  
  -- Monto Aprobado
  select @w_monto_max_calc = replace(convert(varchar, substring(@w_result_values, charindex('|', @w_result_values) + 1, 300)),'|',''),
         @w_monto_min_calc = replace(convert(varchar, substring(@w_result_values, 1,   charindex('|', @w_result_values) - 1)),'|','')
        
  if @w_ciclo_grupal = 1
  begin
    select @w_monto_inicial = @w_monto_max_calc
  end
  
  select @o_monto = @w_monto_inicial  
  print 'Monto Maximo: '   + convert(varchar(50),@w_monto_max_calc)
  print 'Monto Minimo: '   + convert(varchar(50),@w_monto_min_calc)
  print 'Monto Aprobado: ' + convert(varchar(50),@o_monto)
end

return 0

ERROR:
exec cobis..sp_cerror
     @t_debug  = 'N',
     @t_file   = null,
     @t_from   = @w_sp_name,
     @i_num    = @w_error,
     @i_msg    = @w_msg
        
return @w_error
  
go
