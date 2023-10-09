/**************************************************************************/
/*  Archivo:           validafinpe.sp                                     */
/*  Stored procedure:  sp_valida_finpe                                    */
/*  Base de datos:     cob_conta                                          */
/*  Producto:          contabilidad                                       */
/*  Disenado por:      Dario Cumbal                                       */
/*  Fecha de escritura:11-Enero-2018                                      */
/**************************************************************************/
/*                          IMPORTANTE                                    */
/*  Este programa es parte de los paquetes bancarios propiedad de         */
/*	"MACOSA", representantes exclusivos para el Ecuador de la             */
/*	"NCR CORPORATION".                                                    */
/*	Su uso no autorizado queda expresamente prohibido asi como            */
/*	cualquier alteracion o agregado hecho por alguno de sus               */
/*	usuarios sin el debido consentimiento por escrito de la               */
/*	Presidencia Ejecutiva de MACOSA o su representante.                   */
/*	                         PROPOSITO                                    */
/*	Este programa realiza las siguientes  validaciones                    */
/*  1.Validacion que la fecha de proceso se encuentre entre el 1 y 31 de  */
/*  enero del año en curso.                                               */
/*  2.Validacion que se haya realizado el proceso de estimación de prov.  */
/*  3.Validacion de mes de ingreso de comprobante de fin de año           */
/*  4.Verificar que la fecha de comprobante corresponda a un corte abierto*/  
/*  5.Verificar la fecha de ingreso de comprobante sea el 31 del año pasa_*/
/*    do o el primero del año en curso                                    */
/*  6.Verificar que el corte del año anterior este cerrado para generar la*/
/*    solicitud.                                                          */
/*	                         MODIFICACIONES                               */
/*	FECHA          AUTOR       RAZON	                                  */
/*	11/Ene/2018	   D. Cumbal   Emision Inicial			                  */
/**************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_valida_finpe')
	drop proc sp_valida_finpe

go
create proc sp_valida_finpe   (
    @s_ssn			int         = null,
    @s_date         datetime    = null,
    @s_user         login       =  null,
    @s_term         descripcion = null,
    @s_corr         char(1)     = null,
    @s_ssn_corr     int         = null,
    @s_ofi          smallint    = null,
    @t_rty          char(1)     = null,
    @t_trn          smallint    = null,
    @t_debug        char(1)     = 'N',
    @t_file	        varchar(14) = null,
    @t_from         varchar(30) = null,
    @i_empresa      tinyint     = null,
    @i_mes			tinyint		= null,
	@i_anio			smallint	= null,
    @i_opcion       int         = null 	   
)
as 
declare
	@w_fecha_proceso   datetime    ,  	/* fecha del dia */
	@w_return          int         , 		/* valor que retorna */
	@w_sp_name         varchar(32) ,
	@w_fecha_ini       datetime    ,
	@w_fecha_fin       datetime    ,
	@w_parametro_mes   int         ,
    @w_estado          varchar(1)  ,
    @w_periodo         int         ,
    @w_corte           int         ,
    @w_fecha_ing_comp  datetime    ,
    @w_msg             varchar(150),
    @w_fecha_per_ant   datetime    ,
    @w_fecha_prov      datetime    ,
    @w_error_tmp       int         ,
    @w_fecha_ult       datetime    ,
    @w_fecha_fin_per   datetime 
    
    
    select @w_sp_name     = 'sp_valida_finpe'
    
    select 
	       @w_fecha_proceso = fp_fecha
    from cobis..ba_fecha_proceso
    
    select @w_parametro_mes = pa_int
    from cobis..cl_parametro 
    where pa_nemonico = 'MESFPE'
    
    if @w_parametro_mes = 1  
	        select @w_fecha_ing_comp = convert(datetime, '01/01/'+ convert(varchar,datepart(yy,@w_fecha_proceso )))
    else
	        select @w_fecha_ing_comp = convert(datetime, '12/31/'+ convert(varchar,datepart(yy,@w_fecha_proceso)-1))
    
    --Validacion Fecha Proceso
    if @i_opcion = 1
    begin 
          select @w_fecha_ini = convert(datetime, '01/01/'+ convert(varchar,datepart(yy,@w_fecha_proceso )))
          select @w_fecha_fin = convert(datetime, '01/31/'+ convert(varchar,datepart(yy,@w_fecha_proceso )))    
          if (@w_fecha_proceso< @w_fecha_ini) or (@w_fecha_proceso > @w_fecha_fin)
          begin
               return 601315              
          end         
    end 
    
    -- Validacion mes 
    if @i_opcion = 2
    begin
          if @w_parametro_mes != 1 and @w_parametro_mes != 12
          begin
              select 601316              
          end
    end
    
    /* DETERMINAR LA FECHA DE INGRESO DEL COMPROBANTE DE CIERRE */
    -- Validacion que el periodo actual se encuentre abierto
    if @i_opcion = 3
    begin
         if not exists( select 1 from cob_conta..cb_corte
                        where co_empresa   = @i_empresa
                        and   co_fecha_ini = @w_fecha_ing_comp
                        and   co_estado   IN ('V','A')
                        )    
         begin
            return 601317
         end
    end
                    
    -- Validacion del periodo anterior no se encuentre cerrado
    if @i_opcion = 4
    begin
          select   @w_fecha_fin_per  = convert(datetime, '12/31/'+ convert(VARCHAR,datepart(yy,@w_fecha_proceso)-1))
            
          select 
	            @w_estado  = co_estado,
	            @w_corte   = co_corte,
	            @w_periodo = co_periodo  
          from  cob_conta..cb_corte
          where co_empresa   = @i_empresa
          and   co_fecha_ini = @w_fecha_fin_per     
          
          IF @w_estado <> 'C' AND @w_fecha_fin_per <> @w_fecha_ing_comp  --Diferente de Cerrado
          begin
               return 601318
          end
    end
    
    if @i_opcion = 5
    begin
          select @w_fecha_per_ant  = convert(datetime, '12/31/'+ convert(varchar,datepart(yy,@w_fecha_proceso)-1))      
          select @w_fecha_ult = convert(datetime, '12/01/'+ convert(varchar,datepart(yy,@w_fecha_per_ant)))
          exec @w_error_tmp = cob_conta..sp_calcula_ultima_fecha_habil
               @i_reporte		= 'NINGUN',
               @i_fecha		    = @w_fecha_ult,
               @o_fin_mes_hab	= @w_fecha_prov out
                
          if @w_error_tmp != 0
          begin
                 return 601319        
          end
                      
          if (not exists(select 1 from cob_conta_super..sb_dato_operacion
                         where do_fecha = @w_fecha_prov
                         and do_provision is not null
                         and do_provision > 0))   
          begin
                 return 601320        
          end
   end 
   
return 0
go
