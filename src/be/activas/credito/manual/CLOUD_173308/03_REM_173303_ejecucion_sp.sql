use cob_cartera
GO 

declare @w_grupo int,
        @w_cliente int,
        @w_periodicidad varchar(10),
        @w_asesor varchar(14),
        @w_fecha_ven datetime,
		@w_oficial int,
		@w_fecha_proceso datetime,
		@w_error int,
		@w_siguiente int
---rol coordinador- [sp_inicia_proceso_wf]  EL USUARIO NO PUEDE INICIAR ESTE PROCESO POR QUE SE ENCUENTRA INACTIVO Severity 16
select *
into #lista_cliente_caso173308_procesado
from lista_cliente_caso173308
--where ente IN (257219,258262,264617,269178,343117,300470,339715)
where es_cliente = 'S' and tiene_solicitud = 'N'
--AND ente IN (311866)
order by ente

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select @w_cliente = 0, @w_siguiente = 0

while exists (select 1 from #lista_cliente_caso173308_procesado where ente >  @w_cliente and procesado = 'N')
begin
        --@w_id_actividad: 5--@w_id_proceso:5--@w_version:6
        --aaaaaaaaa-a-3--@w_id_usuario:980@w_id_dest:1
    select TOP 1
	   @w_cliente = ente,
       @w_periodicidad = ltrim(rtrim(periodicidad)),
       @w_asesor = ltrim(rtrim(asesor)),
       @w_fecha_ven = ltrim(rtrim(fecha_ven)),
	   @w_oficial = ltrim(rtrim(oficial))
    from #lista_cliente_caso173308_procesado
    where ente > @w_cliente
	and procesado = 'N'
    ORDER BY ente

    print '-->Grupo: ' + convert(varchar(255), @w_grupo) + 
    	  '-->Cliente: ' + convert(varchar(255), @w_cliente) + 
          '-->Periodicidad: ' + convert(varchar(255), @w_periodicidad) + 
          '-->Asesor: ' + convert(varchar(255), @w_asesor) + 
          '-->Fecha_ven: ' + convert(varchar(255), @w_fecha_ven) +
          '-->@w_siguiente: ' + convert(varchar(255), @w_siguiente)
    
    begin try
        exec @w_error = sp_crear_revolventes_caso_173308
           @s_ssn           = 10658366,
           @s_user          = @w_asesor,
           @s_term          = 'bc.mitec.com.mx',
           @s_date          = @w_fecha_proceso,
           @s_sesn          = 2249,
           @s_culture       = 'es_EC',
           @s_srv           = 'CTSSRV',
           @s_lsrv          = 'CTSSRV',
           @s_ofi           = @w_oficial,
           @s_rol           = 12,--32,
           --@s_org_err       = ,
           --@s_error         = ,
           --@s_sev           = ,
           --@s_msg           = ,
           @s_org           = 'U',
           --@t_file          = ,
           --@t_from          = ,
           @t_trn           = 1722,--**'Error: 151091'
           --@t_show_version  = ,
           --@i_grupo         = @w_grupo,
           @i_cliente       = @w_cliente,
           @i_periodicidad  = @w_periodicidad,
           @i_asesor 		= @w_asesor,
           @i_fecha_ven     = @w_fecha_ven  	   
    
        if (@w_error > 0)
        begin
            print 'NumErro:' + convert(VARCHAR(30),@w_error)
            update #lista_cliente_caso173308_procesado 
            set error = 'ERR:' + convert(varchar(255), @w_error), 
			    procesado = 'X'
            where ente = @w_cliente 
            goto SIGUIENTE
        end
        else
        begin
           update #lista_cliente_caso173308_procesado 
           set procesado = 'S', error = 'CREO SOLICITUD'
           where ente = @w_cliente   
	    end
	    select @w_siguiente = @w_siguiente + 1	
    end try
	
    begin catch
	    update #lista_cliente_caso173308_procesado 
        set error = convert(varchar(255), ERROR_MESSAGE()), 
            procesado = 'X'
        where ente = @w_cliente        
		/*select ERROR_NUMBER() AS ErrorNumber, ERROR_STATE() AS ErrorState,
		       ERROR_SEVERITY() AS ErrorSeverity,
		       ERROR_PROCEDURE() AS ErrorProcedure,
		       ERROR_LINE() AS ErrorLine,
		       ERROR_MESSAGE() AS ErrorMessage; */   	  				
	  goto SIGUIENTE
   end catch   
   
   SIGUIENTE:
   
end

update lista_cliente_caso173308
set procesado = T.procesado,
    error = T.error
from #lista_cliente_caso173308_procesado T, lista_cliente_caso173308 R
where T.ente = R.ente
    
SELECT * FROM #lista_cliente_caso173308_procesado
DROP TABLE #lista_cliente_caso173308_procesado

--select * from lista_cliente_caso173308

go
              