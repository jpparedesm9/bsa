/************************************************************************/
/*  Archivo               : fngetctacont.sp                                */
/*  Stored procedure      : fn_getctacont                                */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo Fijo                                  */
/*  Disenado por          : ALF                                         */
/*  Fecha de documentacion: 24/Mar/10                                   */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBISCORP'                                                         */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de COBISCORP o su representante.              */
/*                          PROPOSITO                                   */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA           AUTOR              RAZON                            */ 
/*  24-Mar-2010     M. Jimenez(ALF)    Emision Inicial                  */
/*  24-Ago-2011     N. Silva                                            */
/*  05-Ene-2017     N. Martillo        Ajustes VBatch                   */
/************************************************************************/ 
use cob_pfijo
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select * from sysobjects where name = 'fn_getctacont')
   drop function fn_getctacont
go

create function dbo.fn_getctacont(
       @i_param1     varchar(255),
       @i_param2     varchar(255),
       @i_param3     varchar(255),
       @i_param4     varchar(255),
       @i_param5     varchar(255),
       @i_param6     varchar(255)
)
returns varchar(20)
as
begin
     declare @w_sp_name       varchar(30),
             @w_retorno       int,
             @w_retorno_ej    int,
             @w_error_msg     int,
             @w_fecha_proceso datetime,
             @w_cta_cont      varchar(20),
             @w_toperacion    varchar(10),
             @w_plazo_cont    varchar(10),
             @w_moneda        tinyint,
             @w_estado        varchar(10),
             @w_pignorado     char(1),
             @w_grupo         char(1)
     
     select @w_fecha_proceso = fp_fecha
     from cobis..ba_fecha_proceso
     
     select @w_sp_name    = 'sp_rptnewinv',
            @w_toperacion = convert(varchar(10), @i_param1),
            @w_plazo_cont = convert(varchar(10), @i_param2),
            @w_moneda     = convert(tinyint    , @i_param3),
            @w_estado     = convert(varchar(10), @i_param4),
            @w_pignorado  = convert(char(1)    , @i_param5),
            @w_grupo      = convert(char(1)    , @i_param6)
            
     select @w_cta_cont = re_substring
     from cob_conta..cb_relparam
     where re_empresa    = 1
       and re_parametro  = case @w_pignorado
                             when 'S' then 'PIG'
                             else case
                                    when @w_estado = 'VEN' then 'OVEN'
                                    else 'PLZ'
                                  end
                           end
       and re_clave  like  case @w_pignorado 
                             when 'S' then @w_toperacion+'.'+convert(varchar,@w_moneda)+'.'+@w_grupo
                             else case
                                    when @w_estado = 'VEN' then  @w_toperacion+'.'+convert(varchar,@w_moneda)+'.'+@w_grupo
                                    else @w_toperacion+'.'+@w_plazo_cont+'.'+convert(varchar,@w_moneda)+'.'+@w_grupo
                                  end
                           end
        if @@rowcount = 0 begin
           select @w_retorno_ej = 14000, 
                  @w_error_msg = 'Error en consulta de cob_conta..cb_relparam'
           goto ERROR
         end
      return @w_cta_cont

     ERROR:
     
     exec @w_retorno = cob_pfijo..sp_errorlog
          @i_fecha       = @w_fecha_proceso, 
          @i_error       = @w_retorno_ej, 
          @i_usuario     = 'OPERADOR',
          @i_tran        = 14000, 
          @i_tran_name   = @w_sp_name, 
          @i_rollback    = 'N',
          @i_cuenta      = 'sp_rptanula', 
          @i_descripcion = @w_error_msg
     
     return @w_retorno_ej
     
	  
end

go

