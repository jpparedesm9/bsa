/************************************************************************/
/*      Archivo:                plano_ctas_inac_ah.sp                   */
/*      Stored procedure:       sp_plano_ctas_inac_ah                   */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:                                                   */
/*      Fecha de escritura:                                             */
/************************************************************************/
/*                               IMPORTANTE                             */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por  escrito de COBISCorp.    */
/*  Este programa esta  protegido  por la ley de   derechos de autor    */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Generar Archivo Plano de las cuentas inactivas proyectadas          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_plano_ctas_inac_ah')
   drop proc sp_plano_ctas_inac_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_plano_ctas_inac_ah (
    @t_show_version  bit = 0
)
as
declare
@w_sp_name      varchar(30),
@w_msg          descripcion,
@w_fecha        datetime,
@w_dias_env     int,
@w_tiempo       int,
@w_tiempo_total int,
@w_error        int,
@w_path_s_app   varchar(30),
@w_path         varchar(250),
@w_s_app        varchar(250),
@w_archivo      descripcion,
@w_errores      descripcion,
@w_archivo_bcp  descripcion,
@w_cmd          varchar(250),
@w_comando      varchar(5000),
@w_prod         tinyint,
@w_col_id       int,
@w_columna      varchar(100),
@w_cabecera     varchar(5000),
@w_nom_tabla    varchar(100),
@w_archivo_cab  varchar(255)

/*  Captura nombre de Stored Procedure  */
select @w_sp_name    = 'sp_plano_ctas_inac_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_fecha = fp_fecha
from   cobis..ba_fecha_proceso

if @@rowcount = 0
begin
    select @w_msg = 'ERROR ENCONTRANDO FECHA DE PROCESO', @w_error = 1
    goto ERROR
end

/** Producto de Ahorramia para el filtro ***/
select @w_prod = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CAHO'
and   pa_producto = 'AHO'

if @@rowcount = 0
begin
   select @w_msg = 'NO SE ENCONTRO PARAMETRO Para el producto de ahorramia', @w_error = 1
   goto ERROR
end

/*SE INSERTAN LOS REGISTROS DEL REPORTE*/
/** Se borra la tabla ***/
delete cob_ahorros..datos_inac

insert into datos_inac
select
    of_zona,
    (select  of_nombre from cobis..cl_oficina where of_oficina = O.of_zona),
    ah_oficina,
    (select  convert(varchar(32),of_nombre) from cobis..cl_oficina where of_oficina = O.of_oficina),
    convert(varchar(4),ah_prod_banc),
    ah_cta_banco,
    ah_cuenta,
    ah_estado,
    ah_fecha_aper,
    ah_ctitularidad,
    ah_cliente,
    ah_ced_ruc,
    ah_disponible,
    ah_fecha_ult_mov,
    isnull(di_rural_urb,'X') ,
    vx_banco,
    vx_estado,
    isnull((select es_descripcion from cob_cartera..ca_estado where es_codigo = vx_estado),'-'),
    vx_dias_mora,
    vx_nota,
    'Castigado' = (case vx_estado
                       when 4 then 'S'
                  else  'N'
                  end),
    'exclusivo' = (case when vx_banco IS NULL  then 'S'
                   else 'C'
                   end),
    isnull(vx_valor_vencido, 0),
    isnull(vx_monto_max,0),
    'Exenta' = isnull(eg_marca,'N')
from cob_ahorros..ah_cuenta
     left join cobis..cl_oficina O
        on  ah_oficina = of_oficina

     left join cobis..cl_direccion
        on  di_ente    = ah_cliente
        and di_principal    = 'S'

     left join cob_cartera..ca_valor_atx
        on  ah_ced_ruc = vx_ced_ruc
        and vx_estado in (1,2,4,9)
     left join cob_ahorros..ah_exenta_gmf
        on  ah_cta_banco = eg_cta_banco
    /*** Todas las cuentas Ahorramia Inactivas que no han sido enviadas al tesoro y que no tienen bloqueos de ningun tipo */
where ah_estado     = 'I'
and   ah_cta_banco not in  (select tn_cuenta
                            from   cob_remesas..re_tesoro_nacional
                            where  tn_tipo_cta in (2,3)
                            and    tn_estado = 'P')
and   ah_prod_banc    = @w_prod  -- producto Ahorramia
and   ah_ctitularidad = 'I'
and   ah_bloqueos     = 0
and   ah_num_blqmonto = 0
and   ah_disponible   > 0

if @@rowcount >= 1
begin

    /**** Actualizacion de Cliente exclusivo contra plazo fijo *****/
    update cob_ahorros..datos_inac
    set    exclusivo ='P'
    from   cob_pfijo..pf_operacion
    where  cliente = op_ente
    and    op_estado = 'ACT'
    and    exclusivo = 'S'

    if @@error <> 0
    begin
          print 'ERROR en la actualizacion contra Cdts......'
          select @w_msg = 'ERROR en la actualizacion contra Cdts ' , @w_error = 1
          goto ERROR
    end

   print ' Cantidad de registros'
   select count(*) from datos_inac

   select @w_path_s_app = pa_char
   from   cobis..cl_parametro
   where  pa_nemonico = 'S_APP'

   if @w_path_s_app is null begin
      select @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP', @w_error = 1
      goto ERROR
   end

   /* Se Realiza BCP */
   select @w_s_app = @w_path_s_app + 's_app'

   select @w_path = pp_path_destino
    from  cobis..ba_path_pro
    where pp_producto = 4

   select @w_archivo = 'CTASINAC_'     + convert(varchar,@w_fecha,112) + '_' + convert(varchar,getdate(),112) + '.txt',
          @w_errores = 'ERR_CTASINAC_' + convert(varchar,@w_fecha,112) + '_' + convert(varchar,getdate(),112) + '.txt'

   select @w_archivo_bcp = @w_path  + @w_archivo,
          @w_errores     = @w_path  + @w_errores,
          @w_cmd         = @w_s_app + ' bcp -auto -login cob_ahorros..datos_inac  out '

   ----------------------------------------
   --Generar Archivo de Cabeceras
   ----------------------------------------
   select
   @w_archivo_cab  = @w_path  + 'DEF_' + @w_archivo,
   @w_col_id       = 0,
   @w_columna      = '',
   @w_cabecera     = convert(varchar(5000), '')


   while 1 = 1
   begin
      set rowcount 1
      select
      @w_columna = c.name,
      @w_col_id  = c.colid
      from cob_ahorros..sysobjects o, cob_ahorros..syscolumns c
      where o.id    = c.id
      and   o.name  = 'datos_inac'
      and   c.colid > @w_col_id
      order by c.colid

      if @@rowcount = 0 begin
         set rowcount 0
         break
      end

      select @w_cabecera = @w_cabecera + @w_columna + '^|'
   end

   select @w_cabecera = left(@w_cabecera, datalength(@w_cabecera) - 2)

   --Escribir Cabecera
   select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_archivo_cab

   exec @w_error = xp_cmdshell @w_comando

   if @w_error <> 0 begin
      select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
      goto ERROR
   end

   select @w_comando = @w_cmd + @w_archivo_bcp + ' -b5000 -c -e'+ @w_errores+ ' -t"|" '  +  ' -config '+ @w_s_app + '.ini'
   print ''
   print 'Comando : ' + @w_comando
   print'--'
   exec @w_error = xp_cmdshell @w_comando

   if @w_error <> 0 begin
      print 'ERRORRR......'
      select @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @w_archivo + ' '+ convert(varchar, @w_error), @w_error = 1
      goto ERROR
   end

   select @w_comando = 'copy ' + @w_archivo_cab + ' + ' + @w_archivo_bcp + ' ' + @w_archivo_cab

   exec @w_error = xp_cmdshell @w_comando

   if @w_error <> 0 begin
      select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
      goto ERROR
   end

   select @w_comando = 'del '  + @w_archivo_bcp

   exec @w_error = xp_cmdshell @w_comando

   if @w_error <> 0 begin
      select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
      goto ERROR
   end
   print 'Ejecucion sin problemas'

end
else
   print 'No Existen datos Para Generar Archivo Plano de las cuentas inactivas proyectadas al proximo trimestre'

print ' TERMINO !!!'

return 0

ERROR:
exec sp_errorlog
@i_fecha   = @w_fecha,
@i_error   = @w_error,
@i_usuario = 'Operador',
@i_tran    = 0,
@i_cuenta  = 'sp_plano_ctas_inac_ah',
@i_descripcion = @w_msg

return 1

go

