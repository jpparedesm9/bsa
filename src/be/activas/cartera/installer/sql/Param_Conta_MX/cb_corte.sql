USE cob_conta 
GO

TRUNCATE TABLE cb_corte


DECLARE @w_cont INT,
        @w_fecha datetime,
		@w_periodo int ,
		@w_fecha_hasta datetime,
		@w_fecha_pro  datetime


	

SELECT @w_periodo = 0,
       @w_fecha_pro  = fp_fecha from cobis..ba_fecha_proceso 
       
while 1= 1 begin
   set rowcount 1
    
   select 
   @w_periodo     = pe_periodo,
   @w_fecha_hasta = pe_fecha_fin,
   @w_fecha       = pe_fecha_inicio        
   from cb_periodo 
   where pe_periodo > @w_periodo
   order by pe_periodo
   
   if @@rowcount = 0 begin
      set rowcount 0 break 
   end 
   
   set rowcount 0 
   select @w_cont = 0
   
   while  @w_fecha  <=  @w_fecha_hasta  begin
      
	  select @w_cont = @w_cont +1
      insert into  cb_corte values (@w_cont,@w_periodo,1,@w_fecha, @w_fecha, 'N',1)
	  select @w_fecha = dateadd(dd,1,@w_fecha)
	  
   end 
   
end


update cb_corte set co_estado = 'A' where co_fecha_ini = @w_fecha_pro

update cb_corte set co_estado = 'C' where co_fecha_ini < @w_fecha_pro

go
