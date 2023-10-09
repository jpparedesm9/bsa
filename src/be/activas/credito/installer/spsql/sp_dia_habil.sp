use cob_credito
go


IF OBJECT_ID ('dbo.sp_dia_habil') IS NOT NULL
	DROP PROCEDURE dbo.sp_dia_habil
GO

create proc sp_dia_habil(
	@s_ssn                  int         = NULL,
	@s_date                 datetime    = NULL,
	@s_user                 login       = NULL,
	@s_term                 descripcion = NULL,
	@s_ofi                  smallint    = NULL,
	@s_srv                  varchar(30) = NULL,
	@s_lsrv                 varchar(30) = NULL, 
	@t_rty                  char(1)     = NULL,
	@t_debug                char(1)     = 'N',
	@t_file                 varchar(14) = null,
	@t_from                 varchar(32) = null,
	@i_operacion            char(1)     = 'A',
	@i_fecha                datetime    = null,
        @o_fecha                datetime    = null out
)
as
declare
	@w_sp_name              varchar(32),/*nombre del sp*/
	@w_today                datetime,   /*fecha del dia*/
	@w_return               int,         /*valor que retorna*/
        @w_ciudad_matriz        smallint,
        @w_siguiente_dia        datetime


select @w_sp_name = 'sp_dia_habil'

/** DIA LABORABLE ANTERIOR A LA FECHA INGRESADA **/

if @i_operacion =  'A'
begin   
      select @w_ciudad_matriz  = pa_smallint
        from cobis..cl_parametro
       where pa_producto = 'ADM'
         and pa_nemonico = 'CFN'            

      select @i_fecha = dateadd(dd,-1,@i_fecha)

      while 1 = 1
      begin
	  if exists (select 1 from cobis..cl_dias_feriados
                      where df_ciudad  = @w_ciudad_matriz
                        and df_fecha   = @i_fecha)
		select @i_fecha = dateadd(dd, -1, @i_fecha)
	  else
               break
      end

      /**  DEVUELVE EL DIA ANTERIOR HABIL A LA FECHA INGRESADA  **/
      select @o_fecha = @i_fecha
end  

if @i_operacion =  'B'
begin   
      select @w_ciudad_matriz  = pa_smallint
        from cobis..cl_parametro
       where pa_producto = 'ADM'
         and pa_nemonico = 'CFN'            


      if @w_siguiente_dia is null 
      begin        
        select @w_siguiente_dia = dateadd(day , 1 , @i_fecha)         
        while exists(select 1 from cobis..cl_dias_feriados
                     where df_fecha = @w_siguiente_dia
                     and df_ciudad  = @w_ciudad_matriz )
        begin
            select @w_siguiente_dia = dateadd(day,1,@w_siguiente_dia)
        end -- WHILE        
      end 

      /**  DEVUELVE EL DIA ANTERIOR HABIL A LA FECHA INGRESADA  **/
      select @o_fecha = @w_siguiente_dia      
end  

return 0
                                                                                                                                                                  

go

