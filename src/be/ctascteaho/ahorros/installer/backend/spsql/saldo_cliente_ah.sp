/************************************************************************/
/*  Archivo:            saldo_cliente_ah.sp                             */
/*  Stored procedure:   sp_saldo_cliente_ah                             */
/*  Base de datos:      cob_cuentas                                     */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:       G.Velasquez                                     */
/*  Fecha de escritura: 07-Oct-2005                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa calcula intereses ganados en cuentas corrientes       */
/*                                                                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR             RAZON                             */
/*  07/Oct/2005     G. Velasquez    Emision inicial                     */
/*  02/23/2007      R. Linares      Se Agrego Estado                    */
/*  02/Mayo/2016    Juan Tagle      Migración a CEN                     */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_saldo_cliente_ah')
        drop proc sp_saldo_cliente_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_saldo_cliente_ah (
    @s_rol          smallint = null,
    @t_show_version bit = 0,
    @i_fecha        datetime,
    @i_turno        smallint = null,
    @o_procesadas   int out
)
as
declare @w_return   int,
    @w_sp_name      varchar(30),
    @w_cuenta       int,
    @w_moneda       tinyint,
    @w_mensaje      varchar(254),
    @w_contador     int,
    @w_cta_banco    cuenta,
    @w_disponible   money,
    @w_contable     money,
    @w_cliente      int,
    @w_filial       tinyint,
    @w_oficina      smallint,
    @w_prod_banc    smallint,
    @w_producto     smallint,
    @w_12h          money,
    @w_24h          money,
    @w_48h          money,
    @w_remesas      money,
    @w_nomlar       varchar(254),
    @w_ced_ruc      numero,
    @w_oficial      smallint,
    @w_fec_ape      smalldatetime,
    @w_en_grupo     int,
    @w_estado       varchar(10),
    @w_descestado   varchar(64)

/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_saldo_cliente_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

/* Inicializacion de variables */

select @w_contador = 0

declare ahsaldos cursor
for select ah_cuenta,
           ah_cta_banco,
           ah_cliente,
           ah_prod_banc,
           ah_producto,
           ah_oficina,
           isnull(ah_12h,0),
           isnull(ah_24h,0),
           isnull(ah_48h,0),
           isnull(ah_remesas,0),
           isnull(ah_disponible,0),
           ah_filial,
           ah_moneda,
           ah_oficial,
           ah_fecha_aper,
           ah_estado
  from cob_ahorros..ah_cuenta
 where ah_estado not in ('C')

open ahsaldos
fetch ahsaldos into
    @w_cuenta,
    @w_cta_banco,
    @w_cliente,
    @w_prod_banc,
    @w_producto,
    @w_oficina,
    @w_12h,
    @w_24h,
    @w_48h,
    @w_remesas,
    @w_disponible,
    @w_filial,
    @w_moneda,
    @w_oficial,
    @w_fec_ape,
    @w_estado

if @@fetch_status = -1
begin
     close ahsaldos
     deallocate ahsaldos
     exec cobis..sp_cerror
         @i_num       = 201157
     select @o_procesadas = @w_contador
     return 201157
end
else
if @@fetch_status = -2
begin
     close ahsaldos
     deallocate ahsaldos
     select @o_procesadas = @w_contador
     return 0
end

while @@fetch_status = 0
begin
        select  @w_descestado  = null
        select @w_contable = @w_12h + @w_24h + @w_remesas + @w_disponible + @w_48h

        select @w_nomlar  = en_nomlar,
               @w_ced_ruc = en_ced_ruc,
           @w_en_grupo= isnull(en_grupo,0)
          from cobis..cl_ente
         where en_ente = @w_cliente

        select  @w_descestado  = valor
        from cobis..cl_tabla t,
                cobis..cl_catalogo c
          where t.tabla  = 'ah_estado_cta'
            and t.codigo = c.tabla
             and c.codigo = @w_estado

        insert into cob_reportes..cl_cons_saldos
          (cs_ente, cs_nomlar, cs_ced_ruc,
           cs_oficial, cs_producto,
           cs_fecha_apertura, cs_cuenta, cs_saldo,
           cs_saldo_capital,cs_fecha_saldo, cs_grupo,cs_estado,cs_descestado)
        values (@w_cliente, @w_nomlar, @w_ced_ruc,
            @w_oficial,'AHO',
        @w_fec_ape, @w_cta_banco, @w_disponible,
        @w_contable,@i_fecha, @w_en_grupo,@w_estado,@w_descestado)

    if @@error <> 0
        begin
           rollback tran
       print 'Procesando 4 ... Error Insert Cl_Cons_Saldos'

       /* Grabar en la tabla de errores */
       insert cob_remesas..re_error_batch
       values ('0', 'ERROR AL INSERTAR Cl_Cons_Saldos')

       if @@error <> 0
       begin
          /* Error en grabacion de archivo de errores */
          exec cobis..sp_cerror
               @i_num       = 203035

              /* Cerrar y liberar cursor */
          close ahsaldos
              deallocate ahsaldos

          select @o_procesadas = @w_contador
          return 203035
       end

       goto LEER
    end

        if @w_contador % 500 = 0
          commit tran


LEER:
        fetch ahsaldos into
        @w_cuenta,
        @w_cta_banco,
        @w_cliente,
        @w_prod_banc,
        @w_producto,
        @w_oficina,
        @w_12h,
        @w_24h,
        @w_48h,
        @w_remesas,
        @w_disponible,
        @w_filial,
        @w_moneda,
        @w_oficial,
        @w_fec_ape,
        @w_estado

        if @@fetch_status = -1
        begin
             close ahsaldos
             deallocate ahsaldos
             exec cobis..sp_cerror
                 @i_num       = 201157
             select @o_procesadas = @w_contador
             return 201157
        end
end

commit tran

close ahsaldos
deallocate ahsaldos


select @o_procesadas = @w_contador
return 0


go

