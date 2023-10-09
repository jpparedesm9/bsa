/************************************************************************/
/*	Archivo: 	        apliente.sp                             */ 
/*	Stored procedure:       sp_aplicar_vencimiento                  */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               GARANTIAS                           	*/
/*	Disenado por:           Milena Gonzalez             	        */
/*	Fecha de escritura:     Dic 2000  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*      Permite registrar los vencimientos leidos desde un archivo plano*/
/*      siempre que no se hayan encontrado errores al leer el archivo.  */
/*      Verifica que el total de vencimientos sea igual al valor de la  */
/*      garantia.                                                       */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_aplicar_vencimiento')
    drop proc sp_aplicar_vencimiento 
go
create proc sp_aplicar_vencimiento  (
   @s_ssn                          int          = NULL,
   @s_date                         datetime     = NULL,
   @s_user                         login        = NULL,
   @s_term                         descripcion  = NULL,
   @s_corr                         char(1)      = NULL,
   @s_ssn_corr                     int          = NULL,
   @s_ofi                          smallint     = NULL,
   @s_sesn                         int          = NULL,
   @t_rty                          char(1)      = NULL,
   @t_trn                          smallint     = NULL,
   @t_debug                        char(1)      = 'N',
   @t_file                         varchar(14)  = NULL,
   @t_from                         varchar(30)  = NULL,
   @i_archivo                      varchar(30)  = NULL,
   @i_filial                       tinyint      = NULL,
   @i_sucursal                     smallint     = NULL,
   @i_garantia                     int          = NULL, 
   @i_tipo_cust                    descripcion  = NULL,
   @i_operacion                    char(1)      = NULL,
   @o_archivo_cargado              char(1)      = "N" out
)
as

declare
   @w_sp_name 		        char(30),
   @w_msg 		        varchar(255),
   @w_user                      login, 
   @w_sesn                      int, 
   @w_archivo                   varchar(30), 
   @w_error                     char(1), 
   @w_filial                    tinyint, 
   @w_sucursal                  smallint,
   @w_tipo_cust                 descripcion,
   @w_custodia                  int,
   @w_vencimiento               smallint,
   @w_sujeto_cobro              char(1), 
   @w_num_factura               varchar(20), 
   @w_cta_debito                varchar(20),
   @w_mora                      money,
   @w_valor                     money,
   @w_comision                  money,
   @w_codigo_externo            varchar(64),
   @w_estado_colateral          char(1),
   @w_fecha                     datetime,
   @w_fecha_salida              datetime,
   @w_fecha_retorno             datetime,
   @w_destino_colateral         catalogo,
   @w_segmento                  catalogo,
   @w_instruccion               varchar(255),
   @w_procesado                 login, 
   @w_cotizacion                float, 
   @w_beneficiario              varchar(64),
   @w_emisor                    varchar(64),
   @w_fecha_emision             datetime,
   @w_tasa                      varchar(10), 
   @w_ente                      int,
   @w_sesion                    int,
   @w_total_vto                 money,
   @w_valor_garantia            money

  
select @w_sp_name = 'sp_aplicar_vencimiento'
select @w_total_vto = 0 

if (@t_trn <> 19902 )
begin
    /* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end



-- Verificar que el archivo no haya sido aplicado anteriormente
if exists (select * 
             from cu_archivos_cargados_mig
            where ac_archivo = @i_archivo)
begin
  select @o_archivo_cargado = "S"
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901037
    return 1
end

select @w_fecha = getdate()

-- Si existen errores no procesar la transaccion
if exists (select *
             from cu_error_mig
            where em_user = @s_user
              and em_sesn = @s_sesn
              and em_date = @s_date
              and em_sp = "CARGA DE VENCIMIENTOS")
begin
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901038
    return 1
end

--consultar el total de vencimientos
   select  @w_total_vto = sum(vm_valor)
   from cob_custodia..cu_vencimiento_mig
   where 
   vm_filial   = @i_filial and
   vm_sucursal = @i_sucursal  
   and vm_sesn = @s_sesn --pga 16jul2001
   and vm_archivo = @i_archivo --pga 16jul2001

--consultar el valor de la garantia
   select @w_valor_garantia = cu_valor_inicial
   from cob_custodia..cu_custodia
   where 
   cu_filial   = @i_filial and
   cu_sucursal = @i_sucursal  and
   cu_tipo = @i_tipo_cust and
   cu_custodia = @i_garantia

-- print '%1!',@w_total_vto
-- print '%1!',@w_valor_garantia
   if @w_total_vto > @w_valor_garantia     
    begin
         /* Total de  los vencimientos mayor al valor de la garantia */
          exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903016
             return 1 
    end
            begin tran
            insert into cu_vencimiento(
            ve_filial,ve_sucursal,ve_tipo_cust,
            ve_custodia,ve_vencimiento,ve_fecha,ve_valor,ve_instruccion,
            ve_sujeto_cobro,ve_num_factura,ve_cta_debito,ve_mora,ve_comision,
            ve_codigo_externo,ve_estado_colateral,ve_fecha_salida,
            ve_fecha_retorno, ve_destino_colateral,ve_segmento,
            ve_procesado,ve_cotizacion,ve_beneficiario,
            ve_emisor,ve_fecha_emision,ve_tasa,ve_ente)
            select 
            vm_filial,vm_sucursal,vm_tipo_cust,
            vm_custodia,vm_vencimiento,vm_fecha,vm_valor,vm_instruccion,
            vm_sujeto_cobro,vm_num_factura,vm_cta_debito,vm_mora,vm_comision,
            vm_codigo_externo,vm_estado_colateral,vm_fecha_salida,
            vm_fecha_retorno, vm_destino_colateral,vm_segmento,
            vm_procesado,vm_cotizacion,vm_beneficiario,
            vm_emisor,vm_fecha_emision,vm_tasa,vm_ente
            from cu_vencimiento_mig        
            where vm_user = @s_user
            and vm_sesn = @s_sesn
            and vm_archivo = @i_archivo
            if @@error <> 0 
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file, 
                   @t_from  = @w_sp_name,
                   @i_num   = 1903001
                   return 1 
            end
            commit tran
            return 1 

return 0
go

