use cob_conta_super
go

declare 
 @w_xml              XML,
 @w_fecha            varchar(300),
 @num_codigo         int,
 @num_operacion      varchar(24)
 
  set @w_fecha='2019-08-13T15:30:00'
  
 create table #num_operation_faltante
 (
  codigo    int identity,
  operation varchar(15)
 )
  
 insert into #num_operation_faltante
 select   num_operation   
 from cob_credito..cr_resultado_xml
 where num_operation not in 
( select nec_banco from  cob_conta_super..sb_ns_estado_cuenta )
 
  select @num_codigo = 0
 
 	   while (1 = 1) 
	   begin
         select  TOP 1 @num_operacion = operation ,
                       @num_codigo    = codigo  
	     from #num_operation_faltante 
	     where codigo > @num_codigo 
	     order by codigo asc
		 
         if @@rowcount = 0 BREAK
         
         
          select top 1  @w_xml =linea  from cob_credito..cr_resultado_xml
          where num_operation =@num_operacion
      
          set @w_xml.modify('
                        replace value of(/FacturaInterfactura/Encabezado/@Fecha)[1]
                        with sql:variable("@w_fecha")
                      ')
                      
           update  cob_credito..cr_resultado_xml 
           set linea=@w_xml
           where  num_operation =@num_operacion  
               
   
         end
 
go

