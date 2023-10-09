/***************************************************************************/
/*      Archivo:            relaciones_navidad.sp                          */
/*      Stored procedure:   sp_relaciones_navidad                          */
/*      Base de datos:      cob_ahorros                                    */
/*      Producto:           Cuentas de Ahorros                             */
/*      Disenado para:      Global Bank - Panama                           */
/*      Fecha de escritura: 23-Mar-2005                                    */
/***************************************************************************/
/*              IMPORTANTE                                                 */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad           */
/*  de COBISCorp.                                                          */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como       */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus       */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.      */
/*  Este programa esta protegido por la ley de   derechos de autor         */
/*  y por las    convenciones  internacionales   de  propiedad inte-       */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir           */
/*  penalmente a los autores de cualquier   infraccion.                    */
/***************************************************************************/
/*                              PROPOSITO                                  */
/*      Mantenimiento de las relaciones ACH con cuentas de Navidad         */
/*      y el análisis de las cuentas y la cantidad de semanas pagadas      */
/***************************************************************************/
/*                              MODIFICACIONES                             */
/*      FECHA           AUTOR           RAZON                              */
/*      23/Mar/2005     A. Villarreal   Emision inicial                    */
/*      04/Sep/2005     J. Suarez       Boton Siguiente                    */
/*      16/Nov/2006     P. Coello       Calculo correcto de periodo inicial*/
/*      02/Mayo/2016    Juan Tagle      Migración a CEN                    */
/***************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_relaciones_navidad')
    drop proc sp_relaciones_navidad
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_relaciones_navidad (
        @s_ssn                  int,
        @s_srv                  varchar(30),
        @s_user                 varchar(30),
        @s_term                 varchar(10),
        @s_ofi                  smallint,
        @s_rol                  smallint,
        @s_date                 datetime,
        @t_debug                char(1) = 'N',
        @t_file                 varchar(14) = null,
        @t_from                 varchar(30) = null,
        @t_trn                  int,
        @t_show_version         bit = 0,
        @i_oper                 char(1),
        @i_nombre               descripcion = null,
        @i_ach                  char(1)     = null,
        @i_suc                  smallint    = null,
        @i_relacion             smallint    = null,
        @i_cuenta               char(20)    = null,
        @i_cuentaint            int         = null
)
as

declare @w_return               int,
        @w_sp_name              varchar(30),
        @w_msg                  char(60),
        @w_relacion             smallint,
        @w_semanas              tinyint,
        @w_week_year            tinyint,
        @w_per_inicial          datetime,
        @w_cuenta               int


/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_relaciones_navidad'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_semanas = pa_tinyint
  from cobis..cl_parametro
 where pa_producto = 'AHO'
   and pa_nemonico = 'SECOCN'
if @@rowcount = 0
  begin
     exec cobis..sp_cerror
          @t_debug        = @t_debug,
          @t_file         = @t_file,
          @t_from         = @w_sp_name,
          @i_num          = 253070,
          @i_msg          = 'PARAMETRO DE SEMANAS COMPLETAS DE NAVIDAD, NO EXISTE'
     return 253070
  end

select @w_per_inicial = dateadd(yy, datediff(yy, pa_datetime, @s_date) - 1,
                                    pa_datetime)
  from cobis..cl_parametro
 where pa_producto = 'AHO'
   and pa_nemonico = 'FEIACN'

if @@rowcount = 0
  begin
     exec cobis..sp_cerror
          @t_debug        = @t_debug,
          @t_file         = @t_file,
          @t_from         = @w_sp_name,
          @i_num          = 253070,
          @i_msg          = 'PARAMETRO DE INICIO DE APERTURA DE CTA DE NAVIDAD, NO EXISTE'
     return 253070
  end

/****** Obtiene el numero interno de la cuenta ****/
if @i_cuenta is not null
  begin
    select @w_cuenta = ah_cuenta
      from cob_ahorros..ah_cuenta
     where ah_cta_banco = @i_cuenta
  end

if @i_oper = 'I'
  begin
     begin tran

     if exists (select 1 from cob_ahorros..ah_relacion_navidad
                 where rn_nombre = @i_nombre)
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 252070
          return 252070
       end

     select @w_relacion = isnull(max(rn_codigo), 0) + 1
       from cob_ahorros..ah_relacion_navidad

     insert into cob_ahorros..ah_relacion_navidad
     values (@w_relacion, @i_nombre, @i_ach)
     if @@error <> 0
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 253070
          return 253070
       end

     select @w_relacion
     commit tran
  end

if @i_oper = 'D'
  begin
     begin tran

     if not exists (select 1 from cob_ahorros..ah_relacion_navidad
                     where rn_nombre = @i_nombre
                       and rn_codigo = @i_relacion)
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 252071
          return 252071
       end

     if exists (select 1 from cob_ahorros..ah_cuenta_navidad
                 where cn_relacion = @i_relacion)
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 257071
          return 257071
       end

     delete cob_ahorros..ah_relacion_navidad
      where rn_nombre = @i_nombre
        and rn_codigo = @i_relacion
     if @@error <> 0
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 257070
          return 257070
       end
     commit tran
  end

if @i_oper = 'Q'
  begin
     set rowcount 50

     select convert(varchar(5), rn_codigo) + ' - ' + rn_nombre
       from cob_ahorros..ah_relacion_navidad
      where rn_nombre > @i_nombre
      order by rn_nombre
  end

if @i_oper = 'S'
  begin
     select convert(varchar(5), of_oficina) + ' - ' + of_nombre
       from cobis..cl_oficina
      order by of_oficina
  end

if @i_oper = 'B'
  begin
     select @w_week_year = datepart(wk, @s_date)

     select 'Sucursal'    = ah_oficina,
            'Cantidad'    = count(1),
            'Saldo'       = sum(ah_disponible + ah_12h + ah_24h + ah_remesas),
            'Sld Final'   = sum(convert(money, cn_cuota) * @w_semanas),
            'X Completar' = sum(convert(int, cn_cuota) * @w_semanas
                                     - (ah_disponible + ah_12h + ah_24h + ah_remesas)),
            'Provision'   = sum(convert(money, cn_cuota)),
            '% Completo'  = 100 * avg((floor((ah_disponible + ah_12h + ah_24h + ah_remesas) /
                                       convert(int, cn_cuota))) / @w_semanas)
       from cob_ahorros..ah_cuenta_navidad, cob_ahorros..ah_cuenta
      where cn_fecha_cierre is null
        and cn_cuenta  = ah_cuenta
        and cn_fecha_cierre  is null
        and ah_oficina = isnull(@i_suc, ah_oficina)
        and cn_fecha_apertura > @w_per_inicial
        and ah_estado <> 'C'
        --and cn_cuota <> '0'
      group by ah_oficina
   end

if @i_oper = 'R'
begin
     select @w_week_year = datepart(wk, @s_date)

      /**** PEDRO COELLO AQUI DEBE CONSULTAR CUALQUIER CUENTA NO SOLO LAS QUE NO ESTA EN RELACIONES
     if exists (select 1
                  from cob_ahorros..ah_cuenta_navidad, cob_ahorros..ah_cuenta
                 where cn_fecha_cierre is null
                   and cn_cuenta         = ah_cuenta
                   and cn_relacion       is null
                   and cn_fecha_apertura > @w_per_inicial
                   and cn_fecha_cierre  is null
                   and ah_cta_banco      = @i_cuenta) and @i_relacion is null
           GOTO Sigue
     else
       begin

              exec cobis..sp_cerror
                   @t_debug        = @t_debug,
                   @t_file         = @t_file,
                   @t_from         = @w_sp_name,
                   @i_num          = 255071,
                   @i_msg          = 'CUENTA NO ES DE NAVIDAD O PERTENECE A UN CODIGO DE RELACION'
             return 255071

       end
     *****/
Sigue:

   if @i_cuenta is not null
     begin
        select 'Sucursal'    = ah_oficina,
               'Cuenta'      = ah_cta_banco,
               'Nombre'      = ah_nombre,
               'Saldo'       = ah_disponible + ah_12h + ah_24h + ah_remesas,
               'Cuota'       = convert(money, cn_cuota),
               '# Cuotas'    = convert(int, floor((ah_disponible + ah_12h + ah_24h + ah_remesas) / convert(int, cn_cuota))),
               'C. Retraso'  = case when @w_week_year - convert(int, floor((ah_disponible + ah_12h + ah_24h + ah_remesas)
                                         / convert(int, cn_cuota))) > 0
                               then @w_week_year - convert(int, floor((ah_disponible + ah_12h + ah_24h + ah_remesas)
                                                            / convert(int, cn_cuota)))
                                           else 0 end,
                     'X Completar' = convert(int, cn_cuota) * @w_semanas - (ah_disponible + ah_12h + ah_24h + ah_remesas),
                     '% Completo'  = 100 * (floor((ah_disponible + ah_12h + ah_24h + ah_remesas)
                                                             / convert(int, cn_cuota))) / @w_semanas,
                     'Fec Pago'    = convert(char(11), cn_fecha_cuota, 106),
                     'Cuenta Ach'  = 'N'
              from cob_ahorros..ah_cuenta_navidad, cob_ahorros..ah_cuenta
             where cn_fecha_cierre is null
                and cn_cuenta         = ah_cuenta
                and cn_fecha_apertura > @w_per_inicial
                    and cn_fecha_cierre  is null
                    and ah_cta_banco      = @i_cuenta
                  order by ah_cta_banco
      end
   else
      begin
         set rowcount 20
         select @i_cuenta = ' '
         select 'Sucursal'    = ah_oficina,
                'Cuenta'      = ah_cta_banco,
                'Nombre'      = ah_nombre,
                'Saldo'       = ah_disponible + ah_12h + ah_24h + ah_remesas,
                'Cuota'       = convert(money, cn_cuota),
                '# Cuotas'    = convert(int, floor((ah_disponible + ah_12h + ah_24h + ah_remesas) / convert(int, cn_cuota))),
                'C. Retraso'  = case when @w_week_year - convert(int, floor((ah_disponible + ah_12h + ah_24h + ah_remesas)
                                                       / convert(int, cn_cuota))) > 0
                                     then @w_week_year - convert(int, floor((ah_disponible + ah_12h + ah_24h + ah_remesas)
                                                       / convert(int, cn_cuota)))
                                     else 0 end,
                'X Completar' = convert(int, cn_cuota) * @w_semanas - (ah_disponible + ah_12h + ah_24h + ah_remesas),
                '% Completo'  = 100 * (floor((ah_disponible + ah_12h + ah_24h + ah_remesas)
                                                       / convert(int, cn_cuota))) / @w_semanas,
                'Fec Pago'    = convert(char(11), cn_fecha_cuota, 106),
                'Cuenta Ach'  = isnull(rn_ach, 'N'),
                'Cuenta Int'  = ah_cuenta
           from cob_ahorros..ah_cuenta_navidad, cob_ahorros..ah_cuenta, cob_ahorros..ah_relacion_navidad
          where cn_fecha_cierre is null
            and cn_cuenta         = ah_cuenta
            and cn_relacion       = @i_relacion
            and cn_fecha_apertura > @w_per_inicial
            and cn_fecha_cierre  is null
            --and ah_cta_banco      > @i_cuenta
            and ah_cuenta > @i_cuentaint
            and cn_relacion = rn_codigo
          order by ah_cuenta

          set rowcount 0
      end
end

if @i_oper = 'P'
  begin
     begin tran
  /*** SI SOLO ES UNA CUENTA INDIVIDUAL ENTONCES SE VERIFICA QUE NO TENGA UNA RELACION
       YA QUE SI TIENE UNA RELACION DEBERIA MARCAR COMO PAGADA TODA LA RELACION ****/
     if @i_cuenta is not null
     begin
         /*
         select @w_relacion = cn_relacion
           from cob_ahorros..ah_cuenta_navidad
          where cn_cuenta = @w_cuenta

         if @w_relacion is not null
          begin
             exec cobis..sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 208051
             return 208051
          end
         */

         update cob_ahorros..ah_cuenta_navidad
            set cn_fecha_pago = @s_date
          where cn_cuenta = @w_cuenta

         if @@error <> 0 or @@rowcount = 0
         begin
            exec cobis..sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = 255071
           return 255071
         end
     end
     else
     begin
         update cob_ahorros..ah_cuenta_navidad
            set cn_fecha_pago = @s_date
          where cn_relacion = @i_relacion

         if @@error <> 0 or @@rowcount = 0
         begin
            exec cobis..sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = 255071
           return 255071
         end
     end
     commit tran
  end

return 0

go

