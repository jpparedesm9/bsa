/************************************************************************/
/*      Archivo:                plano_progres_ah.sp                     */
/*      Stored procedure:       sp_plano_progres_ah                     */
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
/*   Generar Archivo Plano del Cuentas de Ahorros Progresivas           */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_plano_progres_ah')
   drop proc sp_plano_progres_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_plano_progres_ah (
    @t_show_version  bit = 0
)
as

declare
@w_sp_name           varchar(30),
@w_msg               descripcion,
@w_error             int,
@w_path_s_app        varchar(30),
@w_path              varchar(250),
@w_s_app             varchar(250),
@w_archivo           descripcion,
@w_errores           descripcion,
@w_archivo_bcp       descripcion,
@w_cmd               varchar(250),
@w_comando           varchar(250),
@w_cuenta            int,
@w_cta_banco         varchar(14),
@w_producto          int,
@w_fecha_aper        datetime,
@w_fecha_hasta       datetime,
@w_fecha_aux         datetime,
@w_fecha_aux1        datetime,
@w_fecha_proc        datetime,
@w_sd_fecha          datetime,
@w_cuota             money,
@w_oficina           int,
@w_categoria         varchar(1),
@w_des_categoria     varchar(16),
@w_plazo             int,
@w_saldo_disponible  money,
@w_num_cuotas        int,
@w_estadocuota       varchar(12)

/*  Captura nombre de Stored Procedure  */
select @w_sp_name    = 'sp_plano_progres_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

/* TABLA TEMPORAL PARA LLENAR LOS DATOS DE TODAS LAS CUENTAS */
if exists (select * from sysobjects where name = 'ah_cta_prog' )
    drop table cob_ahorros..ah_cta_prog

create table ah_cta_prog(
cu_cta_banco       varchar(14),
cu_fecha_aper      datetime,
cu_oficina         int,
cu_categoria       char(1),
cu_des_categoria   varchar(16),
cu_cuota           smallint,
cu_estadocuota     varchar(12) )

select @w_producto = pa_int
from   cobis..cl_parametro  with (nolock)
where  pa_producto = 'AHO'
and    pa_nemonico = 'PAHPR'

print 'Parametro Codigo producto ' + cast (@w_producto as varchar)

select top 1
@w_cuenta        = ah_cuenta,
@w_cta_banco     = ltrim(rtrim(ah_cta_banco)),
@w_fecha_aper    = ah_fecha_aper,
@w_oficina       = ah_oficina,
@w_categoria     = ah_categoria,
@w_des_categoria = (select valor from cobis..cl_tabla T, cobis..cl_catalogo C where T.tabla = 'pe_categoria' and T.codigo = C.tabla and C.codigo = ah_categoria)
from   cob_ahorros..ah_cuenta_tmp  with (nolock)
where  ah_prod_banc = @w_producto
and    ah_estado   <> 'C'
order by ah_cta_banco

select @w_fecha_proc = fp_fecha from cobis..ba_fecha_proceso with (nolock)

print ' Empieza el proceso'
while 1=1
begin
   select @w_cuota = cc_cuota,  @w_plazo = cc_plazo
   from   cob_remesas..re_cuenta_contractual with (nolock)
   where  cc_prodbanc  = @w_producto
   and    cc_cta_banco = @w_cta_banco

   select @w_fecha_hasta = dateadd(mm, @w_plazo, @w_fecha_aper)

   if @w_fecha_hasta > @w_fecha_proc
      select  @w_fecha_hasta = @w_fecha_proc

   select @w_fecha_aux = dateadd(mm, 1, @w_fecha_aper)

   if @w_fecha_aux > @w_fecha_proc
      select  @w_fecha_aux = @w_fecha_proc

   select @w_sd_fecha = max(sd_fecha)
   from   cob_ahorros_his..ah_saldo_diario with (nolock)
   where  sd_cuenta = @w_cuenta

   if @w_fecha_aux > @w_sd_fecha
      select  @w_fecha_aux = @w_sd_fecha


   while  @w_fecha_aux <= @w_fecha_hasta
   begin
      select @w_saldo_disponible = sd_saldo_disponible
      from   cob_ahorros_his..ah_saldo_diario with (nolock)
      where  sd_cuenta = @w_cuenta
      and    sd_fecha  = @w_fecha_aux

      if @@rowcount > 0
      begin
          select @w_num_cuotas = datediff (mm, @w_fecha_aper, @w_fecha_aux)

          if @w_num_cuotas = 0 select @w_num_cuotas = 1

          if @w_saldo_disponible < (isnull(@w_cuota,0) *  isnull(@w_num_cuotas,1))
               select @w_estadocuota = 'INCUMPLIDA'
          else
               select @w_estadocuota = 'CUMPLIDA'

          insert into ah_cta_prog
          values (@w_cta_banco, @w_fecha_aper,@w_oficina, @w_categoria, @w_des_categoria, @w_num_cuotas, @w_estadocuota)
          if @@error <> 0 begin
              select @w_msg = 'Error al hacer el insert en la tabla ah_cta_prog', @w_error = 2
              goto ERROR
          end
      end
      select @w_fecha_aux = dateadd(mm, 1, @w_fecha_aux)
   end

   select top 1
   @w_cuenta        = ah_cuenta,
   @w_cta_banco     = ltrim(rtrim(ah_cta_banco)),
   @w_fecha_aper    = ah_fecha_aper,
   @w_oficina       = ah_oficina,
   @w_categoria     = ah_categoria,
   @w_des_categoria = (select valor from cobis..cl_tabla T, cobis..cl_catalogo C where T.tabla = 'pe_categoria' and T.codigo = C.tabla and C.codigo = ah_categoria)
   from   cob_ahorros..ah_cuenta_tmp  with (nolock)
   where  ah_prod_banc = @w_producto
   and    ah_estado   <> 'C'
   and    ah_cta_banco > @w_cta_banco
   order by ah_cta_banco

   if @@rowcount = 0
      break
end

print ' DATOS'


if ((select count(1) from ah_cta_prog) <> 0 )begin

   select @w_path_s_app = pa_char
   from   cobis..cl_parametro
   where  pa_nemonico = 'S_APP'

    print ' Empieza bCP '

   if @w_path_s_app is null begin
      select @w_msg = 'NO EXISTE PARAMETRO  GENERAL S_APP', @w_error = 3
      goto ERROR
   end

   /* Se Realiza BCP */
   select @w_s_app = @w_path_s_app + 's_app'

   /*** codigo del proceso batch  ****/
   select @w_path = ba_path_destino
   from  cobis..ba_batch
   where ba_batch = 4258

   if  @w_path  is null begin
      select @w_msg = 'NO EXISTE DATOS DEL PATH DE DESTINO', @w_error = 4
      goto ERROR
   end

   select @w_archivo = 'CTAPROG_'     + convert(varchar,@w_fecha_proc,112) + '.txt',
          @w_errores = 'ERR_CTAPROG_' + convert(varchar,@w_fecha_proc,112) + '.txt'

   print ' Path     ' + @w_path
   print 'archivo  ' + @w_archivo

   select @w_archivo_bcp = @w_path  + @w_archivo,
          @w_errores     = @w_path  + @w_errores,
          @w_cmd         = @w_s_app + ' bcp -auto -login cob_ahorros..ah_cta_prog out '

   select @w_comando = @w_cmd + @w_archivo_bcp + ' -b5000 -c -e'+ @w_errores  +  ' -config '+ @w_s_app + '.ini'
   print 'Comando : ' + @w_comando

   exec @w_error = xp_cmdshell @w_comando

   if @w_error <> 0 begin
          select @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @w_archivo + ' '+ convert(varchar, @w_error)
      goto ERROR
   end

end
else begin
          print 'NO HAY DATOS?'
         select @w_msg = 'No hay datos Para Generar Archivo Plano del Cuentas de Ahorros Progresivas', @w_error = 5
         goto ERROR
end

return  0

ERROR:
exec sp_errorlog
@i_fecha   = @w_fecha_proc,
@i_error   = @w_error,
@i_usuario = 'Operador',
@i_tran    = 0,
@i_cuenta  = '',
@i_descripcion = @w_msg
return 1

go

