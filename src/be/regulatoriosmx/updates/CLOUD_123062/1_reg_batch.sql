use cobis
go

declare @w_usuario       varchar(60),
        @w_servidor      varchar(100),
        @w_path_destino  varchar(100),
        @w_path_fuente   varchar(100),
        @w_producto      int

select  @w_usuario      = 'admuser',
        @w_producto     = 7

--Path de producto
select @w_servidor = pa_char
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'SRVR'

select @w_path_destino = 'C:\Cobis\VBatch\Cartera\listados\Impacto_Social' + char(92)

select @w_path_fuente = pp_path_fuente
  from ba_path_pro
 where pp_producto = @w_producto

select @w_path_fuente = isnull(@w_path_fuente, 'C:/Cobis/VBatch/Cartera/listados/Impacto_Social/')
-- ========================================================================================
delete from ba_batch where ba_batch in (152026)

insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (152026, 'REPORTES IMPACTO SOCIAL', 'COMPORTAMIENTO DE CLIENTES ACTIVOS Y PROSPECTOS; E INVENTARIO DE CLIENTES Y PROSPECTOS', 'SP', getdate(), 7, 'P', 1, NULL, NULL, 'cob_conta_super..sp_rpt_comp_clientes_act', 10000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)



GO
