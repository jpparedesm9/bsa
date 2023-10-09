--****************************************************************************************************************
use cob_conta
go

print 'Inicio:' + convert(VARCHAR(30),getdate())

declare @w_mes varchar(2),
        @w_anio varchar(4),
		@w_mes_c int

select @w_mes_c = sr_mes,
       @w_anio = convert(varchar(4),sr_anio)
from cob_conta..cb_solicitud_reportes_reg where sr_reporte = 'ESTCTA'

select @w_mes = case when @w_mes_c < 10 then '0' + convert(varchar(2),@w_mes_c)
                else convert(varchar(2), @w_mes_c) end

update cob_conta_super..sb_info_gen_xml_refacturacion
   set fecha_generacion_archivo = getdate(),
       nombre_archivo = file_name,
	   procesado = 'S'
  from cob_credito..cr_resultado_xml 
 where num_operation = banco
   and timbrado = 'N' 
   and mes_facturacion = @w_mes_c and anio_facturacion = @w_anio

print 'Fin:' + convert(VARCHAR(30),getdate())

go
