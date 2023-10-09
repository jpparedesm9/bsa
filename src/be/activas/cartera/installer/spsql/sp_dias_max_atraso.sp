/************************************************************************/
/*  Archivo:                sp_dias_max_atraso.sp                       */
/*  Stored procedure:       sp_dias_max_atraso                          */
/*  Base de Datos:          cob_cartera                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           ACH                                         */
/*  Fecha de Documentacion: 10/05/2023                                  */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*                           PROPOSITO                                  */
/* Devuelve el nUmero de dIas mAximos de atraso                         */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*  FECHA        AUTOR                   RAZON                          */
/* 10/05/2023    ACH     Emision Inicial                                */
/* **********************************************************************/
use cob_cartera
go

if exists(select 1 from sysobjects where name ='sp_dias_max_atraso')
	drop proc sp_dias_max_atraso
go

create procedure sp_dias_max_atraso (
    @s_ssn               int         = null,
    @s_ofi               smallint    = null,
    @s_user              login       = null,
    @s_date              datetime    = null,
    @s_srv		         varchar(30) = null,
    @s_term	             descripcion = null,
    @s_rol		         smallint    = null,
    @s_lsrv	             varchar(30) = null,
    @s_sesn	             int         = null,
    @s_org		         char(1)     = NULL,
    @s_org_err           int         = null,
    @s_error             int         = null,
    @s_sev               tinyint     = null,
    @s_msg               descripcion = null,
    @t_rty               char(1)     = null,
    @t_trn               int         = null,
    @t_debug             char(1)     = 'N',
    @t_file              varchar(14) = null,
    @t_from              varchar(30) = null,
    --Variables de Ingreso
    @i_tproducto         varchar(30) = null,
    @i_cliente           int         = null,
    @i_grupo             int         = null,
    @i_modo              int,
	@o_dias_max_atraso   int out
 )
as
declare
@w_sp_name       	  varchar(32),
@w_return        	  int,
@w_error              int,
@w_fecha_proceso      datetime,
@w_operacion_max      int,
@w_est_vigente        tinyint,
@w_est_vencido        tinyint,
@w_est_no_vigente     tinyint,
@w_est_cancelado      tinyint,
@w_est_castigado      tinyint,
@w_est_etapa2         tinyint,
@w_tGrupal            varchar(255),
@w_tRenovacion        varchar(255),
@w_tIndividual        varchar(255),
@w_tRevolvente        varchar(255),
@w_dias_max_can       int,
@w_dias_max_ven       int,
@w_dias_max_atraso    int,
@w_mensaje            varchar(255)

select @w_sp_name = 'sp_dias_max_atraso'
select @w_dias_max_atraso = 0

select @w_fecha_proceso = fp_fecha 
from cobis..ba_fecha_proceso

select @w_tGrupal = 'GRUPAL',
       @w_tRenovacion = 'RENOVACION', -- por el momento, no hay. Se tratarA como Grupal
       @w_tIndividual = 'INDIVIDUAL',
       @w_tRevolvente = 'REVOLVENTE' -- por el momento, no hay
	
--CONSULTAR ESTADOS
exec @w_return     = sp_estados_cca
@o_est_vigente    = @w_est_vigente    out,--1
@o_est_vencido    = @w_est_vencido    out,--2
@o_est_novigente  = @w_est_no_vigente out,--0
@o_est_cancelado  = @w_est_cancelado  out,--3
@o_est_castigado  = @w_est_castigado  out,--4
@o_est_etapa2     = @w_est_etapa2     out --12

if @w_return != 0
   goto ERROR
----****----****----****----****----****----****----****----****----****----****----****----****

--DIas de atraso del cliente en su Ultimo trAmite
if (@i_modo = 1) begin

if (@i_tproducto = @w_tRenovacion)
    select @i_tproducto = @w_tGrupal
	
    if (@i_cliente > 0) begin
        
		select @w_operacion_max = 0
		
        if(@w_tIndividual = @i_tproducto) begin		
			select @w_operacion_max = max(op_operacion)
              from ca_operacion 
             where op_toperacion = @w_tIndividual
               and op_estado in (@w_est_vigente, @w_est_cancelado, @w_est_vencido, @w_est_etapa2, @w_est_castigado)
               and op_cliente = @i_cliente
			
        end else if(@i_tproducto = @w_tGrupal or @i_tproducto = @w_tRenovacion) begin            
			select @w_operacion_max = max(dc_operacion) 
              from ca_det_ciclo 
			 where dc_cliente = @i_cliente
		end
		
		select @w_dias_max_can = 0
        select @w_dias_max_can = max(datediff(dd, di_fecha_ven, di_fecha_can))
          from cob_cartera..ca_dividendo
         where di_operacion = @w_operacion_max
           and di_estado in (@w_est_cancelado)
        
		select @w_dias_max_ven = 0
        select @w_dias_max_ven = max(datediff(dd, di_fecha_ven, @w_fecha_proceso))
          from cob_cartera..ca_dividendo
         where di_operacion = @w_operacion_max
           and di_estado in (@w_est_vencido)
		
		if (@w_dias_max_can > 0)
		    select @w_dias_max_can = @w_dias_max_can
		else 
		    select @w_dias_max_can = 0
			
		if (@w_dias_max_ven > 0)
		    select @w_dias_max_ven = @w_dias_max_ven
		else 
		    select @w_dias_max_ven = 0
			
		if (@w_dias_max_can >= @w_dias_max_ven) begin
            select @w_dias_max_atraso = isnull(@w_dias_max_can, 0)
		end else
		    select @w_dias_max_atraso = isnull(@w_dias_max_ven, 0)
	end else begin
	   select @w_return = 101146,
	          @w_mensaje = 'Cliente no proporcionado'
	   goto ERROR
	end
end

select @w_dias_max_atraso = isnull(@w_dias_max_atraso, 0)

select @o_dias_max_atraso = @w_dias_max_atraso

return 0

ERROR:
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_return,
      @i_msg   = @w_mensaje
   return @w_return
go
