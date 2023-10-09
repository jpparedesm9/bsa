use cobis
go

if exists (select * from sysobjects where name = 'sp_prueba_sp' )
   drop proc sp_prueba_sp
go

create proc sp_prueba_sp
(
@t_show_version     bit         = 0,         -- Mostrar la version del programa
@i_oper char(1),
@i_fecha datetime, 
@i_valor integer,
@i_sarta            int         = null,
@i_batch            int         = null,
@i_secuencial       int         = null,
@i_corrida          int         = null,
@i_intento          int         = null
)
as 
declare 
@w_retorno          int,
@w_retorno_ej       int
    
---- VERSIONAMIENTO DEL PROGRAMA ----
if @t_show_version = 1
begin
    print 'Stored procedure sp_prueba_sp, Version 4.0.0.0'
    return 0
end

insert into ba_prueba_sp (oper, fecha, valor) values (@i_oper, @i_fecha, @i_valor)

if @@error > 0
begin    
    exec @w_retorno_ej    = cobis..sp_ba_error_log
         @i_sarta         = @i_sarta,
         @i_batch         = @i_batch,
         @i_secuencial    = @i_secuencial,
         @i_corrida       = @i_corrida,
         @i_intento       = @i_intento,
         @i_error         = 101002,
         @i_detalle       = 'ERROR: Insercion tabla ba_prueba_sp'
    if @w_retorno_ej > 0
    begin        
        return @w_retorno_ej
    end
    else
    begin
        return 1
    end
end

-- if @@error > 0
-- begin
--    print '*SP ERROR*'
--    return 1
-- end

return 0
go
